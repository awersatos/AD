-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/virtex4/SMODEL/X_GT11.vhd,v 1.1 2008/06/19 17:05:33 vandanad Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  11-Gigabit Transceiver for High-Speed I/O Simulation Model
-- /___/   /\     Filename : X_GT11.vhd
-- \   \  /  \    Timestamp : Fri Jun 18 10:57:22 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.
--    08/08/05 - Changed default parameter values for some parameters (CR 214282).
--    02/28/06 - CR#226322 - Addition of new parameters and change of default values for some parameters.
-- End Revision

----- CELL X_GT11 -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.VCOMPONENTS.all; 

library secureip; 
use secureip.all; 

entity X_GT11 is
generic (
        TimingChecksOn : boolean := TRUE;
        InstancePath   : string  := "*";
        Xon            : boolean := TRUE;
        MsgOn          : boolean := TRUE;
        LOC            : string  := "UNPLACED";                

		IN_DELAY : time := 0 ps;
		OUT_DELAY : VitalDelayType01 := (0 ps, 0 ps);
		ALIGN_COMMA_WORD : integer := 4;
		BANDGAPSEL : boolean := FALSE;
		BIASRESSEL : boolean := FALSE;
		CCCB_ARBITRATOR_DISABLE : boolean := FALSE;
		CHAN_BOND_LIMIT : integer := 16;
		CHAN_BOND_MODE : string := "NONE";
		CHAN_BOND_ONE_SHOT : boolean := FALSE;
		CHAN_BOND_SEQ_1_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_1_MASK : bit_vector := "1110";
		CHAN_BOND_SEQ_2_1 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_2 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_3 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_4 : bit_vector := "00000000000";
		CHAN_BOND_SEQ_2_MASK : bit_vector := "1110";
		CHAN_BOND_SEQ_2_USE : boolean := FALSE;
		CHAN_BOND_SEQ_LEN : integer := 1;
		CLK_CORRECT_USE : boolean := FALSE;
		CLK_COR_8B10B_DE : boolean := FALSE;
		CLK_COR_MAX_LAT : integer := 48;
		CLK_COR_MIN_LAT : integer := 36;
		CLK_COR_SEQ_1_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_1_MASK : bit_vector := "1110";
		CLK_COR_SEQ_2_1 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_2 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_3 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_4 : bit_vector := "00000000000";
		CLK_COR_SEQ_2_MASK : bit_vector := "1110";
		CLK_COR_SEQ_2_USE : boolean := FALSE;
		CLK_COR_SEQ_DROP : boolean := FALSE;
		CLK_COR_SEQ_LEN : integer := 1;
		COMMA32 : boolean := FALSE;
		COMMA_10B_MASK : bit_vector := X"3FF";
		CYCLE_LIMIT_SEL : bit_vector := "00";
		DCDR_FILTER : bit_vector := "010";
		DEC_MCOMMA_DETECT : boolean := TRUE;
		DEC_PCOMMA_DETECT : boolean := TRUE;
		DEC_VALID_COMMA_ONLY : boolean := TRUE;
		DIGRX_FWDCLK : bit_vector := "00";
		DIGRX_SYNC_MODE : boolean := FALSE;
		ENABLE_DCDR : boolean := FALSE;
		FDET_HYS_CAL : bit_vector := "010";
		FDET_HYS_SEL : bit_vector := "100";
		FDET_LCK_CAL : bit_vector := "100";
		FDET_LCK_SEL : bit_vector := "001";
		GT11_MODE : string := "DONT_CARE";
		IREFBIASMODE : bit_vector := "11";
		LOOPCAL_WAIT : bit_vector := "00";
		MCOMMA_32B_VALUE : bit_vector := X"00000000";
		MCOMMA_DETECT : boolean := TRUE;
		OPPOSITE_SELECT : boolean := FALSE;
		PCOMMA_32B_VALUE : bit_vector := X"00000000";
		PCOMMA_DETECT : boolean := TRUE;
		PCS_BIT_SLIP : boolean := FALSE;
		PMACLKENABLE : boolean := TRUE;
		PMACOREPWRENABLE : boolean := TRUE;
		PMAIREFTRIM : bit_vector := "0111";
		PMAVBGCTRL : bit_vector := "00000";
		PMAVREFTRIM : bit_vector := "0111";
		PMA_BIT_SLIP : boolean := FALSE;
		POWER_ENABLE : boolean := TRUE;
		REPEATER : boolean := FALSE;
		RXACTST : boolean := FALSE;
		RXAFEEQ : bit_vector := "000000000";
		RXAFEPD : boolean := FALSE;
		RXAFETST : boolean := FALSE;
		RXAPD : boolean := FALSE;
		RXAREGCTRL : bit_vector := "00000";
		RXASYNCDIVIDE : bit_vector := "11";
		RXBY_32 : boolean := FALSE;
		RXCDRLOS : bit_vector := "000000";
		RXCLK0_FORCE_PMACLK : boolean := FALSE;
		RXCLKMODE : bit_vector := "110001";
		RXCLMODE : bit_vector := "00";
		RXCMADJ : bit_vector := "01";
		RXCPSEL : boolean := TRUE;
		RXCPTST : boolean := FALSE;
		RXCRCCLOCKDOUBLE : boolean := FALSE;
		RXCRCENABLE : boolean := FALSE;
		RXCRCINITVAL : bit_vector := X"00000000";
		RXCRCINVERTGEN : boolean := FALSE;
		RXCRCSAMECLOCK : boolean := FALSE;
		RXCTRL1 : bit_vector := X"200";
		RXCYCLE_LIMIT_SEL : bit_vector := "00";
		RXDATA_SEL : bit_vector := "00";
		RXDCCOUPLE : boolean := FALSE;
		RXDIGRESET : boolean := FALSE;
		RXDIGRX : boolean := FALSE;
		RXEQ : bit_vector := X"4000000000000000";
		RXFDCAL_CLOCK_DIVIDE : string := "NONE";
		RXFDET_HYS_CAL : bit_vector := "010";
		RXFDET_HYS_SEL : bit_vector := "100";
		RXFDET_LCK_CAL : bit_vector := "100";
		RXFDET_LCK_SEL : bit_vector := "001";
		RXFECONTROL1 : bit_vector := "00";
		RXFECONTROL2 : bit_vector := "000";
		RXFETUNE : bit_vector := "01";
		RXLB : boolean := FALSE;
		RXLKADJ : bit_vector := "00000";
		RXLKAPD : boolean := FALSE;
		RXLOOPCAL_WAIT : bit_vector := "00";
		RXLOOPFILT : bit_vector := "0111";
		RXMODE : bit_vector := "000000";
		RXOUTDIV2SEL : integer := 1;
		RXPD : boolean := FALSE;
		RXPDDTST : boolean := TRUE;
		RXPLLNDIVSEL : integer := 8;
		RXPMACLKSEL : string := "REFCLK1";
		RXRCPADJ : bit_vector := "011";
		RXRCPPD : boolean := FALSE;
		RXRECCLK1_USE_SYNC : boolean := FALSE;
		RXRIBADJ : bit_vector := "11";
		RXRPDPD : boolean := FALSE;
		RXRSDPD : boolean := FALSE;
		RXSLOWDOWN_CAL : bit_vector := "00";
		RXTUNE : bit_vector := X"0000";
		RXUSRDIVISOR : integer := 1;
		RXVCODAC_INIT : bit_vector := "1010000000";
		RXVCO_CTRL_ENABLE : boolean := FALSE;
		RX_BUFFER_USE : boolean := TRUE;
		RX_CLOCK_DIVIDER : bit_vector := "00";
		SAMPLE_8X : boolean := FALSE;
		SH_CNT_MAX : integer := 64;
		SH_INVALID_CNT_MAX : integer := 16;
		SLOWDOWN_CAL : bit_vector := "00";
		TXABPMACLKSEL : string := "REFCLK1";
		TXAPD : boolean := FALSE;
		TXAREFBIASSEL : boolean := TRUE;
		TXASYNCDIVIDE : bit_vector := "11";
		TXCLK0_FORCE_PMACLK : boolean := FALSE;
		TXCLKMODE : bit_vector := "1001";
		TXCLMODE : bit_vector := "00";
		TXCPSEL : boolean := TRUE;
		TXCRCCLOCKDOUBLE : boolean := FALSE;
		TXCRCENABLE : boolean := FALSE;
		TXCRCINITVAL : bit_vector := X"00000000";
		TXCRCINVERTGEN : boolean := FALSE;
		TXCRCSAMECLOCK : boolean := FALSE;
		TXCTRL1 : bit_vector := X"200";
		TXDATA_SEL : bit_vector := "00";
		TXDAT_PRDRV_DAC : bit_vector := "111";
		TXDAT_TAP_DAC : bit_vector := "10110";
		TXDIGPD : boolean := FALSE;
		TXFDCAL_CLOCK_DIVIDE : string := "NONE";
		TXHIGHSIGNALEN : boolean := TRUE;
		TXLOOPFILT : bit_vector := "0111";
		TXLVLSHFTPD : boolean := FALSE;
		TXOUTCLK1_USE_SYNC : boolean := FALSE;
		TXOUTDIV2SEL : integer := 1;
		TXPD : boolean := FALSE;
		TXPHASESEL : boolean := FALSE;
		TXPLLNDIVSEL : integer := 8;
		TXPOST_PRDRV_DAC : bit_vector := "111";
		TXPOST_TAP_DAC : bit_vector := "01110";
		TXPOST_TAP_PD : boolean := TRUE;
		TXPRE_PRDRV_DAC : bit_vector := "111";
		TXPRE_TAP_DAC : bit_vector := "00000";
		TXPRE_TAP_PD : boolean := TRUE;
		TXSLEWRATE : boolean := FALSE;
		TXTERMTRIM : bit_vector := "1100";
		TXTUNE : bit_vector := X"0000";
		TX_BUFFER_USE : boolean := TRUE;
		TX_CLOCK_DIVIDER : bit_vector := "00";
		VCODAC_INIT : bit_vector := "1010000000";
		VCO_CTRL_ENABLE : boolean := FALSE;
		VREFBIASMODE : bit_vector := "11";


--  Pin pulse width delays
--  Pin period delays
        tperiod_RXUSRCLK_posedge : VitalDelayType := 0.0 ns;
        tperiod_RXUSRCLK2_posedge : VitalDelayType := 0.0 ns;
        tperiod_TXUSRCLK_posedge : VitalDelayType := 0.0 ns;
        tperiod_TXUSRCLK2_posedge : VitalDelayType := 0.0 ns;
        tperiod_RXCRCCLK_posedge : VitalDelayType := 0.0 ns;
        tperiod_RXCRCINTCLK_posedge : VitalDelayType := 0.0 ns;
        tperiod_TXCRCCLK_posedge : VitalDelayType := 0.0 ns;
        tperiod_TXCRCINTCLK_posedge : VitalDelayType := 0.0 ns;
        tperiod_DCLK_posedge : VitalDelayType := 0.0 ns;

--  Input Pin path delays
        tipd_CHBONDI : VitalDelayArrayType01 (4 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_COMBUSIN : VitalDelayArrayType(15 downto 0) := (others => 0.000 ns);         
        tipd_ENCHANSYNC : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_ENMCOMMAALIGN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_ENPCOMMAALIGN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_LOOPBACK : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_POWERDOWN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXBLOCKSYNC64B66BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCOMMADETUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXDATAWIDTH : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_RXDEC64B66BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXDEC8B10BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXDESCRAM64B66BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXIGNOREBTF : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXINTDATAWIDTH : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_RXPOLARITY : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXRESET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXSLIDE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXUSRCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXUSRCLK2 : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXBYPASS8B10B : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXCHARDISPMODE : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXCHARDISPVAL : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXCHARISK : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXDATA : VitalDelayArrayType01 (63 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXDATAWIDTH : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXENC64B66BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXENC8B10BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXGEARBOX64B66BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXINHIBIT : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXINTDATAWIDTH : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXPOLARITY : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXRESET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXSCRAM64B66BUSE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXUSRCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXUSRCLK2 : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCLKSTABLE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXPMARESET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXCLKSTABLE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXPMARESET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCRCIN : VitalDelayArrayType01 (63 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_RXCRCDATAWIDTH : VitalDelayArrayType01 (2 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_RXCRCDATAVALID : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCRCINIT : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCRCRESET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCRCPD : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCRCCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXCRCINTCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXCRCIN : VitalDelayArrayType01 (63 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXCRCDATAWIDTH : VitalDelayArrayType01 (2 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TXCRCDATAVALID : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXCRCINIT : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXCRCRESET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXCRCPD : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXCRCCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXCRCINTCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXSYNC : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RXSYNC : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TXENOOB : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_DCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_DADDR : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_DEN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_DWE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_DI : VitalDelayArrayType01 (15 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_RX1P : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RX1N : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_GREFCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_REFCLK1 : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_REFCLK2 : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_GSR : VitalDelayType01 := (0.0 ns, 0.0 ns);
--  clk-to-output path delays
        tpd_RXUSRCLK_CHBONDO : VitalDelayArrayType01(4 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXSTATUS : VitalDelayArrayType01(5 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXCHARISCOMMA : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXCHARISK : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXCOMMADET : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RXUSRCLK2_RXDATA : VitalDelayArrayType01(63 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXDISPERR : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXLOSSOFSYNC : VitalDelayArrayType01(1 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXNOTINTABLE : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXREALIGN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RXUSRCLK2_RXRUNDISP : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXBUFERR : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_TXUSRCLK2_TXBUFERR : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_TXUSRCLK2_TXKERR : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_TXUSRCLK2_TXRUNDISP : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXLOCK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_TXUSRCLK2_TXLOCK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RXUSRCLK2_RXCYCLELIMIT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_TXUSRCLK2_TXCYCLELIMIT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_TXUSRCLK2_RXCALFAIL : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_TXUSRCLK2_TXCALFAIL : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RXCRCINTCLK_RXCRCOUT : VitalDelayArrayType01(31 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_TXCRCINTCLK_TXCRCOUT : VitalDelayArrayType01(31 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_RXUSRCLK2_RXSIGDET : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DCLK_DRDY : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DCLK_DO : VitalDelayArrayType01(15 downto 0) := (others => (0.1 ns, 0.1 ns));

--  Setup/Hold delays
        tsetup_CHBONDI_RXUSRCLK_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0.0 ns);
        tsetup_CHBONDI_RXUSRCLK_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0.0 ns);
        thold_CHBONDI_RXUSRCLK_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0.0 ns);
        thold_CHBONDI_RXUSRCLK_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0.0 ns);
        tsetup_ENCHANSYNC_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ENCHANSYNC_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_ENCHANSYNC_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_ENCHANSYNC_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ENMCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ENMCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_ENMCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_ENMCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ENPCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_ENPCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_ENPCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_ENPCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXIGNOREBTF_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXIGNOREBTF_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXIGNOREBTF_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXIGNOREBTF_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXRESET_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXRESET_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXRESET_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXRESET_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXSLIDE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXSLIDE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXSLIDE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXSLIDE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXCHARISK_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_TXCHARISK_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_TXDATA_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        tsetup_TXDATA_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        thold_TXDATA_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        thold_TXDATA_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        tsetup_TXRESET_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXRESET_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXRESET_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXRESET_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCLKSTABLE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCLKSTABLE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCLKSTABLE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCLKSTABLE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXPMARESET_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXPMARESET_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXPMARESET_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXPMARESET_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCLKSTABLE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCLKSTABLE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCLKSTABLE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCLKSTABLE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXPMARESET_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXPMARESET_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXPMARESET_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXPMARESET_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        thold_RXCRCIN_RXCRCINTCLK_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        thold_RXCRCIN_RXCRCINTCLK_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_RXCRCDATAVALID_RXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCRCDATAVALID_RXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCRCDATAVALID_RXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCRCDATAVALID_RXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCRCINIT_RXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCRCINIT_RXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCRCINIT_RXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCRCINIT_RXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCRCRESET_RXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXCRCRESET_RXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCRCRESET_RXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXCRCRESET_RXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        thold_TXCRCIN_TXCRCINTCLK_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        thold_TXCRCIN_TXCRCINTCLK_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0.0 ns);
        tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_TXCRCDATAVALID_TXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCRCDATAVALID_TXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCRCDATAVALID_TXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCRCDATAVALID_TXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCRCINIT_TXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCRCINIT_TXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCRCINIT_TXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCRCINIT_TXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCRCRESET_TXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXCRCRESET_TXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCRCRESET_TXCRCINTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXCRCRESET_TXCRCINTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXSYNC_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXSYNC_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXSYNC_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXSYNC_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXSYNC_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_RXSYNC_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXSYNC_RXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_RXSYNC_RXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXENOOB_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TXENOOB_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXENOOB_TXUSRCLK2_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_TXENOOB_TXUSRCLK2_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_DEN_DCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_DEN_DCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_DEN_DCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_DEN_DCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_DWE_DCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_DWE_DCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_DWE_DCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_DWE_DCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);

--  Clock ticd

        ticd_RXUSRCLK : VitalDelayType := 0.000 ns;
        ticd_RXUSRCLK2 : VitalDelayType := 0.000 ns;
        ticd_TXUSRCLK2 : VitalDelayType := 0.000 ns;
        ticd_RXCRCINTCLK : VitalDelayType := 0.000 ns;
        ticd_TXCRCINTCLK : VitalDelayType := 0.000 ns;
        ticd_DCLK : VitalDelayType := 0.000 ns;

-- Clock-to-pin tisd 
        tisd_CHBONDI : VitalDelayArrayType(4 downto 0) := (others => 0.000 ns);
        tisd_ENCHANSYNC : VitalDelayType := 0.000 ns;
        tisd_ENMCOMMAALIGN : VitalDelayType := 0.000 ns;
        tisd_ENPCOMMAALIGN : VitalDelayType := 0.000 ns;
        tisd_RXCOMMADETUSE : VitalDelayType := 0.000 ns;
        tisd_RXIGNOREBTF : VitalDelayType := 0.000 ns;
        tisd_RXRESET : VitalDelayType := 0.000 ns;
        tisd_RXSLIDE : VitalDelayType := 0.000 ns;
        tisd_TXBYPASS8B10B : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_TXCHARDISPMODE : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_TXCHARDISPVAL : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_TXCHARISK : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_TXDATA : VitalDelayArrayType(63 downto 0) := (others => 0.000 ns);
        tisd_TXRESET : VitalDelayType := 0.000 ns;
        tisd_RXCLKSTABLE : VitalDelayType := 0.000 ns;
        tisd_RXPMARESET : VitalDelayType := 0.000 ns;
        tisd_TXCLKSTABLE : VitalDelayType := 0.000 ns;
        tisd_TXPMARESET : VitalDelayType := 0.000 ns;
        tisd_RXCRCIN : VitalDelayArrayType(63 downto 0) := (others => 0.000 ns);
        tisd_RXCRCDATAWIDTH : VitalDelayArrayType(2 downto 0) := (others => 0.000 ns);
        tisd_RXCRCDATAVALID : VitalDelayType := 0.000 ns;
        tisd_RXCRCINIT : VitalDelayType := 0.000 ns;
        tisd_RXCRCRESET : VitalDelayType := 0.000 ns;
        tisd_TXCRCIN : VitalDelayArrayType(63 downto 0) := (others => 0.000 ns);
        tisd_TXCRCDATAWIDTH : VitalDelayArrayType(2 downto 0) := (others => 0.000 ns);
        tisd_TXCRCDATAVALID : VitalDelayType := 0.000 ns;
        tisd_TXCRCINIT : VitalDelayType := 0.000 ns;
        tisd_TXCRCRESET : VitalDelayType := 0.000 ns;
        tisd_TXSYNC : VitalDelayType := 0.000 ns;
        tisd_RXSYNC : VitalDelayType := 0.000 ns;
        tisd_TXENOOB : VitalDelayType := 0.000 ns;
        tisd_DADDR : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_DEN : VitalDelayType := 0.000 ns;
        tisd_DWE : VitalDelayType := 0.000 ns;
        tisd_DI : VitalDelayArrayType(15 downto 0) := (others => 0.000 ns)

  );

port (
		CHBONDO : out std_logic_vector(4 downto 0);
		COMBUSOUT : out std_logic_vector(15 downto 0);
		DO : out std_logic_vector(15 downto 0);
		DRDY : out std_ulogic;
		RXBUFERR : out std_ulogic;
		RXCALFAIL : out std_ulogic;
		RXCHARISCOMMA : out std_logic_vector(7 downto 0);
		RXCHARISK : out std_logic_vector(7 downto 0);
		RXCOMMADET : out std_ulogic;
		RXCRCOUT : out std_logic_vector(31 downto 0);
		RXCYCLELIMIT : out std_ulogic;
		RXDATA : out std_logic_vector(63 downto 0);
		RXDISPERR : out std_logic_vector(7 downto 0);
		RXLOCK : out std_ulogic;
		RXLOSSOFSYNC : out std_logic_vector(1 downto 0);
		RXMCLK : out std_ulogic;
		RXNOTINTABLE : out std_logic_vector(7 downto 0);
		RXPCSHCLKOUT : out std_ulogic;
		RXREALIGN : out std_ulogic;
		RXRECCLK1 : out std_ulogic;
		RXRECCLK2 : out std_ulogic;
		RXRUNDISP : out std_logic_vector(7 downto 0);
		RXSIGDET : out std_ulogic;
		RXSTATUS : out std_logic_vector(5 downto 0);
		TX1N : out std_ulogic;
		TX1P : out std_ulogic;
		TXBUFERR : out std_ulogic;
		TXCALFAIL : out std_ulogic;
		TXCRCOUT : out std_logic_vector(31 downto 0);
		TXCYCLELIMIT : out std_ulogic;
		TXKERR : out std_logic_vector(7 downto 0);
		TXLOCK : out std_ulogic;
		TXOUTCLK1 : out std_ulogic;
		TXOUTCLK2 : out std_ulogic;
		TXPCSHCLKOUT : out std_ulogic;
		TXRUNDISP : out std_logic_vector(7 downto 0);

		CHBONDI : in std_logic_vector(4 downto 0);
		COMBUSIN : in std_logic_vector(15 downto 0);
		DADDR : in std_logic_vector(7 downto 0);
		DCLK : in std_ulogic;
		DEN : in std_ulogic;
		DI : in std_logic_vector(15 downto 0);
		DWE : in std_ulogic;
		ENCHANSYNC : in std_ulogic;
		ENMCOMMAALIGN : in std_ulogic;
		ENPCOMMAALIGN : in std_ulogic;
		GREFCLK : in std_ulogic;
		LOOPBACK : in std_logic_vector(1 downto 0);
		POWERDOWN : in std_ulogic;
		REFCLK1 : in std_ulogic;
		REFCLK2 : in std_ulogic;
		RX1N : in std_ulogic;
		RX1P : in std_ulogic;
		RXBLOCKSYNC64B66BUSE : in std_ulogic;
		RXCLKSTABLE : in std_ulogic;
		RXCOMMADETUSE : in std_ulogic;
		RXCRCCLK : in std_ulogic;
		RXCRCDATAVALID : in std_ulogic;
		RXCRCDATAWIDTH : in std_logic_vector(2 downto 0);
		RXCRCIN : in std_logic_vector(63 downto 0);
		RXCRCINIT : in std_ulogic;
		RXCRCINTCLK : in std_ulogic;
		RXCRCPD : in std_ulogic;
		RXCRCRESET : in std_ulogic;
		RXDATAWIDTH : in std_logic_vector(1 downto 0);
		RXDEC64B66BUSE : in std_ulogic;
		RXDEC8B10BUSE : in std_ulogic;
		RXDESCRAM64B66BUSE : in std_ulogic;
		RXIGNOREBTF : in std_ulogic;
		RXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		RXPMARESET : in std_ulogic;
		RXPOLARITY : in std_ulogic;
		RXRESET : in std_ulogic;
		RXSLIDE : in std_ulogic;
		RXSYNC : in std_ulogic;
		RXUSRCLK : in std_ulogic;
		RXUSRCLK2 : in std_ulogic;
		TXBYPASS8B10B : in std_logic_vector(7 downto 0);
		TXCHARDISPMODE : in std_logic_vector(7 downto 0);
		TXCHARDISPVAL : in std_logic_vector(7 downto 0);
		TXCHARISK : in std_logic_vector(7 downto 0);
		TXCLKSTABLE : in std_ulogic;
		TXCRCCLK : in std_ulogic;
		TXCRCDATAVALID : in std_ulogic;
		TXCRCDATAWIDTH : in std_logic_vector(2 downto 0);
		TXCRCIN : in std_logic_vector(63 downto 0);
		TXCRCINIT : in std_ulogic;
		TXCRCINTCLK : in std_ulogic;
		TXCRCPD : in std_ulogic;
		TXCRCRESET : in std_ulogic;
		TXDATA : in std_logic_vector(63 downto 0);
		TXDATAWIDTH : in std_logic_vector(1 downto 0);
		TXENC64B66BUSE : in std_ulogic;
		TXENC8B10BUSE : in std_ulogic;
		TXENOOB : in std_ulogic;
		TXGEARBOX64B66BUSE : in std_ulogic;
		TXINHIBIT : in std_ulogic;
		TXINTDATAWIDTH : in std_logic_vector(1 downto 0);
		TXPMARESET : in std_ulogic;
		TXPOLARITY : in std_ulogic;
		TXRESET : in std_ulogic;
		TXSCRAM64B66BUSE : in std_ulogic;
		TXSYNC : in std_ulogic;
		TXUSRCLK : in std_ulogic;
		TXUSRCLK2 : in std_ulogic
     );
end X_GT11;

-- Architecture body --

architecture X_GT11_V of X_GT11 is

  component GT11_SWIFT
    port (
      CHBONDO              : out std_logic_vector(4 downto 0);
      COMBUSOUT            : out std_logic_vector(15 downto 0);
      DO                   : out std_logic_vector(15 downto 0);
      DRDY                 : out std_ulogic;
      RXBUFERR             : out std_ulogic;
      RXCALFAIL            : out std_ulogic;
      RXCHARISCOMMA        : out std_logic_vector(7 downto 0);
      RXCHARISK            : out std_logic_vector(7 downto 0);
      RXCOMMADET           : out std_ulogic;
      RXCRCOUT             : out std_logic_vector(31 downto 0);
      RXCYCLELIMIT         : out std_ulogic;
      RXDATA               : out std_logic_vector(63 downto 0);
      RXDISPERR            : out std_logic_vector(7 downto 0);
      RXLOCK               : out std_ulogic;
      RXLOSSOFSYNC         : out std_logic_vector(1 downto 0);
      RXMCLK               : out std_ulogic;
      RXNOTINTABLE         : out std_logic_vector(7 downto 0);
      RXPCSHCLKOUT         : out std_ulogic;
      RXREALIGN            : out std_ulogic;
      RXRECCLK1            : out std_ulogic;
      RXRECCLK2            : out std_ulogic;
      RXRUNDISP            : out std_logic_vector(7 downto 0);
      RXSIGDET             : out std_ulogic;
      RXSTATUS             : out std_logic_vector(5 downto 0);
      TX1N                 : out std_ulogic;
      TX1P                 : out std_ulogic;
      TXBUFERR             : out std_ulogic;
      TXCALFAIL            : out std_ulogic;
      TXCRCOUT             : out std_logic_vector(31 downto 0);
      TXCYCLELIMIT         : out std_ulogic;
      TXKERR               : out std_logic_vector(7 downto 0);
      TXLOCK               : out std_ulogic;
      TXOUTCLK1            : out std_ulogic;
      TXOUTCLK2            : out std_ulogic;
      TXPCSHCLKOUT         : out std_ulogic;
      TXRUNDISP            : out std_logic_vector(7 downto 0);

      GT11_MODE : in std_logic_vector(1 downto 0);
      
      PMACFG : in std_logic_vector(63 downto 0);
      PMACFG2 : in std_logic_vector(63 downto 0);
      RXACLCFG : in std_logic_vector(63 downto 0);
      RXAEQCFG : in std_logic_vector(63 downto 0);
      RXAFECFG : in std_logic_vector(63 downto 0);
      synDigCfgChnBnd1 : in std_logic_vector(63 downto 0);
      synDigCfgChnBnd2 : in std_logic_vector(63 downto 0);
      synDigCfgClkCor1 : in std_logic_vector(63 downto 0);
      synDigCfgClkCor2 : in std_logic_vector(63 downto 0);
      synDigCfgComma1 : in std_logic_vector(63 downto 0);
      synDigCfgComma2 : in std_logic_vector(63 downto 0);
      synDigCfgCrc : in std_logic_vector(63 downto 0);
      synDigCfgMisc : in std_logic_vector(63 downto 0);
      synDigCfgSynPmaFD : in std_logic_vector(63 downto 0);
      TXACFG : in std_logic_vector(63 downto 0);
      TXCLCFG : in std_logic_vector(63 downto 0);                  

      CHBONDI              : in std_logic_vector(4 downto 0);
      COMBUSIN             : in std_logic_vector(15 downto 0);
      DADDR                : in std_logic_vector(7 downto 0);
      DCLK                 : in std_ulogic;
      DEN                  : in std_ulogic;
      DI                   : in std_logic_vector(15 downto 0);
      DWE                  : in std_ulogic;
      ENCHANSYNC           : in std_ulogic;
      ENMCOMMAALIGN        : in std_ulogic;
      ENPCOMMAALIGN        : in std_ulogic;
      GREFCLK              : in std_ulogic;
      GSR : in std_ulogic;
      LOOPBACK             : in std_logic_vector(1 downto 0);
      POWERDOWN            : in std_ulogic;
      REFCLK1              : in std_ulogic;
      REFCLK2              : in std_ulogic;
      RX1N                 : in std_ulogic;
      RX1P                 : in std_ulogic;
      RXBLOCKSYNC64B66BUSE : in std_ulogic;
      RXCLKSTABLE          : in std_ulogic;
      RXCOMMADETUSE        : in std_ulogic;
      RXCRCCLK             : in std_ulogic;
      RXCRCDATAVALID       : in std_ulogic;
      RXCRCDATAWIDTH       : in std_logic_vector(2 downto 0);
      RXCRCIN              : in std_logic_vector(63 downto 0);
      RXCRCINIT            : in std_ulogic;
      RXCRCINTCLK          : in std_ulogic;
      RXCRCPD              : in std_ulogic;
      RXCRCRESET           : in std_ulogic;
      RXDATAWIDTH          : in std_logic_vector(1 downto 0);
      RXDEC64B66BUSE       : in std_ulogic;
      RXDEC8B10BUSE        : in std_ulogic;
      RXDESCRAM64B66BUSE   : in std_ulogic;
      RXIGNOREBTF          : in std_ulogic;
      RXINTDATAWIDTH       : in std_logic_vector(1 downto 0);
      RXPMARESET           : in std_ulogic;
      RXPOLARITY           : in std_ulogic;
      RXRESET              : in std_ulogic;
      RXSLIDE              : in std_ulogic;
      RXSYNC               : in std_ulogic;
      RXUSRCLK             : in std_ulogic;
      RXUSRCLK2            : in std_ulogic;
      TXBYPASS8B10B        : in std_logic_vector(7 downto 0);
      TXCHARDISPMODE       : in std_logic_vector(7 downto 0);
      TXCHARDISPVAL        : in std_logic_vector(7 downto 0);
      TXCHARISK            : in std_logic_vector(7 downto 0);
      TXCLKSTABLE          : in std_ulogic;
      TXCRCCLK             : in std_ulogic;
      TXCRCDATAVALID       : in std_ulogic;
      TXCRCDATAWIDTH       : in std_logic_vector(2 downto 0);
      TXCRCIN              : in std_logic_vector(63 downto 0);
      TXCRCINIT            : in std_ulogic;
      TXCRCINTCLK          : in std_ulogic;
      TXCRCPD              : in std_ulogic;
      TXCRCRESET           : in std_ulogic;
      TXDATA               : in std_logic_vector(63 downto 0);
      TXDATAWIDTH          : in std_logic_vector(1 downto 0);
      TXENC64B66BUSE       : in std_ulogic;
      TXENC8B10BUSE        : in std_ulogic;
      TXENOOB              : in std_ulogic;
      TXGEARBOX64B66BUSE   : in std_ulogic;
      TXINHIBIT            : in std_ulogic;
      TXINTDATAWIDTH       : in std_logic_vector(1 downto 0);
      TXPMARESET           : in std_ulogic;
      TXPOLARITY           : in std_ulogic;
      TXRESET              : in std_ulogic;
      TXSCRAM64B66BUSE     : in std_ulogic;
      TXSYNC               : in std_ulogic;
      TXUSRCLK             : in std_ulogic;
      TXUSRCLK2            : in std_ulogic
    );
  end component;

-- Attribute-to-Cell mapping signals
        signal   GT11_MODE_BINARY  :  std_logic_vector(1 downto 0);


-- Input/Output Pin signals

        signal   GSR_ipd  :  std_ulogic;
        signal   CHBONDI_ipd  :  std_logic_vector(4 downto 0);
        signal   ENCHANSYNC_ipd  :  std_ulogic;
        signal   ENMCOMMAALIGN_ipd  :  std_ulogic;
        signal   ENPCOMMAALIGN_ipd  :  std_ulogic;
        signal   LOOPBACK_ipd  :  std_logic_vector(1 downto 0);
        signal   POWERDOWN_ipd  :  std_ulogic;
        signal   RXBLOCKSYNC64B66BUSE_ipd  :  std_ulogic;
        signal   RXCOMMADETUSE_ipd  :  std_ulogic;
        signal   RXDATAWIDTH_ipd  :  std_logic_vector(1 downto 0);
        signal   RXDEC64B66BUSE_ipd  :  std_ulogic;
        signal   RXDEC8B10BUSE_ipd  :  std_ulogic;
        signal   RXDESCRAM64B66BUSE_ipd  :  std_ulogic;
        signal   RXIGNOREBTF_ipd  :  std_ulogic;
        signal   RXINTDATAWIDTH_ipd  :  std_logic_vector(1 downto 0);
        signal   RXPOLARITY_ipd  :  std_ulogic;
        signal   RXRESET_ipd  :  std_ulogic;
        signal   RXSLIDE_ipd  :  std_ulogic;
        signal   RXUSRCLK_ipd  :  std_ulogic;
        signal   RXUSRCLK2_ipd  :  std_ulogic;
        signal   TXBYPASS8B10B_ipd  :  std_logic_vector(7 downto 0);
        signal   TXCHARDISPMODE_ipd  :  std_logic_vector(7 downto 0);
        signal   TXCHARDISPVAL_ipd  :  std_logic_vector(7 downto 0);
        signal   TXCHARISK_ipd  :  std_logic_vector(7 downto 0);
        signal   TXDATA_ipd  :  std_logic_vector(63 downto 0);
        signal   TXDATAWIDTH_ipd  :  std_logic_vector(1 downto 0);
        signal   TXENC64B66BUSE_ipd  :  std_ulogic;
        signal   TXENC8B10BUSE_ipd  :  std_ulogic;
        signal   TXGEARBOX64B66BUSE_ipd  :  std_ulogic;
        signal   TXINHIBIT_ipd  :  std_ulogic;
        signal   TXINTDATAWIDTH_ipd  :  std_logic_vector(1 downto 0);
        signal   TXPOLARITY_ipd  :  std_ulogic;
        signal   TXRESET_ipd  :  std_ulogic;
        signal   TXSCRAM64B66BUSE_ipd  :  std_ulogic;
        signal   TXUSRCLK_ipd  :  std_ulogic;
        signal   TXUSRCLK2_ipd  :  std_ulogic;
        signal   RXCLKSTABLE_ipd  :  std_ulogic;
        signal   RXPMARESET_ipd  :  std_ulogic;
        signal   TXCLKSTABLE_ipd  :  std_ulogic;
        signal   TXPMARESET_ipd  :  std_ulogic;
        signal   RXCRCIN_ipd  :  std_logic_vector(63 downto 0);
        signal   RXCRCDATAWIDTH_ipd  :  std_logic_vector(2 downto 0);
        signal   RXCRCDATAVALID_ipd  :  std_ulogic;
        signal   RXCRCINIT_ipd  :  std_ulogic;
        signal   RXCRCRESET_ipd  :  std_ulogic;
        signal   RXCRCPD_ipd  :  std_ulogic;
        signal   RXCRCCLK_ipd  :  std_ulogic;
        signal   RXCRCINTCLK_ipd  :  std_ulogic;
        signal   TXCRCIN_ipd  :  std_logic_vector(63 downto 0);
        signal   TXCRCDATAWIDTH_ipd  :  std_logic_vector(2 downto 0);
        signal   TXCRCDATAVALID_ipd  :  std_ulogic;
        signal   TXCRCINIT_ipd  :  std_ulogic;
        signal   TXCRCRESET_ipd  :  std_ulogic;
        signal   TXCRCPD_ipd  :  std_ulogic;
        signal   TXCRCCLK_ipd  :  std_ulogic;
        signal   TXCRCINTCLK_ipd  :  std_ulogic;
        signal   TXSYNC_ipd  :  std_ulogic;
        signal   RXSYNC_ipd  :  std_ulogic;
        signal   TXENOOB_ipd  :  std_ulogic;
        signal   DCLK_ipd  :  std_ulogic;
        signal   DADDR_ipd  :  std_logic_vector(7 downto 0);
        signal   DEN_ipd  :  std_ulogic;
        signal   DWE_ipd  :  std_ulogic;
        signal   DI_ipd  :  std_logic_vector(15 downto 0);
        signal   RX1P_ipd  :  std_ulogic;
        signal   RX1N_ipd  :  std_ulogic;
        signal   GREFCLK_ipd  :  std_ulogic;
        signal   REFCLK1_ipd  :  std_ulogic;
        signal   REFCLK2_ipd  :  std_ulogic;
        signal   COMBUSIN_ipd  :  std_logic_vector(15 downto 0);

        signal   CHBONDO_out  :  std_logic_vector(4 downto 0);
        signal   RXSTATUS_out  :  std_logic_vector(5 downto 0);
        signal   RXCHARISCOMMA_out  :  std_logic_vector(7 downto 0);
        signal   RXCHARISK_out  :  std_logic_vector(7 downto 0);
        signal   RXCOMMADET_out  :  std_ulogic;
        signal   RXDATA_out  :  std_logic_vector(63 downto 0);
        signal   RXDISPERR_out  :  std_logic_vector(7 downto 0);
        signal   RXLOSSOFSYNC_out  :  std_logic_vector(1 downto 0);
        signal   RXNOTINTABLE_out  :  std_logic_vector(7 downto 0);
        signal   RXREALIGN_out  :  std_ulogic;
        signal   RXRUNDISP_out  :  std_logic_vector(7 downto 0);
        signal   RXBUFERR_out  :  std_ulogic;
        signal   TXBUFERR_out  :  std_ulogic;
        signal   TXKERR_out  :  std_logic_vector(7 downto 0);
        signal   TXRUNDISP_out  :  std_logic_vector(7 downto 0);
        signal   RXRECCLK1_out  :  std_ulogic;
        signal   RXRECCLK2_out  :  std_ulogic;
        signal   TXOUTCLK1_out  :  std_ulogic;
        signal   TXOUTCLK2_out  :  std_ulogic;
        signal   RXLOCK_out  :  std_ulogic;
        signal   TXLOCK_out  :  std_ulogic;
        signal   RXCYCLELIMIT_out  :  std_ulogic;
        signal   TXCYCLELIMIT_out  :  std_ulogic;
        signal   RXCALFAIL_out  :  std_ulogic;
        signal   TXCALFAIL_out  :  std_ulogic;
        signal   RXCRCOUT_out  :  std_logic_vector(31 downto 0);
        signal   TXCRCOUT_out  :  std_logic_vector(31 downto 0);
        signal   RXSIGDET_out  :  std_ulogic;
        signal   DRDY_out  :  std_ulogic;
        signal   DO_out  :  std_logic_vector(15 downto 0);
        signal   RXMCLK_out  :  std_ulogic;
        signal   TX1P_out  :  std_ulogic;
        signal   TX1N_out  :  std_ulogic;
        signal   TXPCSHCLKOUT_out  :  std_ulogic;
        signal   RXPCSHCLKOUT_out  :  std_ulogic;
        signal   COMBUSOUT_out  :  std_logic_vector(15 downto 0);

        signal   GSR_dly  :  std_ulogic;
        signal   CHBONDI_dly  :  std_logic_vector(4 downto 0);
        signal   ENCHANSYNC_dly  :  std_ulogic;
        signal   ENMCOMMAALIGN_dly  :  std_ulogic;
        signal   ENPCOMMAALIGN_dly  :  std_ulogic;
        signal   LOOPBACK_dly  :  std_logic_vector(1 downto 0);
        signal   POWERDOWN_dly  :  std_ulogic;
        signal   RXBLOCKSYNC64B66BUSE_dly  :  std_ulogic;
        signal   RXCOMMADETUSE_dly  :  std_ulogic;
        signal   RXDATAWIDTH_dly  :  std_logic_vector(1 downto 0);
        signal   RXDEC64B66BUSE_dly  :  std_ulogic;
        signal   RXDEC8B10BUSE_dly  :  std_ulogic;
        signal   RXDESCRAM64B66BUSE_dly  :  std_ulogic;
        signal   RXIGNOREBTF_dly  :  std_ulogic;
        signal   RXINTDATAWIDTH_dly  :  std_logic_vector(1 downto 0);
        signal   RXPOLARITY_dly  :  std_ulogic;
        signal   RXRESET_dly  :  std_ulogic;
        signal   RXSLIDE_dly  :  std_ulogic;
        signal   RXUSRCLK_dly  :  std_ulogic;
        signal   RXUSRCLK2_dly  :  std_ulogic;
        signal   TXBYPASS8B10B_dly  :  std_logic_vector(7 downto 0);
        signal   TXCHARDISPMODE_dly  :  std_logic_vector(7 downto 0);
        signal   TXCHARDISPVAL_dly  :  std_logic_vector(7 downto 0);
        signal   TXCHARISK_dly  :  std_logic_vector(7 downto 0);
        signal   TXDATA_dly  :  std_logic_vector(63 downto 0);
        signal   TXDATAWIDTH_dly  :  std_logic_vector(1 downto 0);
        signal   TXENC64B66BUSE_dly  :  std_ulogic;
        signal   TXENC8B10BUSE_dly  :  std_ulogic;
        signal   TXGEARBOX64B66BUSE_dly  :  std_ulogic;
        signal   TXINHIBIT_dly  :  std_ulogic;
        signal   TXINTDATAWIDTH_dly  :  std_logic_vector(1 downto 0);
        signal   TXPOLARITY_dly  :  std_ulogic;
        signal   TXRESET_dly  :  std_ulogic;
        signal   TXSCRAM64B66BUSE_dly  :  std_ulogic;
        signal   TXUSRCLK_dly  :  std_ulogic;
        signal   TXUSRCLK2_dly  :  std_ulogic;
        signal   RXCLKSTABLE_dly  :  std_ulogic;
        signal   RXPMARESET_dly  :  std_ulogic;
        signal   TXCLKSTABLE_dly  :  std_ulogic;
        signal   TXPMARESET_dly  :  std_ulogic;
        signal   RXCRCIN_dly  :  std_logic_vector(63 downto 0);
        signal   RXCRCDATAWIDTH_dly  :  std_logic_vector(2 downto 0);
        signal   RXCRCDATAVALID_dly  :  std_ulogic;
        signal   RXCRCINIT_dly  :  std_ulogic;
        signal   RXCRCRESET_dly  :  std_ulogic;
        signal   RXCRCPD_dly  :  std_ulogic;
        signal   RXCRCCLK_dly  :  std_ulogic;
        signal   RXCRCINTCLK_dly  :  std_ulogic;
        signal   TXCRCIN_dly  :  std_logic_vector(63 downto 0);
        signal   TXCRCDATAWIDTH_dly  :  std_logic_vector(2 downto 0);
        signal   TXCRCDATAVALID_dly  :  std_ulogic;
        signal   TXCRCINIT_dly  :  std_ulogic;
        signal   TXCRCRESET_dly  :  std_ulogic;
        signal   TXCRCPD_dly  :  std_ulogic;
        signal   TXCRCCLK_dly  :  std_ulogic;
        signal   TXCRCINTCLK_dly  :  std_ulogic;
        signal   TXSYNC_dly  :  std_ulogic;
        signal   RXSYNC_dly  :  std_ulogic;
        signal   TXENOOB_dly  :  std_ulogic;
        signal   DCLK_dly  :  std_ulogic;
        signal   DADDR_dly  :  std_logic_vector(7 downto 0);
        signal   DEN_dly  :  std_ulogic;
        signal   DWE_dly  :  std_ulogic;
        signal   DI_dly  :  std_logic_vector(15 downto 0);
        signal   RX1P_dly  :  std_ulogic;
        signal   RX1N_dly  :  std_ulogic;
        signal   GREFCLK_dly  :  std_ulogic;
        signal   REFCLK1_dly  :  std_ulogic;
        signal   REFCLK2_dly  :  std_ulogic;
        signal   COMBUSIN_dly  :  std_logic_vector(15 downto 0);

        signal PMACFG : std_logic_vector(63 downto 0);
        signal PMACFG2 : std_logic_vector(63 downto 0);
        signal RXACLCFG : std_logic_vector(63 downto 0);
        signal RXAEQCFG : std_logic_vector(63 downto 0);
        signal RXAFECFG : std_logic_vector(63 downto 0);
        signal TXACFG : std_logic_vector(63 downto 0);
        signal TXCLCFG : std_logic_vector(63 downto 0);
        signal synDigCfgChnBnd1 : std_logic_vector(63 downto 0);
        signal synDigCfgChnBnd2 : std_logic_vector(63 downto 0);
        signal synDigCfgClkCor1 : std_logic_vector(63 downto 0);
        signal synDigCfgClkCor2 : std_logic_vector(63 downto 0);
        signal synDigCfgComma1 : std_logic_vector(63 downto 0);
        signal synDigCfgComma2 : std_logic_vector(63 downto 0);
        signal synDigCfgCrc : std_logic_vector(63 downto 0);
        signal synDigCfgMisc : std_logic_vector(63 downto 0);
        signal synDigCfgSynPmaFD : std_logic_vector(63 downto 0);                 

begin


   WireDelay : block
       begin
           CHBONDI_DELAY : for i in 4 downto 0 generate
              VitalWireDelay (CHBONDI_ipd(i),CHBONDI(i),tipd_CHBONDI(i));
           end generate CHBONDI_DELAY;
              VitalWireDelay (ENCHANSYNC_ipd,ENCHANSYNC,tipd_ENCHANSYNC);
              VitalWireDelay (ENMCOMMAALIGN_ipd,ENMCOMMAALIGN,tipd_ENMCOMMAALIGN);
              VitalWireDelay (ENPCOMMAALIGN_ipd,ENPCOMMAALIGN,tipd_ENPCOMMAALIGN);
           LOOPBACK_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (LOOPBACK_ipd(i),LOOPBACK(i),tipd_LOOPBACK(i));
           end generate LOOPBACK_DELAY;
              VitalWireDelay (POWERDOWN_ipd,POWERDOWN,tipd_POWERDOWN);
              VitalWireDelay (RXBLOCKSYNC64B66BUSE_ipd,RXBLOCKSYNC64B66BUSE,tipd_RXBLOCKSYNC64B66BUSE);
              VitalWireDelay (RXCOMMADETUSE_ipd,RXCOMMADETUSE,tipd_RXCOMMADETUSE);
           RXDATAWIDTH_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXDATAWIDTH_ipd(i),RXDATAWIDTH(i),tipd_RXDATAWIDTH(i));
           end generate RXDATAWIDTH_DELAY;
              VitalWireDelay (RXDEC64B66BUSE_ipd,RXDEC64B66BUSE,tipd_RXDEC64B66BUSE);
              VitalWireDelay (RXDEC8B10BUSE_ipd,RXDEC8B10BUSE,tipd_RXDEC8B10BUSE);
              VitalWireDelay (RXDESCRAM64B66BUSE_ipd,RXDESCRAM64B66BUSE,tipd_RXDESCRAM64B66BUSE);
              VitalWireDelay (RXIGNOREBTF_ipd,RXIGNOREBTF,tipd_RXIGNOREBTF);
           RXINTDATAWIDTH_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXINTDATAWIDTH_ipd(i),RXINTDATAWIDTH(i),tipd_RXINTDATAWIDTH(i));
           end generate RXINTDATAWIDTH_DELAY;
              VitalWireDelay (RXPOLARITY_ipd,RXPOLARITY,tipd_RXPOLARITY);
              VitalWireDelay (RXRESET_ipd,RXRESET,tipd_RXRESET);
              VitalWireDelay (RXSLIDE_ipd,RXSLIDE,tipd_RXSLIDE);
              VitalWireDelay (RXUSRCLK_ipd,RXUSRCLK,tipd_RXUSRCLK);
              VitalWireDelay (RXUSRCLK2_ipd,RXUSRCLK2,tipd_RXUSRCLK2);
           TXBYPASS8B10B_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (TXBYPASS8B10B_ipd(i),TXBYPASS8B10B(i),tipd_TXBYPASS8B10B(i));
           end generate TXBYPASS8B10B_DELAY;
           TXCHARDISPMODE_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (TXCHARDISPMODE_ipd(i),TXCHARDISPMODE(i),tipd_TXCHARDISPMODE(i));
           end generate TXCHARDISPMODE_DELAY;
           TXCHARDISPVAL_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (TXCHARDISPVAL_ipd(i),TXCHARDISPVAL(i),tipd_TXCHARDISPVAL(i));
           end generate TXCHARDISPVAL_DELAY;
           TXCHARISK_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (TXCHARISK_ipd(i),TXCHARISK(i),tipd_TXCHARISK(i));
           end generate TXCHARISK_DELAY;
           TXDATA_DELAY : for i in 63 downto 0 generate
              VitalWireDelay (TXDATA_ipd(i),TXDATA(i),tipd_TXDATA(i));
           end generate TXDATA_DELAY;
           TXDATAWIDTH_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXDATAWIDTH_ipd(i),TXDATAWIDTH(i),tipd_TXDATAWIDTH(i));
           end generate TXDATAWIDTH_DELAY;
              VitalWireDelay (TXENC64B66BUSE_ipd,TXENC64B66BUSE,tipd_TXENC64B66BUSE);
              VitalWireDelay (TXENC8B10BUSE_ipd,TXENC8B10BUSE,tipd_TXENC8B10BUSE);
              VitalWireDelay (TXGEARBOX64B66BUSE_ipd,TXGEARBOX64B66BUSE,tipd_TXGEARBOX64B66BUSE);
              VitalWireDelay (TXINHIBIT_ipd,TXINHIBIT,tipd_TXINHIBIT);
           TXINTDATAWIDTH_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXINTDATAWIDTH_ipd(i),TXINTDATAWIDTH(i),tipd_TXINTDATAWIDTH(i));
           end generate TXINTDATAWIDTH_DELAY;
              VitalWireDelay (TXPOLARITY_ipd,TXPOLARITY,tipd_TXPOLARITY);
              VitalWireDelay (TXRESET_ipd,TXRESET,tipd_TXRESET);
              VitalWireDelay (TXSCRAM64B66BUSE_ipd,TXSCRAM64B66BUSE,tipd_TXSCRAM64B66BUSE);
              VitalWireDelay (TXUSRCLK_ipd,TXUSRCLK,tipd_TXUSRCLK);
              VitalWireDelay (TXUSRCLK2_ipd,TXUSRCLK2,tipd_TXUSRCLK2);
              VitalWireDelay (RXCLKSTABLE_ipd,RXCLKSTABLE,tipd_RXCLKSTABLE);
              VitalWireDelay (RXPMARESET_ipd,RXPMARESET,tipd_RXPMARESET);
              VitalWireDelay (TXCLKSTABLE_ipd,TXCLKSTABLE,tipd_TXCLKSTABLE);
              VitalWireDelay (TXPMARESET_ipd,TXPMARESET,tipd_TXPMARESET);
           RXCRCIN_DELAY : for i in 63 downto 0 generate
              VitalWireDelay (RXCRCIN_ipd(i),RXCRCIN(i),tipd_RXCRCIN(i));
           end generate RXCRCIN_DELAY;
           RXCRCDATAWIDTH_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (RXCRCDATAWIDTH_ipd(i),RXCRCDATAWIDTH(i),tipd_RXCRCDATAWIDTH(i));
           end generate RXCRCDATAWIDTH_DELAY;
              VitalWireDelay (RXCRCDATAVALID_ipd,RXCRCDATAVALID,tipd_RXCRCDATAVALID);
              VitalWireDelay (RXCRCINIT_ipd,RXCRCINIT,tipd_RXCRCINIT);
              VitalWireDelay (RXCRCRESET_ipd,RXCRCRESET,tipd_RXCRCRESET);
              VitalWireDelay (RXCRCPD_ipd,RXCRCPD,tipd_RXCRCPD);
              VitalWireDelay (RXCRCCLK_ipd,RXCRCCLK,tipd_RXCRCCLK);
              VitalWireDelay (RXCRCINTCLK_ipd,RXCRCINTCLK,tipd_RXCRCINTCLK);
           TXCRCIN_DELAY : for i in 63 downto 0 generate
              VitalWireDelay (TXCRCIN_ipd(i),TXCRCIN(i),tipd_TXCRCIN(i));
           end generate TXCRCIN_DELAY;
           TXCRCDATAWIDTH_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (TXCRCDATAWIDTH_ipd(i),TXCRCDATAWIDTH(i),tipd_TXCRCDATAWIDTH(i));
           end generate TXCRCDATAWIDTH_DELAY;
              VitalWireDelay (TXCRCDATAVALID_ipd,TXCRCDATAVALID,tipd_TXCRCDATAVALID);
              VitalWireDelay (TXCRCINIT_ipd,TXCRCINIT,tipd_TXCRCINIT);
              VitalWireDelay (TXCRCRESET_ipd,TXCRCRESET,tipd_TXCRCRESET);
              VitalWireDelay (TXCRCPD_ipd,TXCRCPD,tipd_TXCRCPD);
              VitalWireDelay (TXCRCCLK_ipd,TXCRCCLK,tipd_TXCRCCLK);
              VitalWireDelay (TXCRCINTCLK_ipd,TXCRCINTCLK,tipd_TXCRCINTCLK);
              VitalWireDelay (TXSYNC_ipd,TXSYNC,tipd_TXSYNC);
              VitalWireDelay (RXSYNC_ipd,RXSYNC,tipd_RXSYNC);
              VitalWireDelay (TXENOOB_ipd,TXENOOB,tipd_TXENOOB);
              VitalWireDelay (DCLK_ipd,DCLK,tipd_DCLK);
           DADDR_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (DADDR_ipd(i),DADDR(i),tipd_DADDR(i));
           end generate DADDR_DELAY;
              VitalWireDelay (DEN_ipd,DEN,tipd_DEN);
              VitalWireDelay (DWE_ipd,DWE,tipd_DWE);
           DI_DELAY : for i in 15 downto 0 generate
              VitalWireDelay (DI_ipd(i),DI(i),tipd_DI(i));
           end generate DI_DELAY;
              VitalWireDelay (RX1P_ipd,RX1P,tipd_RX1P);
              VitalWireDelay (RX1N_ipd,RX1N,tipd_RX1N);
              VitalWireDelay (GREFCLK_ipd,GREFCLK,tipd_GREFCLK);
              VitalWireDelay (REFCLK1_ipd,REFCLK1,tipd_REFCLK1);
              VitalWireDelay (REFCLK2_ipd,REFCLK2,tipd_REFCLK2);
           COMBUSIN_DELAY : for i in 15 downto 0 generate
              VitalWireDelay (COMBUSIN_ipd(i),COMBUSIN(i),tipd_COMBUSIN(i));
           end generate COMBUSIN_DELAY;
              VitalWireDelay (GSR_ipd,GSR,tipd_GSR);
       end block;

   SignalDelay : block
       begin
           CHBONDI_DELAY : for i in 4 downto 0 generate
              VitalSignalDelay (CHBONDI_dly(i),CHBONDI_ipd(i),tisd_CHBONDI(i));
           end generate CHBONDI_DELAY;
              VitalSignalDelay (ENCHANSYNC_dly,ENCHANSYNC_ipd,tisd_ENCHANSYNC);
              VitalSignalDelay (ENMCOMMAALIGN_dly,ENMCOMMAALIGN_ipd,tisd_ENMCOMMAALIGN);
              VitalSignalDelay (ENPCOMMAALIGN_dly,ENPCOMMAALIGN_ipd,tisd_ENPCOMMAALIGN);
              VitalSignalDelay (RXCOMMADETUSE_dly,RXCOMMADETUSE_ipd,tisd_RXCOMMADETUSE);
              VitalSignalDelay (RXIGNOREBTF_dly,RXIGNOREBTF_ipd,tisd_RXIGNOREBTF);
              VitalSignalDelay (RXRESET_dly,RXRESET_ipd,tisd_RXRESET);
              VitalSignalDelay (RXSLIDE_dly,RXSLIDE_ipd,tisd_RXSLIDE);
           TXBYPASS8B10B_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (TXBYPASS8B10B_dly(i),TXBYPASS8B10B_ipd(i),tisd_TXBYPASS8B10B(i));
           end generate TXBYPASS8B10B_DELAY;
           TXCHARDISPMODE_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (TXCHARDISPMODE_dly(i),TXCHARDISPMODE_ipd(i),tisd_TXCHARDISPMODE(i));
           end generate TXCHARDISPMODE_DELAY;
           TXCHARDISPVAL_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (TXCHARDISPVAL_dly(i),TXCHARDISPVAL_ipd(i),tisd_TXCHARDISPVAL(i));
           end generate TXCHARDISPVAL_DELAY;
           TXCHARISK_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (TXCHARISK_dly(i),TXCHARISK_ipd(i),tisd_TXCHARISK(i));
           end generate TXCHARISK_DELAY;
           TXDATA_DELAY : for i in 63 downto 0 generate
              VitalSignalDelay (TXDATA_dly(i),TXDATA_ipd(i),tisd_TXDATA(i));
           end generate TXDATA_DELAY;
              VitalSignalDelay (TXRESET_dly,TXRESET_ipd,tisd_TXRESET);
              VitalSignalDelay (RXCLKSTABLE_dly,RXCLKSTABLE_ipd,tisd_RXCLKSTABLE);
              VitalSignalDelay (RXPMARESET_dly,RXPMARESET_ipd,tisd_RXPMARESET);
              VitalSignalDelay (TXCLKSTABLE_dly,TXCLKSTABLE_ipd,tisd_TXCLKSTABLE);
              VitalSignalDelay (TXPMARESET_dly,TXPMARESET_ipd,tisd_TXPMARESET);
           RXCRCIN_DELAY : for i in 63 downto 0 generate
              VitalSignalDelay (RXCRCIN_dly(i),RXCRCIN_ipd(i),tisd_RXCRCIN(i));
           end generate RXCRCIN_DELAY;
           RXCRCDATAWIDTH_DELAY : for i in 2 downto 0 generate
              VitalSignalDelay (RXCRCDATAWIDTH_dly(i),RXCRCDATAWIDTH_ipd(i),tisd_RXCRCDATAWIDTH(i));
           end generate RXCRCDATAWIDTH_DELAY;
              VitalSignalDelay (RXCRCDATAVALID_dly,RXCRCDATAVALID_ipd,tisd_RXCRCDATAVALID);
              VitalSignalDelay (RXCRCINIT_dly,RXCRCINIT_ipd,tisd_RXCRCINIT);
              VitalSignalDelay (RXCRCRESET_dly,RXCRCRESET_ipd,tisd_RXCRCRESET);
           TXCRCIN_DELAY : for i in 63 downto 0 generate
              VitalSignalDelay (TXCRCIN_dly(i),TXCRCIN_ipd(i),tisd_TXCRCIN(i));
           end generate TXCRCIN_DELAY;
           TXCRCDATAWIDTH_DELAY : for i in 2 downto 0 generate
              VitalSignalDelay (TXCRCDATAWIDTH_dly(i),TXCRCDATAWIDTH_ipd(i),tisd_TXCRCDATAWIDTH(i));
           end generate TXCRCDATAWIDTH_DELAY;
              VitalSignalDelay (TXCRCDATAVALID_dly,TXCRCDATAVALID_ipd,tisd_TXCRCDATAVALID);
              VitalSignalDelay (TXCRCINIT_dly,TXCRCINIT_ipd,tisd_TXCRCINIT);
              VitalSignalDelay (TXCRCRESET_dly,TXCRCRESET_ipd,tisd_TXCRCRESET);
              VitalSignalDelay (TXSYNC_dly,TXSYNC_ipd,tisd_TXSYNC);
              VitalSignalDelay (RXSYNC_dly,RXSYNC_ipd,tisd_RXSYNC);
              VitalSignalDelay (TXENOOB_dly,TXENOOB_ipd,tisd_TXENOOB);
           DADDR_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (DADDR_dly(i),DADDR_ipd(i),tisd_DADDR(i));
           end generate DADDR_DELAY;
              VitalSignalDelay (DEN_dly,DEN_ipd,tisd_DEN);
              VitalSignalDelay (DWE_dly,DWE_ipd,tisd_DWE);
           DI_DELAY : for i in 15 downto 0 generate
              VitalSignalDelay (DI_dly(i),DI_ipd(i),tisd_DI(i));
           end generate DI_DELAY;

              VitalSignalDelay (RXUSRCLK_dly,RXUSRCLK_ipd,ticd_RXUSRCLK);
              VitalSignalDelay (RXUSRCLK2_dly,RXUSRCLK2_ipd,ticd_RXUSRCLK2);
              VitalSignalDelay (TXUSRCLK2_dly,TXUSRCLK2_ipd,ticd_TXUSRCLK2);
              VitalSignalDelay (RXCRCINTCLK_dly,RXCRCINTCLK_ipd,ticd_RXCRCINTCLK);
              VitalSignalDelay (TXCRCINTCLK_dly,TXCRCINTCLK_ipd,ticd_TXCRCINTCLK);
              VitalSignalDelay (DCLK_dly,DCLK_ipd,ticd_DCLK);
       end block;

   LOOPBACK_dly <= LOOPBACK_ipd;
   POWERDOWN_dly <= POWERDOWN_ipd;
   RXBLOCKSYNC64B66BUSE_dly <= RXBLOCKSYNC64B66BUSE_ipd;
   RXDATAWIDTH_dly <= RXDATAWIDTH_ipd;
   RXDEC64B66BUSE_dly <= RXDEC64B66BUSE_ipd;
   RXDEC8B10BUSE_dly <= RXDEC8B10BUSE_ipd;
   RXDESCRAM64B66BUSE_dly <= RXDESCRAM64B66BUSE_ipd;
   RXINTDATAWIDTH_dly <= RXINTDATAWIDTH_ipd;
   RXPOLARITY_dly <= RXPOLARITY_ipd;
   TXDATAWIDTH_dly <= TXDATAWIDTH_ipd;
   TXENC64B66BUSE_dly <= TXENC64B66BUSE_ipd;
   TXENC8B10BUSE_dly <= TXENC8B10BUSE_ipd;
   TXGEARBOX64B66BUSE_dly <= TXGEARBOX64B66BUSE_ipd;
   TXINHIBIT_dly <= TXINHIBIT_ipd;
   TXINTDATAWIDTH_dly <= TXINTDATAWIDTH_ipd;
   TXPOLARITY_dly <= TXPOLARITY_ipd;
   TXSCRAM64B66BUSE_dly <= TXSCRAM64B66BUSE_ipd;
   RXCRCPD_dly <= RXCRCPD_ipd;
   TXCRCPD_dly <= TXCRCPD_ipd;
   RX1P_dly <= RX1P_ipd;
   RX1N_dly <= RX1N_ipd;
   COMBUSIN_dly <= COMBUSIN_ipd;
--   RXUSRCLK_dly <= RXUSRCLK_ipd;
--   RXUSRCLK2_dly <= RXUSRCLK2_ipd;
   TXUSRCLK_dly <= TXUSRCLK_ipd;
--   TXUSRCLK2_dly <= TXUSRCLK2_ipd;
   RXCRCCLK_dly <= RXCRCCLK_ipd;
--   RXCRCINTCLK_dly <= RXCRCINTCLK_ipd;
   TXCRCCLK_dly <= TXCRCCLK_ipd;
--   TXCRCINTCLK_dly <= TXCRCINTCLK_ipd;
--   DCLK_dly <= DCLK_ipd;
   REFCLK2_dly <= REFCLK2_ipd; 
   REFCLK1_dly <= REFCLK1_ipd;
  GSR_dly <= GSR_ipd;           

   gt11_swift_bw_1 : GT11_SWIFT
      port map (
CHBONDO => CHBONDO_OUT,
COMBUSOUT => COMBUSOUT_OUT,
DO => DO_OUT,
DRDY => DRDY_OUT,
RXBUFERR => RXBUFERR_OUT,
RXCALFAIL => RXCALFAIL_OUT,
RXCHARISCOMMA => RXCHARISCOMMA_OUT,
RXCHARISK => RXCHARISK_OUT,
RXCOMMADET => RXCOMMADET_OUT,
RXCRCOUT => RXCRCOUT_OUT,
RXCYCLELIMIT => RXCYCLELIMIT_OUT,
RXDATA => RXDATA_OUT,
RXDISPERR => RXDISPERR_OUT,
RXLOCK => RXLOCK_OUT,
RXLOSSOFSYNC => RXLOSSOFSYNC_OUT,
RXMCLK => RXMCLK_OUT,
RXNOTINTABLE => RXNOTINTABLE_OUT,
RXPCSHCLKOUT => RXPCSHCLKOUT_OUT,
RXREALIGN => RXREALIGN_OUT,
RXRECCLK1 => RXRECCLK1_OUT,
RXRECCLK2 => RXRECCLK2_OUT,
RXRUNDISP => RXRUNDISP_OUT,
RXSIGDET => RXSIGDET_OUT,
RXSTATUS => RXSTATUS_OUT,
TX1N => TX1N_OUT,
TX1P => TX1P_OUT,
TXBUFERR => TXBUFERR_OUT,
TXCALFAIL => TXCALFAIL_OUT,
TXCRCOUT => TXCRCOUT_OUT,
TXCYCLELIMIT => TXCYCLELIMIT_OUT,
TXKERR => TXKERR_OUT,
TXLOCK => TXLOCK_OUT,
TXOUTCLK1 => TXOUTCLK1_OUT,
TXOUTCLK2 => TXOUTCLK2_OUT,
TXPCSHCLKOUT => TXPCSHCLKOUT_OUT,
TXRUNDISP => TXRUNDISP_OUT,

GT11_MODE => GT11_MODE_BINARY,

PMACFG2 => PMACFG2,
PMACFG => PMACFG,
RXACLCFG => RXACLCFG,
RXAEQCFG => RXAEQCFG,
RXAFECFG => RXAFECFG,
synDigCfgChnBnd1 => synDigCfgChnBnd1,
synDigCfgChnBnd2 => synDigCfgChnBnd2,
synDigCfgClkCor1 => synDigCfgClkCor1,
synDigCfgClkCor2 => synDigCfgClkCor2,
synDigCfgComma1 => synDigCfgComma1,
synDigCfgComma2 => synDigCfgComma2,
synDigCfgCrc => synDigCfgCrc,
synDigCfgMisc => synDigCfgMisc,
synDigCfgSynPmaFD => synDigCfgSynPmaFD,
TXACFG => TXACFG,
TXCLCFG => TXCLCFG,

CHBONDI => CHBONDI_dly,
COMBUSIN => COMBUSIN_dly,
DADDR => DADDR_dly,
DCLK => DCLK_dly,
DEN => DEN_dly,
DI => DI_dly,
DWE => DWE_dly,
ENCHANSYNC => ENCHANSYNC_dly,
ENMCOMMAALIGN => ENMCOMMAALIGN_dly,
ENPCOMMAALIGN => ENPCOMMAALIGN_dly,
GREFCLK => GREFCLK_dly,
GSR => GSR_dly,
LOOPBACK => LOOPBACK_dly,
POWERDOWN => POWERDOWN_dly,
REFCLK1 => REFCLK1_dly,
REFCLK2 => REFCLK2_dly,
RX1N => RX1N_dly,
RX1P => RX1P_dly,
RXBLOCKSYNC64B66BUSE => RXBLOCKSYNC64B66BUSE_dly,
RXCLKSTABLE => RXCLKSTABLE_dly,
RXCOMMADETUSE => RXCOMMADETUSE_dly,
RXCRCCLK => RXCRCCLK_dly,
RXCRCDATAVALID => RXCRCDATAVALID_dly,
RXCRCDATAWIDTH => RXCRCDATAWIDTH_dly,
RXCRCIN => RXCRCIN_dly,
RXCRCINIT => RXCRCINIT_dly,
RXCRCINTCLK => RXCRCINTCLK_dly,
RXCRCPD => RXCRCPD_dly,
RXCRCRESET => RXCRCRESET_dly,
RXDATAWIDTH => RXDATAWIDTH_dly,
RXDEC8B10BUSE => RXDEC8B10BUSE_dly,
RXDEC64B66BUSE => RXDEC64B66BUSE_dly,
RXDESCRAM64B66BUSE => RXDESCRAM64B66BUSE_dly,
RXIGNOREBTF => RXIGNOREBTF_dly,
RXINTDATAWIDTH => RXINTDATAWIDTH_dly,
RXPMARESET => RXPMARESET_dly,
RXPOLARITY => RXPOLARITY_dly,
RXRESET => RXRESET_dly,
RXSLIDE => RXSLIDE_dly,
RXSYNC => RXSYNC_dly,
RXUSRCLK => RXUSRCLK_dly,
RXUSRCLK2 => RXUSRCLK2_dly,
TXBYPASS8B10B => TXBYPASS8B10B_dly,
TXCHARDISPMODE => TXCHARDISPMODE_dly,
TXCHARDISPVAL => TXCHARDISPVAL_dly,
TXCHARISK => TXCHARISK_dly,
TXCLKSTABLE => TXCLKSTABLE_dly,
TXCRCCLK => TXCRCCLK_dly,
TXCRCDATAVALID => TXCRCDATAVALID_dly,
TXCRCDATAWIDTH => TXCRCDATAWIDTH_dly,
TXCRCIN => TXCRCIN_dly,
TXCRCINIT => TXCRCINIT_dly,
TXCRCINTCLK => TXCRCINTCLK_dly,
TXCRCPD => TXCRCPD_dly,
TXCRCRESET => TXCRCRESET_dly,
TXDATA => TXDATA_dly,
TXDATAWIDTH => TXDATAWIDTH_dly,
TXENC8B10BUSE => TXENC8B10BUSE_dly,
TXENC64B66BUSE => TXENC64B66BUSE_dly,
TXENOOB => TXENOOB_dly,
TXGEARBOX64B66BUSE => TXGEARBOX64B66BUSE_dly,
TXINHIBIT => TXINHIBIT_dly,
TXINTDATAWIDTH => TXINTDATAWIDTH_dly,
TXPMARESET => TXPMARESET_dly,
TXPOLARITY => TXPOLARITY_dly,
TXRESET => TXRESET_dly,
TXSCRAM64B66BUSE => TXSCRAM64B66BUSE_dly,
TXSYNC => TXSYNC_dly,
TXUSRCLK => TXUSRCLK_dly,
TXUSRCLK2 => TXUSRCLK2_dly

      );

   INIPROC : process
        variable   CHAN_BOND_SEQ_1_1_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_1);
        variable   CHAN_BOND_SEQ_1_2_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_2);
        variable   CHAN_BOND_SEQ_1_3_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_3);
        variable   CHAN_BOND_SEQ_1_4_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_4);
        variable   CHAN_BOND_SEQ_1_MASK_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_MASK);
        variable   CHAN_BOND_LIMIT_BINARY  :  std_logic_vector(5 downto 0);
        variable   CHAN_BOND_MODE_BINARY  :  std_logic_vector(1 downto 0);
        variable   CHAN_BOND_ONE_SHOT_BINARY  :  std_ulogic;
        variable   CHAN_BOND_SEQ_2_USE_BINARY  :  std_ulogic;
        variable   CHAN_BOND_SEQ_LEN_BINARY  :  std_logic_vector(2 downto 0);
        variable   RX_BUFFER_USE_BINARY  :  std_ulogic;
        variable   TX_BUFFER_USE_BINARY  :  std_ulogic;
        variable   CHAN_BOND_SEQ_2_1_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_1);
        variable   CHAN_BOND_SEQ_2_2_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_2);
        variable   CHAN_BOND_SEQ_2_3_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_3);
        variable   CHAN_BOND_SEQ_2_4_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_4);
        variable   CHAN_BOND_SEQ_2_MASK_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_MASK);
        variable   POWER_ENABLE_BINARY  :  std_ulogic;
        variable   OPPOSITE_SELECT_BINARY  :  std_ulogic;
        variable   CCCB_ARBITRATOR_DISABLE_BINARY  :  std_ulogic;
        variable   CLK_COR_SEQ_1_1_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_1);
        variable   CLK_COR_SEQ_1_2_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_2);
        variable   CLK_COR_SEQ_1_3_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_3);
        variable   CLK_COR_SEQ_1_4_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_4);
        variable   CLK_COR_SEQ_1_MASK_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_MASK);
        variable   DIGRX_SYNC_MODE_BINARY  :  std_ulogic;
        variable   DIGRX_FWDCLK_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(DIGRX_FWDCLK);
        variable   PCS_BIT_SLIP_BINARY  :  std_ulogic;
        variable   CLK_COR_MIN_LAT_BINARY  :  std_logic_vector(5 downto 0);
        variable   TXDATA_SEL_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(TXDATA_SEL);
        variable   RXDATA_SEL_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXDATA_SEL);
        variable   CLK_COR_SEQ_2_1_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_1);
        variable   CLK_COR_SEQ_2_2_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_2);
        variable   CLK_COR_SEQ_2_3_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_3);
        variable   CLK_COR_SEQ_2_4_BINARY  :  std_logic_vector(10 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_4);
        variable   CLK_COR_SEQ_2_MASK_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_MASK);
        variable   CLK_COR_MAX_LAT_BINARY  :  std_logic_vector(5 downto 0);
        variable   CLK_COR_SEQ_2_USE_BINARY  :  std_ulogic;
        variable   CLK_COR_SEQ_DROP_BINARY  :  std_ulogic;
        variable   CLK_COR_SEQ_LEN_BINARY  :  std_logic_vector(2 downto 0);
        variable   CLK_CORRECT_USE_BINARY  :  std_ulogic;
        variable   CLK_COR_8B10B_DE_BINARY  :  std_ulogic;
        variable   SH_CNT_MAX_BINARY  :  std_logic_vector(7 downto 0);
        variable   SH_INVALID_CNT_MAX_BINARY  :  std_logic_vector(7 downto 0);
        variable   ALIGN_COMMA_WORD_BINARY  :  std_logic_vector(1 downto 0);
        variable   DEC_MCOMMA_DETECT_BINARY  :  std_ulogic;
        variable   DEC_PCOMMA_DETECT_BINARY  :  std_ulogic;
        variable   DEC_VALID_COMMA_ONLY_BINARY  :  std_ulogic;
        variable   MCOMMA_DETECT_BINARY  :  std_ulogic;
        variable   PCOMMA_DETECT_BINARY  :  std_ulogic;
        variable   COMMA32_BINARY  :  std_ulogic;
        variable   COMMA_10B_MASK_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(COMMA_10B_MASK)(9 downto 0);
        variable   MCOMMA_32B_VALUE_BINARY  :  std_logic_vector(31 downto 0) := To_StdLogicVector(MCOMMA_32B_VALUE);
        variable   PCOMMA_32B_VALUE_BINARY  :  std_logic_vector(31 downto 0) := To_StdLogicVector(PCOMMA_32B_VALUE);
        variable   RXUSRDIVISOR_BINARY  :  std_logic_vector(4 downto 0);
        variable   DCDR_FILTER_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(DCDR_FILTER);
        variable   SAMPLE_8X_BINARY  :  std_ulogic;
        variable   ENABLE_DCDR_BINARY  :  std_ulogic;
        variable   REPEATER_BINARY  :  std_ulogic;
        variable   RXBY_32_BINARY  :  std_ulogic;
        variable   TXFDCAL_CLOCK_DIVIDE_BINARY  :  std_logic_vector(1 downto 0);
        variable   RXFDCAL_CLOCK_DIVIDE_BINARY  :  std_logic_vector(1 downto 0);
        variable   RXCYCLE_LIMIT_SEL_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXCYCLE_LIMIT_SEL);
        variable   RXVCO_CTRL_ENABLE_BINARY  :  std_ulogic;
        variable   RXFDET_LCK_SEL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(RXFDET_LCK_SEL);
        variable   RXFDET_HYS_SEL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(RXFDET_HYS_SEL);
        variable   RXFDET_LCK_CAL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(RXFDET_LCK_CAL);
        variable   RXFDET_HYS_CAL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(RXFDET_HYS_CAL);
        variable   RXLOOPCAL_WAIT_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXLOOPCAL_WAIT);
        variable   RXSLOWDOWN_CAL_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXSLOWDOWN_CAL);
        variable   RXVCODAC_INIT_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(RXVCODAC_INIT);
        variable   CYCLE_LIMIT_SEL_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(CYCLE_LIMIT_SEL);
        variable   VCO_CTRL_ENABLE_BINARY  :  std_ulogic;
        variable   FDET_LCK_SEL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(FDET_LCK_SEL);
        variable   FDET_HYS_SEL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(FDET_HYS_SEL);
        variable   FDET_LCK_CAL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(FDET_LCK_CAL);
        variable   FDET_HYS_CAL_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(FDET_HYS_CAL);
        variable   LOOPCAL_WAIT_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(LOOPCAL_WAIT);
        variable   SLOWDOWN_CAL_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(SLOWDOWN_CAL);
        variable   VCODAC_INIT_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(VCODAC_INIT);
        variable   RXCRCCLOCKDOUBLE_BINARY  :  std_ulogic;
        variable   RXCRCINVERTGEN_BINARY  :  std_ulogic;
        variable   RXCRCSAMECLOCK_BINARY  :  std_ulogic;
        variable   RXCRCENABLE_BINARY  :  std_ulogic;
        variable   RXCRCINITVAL_BINARY  :  std_logic_vector(31 downto 0) := To_StdLogicVector(RXCRCINITVAL);
        variable   TXCRCCLOCKDOUBLE_BINARY  :  std_ulogic;
        variable   TXCRCINVERTGEN_BINARY  :  std_ulogic;
        variable   TXCRCSAMECLOCK_BINARY  :  std_ulogic;
        variable   TXCRCINITVAL_BINARY  :  std_logic_vector(31 downto 0) := To_StdLogicVector(TXCRCINITVAL);
        variable   TXCRCENABLE_BINARY  :  std_ulogic;
        variable   RX_CLOCK_DIVIDER_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RX_CLOCK_DIVIDER);
        variable   TX_CLOCK_DIVIDER_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(TX_CLOCK_DIVIDER);
        variable   RXCLK0_FORCE_PMACLK_BINARY  :  std_ulogic;
        variable   TXCLK0_FORCE_PMACLK_BINARY  :  std_ulogic;
        variable   TXOUTCLK1_USE_SYNC_BINARY  :  std_ulogic;
        variable   RXRECCLK1_USE_SYNC_BINARY  :  std_ulogic;
        variable   RXPMACLKSEL_BINARY  :  std_logic_vector(1 downto 0);
        variable   TXABPMACLKSEL_BINARY  :  std_logic_vector(1 downto 0);
        variable   RXAREGCTRL_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(RXAREGCTRL);
        variable   PMAVBGCTRL_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(PMAVBGCTRL);
        variable   BANDGAPSEL_BINARY  :  std_ulogic;
        variable   PMAIREFTRIM_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(PMAIREFTRIM);
        variable   IREFBIASMODE_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(IREFBIASMODE);
        variable   BIASRESSEL_BINARY  :  std_ulogic;
        variable   PMAVREFTRIM_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(PMAVREFTRIM);
        variable   VREFBIASMODE_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(VREFBIASMODE);
        variable   TXPHASESEL_BINARY  :  std_ulogic;
        variable   PMACLKENABLE_BINARY  :  std_ulogic;
        variable   PMACOREPWRENABLE_BINARY  :  std_ulogic;
        variable   RXMODE_BINARY  :  std_logic_vector(5 downto 0) := To_StdLogicVector(RXMODE);
        variable   PMA_BIT_SLIP_BINARY  :  std_ulogic;
        variable   RXASYNCDIVIDE_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXASYNCDIVIDE);
        variable   RXCLKMODE_BINARY  :  std_logic_vector(5 downto 0) := To_StdLogicVector(RXCLKMODE);
        variable   RXLB_BINARY  :  std_ulogic;
        variable   RXFETUNE_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXFETUNE);
        variable   RXRCPADJ_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(RXRCPADJ);
        variable   RXRIBADJ_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXRIBADJ);
        variable   RXAFEEQ_BINARY  :  std_logic_vector(8 downto 0) := To_StdLogicVector(RXAFEEQ);
        variable   RXCMADJ_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXCMADJ);
        variable   RXCDRLOS_BINARY  :  std_logic_vector(5 downto 0) := To_StdLogicVector(RXCDRLOS);
        variable   RXDCCOUPLE_BINARY  :  std_ulogic;
        variable   RXLKADJ_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(RXLKADJ);
        variable   RXDIGRESET_BINARY  :  std_ulogic;
        variable   RXFECONTROL2_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(RXFECONTROL2);
        variable   RXCPTST_BINARY  :  std_ulogic;
        variable   RXPDDTST_BINARY  :  std_ulogic;
        variable   RXACTST_BINARY  :  std_ulogic;
        variable   RXAFETST_BINARY  :  std_ulogic;
        variable   RXFECONTROL1_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXFECONTROL1);
        variable   RXLKAPD_BINARY  :  std_ulogic;
        variable   RXRSDPD_BINARY  :  std_ulogic;
        variable   RXRCPPD_BINARY  :  std_ulogic;
        variable   RXRPDPD_BINARY  :  std_ulogic;
        variable   RXAFEPD_BINARY  :  std_ulogic;
        variable   RXPD_BINARY  :  std_ulogic;
        variable   RXEQ_BINARY  :  std_logic_vector(63 downto 0) := To_StdLogicVector(RXEQ);
        variable   TXOUTDIV2SEL_BINARY  :  std_logic_vector(3 downto 0);
        variable   TXPLLNDIVSEL_BINARY  :  std_logic_vector(3 downto 0);
        variable   TXCLMODE_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(TXCLMODE);
        variable   TXLOOPFILT_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(TXLOOPFILT);
        variable   TXTUNE_BINARY  :  std_logic_vector(12 downto 0) := To_StdLogicVector(TXTUNE)(12 downto 0);
        variable   TXCPSEL_BINARY  :  std_ulogic;
        variable   TXCTRL1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(TXCTRL1)(9 downto 0);
        variable   TXAPD_BINARY  :  std_ulogic;
        variable   TXLVLSHFTPD_BINARY  :  std_ulogic;
        variable   TXPRE_PRDRV_DAC_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(TXPRE_PRDRV_DAC);
        variable   TXPRE_TAP_PD_BINARY  :  std_ulogic;
        variable   TXPRE_TAP_DAC_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(TXPRE_TAP_DAC);
        variable   TXDIGPD_BINARY  :  std_ulogic;
        variable   TXCLKMODE_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(TXCLKMODE);
        variable   TXHIGHSIGNALEN_BINARY  :  std_ulogic;
        variable   TXAREFBIASSEL_BINARY  :  std_ulogic;
        variable   TXTERMTRIM_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(TXTERMTRIM);
        variable   TXASYNCDIVIDE_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(TXASYNCDIVIDE);
        variable   TXSLEWRATE_BINARY  :  std_ulogic;
        variable   TXPOST_PRDRV_DAC_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(TXPOST_PRDRV_DAC);
        variable   TXDAT_PRDRV_DAC_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(TXDAT_PRDRV_DAC);
        variable   TXPOST_TAP_PD_BINARY  :  std_ulogic;
        variable   TXPOST_TAP_DAC_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(TXPOST_TAP_DAC);
        variable   TXDAT_TAP_DAC_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(TXDAT_TAP_DAC);
        variable   TXPD_BINARY  :  std_ulogic;
        variable   RXOUTDIV2SEL_BINARY  :  std_logic_vector(7 downto 0);
        variable   RXPLLNDIVSEL_BINARY  :  std_logic_vector(3 downto 0);
        variable   RXCLMODE_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(RXCLMODE);
        variable   RXLOOPFILT_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(RXLOOPFILT);
        variable   RXDIGRX_BINARY  :  std_ulogic;
        variable   RXTUNE_BINARY  :  std_logic_vector(12 downto 0) := To_StdLogicVector(RXTUNE)(12 downto 0);
        variable   RXCPSEL_BINARY  :  std_ulogic;
        variable   RXCTRL1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(RXCTRL1)(9 downto 0);
        variable   RXAPD_BINARY  :  std_ulogic;     
     begin
--     case GT11_MODE is
           if((GT11_MODE = "B") or (GT11_MODE = "b")) then       
               GT11_MODE_BINARY <= "00";
           elsif((GT11_MODE = "A") or (GT11_MODE = "a")) then
               GT11_MODE_BINARY <= "01";
           elsif((GT11_MODE = "DONT_CARE") or (GT11_MODE = "dont_care")) then
               GT11_MODE_BINARY <= "10";
           elsif((GT11_MODE = "SINGLE") or (GT11_MODE = "single")) then
               GT11_MODE_BINARY <= "11";
           else
             assert FALSE report "Error : GT11_MODE = is not DONT_CARE, A, B, SINGLE." severity error;
           end if;
--     end case;
       case CHAN_BOND_LIMIT is
           when   0  =>  CHAN_BOND_LIMIT_BINARY := "000000";
           when   1  =>  CHAN_BOND_LIMIT_BINARY := "000001";
           when   2  =>  CHAN_BOND_LIMIT_BINARY := "000010";
           when   3  =>  CHAN_BOND_LIMIT_BINARY := "000011";
           when   4  =>  CHAN_BOND_LIMIT_BINARY := "000100";
           when   5  =>  CHAN_BOND_LIMIT_BINARY := "000101";
           when   6  =>  CHAN_BOND_LIMIT_BINARY := "000110";
           when   7  =>  CHAN_BOND_LIMIT_BINARY := "000111";
           when   8  =>  CHAN_BOND_LIMIT_BINARY := "001000";
           when   9  =>  CHAN_BOND_LIMIT_BINARY := "001001";
           when   10  =>  CHAN_BOND_LIMIT_BINARY := "001010";
           when   11  =>  CHAN_BOND_LIMIT_BINARY := "001011";
           when   12  =>  CHAN_BOND_LIMIT_BINARY := "001100";
           when   13  =>  CHAN_BOND_LIMIT_BINARY := "001101";
           when   14  =>  CHAN_BOND_LIMIT_BINARY := "001110";
           when   15  =>  CHAN_BOND_LIMIT_BINARY := "001111";
           when   16  =>  CHAN_BOND_LIMIT_BINARY := "010000";
           when   17  =>  CHAN_BOND_LIMIT_BINARY := "010001";
           when   18  =>  CHAN_BOND_LIMIT_BINARY := "010010";
           when   19  =>  CHAN_BOND_LIMIT_BINARY := "010011";
           when   20  =>  CHAN_BOND_LIMIT_BINARY := "010100";
           when   21  =>  CHAN_BOND_LIMIT_BINARY := "010101";
           when   22  =>  CHAN_BOND_LIMIT_BINARY := "010110";
           when   23  =>  CHAN_BOND_LIMIT_BINARY := "010111";
           when   24  =>  CHAN_BOND_LIMIT_BINARY := "011000";
           when   25  =>  CHAN_BOND_LIMIT_BINARY := "011001";
           when   26  =>  CHAN_BOND_LIMIT_BINARY := "011010";
           when   27  =>  CHAN_BOND_LIMIT_BINARY := "011011";
           when   28  =>  CHAN_BOND_LIMIT_BINARY := "011100";
           when   29  =>  CHAN_BOND_LIMIT_BINARY := "011101";
           when   30  =>  CHAN_BOND_LIMIT_BINARY := "011110";
           when   31  =>  CHAN_BOND_LIMIT_BINARY := "011111";
           when others  =>  assert FALSE report "Error : CHAN_BOND_LIMIT is not in range 0...31." severity error;
       end case;
--     case CHAN_BOND_MODE is
           if((CHAN_BOND_MODE = "NONE") or (CHAN_BOND_MODE = "none")) then
               CHAN_BOND_MODE_BINARY := "00";
           elsif((CHAN_BOND_MODE = "MASTER") or (CHAN_BOND_MODE = "master")) then
               CHAN_BOND_MODE_BINARY := "01";
           elsif((CHAN_BOND_MODE = "SLAVE_1_HOP") or (CHAN_BOND_MODE = "slave_1_hop")) then
               CHAN_BOND_MODE_BINARY := "10";
           elsif((CHAN_BOND_MODE = "SLAVE_2_HOPS") or (CHAN_BOND_MODE = "slave_2_hops")) then
               CHAN_BOND_MODE_BINARY := "11";
           else
             assert FALSE report "Error : CHAN_BOND_MODE = is not NONE, MASTER, SLAVE_1_HOP, SLAVE_2_HOPS." severity error;
           end if;
--     end case;
       case CHAN_BOND_ONE_SHOT is
           when FALSE   =>  CHAN_BOND_ONE_SHOT_BINARY := '0';
           when TRUE    =>  CHAN_BOND_ONE_SHOT_BINARY := '1';
           when others  =>  assert FALSE report "Error : CHAN_BOND_ONE_SHOT is neither TRUE nor FALSE." severity error;
       end case;
       case CHAN_BOND_SEQ_2_USE is
           when FALSE   =>  CHAN_BOND_SEQ_2_USE_BINARY := '0';
           when TRUE    =>  CHAN_BOND_SEQ_2_USE_BINARY := '1';
           when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_2_USE is neither TRUE nor FALSE." severity error;
       end case;
       case CHAN_BOND_SEQ_LEN is
           when   1  =>  CHAN_BOND_SEQ_LEN_BINARY := "000";
           when   2  =>  CHAN_BOND_SEQ_LEN_BINARY := "001";
           when   3  =>  CHAN_BOND_SEQ_LEN_BINARY := "010";
           when   4  =>  CHAN_BOND_SEQ_LEN_BINARY := "011";
           when   8  =>  CHAN_BOND_SEQ_LEN_BINARY := "111";
           when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_LEN is not in 1, 2, 3, 4, 8." severity error;
       end case;
       case RX_BUFFER_USE is
           when FALSE   =>  RX_BUFFER_USE_BINARY := '0';
           when TRUE    =>  RX_BUFFER_USE_BINARY := '1';
           when others  =>  assert FALSE report "Error : RX_BUFFER_USE is neither TRUE nor FALSE." severity error;
       end case;
       case TX_BUFFER_USE is
           when FALSE   =>  TX_BUFFER_USE_BINARY := '0';
           when TRUE    =>  TX_BUFFER_USE_BINARY := '1';
           when others  =>  assert FALSE report "Error : TX_BUFFER_USE is neither TRUE nor FALSE." severity error;
       end case;
       case POWER_ENABLE is
           when FALSE   =>  POWER_ENABLE_BINARY := '0';
           when TRUE    =>  POWER_ENABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : POWER_ENABLE is neither TRUE nor FALSE." severity error;
       end case;
       case OPPOSITE_SELECT is
           when FALSE   =>  OPPOSITE_SELECT_BINARY := '0';
           when TRUE    =>  OPPOSITE_SELECT_BINARY := '1';
           when others  =>  assert FALSE report "Error : OPPOSITE_SELECT is neither TRUE nor FALSE." severity error;
       end case;
       case CCCB_ARBITRATOR_DISABLE is
           when FALSE   =>  CCCB_ARBITRATOR_DISABLE_BINARY := '0';
           when TRUE    =>  CCCB_ARBITRATOR_DISABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : CCCB_ARBITRATOR_DISABLE is neither TRUE nor FALSE." severity error;
       end case;
       case DIGRX_SYNC_MODE is
           when FALSE   =>  DIGRX_SYNC_MODE_BINARY := '0';
           when TRUE    =>  DIGRX_SYNC_MODE_BINARY := '1';
           when others  =>  assert FALSE report "Error : DIGRX_SYNC_MODE is neither TRUE nor FALSE." severity error;
       end case;
       case PCS_BIT_SLIP is
           when FALSE   =>  PCS_BIT_SLIP_BINARY := '0';
           when TRUE    =>  PCS_BIT_SLIP_BINARY := '1';
           when others  =>  assert FALSE report "Error : PCS_BIT_SLIP is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_MIN_LAT is
           when   0  =>  CLK_COR_MIN_LAT_BINARY := "000000";
           when   1  =>  CLK_COR_MIN_LAT_BINARY := "000001";
           when   2  =>  CLK_COR_MIN_LAT_BINARY := "000010";
           when   3  =>  CLK_COR_MIN_LAT_BINARY := "000011";
           when   4  =>  CLK_COR_MIN_LAT_BINARY := "000100";
           when   5  =>  CLK_COR_MIN_LAT_BINARY := "000101";
           when   6  =>  CLK_COR_MIN_LAT_BINARY := "000110";
           when   7  =>  CLK_COR_MIN_LAT_BINARY := "000111";
           when   8  =>  CLK_COR_MIN_LAT_BINARY := "001000";
           when   9  =>  CLK_COR_MIN_LAT_BINARY := "001001";
           when   10  =>  CLK_COR_MIN_LAT_BINARY := "001010";
           when   11  =>  CLK_COR_MIN_LAT_BINARY := "001011";
           when   12  =>  CLK_COR_MIN_LAT_BINARY := "001100";
           when   13  =>  CLK_COR_MIN_LAT_BINARY := "001101";
           when   14  =>  CLK_COR_MIN_LAT_BINARY := "001110";
           when   15  =>  CLK_COR_MIN_LAT_BINARY := "001111";
           when   16  =>  CLK_COR_MIN_LAT_BINARY := "010000";
           when   17  =>  CLK_COR_MIN_LAT_BINARY := "010001";
           when   18  =>  CLK_COR_MIN_LAT_BINARY := "010010";
           when   19  =>  CLK_COR_MIN_LAT_BINARY := "010011";
           when   20  =>  CLK_COR_MIN_LAT_BINARY := "010100";
           when   21  =>  CLK_COR_MIN_LAT_BINARY := "010101";
           when   22  =>  CLK_COR_MIN_LAT_BINARY := "010110";
           when   23  =>  CLK_COR_MIN_LAT_BINARY := "010111";
           when   24  =>  CLK_COR_MIN_LAT_BINARY := "011000";
           when   25  =>  CLK_COR_MIN_LAT_BINARY := "011001";
           when   26  =>  CLK_COR_MIN_LAT_BINARY := "011010";
           when   27  =>  CLK_COR_MIN_LAT_BINARY := "011011";
           when   28  =>  CLK_COR_MIN_LAT_BINARY := "011100";
           when   29  =>  CLK_COR_MIN_LAT_BINARY := "011101";
           when   30  =>  CLK_COR_MIN_LAT_BINARY := "011110";
           when   31  =>  CLK_COR_MIN_LAT_BINARY := "011111";
           when   32  =>  CLK_COR_MIN_LAT_BINARY := "100000";
           when   33  =>  CLK_COR_MIN_LAT_BINARY := "100001";
           when   34  =>  CLK_COR_MIN_LAT_BINARY := "100010";
           when   35  =>  CLK_COR_MIN_LAT_BINARY := "100011";
           when   36  =>  CLK_COR_MIN_LAT_BINARY := "100100";
           when   37  =>  CLK_COR_MIN_LAT_BINARY := "100101";
           when   38  =>  CLK_COR_MIN_LAT_BINARY := "100110";
           when   39  =>  CLK_COR_MIN_LAT_BINARY := "100111";
           when   40  =>  CLK_COR_MIN_LAT_BINARY := "101000";
           when   41  =>  CLK_COR_MIN_LAT_BINARY := "101001";
           when   42  =>  CLK_COR_MIN_LAT_BINARY := "101010";
           when   43  =>  CLK_COR_MIN_LAT_BINARY := "101011";
           when   44  =>  CLK_COR_MIN_LAT_BINARY := "101100";
           when   45  =>  CLK_COR_MIN_LAT_BINARY := "101101";
           when   46  =>  CLK_COR_MIN_LAT_BINARY := "101110";
           when   47  =>  CLK_COR_MIN_LAT_BINARY := "101111";
           when   48  =>  CLK_COR_MIN_LAT_BINARY := "110000";
           when   49  =>  CLK_COR_MIN_LAT_BINARY := "110001";
           when   50  =>  CLK_COR_MIN_LAT_BINARY := "110010";
           when   51  =>  CLK_COR_MIN_LAT_BINARY := "110011";
           when   52  =>  CLK_COR_MIN_LAT_BINARY := "110100";
           when   53  =>  CLK_COR_MIN_LAT_BINARY := "110101";
           when   54  =>  CLK_COR_MIN_LAT_BINARY := "110110";
           when   55  =>  CLK_COR_MIN_LAT_BINARY := "110111";
           when   56  =>  CLK_COR_MIN_LAT_BINARY := "111000";
           when   57  =>  CLK_COR_MIN_LAT_BINARY := "111001";
           when   58  =>  CLK_COR_MIN_LAT_BINARY := "111010";
           when   59  =>  CLK_COR_MIN_LAT_BINARY := "111011";
           when   60  =>  CLK_COR_MIN_LAT_BINARY := "111100";
           when   61  =>  CLK_COR_MIN_LAT_BINARY := "111101";
           when   62  =>  CLK_COR_MIN_LAT_BINARY := "111110";
           when   63  =>  CLK_COR_MIN_LAT_BINARY := "111111";
           when others  =>  assert FALSE report "Error : CLK_COR_MIN_LAT is not in range 0...63." severity error;
       end case;
       case CLK_COR_MAX_LAT is
           when   0  =>  CLK_COR_MAX_LAT_BINARY := "000000";
           when   1  =>  CLK_COR_MAX_LAT_BINARY := "000001";
           when   2  =>  CLK_COR_MAX_LAT_BINARY := "000010";
           when   3  =>  CLK_COR_MAX_LAT_BINARY := "000011";
           when   4  =>  CLK_COR_MAX_LAT_BINARY := "000100";
           when   5  =>  CLK_COR_MAX_LAT_BINARY := "000101";
           when   6  =>  CLK_COR_MAX_LAT_BINARY := "000110";
           when   7  =>  CLK_COR_MAX_LAT_BINARY := "000111";
           when   8  =>  CLK_COR_MAX_LAT_BINARY := "001000";
           when   9  =>  CLK_COR_MAX_LAT_BINARY := "001001";
           when   10  =>  CLK_COR_MAX_LAT_BINARY := "001010";
           when   11  =>  CLK_COR_MAX_LAT_BINARY := "001011";
           when   12  =>  CLK_COR_MAX_LAT_BINARY := "001100";
           when   13  =>  CLK_COR_MAX_LAT_BINARY := "001101";
           when   14  =>  CLK_COR_MAX_LAT_BINARY := "001110";
           when   15  =>  CLK_COR_MAX_LAT_BINARY := "001111";
           when   16  =>  CLK_COR_MAX_LAT_BINARY := "010000";
           when   17  =>  CLK_COR_MAX_LAT_BINARY := "010001";
           when   18  =>  CLK_COR_MAX_LAT_BINARY := "010010";
           when   19  =>  CLK_COR_MAX_LAT_BINARY := "010011";
           when   20  =>  CLK_COR_MAX_LAT_BINARY := "010100";
           when   21  =>  CLK_COR_MAX_LAT_BINARY := "010101";
           when   22  =>  CLK_COR_MAX_LAT_BINARY := "010110";
           when   23  =>  CLK_COR_MAX_LAT_BINARY := "010111";
           when   24  =>  CLK_COR_MAX_LAT_BINARY := "011000";
           when   25  =>  CLK_COR_MAX_LAT_BINARY := "011001";
           when   26  =>  CLK_COR_MAX_LAT_BINARY := "011010";
           when   27  =>  CLK_COR_MAX_LAT_BINARY := "011011";
           when   28  =>  CLK_COR_MAX_LAT_BINARY := "011100";
           when   29  =>  CLK_COR_MAX_LAT_BINARY := "011101";
           when   30  =>  CLK_COR_MAX_LAT_BINARY := "011110";
           when   31  =>  CLK_COR_MAX_LAT_BINARY := "011111";
           when   32  =>  CLK_COR_MAX_LAT_BINARY := "100000";
           when   33  =>  CLK_COR_MAX_LAT_BINARY := "100001";
           when   34  =>  CLK_COR_MAX_LAT_BINARY := "100010";
           when   35  =>  CLK_COR_MAX_LAT_BINARY := "100011";
           when   36  =>  CLK_COR_MAX_LAT_BINARY := "100100";
           when   37  =>  CLK_COR_MAX_LAT_BINARY := "100101";
           when   38  =>  CLK_COR_MAX_LAT_BINARY := "100110";
           when   39  =>  CLK_COR_MAX_LAT_BINARY := "100111";
           when   40  =>  CLK_COR_MAX_LAT_BINARY := "101000";
           when   41  =>  CLK_COR_MAX_LAT_BINARY := "101001";
           when   42  =>  CLK_COR_MAX_LAT_BINARY := "101010";
           when   43  =>  CLK_COR_MAX_LAT_BINARY := "101011";
           when   44  =>  CLK_COR_MAX_LAT_BINARY := "101100";
           when   45  =>  CLK_COR_MAX_LAT_BINARY := "101101";
           when   46  =>  CLK_COR_MAX_LAT_BINARY := "101110";
           when   47  =>  CLK_COR_MAX_LAT_BINARY := "101111";
           when   48  =>  CLK_COR_MAX_LAT_BINARY := "110000";
           when   49  =>  CLK_COR_MAX_LAT_BINARY := "110001";
           when   50  =>  CLK_COR_MAX_LAT_BINARY := "110010";
           when   51  =>  CLK_COR_MAX_LAT_BINARY := "110011";
           when   52  =>  CLK_COR_MAX_LAT_BINARY := "110100";
           when   53  =>  CLK_COR_MAX_LAT_BINARY := "110101";
           when   54  =>  CLK_COR_MAX_LAT_BINARY := "110110";
           when   55  =>  CLK_COR_MAX_LAT_BINARY := "110111";
           when   56  =>  CLK_COR_MAX_LAT_BINARY := "111000";
           when   57  =>  CLK_COR_MAX_LAT_BINARY := "111001";
           when   58  =>  CLK_COR_MAX_LAT_BINARY := "111010";
           when   59  =>  CLK_COR_MAX_LAT_BINARY := "111011";
           when   60  =>  CLK_COR_MAX_LAT_BINARY := "111100";
           when   61  =>  CLK_COR_MAX_LAT_BINARY := "111101";
           when   62  =>  CLK_COR_MAX_LAT_BINARY := "111110";
           when   63  =>  CLK_COR_MAX_LAT_BINARY := "111111";
           when others  =>  assert FALSE report "Error : CLK_COR_MAX_LAT is not in range 0...63." severity error;
       end case;
       case CLK_COR_SEQ_2_USE is
           when FALSE   =>  CLK_COR_SEQ_2_USE_BINARY := '0';
           when TRUE    =>  CLK_COR_SEQ_2_USE_BINARY := '1';
           when others  =>  assert FALSE report "Error : CLK_COR_SEQ_2_USE is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_SEQ_DROP is
           when FALSE   =>  CLK_COR_SEQ_DROP_BINARY := '0';
           when TRUE    =>  CLK_COR_SEQ_DROP_BINARY := '1';
           when others  =>  assert FALSE report "Error : CLK_COR_SEQ_DROP is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_SEQ_LEN is
           when   1  =>  CLK_COR_SEQ_LEN_BINARY := "000";
           when   2  =>  CLK_COR_SEQ_LEN_BINARY := "001";
           when   3  =>  CLK_COR_SEQ_LEN_BINARY := "010";
           when   4  =>  CLK_COR_SEQ_LEN_BINARY := "011";
           when   8  =>  CLK_COR_SEQ_LEN_BINARY := "111";
           when others  =>  assert FALSE report "Error : CLK_COR_SEQ_LEN is not in 1, 2, 3, 4, 8." severity error;
       end case;
       case CLK_CORRECT_USE is
           when FALSE   =>  CLK_CORRECT_USE_BINARY := '0';
           when TRUE    =>  CLK_CORRECT_USE_BINARY := '1';
           when others  =>  assert FALSE report "Error : CLK_CORRECT_USE is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_8B10B_DE is
           when FALSE   =>  CLK_COR_8B10B_DE_BINARY := '0';
           when TRUE    =>  CLK_COR_8B10B_DE_BINARY := '1';
           when others  =>  assert FALSE report "Error : CLK_COR_8B10B_DE is neither TRUE nor FALSE." severity error;
       end case;
       case SH_CNT_MAX is
           when   0  =>  SH_CNT_MAX_BINARY := "00000000";
           when   1  =>  SH_CNT_MAX_BINARY := "00000001";
           when   2  =>  SH_CNT_MAX_BINARY := "00000010";
           when   3  =>  SH_CNT_MAX_BINARY := "00000011";
           when   4  =>  SH_CNT_MAX_BINARY := "00000100";
           when   5  =>  SH_CNT_MAX_BINARY := "00000101";
           when   6  =>  SH_CNT_MAX_BINARY := "00000110";
           when   7  =>  SH_CNT_MAX_BINARY := "00000111";
           when   8  =>  SH_CNT_MAX_BINARY := "00001000";
           when   9  =>  SH_CNT_MAX_BINARY := "00001001";
           when   10  =>  SH_CNT_MAX_BINARY := "00001010";
           when   11  =>  SH_CNT_MAX_BINARY := "00001011";
           when   12  =>  SH_CNT_MAX_BINARY := "00001100";
           when   13  =>  SH_CNT_MAX_BINARY := "00001101";
           when   14  =>  SH_CNT_MAX_BINARY := "00001110";
           when   15  =>  SH_CNT_MAX_BINARY := "00001111";
           when   16  =>  SH_CNT_MAX_BINARY := "00010000";
           when   17  =>  SH_CNT_MAX_BINARY := "00010001";
           when   18  =>  SH_CNT_MAX_BINARY := "00010010";
           when   19  =>  SH_CNT_MAX_BINARY := "00010011";
           when   20  =>  SH_CNT_MAX_BINARY := "00010100";
           when   21  =>  SH_CNT_MAX_BINARY := "00010101";
           when   22  =>  SH_CNT_MAX_BINARY := "00010110";
           when   23  =>  SH_CNT_MAX_BINARY := "00010111";
           when   24  =>  SH_CNT_MAX_BINARY := "00011000";
           when   25  =>  SH_CNT_MAX_BINARY := "00011001";
           when   26  =>  SH_CNT_MAX_BINARY := "00011010";
           when   27  =>  SH_CNT_MAX_BINARY := "00011011";
           when   28  =>  SH_CNT_MAX_BINARY := "00011100";
           when   29  =>  SH_CNT_MAX_BINARY := "00011101";
           when   30  =>  SH_CNT_MAX_BINARY := "00011110";
           when   31  =>  SH_CNT_MAX_BINARY := "00011111";
           when   32  =>  SH_CNT_MAX_BINARY := "00100000";
           when   33  =>  SH_CNT_MAX_BINARY := "00100001";
           when   34  =>  SH_CNT_MAX_BINARY := "00100010";
           when   35  =>  SH_CNT_MAX_BINARY := "00100011";
           when   36  =>  SH_CNT_MAX_BINARY := "00100100";
           when   37  =>  SH_CNT_MAX_BINARY := "00100101";
           when   38  =>  SH_CNT_MAX_BINARY := "00100110";
           when   39  =>  SH_CNT_MAX_BINARY := "00100111";
           when   40  =>  SH_CNT_MAX_BINARY := "00101000";
           when   41  =>  SH_CNT_MAX_BINARY := "00101001";
           when   42  =>  SH_CNT_MAX_BINARY := "00101010";
           when   43  =>  SH_CNT_MAX_BINARY := "00101011";
           when   44  =>  SH_CNT_MAX_BINARY := "00101100";
           when   45  =>  SH_CNT_MAX_BINARY := "00101101";
           when   46  =>  SH_CNT_MAX_BINARY := "00101110";
           when   47  =>  SH_CNT_MAX_BINARY := "00101111";
           when   48  =>  SH_CNT_MAX_BINARY := "00110000";
           when   49  =>  SH_CNT_MAX_BINARY := "00110001";
           when   50  =>  SH_CNT_MAX_BINARY := "00110010";
           when   51  =>  SH_CNT_MAX_BINARY := "00110011";
           when   52  =>  SH_CNT_MAX_BINARY := "00110100";
           when   53  =>  SH_CNT_MAX_BINARY := "00110101";
           when   54  =>  SH_CNT_MAX_BINARY := "00110110";
           when   55  =>  SH_CNT_MAX_BINARY := "00110111";
           when   56  =>  SH_CNT_MAX_BINARY := "00111000";
           when   57  =>  SH_CNT_MAX_BINARY := "00111001";
           when   58  =>  SH_CNT_MAX_BINARY := "00111010";
           when   59  =>  SH_CNT_MAX_BINARY := "00111011";
           when   60  =>  SH_CNT_MAX_BINARY := "00111100";
           when   61  =>  SH_CNT_MAX_BINARY := "00111101";
           when   62  =>  SH_CNT_MAX_BINARY := "00111110";
           when   63  =>  SH_CNT_MAX_BINARY := "00111111";
           when   64  =>  SH_CNT_MAX_BINARY := "01000000";
           when   65  =>  SH_CNT_MAX_BINARY := "01000001";
           when   66  =>  SH_CNT_MAX_BINARY := "01000010";
           when   67  =>  SH_CNT_MAX_BINARY := "01000011";
           when   68  =>  SH_CNT_MAX_BINARY := "01000100";
           when   69  =>  SH_CNT_MAX_BINARY := "01000101";
           when   70  =>  SH_CNT_MAX_BINARY := "01000110";
           when   71  =>  SH_CNT_MAX_BINARY := "01000111";
           when   72  =>  SH_CNT_MAX_BINARY := "01001000";
           when   73  =>  SH_CNT_MAX_BINARY := "01001001";
           when   74  =>  SH_CNT_MAX_BINARY := "01001010";
           when   75  =>  SH_CNT_MAX_BINARY := "01001011";
           when   76  =>  SH_CNT_MAX_BINARY := "01001100";
           when   77  =>  SH_CNT_MAX_BINARY := "01001101";
           when   78  =>  SH_CNT_MAX_BINARY := "01001110";
           when   79  =>  SH_CNT_MAX_BINARY := "01001111";
           when   80  =>  SH_CNT_MAX_BINARY := "01010000";
           when   81  =>  SH_CNT_MAX_BINARY := "01010001";
           when   82  =>  SH_CNT_MAX_BINARY := "01010010";
           when   83  =>  SH_CNT_MAX_BINARY := "01010011";
           when   84  =>  SH_CNT_MAX_BINARY := "01010100";
           when   85  =>  SH_CNT_MAX_BINARY := "01010101";
           when   86  =>  SH_CNT_MAX_BINARY := "01010110";
           when   87  =>  SH_CNT_MAX_BINARY := "01010111";
           when   88  =>  SH_CNT_MAX_BINARY := "01011000";
           when   89  =>  SH_CNT_MAX_BINARY := "01011001";
           when   90  =>  SH_CNT_MAX_BINARY := "01011010";
           when   91  =>  SH_CNT_MAX_BINARY := "01011011";
           when   92  =>  SH_CNT_MAX_BINARY := "01011100";
           when   93  =>  SH_CNT_MAX_BINARY := "01011101";
           when   94  =>  SH_CNT_MAX_BINARY := "01011110";
           when   95  =>  SH_CNT_MAX_BINARY := "01011111";
           when   96  =>  SH_CNT_MAX_BINARY := "01100000";
           when   97  =>  SH_CNT_MAX_BINARY := "01100001";
           when   98  =>  SH_CNT_MAX_BINARY := "01100010";
           when   99  =>  SH_CNT_MAX_BINARY := "01100011";
           when   100  =>  SH_CNT_MAX_BINARY := "01100100";
           when   101  =>  SH_CNT_MAX_BINARY := "01100101";
           when   102  =>  SH_CNT_MAX_BINARY := "01100110";
           when   103  =>  SH_CNT_MAX_BINARY := "01100111";
           when   104  =>  SH_CNT_MAX_BINARY := "01101000";
           when   105  =>  SH_CNT_MAX_BINARY := "01101001";
           when   106  =>  SH_CNT_MAX_BINARY := "01101010";
           when   107  =>  SH_CNT_MAX_BINARY := "01101011";
           when   108  =>  SH_CNT_MAX_BINARY := "01101100";
           when   109  =>  SH_CNT_MAX_BINARY := "01101101";
           when   110  =>  SH_CNT_MAX_BINARY := "01101110";
           when   111  =>  SH_CNT_MAX_BINARY := "01101111";
           when   112  =>  SH_CNT_MAX_BINARY := "01110000";
           when   113  =>  SH_CNT_MAX_BINARY := "01110001";
           when   114  =>  SH_CNT_MAX_BINARY := "01110010";
           when   115  =>  SH_CNT_MAX_BINARY := "01110011";
           when   116  =>  SH_CNT_MAX_BINARY := "01110100";
           when   117  =>  SH_CNT_MAX_BINARY := "01110101";
           when   118  =>  SH_CNT_MAX_BINARY := "01110110";
           when   119  =>  SH_CNT_MAX_BINARY := "01110111";
           when   120  =>  SH_CNT_MAX_BINARY := "01111000";
           when   121  =>  SH_CNT_MAX_BINARY := "01111001";
           when   122  =>  SH_CNT_MAX_BINARY := "01111010";
           when   123  =>  SH_CNT_MAX_BINARY := "01111011";
           when   124  =>  SH_CNT_MAX_BINARY := "01111100";
           when   125  =>  SH_CNT_MAX_BINARY := "01111101";
           when   126  =>  SH_CNT_MAX_BINARY := "01111110";
           when   127  =>  SH_CNT_MAX_BINARY := "01111111";
           when   128  =>  SH_CNT_MAX_BINARY := "10000000";
           when   129  =>  SH_CNT_MAX_BINARY := "10000001";
           when   130  =>  SH_CNT_MAX_BINARY := "10000010";
           when   131  =>  SH_CNT_MAX_BINARY := "10000011";
           when   132  =>  SH_CNT_MAX_BINARY := "10000100";
           when   133  =>  SH_CNT_MAX_BINARY := "10000101";
           when   134  =>  SH_CNT_MAX_BINARY := "10000110";
           when   135  =>  SH_CNT_MAX_BINARY := "10000111";
           when   136  =>  SH_CNT_MAX_BINARY := "10001000";
           when   137  =>  SH_CNT_MAX_BINARY := "10001001";
           when   138  =>  SH_CNT_MAX_BINARY := "10001010";
           when   139  =>  SH_CNT_MAX_BINARY := "10001011";
           when   140  =>  SH_CNT_MAX_BINARY := "10001100";
           when   141  =>  SH_CNT_MAX_BINARY := "10001101";
           when   142  =>  SH_CNT_MAX_BINARY := "10001110";
           when   143  =>  SH_CNT_MAX_BINARY := "10001111";
           when   144  =>  SH_CNT_MAX_BINARY := "10010000";
           when   145  =>  SH_CNT_MAX_BINARY := "10010001";
           when   146  =>  SH_CNT_MAX_BINARY := "10010010";
           when   147  =>  SH_CNT_MAX_BINARY := "10010011";
           when   148  =>  SH_CNT_MAX_BINARY := "10010100";
           when   149  =>  SH_CNT_MAX_BINARY := "10010101";
           when   150  =>  SH_CNT_MAX_BINARY := "10010110";
           when   151  =>  SH_CNT_MAX_BINARY := "10010111";
           when   152  =>  SH_CNT_MAX_BINARY := "10011000";
           when   153  =>  SH_CNT_MAX_BINARY := "10011001";
           when   154  =>  SH_CNT_MAX_BINARY := "10011010";
           when   155  =>  SH_CNT_MAX_BINARY := "10011011";
           when   156  =>  SH_CNT_MAX_BINARY := "10011100";
           when   157  =>  SH_CNT_MAX_BINARY := "10011101";
           when   158  =>  SH_CNT_MAX_BINARY := "10011110";
           when   159  =>  SH_CNT_MAX_BINARY := "10011111";
           when   160  =>  SH_CNT_MAX_BINARY := "10100000";
           when   161  =>  SH_CNT_MAX_BINARY := "10100001";
           when   162  =>  SH_CNT_MAX_BINARY := "10100010";
           when   163  =>  SH_CNT_MAX_BINARY := "10100011";
           when   164  =>  SH_CNT_MAX_BINARY := "10100100";
           when   165  =>  SH_CNT_MAX_BINARY := "10100101";
           when   166  =>  SH_CNT_MAX_BINARY := "10100110";
           when   167  =>  SH_CNT_MAX_BINARY := "10100111";
           when   168  =>  SH_CNT_MAX_BINARY := "10101000";
           when   169  =>  SH_CNT_MAX_BINARY := "10101001";
           when   170  =>  SH_CNT_MAX_BINARY := "10101010";
           when   171  =>  SH_CNT_MAX_BINARY := "10101011";
           when   172  =>  SH_CNT_MAX_BINARY := "10101100";
           when   173  =>  SH_CNT_MAX_BINARY := "10101101";
           when   174  =>  SH_CNT_MAX_BINARY := "10101110";
           when   175  =>  SH_CNT_MAX_BINARY := "10101111";
           when   176  =>  SH_CNT_MAX_BINARY := "10110000";
           when   177  =>  SH_CNT_MAX_BINARY := "10110001";
           when   178  =>  SH_CNT_MAX_BINARY := "10110010";
           when   179  =>  SH_CNT_MAX_BINARY := "10110011";
           when   180  =>  SH_CNT_MAX_BINARY := "10110100";
           when   181  =>  SH_CNT_MAX_BINARY := "10110101";
           when   182  =>  SH_CNT_MAX_BINARY := "10110110";
           when   183  =>  SH_CNT_MAX_BINARY := "10110111";
           when   184  =>  SH_CNT_MAX_BINARY := "10111000";
           when   185  =>  SH_CNT_MAX_BINARY := "10111001";
           when   186  =>  SH_CNT_MAX_BINARY := "10111010";
           when   187  =>  SH_CNT_MAX_BINARY := "10111011";
           when   188  =>  SH_CNT_MAX_BINARY := "10111100";
           when   189  =>  SH_CNT_MAX_BINARY := "10111101";
           when   190  =>  SH_CNT_MAX_BINARY := "10111110";
           when   191  =>  SH_CNT_MAX_BINARY := "10111111";
           when   192  =>  SH_CNT_MAX_BINARY := "11000000";
           when   193  =>  SH_CNT_MAX_BINARY := "11000001";
           when   194  =>  SH_CNT_MAX_BINARY := "11000010";
           when   195  =>  SH_CNT_MAX_BINARY := "11000011";
           when   196  =>  SH_CNT_MAX_BINARY := "11000100";
           when   197  =>  SH_CNT_MAX_BINARY := "11000101";
           when   198  =>  SH_CNT_MAX_BINARY := "11000110";
           when   199  =>  SH_CNT_MAX_BINARY := "11000111";
           when   200  =>  SH_CNT_MAX_BINARY := "11001000";
           when   201  =>  SH_CNT_MAX_BINARY := "11001001";
           when   202  =>  SH_CNT_MAX_BINARY := "11001010";
           when   203  =>  SH_CNT_MAX_BINARY := "11001011";
           when   204  =>  SH_CNT_MAX_BINARY := "11001100";
           when   205  =>  SH_CNT_MAX_BINARY := "11001101";
           when   206  =>  SH_CNT_MAX_BINARY := "11001110";
           when   207  =>  SH_CNT_MAX_BINARY := "11001111";
           when   208  =>  SH_CNT_MAX_BINARY := "11010000";
           when   209  =>  SH_CNT_MAX_BINARY := "11010001";
           when   210  =>  SH_CNT_MAX_BINARY := "11010010";
           when   211  =>  SH_CNT_MAX_BINARY := "11010011";
           when   212  =>  SH_CNT_MAX_BINARY := "11010100";
           when   213  =>  SH_CNT_MAX_BINARY := "11010101";
           when   214  =>  SH_CNT_MAX_BINARY := "11010110";
           when   215  =>  SH_CNT_MAX_BINARY := "11010111";
           when   216  =>  SH_CNT_MAX_BINARY := "11011000";
           when   217  =>  SH_CNT_MAX_BINARY := "11011001";
           when   218  =>  SH_CNT_MAX_BINARY := "11011010";
           when   219  =>  SH_CNT_MAX_BINARY := "11011011";
           when   220  =>  SH_CNT_MAX_BINARY := "11011100";
           when   221  =>  SH_CNT_MAX_BINARY := "11011101";
           when   222  =>  SH_CNT_MAX_BINARY := "11011110";
           when   223  =>  SH_CNT_MAX_BINARY := "11011111";
           when   224  =>  SH_CNT_MAX_BINARY := "11100000";
           when   225  =>  SH_CNT_MAX_BINARY := "11100001";
           when   226  =>  SH_CNT_MAX_BINARY := "11100010";
           when   227  =>  SH_CNT_MAX_BINARY := "11100011";
           when   228  =>  SH_CNT_MAX_BINARY := "11100100";
           when   229  =>  SH_CNT_MAX_BINARY := "11100101";
           when   230  =>  SH_CNT_MAX_BINARY := "11100110";
           when   231  =>  SH_CNT_MAX_BINARY := "11100111";
           when   232  =>  SH_CNT_MAX_BINARY := "11101000";
           when   233  =>  SH_CNT_MAX_BINARY := "11101001";
           when   234  =>  SH_CNT_MAX_BINARY := "11101010";
           when   235  =>  SH_CNT_MAX_BINARY := "11101011";
           when   236  =>  SH_CNT_MAX_BINARY := "11101100";
           when   237  =>  SH_CNT_MAX_BINARY := "11101101";
           when   238  =>  SH_CNT_MAX_BINARY := "11101110";
           when   239  =>  SH_CNT_MAX_BINARY := "11101111";
           when   240  =>  SH_CNT_MAX_BINARY := "11110000";
           when   241  =>  SH_CNT_MAX_BINARY := "11110001";
           when   242  =>  SH_CNT_MAX_BINARY := "11110010";
           when   243  =>  SH_CNT_MAX_BINARY := "11110011";
           when   244  =>  SH_CNT_MAX_BINARY := "11110100";
           when   245  =>  SH_CNT_MAX_BINARY := "11110101";
           when   246  =>  SH_CNT_MAX_BINARY := "11110110";
           when   247  =>  SH_CNT_MAX_BINARY := "11110111";
           when   248  =>  SH_CNT_MAX_BINARY := "11111000";
           when   249  =>  SH_CNT_MAX_BINARY := "11111001";
           when   250  =>  SH_CNT_MAX_BINARY := "11111010";
           when   251  =>  SH_CNT_MAX_BINARY := "11111011";
           when   252  =>  SH_CNT_MAX_BINARY := "11111100";
           when   253  =>  SH_CNT_MAX_BINARY := "11111101";
           when   254  =>  SH_CNT_MAX_BINARY := "11111110";
           when   255  =>  SH_CNT_MAX_BINARY := "11111111";
           when others  =>  assert FALSE report "Error : SH_CNT_MAX is not in range 0...255." severity error;
       end case;
       case SH_INVALID_CNT_MAX is
           when   0  =>  SH_INVALID_CNT_MAX_BINARY := "00000000";
           when   1  =>  SH_INVALID_CNT_MAX_BINARY := "00000001";
           when   2  =>  SH_INVALID_CNT_MAX_BINARY := "00000010";
           when   3  =>  SH_INVALID_CNT_MAX_BINARY := "00000011";
           when   4  =>  SH_INVALID_CNT_MAX_BINARY := "00000100";
           when   5  =>  SH_INVALID_CNT_MAX_BINARY := "00000101";
           when   6  =>  SH_INVALID_CNT_MAX_BINARY := "00000110";
           when   7  =>  SH_INVALID_CNT_MAX_BINARY := "00000111";
           when   8  =>  SH_INVALID_CNT_MAX_BINARY := "00001000";
           when   9  =>  SH_INVALID_CNT_MAX_BINARY := "00001001";
           when   10  =>  SH_INVALID_CNT_MAX_BINARY := "00001010";
           when   11  =>  SH_INVALID_CNT_MAX_BINARY := "00001011";
           when   12  =>  SH_INVALID_CNT_MAX_BINARY := "00001100";
           when   13  =>  SH_INVALID_CNT_MAX_BINARY := "00001101";
           when   14  =>  SH_INVALID_CNT_MAX_BINARY := "00001110";
           when   15  =>  SH_INVALID_CNT_MAX_BINARY := "00001111";
           when   16  =>  SH_INVALID_CNT_MAX_BINARY := "00010000";
           when   17  =>  SH_INVALID_CNT_MAX_BINARY := "00010001";
           when   18  =>  SH_INVALID_CNT_MAX_BINARY := "00010010";
           when   19  =>  SH_INVALID_CNT_MAX_BINARY := "00010011";
           when   20  =>  SH_INVALID_CNT_MAX_BINARY := "00010100";
           when   21  =>  SH_INVALID_CNT_MAX_BINARY := "00010101";
           when   22  =>  SH_INVALID_CNT_MAX_BINARY := "00010110";
           when   23  =>  SH_INVALID_CNT_MAX_BINARY := "00010111";
           when   24  =>  SH_INVALID_CNT_MAX_BINARY := "00011000";
           when   25  =>  SH_INVALID_CNT_MAX_BINARY := "00011001";
           when   26  =>  SH_INVALID_CNT_MAX_BINARY := "00011010";
           when   27  =>  SH_INVALID_CNT_MAX_BINARY := "00011011";
           when   28  =>  SH_INVALID_CNT_MAX_BINARY := "00011100";
           when   29  =>  SH_INVALID_CNT_MAX_BINARY := "00011101";
           when   30  =>  SH_INVALID_CNT_MAX_BINARY := "00011110";
           when   31  =>  SH_INVALID_CNT_MAX_BINARY := "00011111";
           when   32  =>  SH_INVALID_CNT_MAX_BINARY := "00100000";
           when   33  =>  SH_INVALID_CNT_MAX_BINARY := "00100001";
           when   34  =>  SH_INVALID_CNT_MAX_BINARY := "00100010";
           when   35  =>  SH_INVALID_CNT_MAX_BINARY := "00100011";
           when   36  =>  SH_INVALID_CNT_MAX_BINARY := "00100100";
           when   37  =>  SH_INVALID_CNT_MAX_BINARY := "00100101";
           when   38  =>  SH_INVALID_CNT_MAX_BINARY := "00100110";
           when   39  =>  SH_INVALID_CNT_MAX_BINARY := "00100111";
           when   40  =>  SH_INVALID_CNT_MAX_BINARY := "00101000";
           when   41  =>  SH_INVALID_CNT_MAX_BINARY := "00101001";
           when   42  =>  SH_INVALID_CNT_MAX_BINARY := "00101010";
           when   43  =>  SH_INVALID_CNT_MAX_BINARY := "00101011";
           when   44  =>  SH_INVALID_CNT_MAX_BINARY := "00101100";
           when   45  =>  SH_INVALID_CNT_MAX_BINARY := "00101101";
           when   46  =>  SH_INVALID_CNT_MAX_BINARY := "00101110";
           when   47  =>  SH_INVALID_CNT_MAX_BINARY := "00101111";
           when   48  =>  SH_INVALID_CNT_MAX_BINARY := "00110000";
           when   49  =>  SH_INVALID_CNT_MAX_BINARY := "00110001";
           when   50  =>  SH_INVALID_CNT_MAX_BINARY := "00110010";
           when   51  =>  SH_INVALID_CNT_MAX_BINARY := "00110011";
           when   52  =>  SH_INVALID_CNT_MAX_BINARY := "00110100";
           when   53  =>  SH_INVALID_CNT_MAX_BINARY := "00110101";
           when   54  =>  SH_INVALID_CNT_MAX_BINARY := "00110110";
           when   55  =>  SH_INVALID_CNT_MAX_BINARY := "00110111";
           when   56  =>  SH_INVALID_CNT_MAX_BINARY := "00111000";
           when   57  =>  SH_INVALID_CNT_MAX_BINARY := "00111001";
           when   58  =>  SH_INVALID_CNT_MAX_BINARY := "00111010";
           when   59  =>  SH_INVALID_CNT_MAX_BINARY := "00111011";
           when   60  =>  SH_INVALID_CNT_MAX_BINARY := "00111100";
           when   61  =>  SH_INVALID_CNT_MAX_BINARY := "00111101";
           when   62  =>  SH_INVALID_CNT_MAX_BINARY := "00111110";
           when   63  =>  SH_INVALID_CNT_MAX_BINARY := "00111111";
           when   64  =>  SH_INVALID_CNT_MAX_BINARY := "01000000";
           when   65  =>  SH_INVALID_CNT_MAX_BINARY := "01000001";
           when   66  =>  SH_INVALID_CNT_MAX_BINARY := "01000010";
           when   67  =>  SH_INVALID_CNT_MAX_BINARY := "01000011";
           when   68  =>  SH_INVALID_CNT_MAX_BINARY := "01000100";
           when   69  =>  SH_INVALID_CNT_MAX_BINARY := "01000101";
           when   70  =>  SH_INVALID_CNT_MAX_BINARY := "01000110";
           when   71  =>  SH_INVALID_CNT_MAX_BINARY := "01000111";
           when   72  =>  SH_INVALID_CNT_MAX_BINARY := "01001000";
           when   73  =>  SH_INVALID_CNT_MAX_BINARY := "01001001";
           when   74  =>  SH_INVALID_CNT_MAX_BINARY := "01001010";
           when   75  =>  SH_INVALID_CNT_MAX_BINARY := "01001011";
           when   76  =>  SH_INVALID_CNT_MAX_BINARY := "01001100";
           when   77  =>  SH_INVALID_CNT_MAX_BINARY := "01001101";
           when   78  =>  SH_INVALID_CNT_MAX_BINARY := "01001110";
           when   79  =>  SH_INVALID_CNT_MAX_BINARY := "01001111";
           when   80  =>  SH_INVALID_CNT_MAX_BINARY := "01010000";
           when   81  =>  SH_INVALID_CNT_MAX_BINARY := "01010001";
           when   82  =>  SH_INVALID_CNT_MAX_BINARY := "01010010";
           when   83  =>  SH_INVALID_CNT_MAX_BINARY := "01010011";
           when   84  =>  SH_INVALID_CNT_MAX_BINARY := "01010100";
           when   85  =>  SH_INVALID_CNT_MAX_BINARY := "01010101";
           when   86  =>  SH_INVALID_CNT_MAX_BINARY := "01010110";
           when   87  =>  SH_INVALID_CNT_MAX_BINARY := "01010111";
           when   88  =>  SH_INVALID_CNT_MAX_BINARY := "01011000";
           when   89  =>  SH_INVALID_CNT_MAX_BINARY := "01011001";
           when   90  =>  SH_INVALID_CNT_MAX_BINARY := "01011010";
           when   91  =>  SH_INVALID_CNT_MAX_BINARY := "01011011";
           when   92  =>  SH_INVALID_CNT_MAX_BINARY := "01011100";
           when   93  =>  SH_INVALID_CNT_MAX_BINARY := "01011101";
           when   94  =>  SH_INVALID_CNT_MAX_BINARY := "01011110";
           when   95  =>  SH_INVALID_CNT_MAX_BINARY := "01011111";
           when   96  =>  SH_INVALID_CNT_MAX_BINARY := "01100000";
           when   97  =>  SH_INVALID_CNT_MAX_BINARY := "01100001";
           when   98  =>  SH_INVALID_CNT_MAX_BINARY := "01100010";
           when   99  =>  SH_INVALID_CNT_MAX_BINARY := "01100011";
           when   100  =>  SH_INVALID_CNT_MAX_BINARY := "01100100";
           when   101  =>  SH_INVALID_CNT_MAX_BINARY := "01100101";
           when   102  =>  SH_INVALID_CNT_MAX_BINARY := "01100110";
           when   103  =>  SH_INVALID_CNT_MAX_BINARY := "01100111";
           when   104  =>  SH_INVALID_CNT_MAX_BINARY := "01101000";
           when   105  =>  SH_INVALID_CNT_MAX_BINARY := "01101001";
           when   106  =>  SH_INVALID_CNT_MAX_BINARY := "01101010";
           when   107  =>  SH_INVALID_CNT_MAX_BINARY := "01101011";
           when   108  =>  SH_INVALID_CNT_MAX_BINARY := "01101100";
           when   109  =>  SH_INVALID_CNT_MAX_BINARY := "01101101";
           when   110  =>  SH_INVALID_CNT_MAX_BINARY := "01101110";
           when   111  =>  SH_INVALID_CNT_MAX_BINARY := "01101111";
           when   112  =>  SH_INVALID_CNT_MAX_BINARY := "01110000";
           when   113  =>  SH_INVALID_CNT_MAX_BINARY := "01110001";
           when   114  =>  SH_INVALID_CNT_MAX_BINARY := "01110010";
           when   115  =>  SH_INVALID_CNT_MAX_BINARY := "01110011";
           when   116  =>  SH_INVALID_CNT_MAX_BINARY := "01110100";
           when   117  =>  SH_INVALID_CNT_MAX_BINARY := "01110101";
           when   118  =>  SH_INVALID_CNT_MAX_BINARY := "01110110";
           when   119  =>  SH_INVALID_CNT_MAX_BINARY := "01110111";
           when   120  =>  SH_INVALID_CNT_MAX_BINARY := "01111000";
           when   121  =>  SH_INVALID_CNT_MAX_BINARY := "01111001";
           when   122  =>  SH_INVALID_CNT_MAX_BINARY := "01111010";
           when   123  =>  SH_INVALID_CNT_MAX_BINARY := "01111011";
           when   124  =>  SH_INVALID_CNT_MAX_BINARY := "01111100";
           when   125  =>  SH_INVALID_CNT_MAX_BINARY := "01111101";
           when   126  =>  SH_INVALID_CNT_MAX_BINARY := "01111110";
           when   127  =>  SH_INVALID_CNT_MAX_BINARY := "01111111";
           when   128  =>  SH_INVALID_CNT_MAX_BINARY := "10000000";
           when   129  =>  SH_INVALID_CNT_MAX_BINARY := "10000001";
           when   130  =>  SH_INVALID_CNT_MAX_BINARY := "10000010";
           when   131  =>  SH_INVALID_CNT_MAX_BINARY := "10000011";
           when   132  =>  SH_INVALID_CNT_MAX_BINARY := "10000100";
           when   133  =>  SH_INVALID_CNT_MAX_BINARY := "10000101";
           when   134  =>  SH_INVALID_CNT_MAX_BINARY := "10000110";
           when   135  =>  SH_INVALID_CNT_MAX_BINARY := "10000111";
           when   136  =>  SH_INVALID_CNT_MAX_BINARY := "10001000";
           when   137  =>  SH_INVALID_CNT_MAX_BINARY := "10001001";
           when   138  =>  SH_INVALID_CNT_MAX_BINARY := "10001010";
           when   139  =>  SH_INVALID_CNT_MAX_BINARY := "10001011";
           when   140  =>  SH_INVALID_CNT_MAX_BINARY := "10001100";
           when   141  =>  SH_INVALID_CNT_MAX_BINARY := "10001101";
           when   142  =>  SH_INVALID_CNT_MAX_BINARY := "10001110";
           when   143  =>  SH_INVALID_CNT_MAX_BINARY := "10001111";
           when   144  =>  SH_INVALID_CNT_MAX_BINARY := "10010000";
           when   145  =>  SH_INVALID_CNT_MAX_BINARY := "10010001";
           when   146  =>  SH_INVALID_CNT_MAX_BINARY := "10010010";
           when   147  =>  SH_INVALID_CNT_MAX_BINARY := "10010011";
           when   148  =>  SH_INVALID_CNT_MAX_BINARY := "10010100";
           when   149  =>  SH_INVALID_CNT_MAX_BINARY := "10010101";
           when   150  =>  SH_INVALID_CNT_MAX_BINARY := "10010110";
           when   151  =>  SH_INVALID_CNT_MAX_BINARY := "10010111";
           when   152  =>  SH_INVALID_CNT_MAX_BINARY := "10011000";
           when   153  =>  SH_INVALID_CNT_MAX_BINARY := "10011001";
           when   154  =>  SH_INVALID_CNT_MAX_BINARY := "10011010";
           when   155  =>  SH_INVALID_CNT_MAX_BINARY := "10011011";
           when   156  =>  SH_INVALID_CNT_MAX_BINARY := "10011100";
           when   157  =>  SH_INVALID_CNT_MAX_BINARY := "10011101";
           when   158  =>  SH_INVALID_CNT_MAX_BINARY := "10011110";
           when   159  =>  SH_INVALID_CNT_MAX_BINARY := "10011111";
           when   160  =>  SH_INVALID_CNT_MAX_BINARY := "10100000";
           when   161  =>  SH_INVALID_CNT_MAX_BINARY := "10100001";
           when   162  =>  SH_INVALID_CNT_MAX_BINARY := "10100010";
           when   163  =>  SH_INVALID_CNT_MAX_BINARY := "10100011";
           when   164  =>  SH_INVALID_CNT_MAX_BINARY := "10100100";
           when   165  =>  SH_INVALID_CNT_MAX_BINARY := "10100101";
           when   166  =>  SH_INVALID_CNT_MAX_BINARY := "10100110";
           when   167  =>  SH_INVALID_CNT_MAX_BINARY := "10100111";
           when   168  =>  SH_INVALID_CNT_MAX_BINARY := "10101000";
           when   169  =>  SH_INVALID_CNT_MAX_BINARY := "10101001";
           when   170  =>  SH_INVALID_CNT_MAX_BINARY := "10101010";
           when   171  =>  SH_INVALID_CNT_MAX_BINARY := "10101011";
           when   172  =>  SH_INVALID_CNT_MAX_BINARY := "10101100";
           when   173  =>  SH_INVALID_CNT_MAX_BINARY := "10101101";
           when   174  =>  SH_INVALID_CNT_MAX_BINARY := "10101110";
           when   175  =>  SH_INVALID_CNT_MAX_BINARY := "10101111";
           when   176  =>  SH_INVALID_CNT_MAX_BINARY := "10110000";
           when   177  =>  SH_INVALID_CNT_MAX_BINARY := "10110001";
           when   178  =>  SH_INVALID_CNT_MAX_BINARY := "10110010";
           when   179  =>  SH_INVALID_CNT_MAX_BINARY := "10110011";
           when   180  =>  SH_INVALID_CNT_MAX_BINARY := "10110100";
           when   181  =>  SH_INVALID_CNT_MAX_BINARY := "10110101";
           when   182  =>  SH_INVALID_CNT_MAX_BINARY := "10110110";
           when   183  =>  SH_INVALID_CNT_MAX_BINARY := "10110111";
           when   184  =>  SH_INVALID_CNT_MAX_BINARY := "10111000";
           when   185  =>  SH_INVALID_CNT_MAX_BINARY := "10111001";
           when   186  =>  SH_INVALID_CNT_MAX_BINARY := "10111010";
           when   187  =>  SH_INVALID_CNT_MAX_BINARY := "10111011";
           when   188  =>  SH_INVALID_CNT_MAX_BINARY := "10111100";
           when   189  =>  SH_INVALID_CNT_MAX_BINARY := "10111101";
           when   190  =>  SH_INVALID_CNT_MAX_BINARY := "10111110";
           when   191  =>  SH_INVALID_CNT_MAX_BINARY := "10111111";
           when   192  =>  SH_INVALID_CNT_MAX_BINARY := "11000000";
           when   193  =>  SH_INVALID_CNT_MAX_BINARY := "11000001";
           when   194  =>  SH_INVALID_CNT_MAX_BINARY := "11000010";
           when   195  =>  SH_INVALID_CNT_MAX_BINARY := "11000011";
           when   196  =>  SH_INVALID_CNT_MAX_BINARY := "11000100";
           when   197  =>  SH_INVALID_CNT_MAX_BINARY := "11000101";
           when   198  =>  SH_INVALID_CNT_MAX_BINARY := "11000110";
           when   199  =>  SH_INVALID_CNT_MAX_BINARY := "11000111";
           when   200  =>  SH_INVALID_CNT_MAX_BINARY := "11001000";
           when   201  =>  SH_INVALID_CNT_MAX_BINARY := "11001001";
           when   202  =>  SH_INVALID_CNT_MAX_BINARY := "11001010";
           when   203  =>  SH_INVALID_CNT_MAX_BINARY := "11001011";
           when   204  =>  SH_INVALID_CNT_MAX_BINARY := "11001100";
           when   205  =>  SH_INVALID_CNT_MAX_BINARY := "11001101";
           when   206  =>  SH_INVALID_CNT_MAX_BINARY := "11001110";
           when   207  =>  SH_INVALID_CNT_MAX_BINARY := "11001111";
           when   208  =>  SH_INVALID_CNT_MAX_BINARY := "11010000";
           when   209  =>  SH_INVALID_CNT_MAX_BINARY := "11010001";
           when   210  =>  SH_INVALID_CNT_MAX_BINARY := "11010010";
           when   211  =>  SH_INVALID_CNT_MAX_BINARY := "11010011";
           when   212  =>  SH_INVALID_CNT_MAX_BINARY := "11010100";
           when   213  =>  SH_INVALID_CNT_MAX_BINARY := "11010101";
           when   214  =>  SH_INVALID_CNT_MAX_BINARY := "11010110";
           when   215  =>  SH_INVALID_CNT_MAX_BINARY := "11010111";
           when   216  =>  SH_INVALID_CNT_MAX_BINARY := "11011000";
           when   217  =>  SH_INVALID_CNT_MAX_BINARY := "11011001";
           when   218  =>  SH_INVALID_CNT_MAX_BINARY := "11011010";
           when   219  =>  SH_INVALID_CNT_MAX_BINARY := "11011011";
           when   220  =>  SH_INVALID_CNT_MAX_BINARY := "11011100";
           when   221  =>  SH_INVALID_CNT_MAX_BINARY := "11011101";
           when   222  =>  SH_INVALID_CNT_MAX_BINARY := "11011110";
           when   223  =>  SH_INVALID_CNT_MAX_BINARY := "11011111";
           when   224  =>  SH_INVALID_CNT_MAX_BINARY := "11100000";
           when   225  =>  SH_INVALID_CNT_MAX_BINARY := "11100001";
           when   226  =>  SH_INVALID_CNT_MAX_BINARY := "11100010";
           when   227  =>  SH_INVALID_CNT_MAX_BINARY := "11100011";
           when   228  =>  SH_INVALID_CNT_MAX_BINARY := "11100100";
           when   229  =>  SH_INVALID_CNT_MAX_BINARY := "11100101";
           when   230  =>  SH_INVALID_CNT_MAX_BINARY := "11100110";
           when   231  =>  SH_INVALID_CNT_MAX_BINARY := "11100111";
           when   232  =>  SH_INVALID_CNT_MAX_BINARY := "11101000";
           when   233  =>  SH_INVALID_CNT_MAX_BINARY := "11101001";
           when   234  =>  SH_INVALID_CNT_MAX_BINARY := "11101010";
           when   235  =>  SH_INVALID_CNT_MAX_BINARY := "11101011";
           when   236  =>  SH_INVALID_CNT_MAX_BINARY := "11101100";
           when   237  =>  SH_INVALID_CNT_MAX_BINARY := "11101101";
           when   238  =>  SH_INVALID_CNT_MAX_BINARY := "11101110";
           when   239  =>  SH_INVALID_CNT_MAX_BINARY := "11101111";
           when   240  =>  SH_INVALID_CNT_MAX_BINARY := "11110000";
           when   241  =>  SH_INVALID_CNT_MAX_BINARY := "11110001";
           when   242  =>  SH_INVALID_CNT_MAX_BINARY := "11110010";
           when   243  =>  SH_INVALID_CNT_MAX_BINARY := "11110011";
           when   244  =>  SH_INVALID_CNT_MAX_BINARY := "11110100";
           when   245  =>  SH_INVALID_CNT_MAX_BINARY := "11110101";
           when   246  =>  SH_INVALID_CNT_MAX_BINARY := "11110110";
           when   247  =>  SH_INVALID_CNT_MAX_BINARY := "11110111";
           when   248  =>  SH_INVALID_CNT_MAX_BINARY := "11111000";
           when   249  =>  SH_INVALID_CNT_MAX_BINARY := "11111001";
           when   250  =>  SH_INVALID_CNT_MAX_BINARY := "11111010";
           when   251  =>  SH_INVALID_CNT_MAX_BINARY := "11111011";
           when   252  =>  SH_INVALID_CNT_MAX_BINARY := "11111100";
           when   253  =>  SH_INVALID_CNT_MAX_BINARY := "11111101";
           when   254  =>  SH_INVALID_CNT_MAX_BINARY := "11111110";
           when   255  =>  SH_INVALID_CNT_MAX_BINARY := "11111111";
           when others  =>  assert FALSE report "Error : SH_INVALID_CNT_MAX is not in range 0...255." severity error;
       end case;
       case ALIGN_COMMA_WORD is
           when   1  =>  ALIGN_COMMA_WORD_BINARY := "00";
           when   2  =>  ALIGN_COMMA_WORD_BINARY := "01";
           when   4  =>  ALIGN_COMMA_WORD_BINARY := "10";
           when others  =>  assert FALSE report "Error : ALIGN_COMMA_WORD is not in 1, 2, 4." severity error;
       end case;
       case DEC_MCOMMA_DETECT is
           when FALSE   =>  DEC_MCOMMA_DETECT_BINARY := '0';
           when TRUE    =>  DEC_MCOMMA_DETECT_BINARY := '1';
           when others  =>  assert FALSE report "Error : DEC_MCOMMA_DETECT is neither TRUE nor FALSE." severity error;
       end case;
       case DEC_PCOMMA_DETECT is
           when FALSE   =>  DEC_PCOMMA_DETECT_BINARY := '0';
           when TRUE    =>  DEC_PCOMMA_DETECT_BINARY := '1';
           when others  =>  assert FALSE report "Error : DEC_PCOMMA_DETECT is neither TRUE nor FALSE." severity error;
       end case;
       case DEC_VALID_COMMA_ONLY is
           when FALSE   =>  DEC_VALID_COMMA_ONLY_BINARY := '0';
           when TRUE    =>  DEC_VALID_COMMA_ONLY_BINARY := '1';
           when others  =>  assert FALSE report "Error : DEC_VALID_COMMA_ONLY is neither TRUE nor FALSE." severity error;
       end case;
       case MCOMMA_DETECT is
           when FALSE   =>  MCOMMA_DETECT_BINARY := '0';
           when TRUE    =>  MCOMMA_DETECT_BINARY := '1';
           when others  =>  assert FALSE report "Error : MCOMMA_DETECT is neither TRUE nor FALSE." severity error;
       end case;
       case PCOMMA_DETECT is
           when FALSE   =>  PCOMMA_DETECT_BINARY := '0';
           when TRUE    =>  PCOMMA_DETECT_BINARY := '1';
           when others  =>  assert FALSE report "Error : PCOMMA_DETECT is neither TRUE nor FALSE." severity error;
       end case;
       case COMMA32 is
           when FALSE   =>  COMMA32_BINARY := '0';
           when TRUE    =>  COMMA32_BINARY := '1';
           when others  =>  assert FALSE report "Error : COMMA32 is neither TRUE nor FALSE." severity error;
       end case;
       case RXUSRDIVISOR is
           when   1  =>  RXUSRDIVISOR_BINARY := "00001";
           when   2  =>  RXUSRDIVISOR_BINARY := "00010";
           when   4  =>  RXUSRDIVISOR_BINARY := "00100";
           when   8  =>  RXUSRDIVISOR_BINARY := "01000";
           when   16  =>  RXUSRDIVISOR_BINARY := "10000";
           when others  =>  assert FALSE report "Error : RXUSRDIVISOR is not in 1, 2, 4, 8, 16." severity error;
       end case;
       case SAMPLE_8X is
           when FALSE   =>  SAMPLE_8X_BINARY := '0';
           when TRUE    =>  SAMPLE_8X_BINARY := '1';
           when others  =>  assert FALSE report "Error : SAMPLE_8X is neither TRUE nor FALSE." severity error;
       end case;
       case ENABLE_DCDR is
           when FALSE   =>  ENABLE_DCDR_BINARY := '0';
           when TRUE    =>  ENABLE_DCDR_BINARY := '1';
           when others  =>  assert FALSE report "Error : ENABLE_DCDR is neither TRUE nor FALSE." severity error;
       end case;
       case REPEATER is
           when FALSE   =>  REPEATER_BINARY := '0';
           when TRUE    =>  REPEATER_BINARY := '1';
           when others  =>  assert FALSE report "Error : REPEATER is neither TRUE nor FALSE." severity error;
       end case;
       case RXBY_32 is
           when FALSE   =>  RXBY_32_BINARY := '0';
           when TRUE    =>  RXBY_32_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXBY_32 is neither TRUE nor FALSE." severity error;
       end case;
--     case TXFDCAL_CLOCK_DIVIDE is
           if((TXFDCAL_CLOCK_DIVIDE = "NONE") or (TXFDCAL_CLOCK_DIVIDE = "none")) then
               TXFDCAL_CLOCK_DIVIDE_BINARY := "00";
           elsif((TXFDCAL_CLOCK_DIVIDE = "TWO") or (TXFDCAL_CLOCK_DIVIDE = "two")) then
               TXFDCAL_CLOCK_DIVIDE_BINARY := "01";
           elsif((TXFDCAL_CLOCK_DIVIDE = "FOUR") or (TXFDCAL_CLOCK_DIVIDE = "four")) then
               TXFDCAL_CLOCK_DIVIDE_BINARY := "10";
           else
             assert FALSE report "Error : TXFDCAL_CLOCK_DIVIDE = is not NONE, TWO, FOUR." severity error;
           end if;
--     end case;
--     case RXFDCAL_CLOCK_DIVIDE is
           if((RXFDCAL_CLOCK_DIVIDE = "NONE") or (RXFDCAL_CLOCK_DIVIDE = "none")) then
               RXFDCAL_CLOCK_DIVIDE_BINARY := "00";
           elsif((RXFDCAL_CLOCK_DIVIDE = "TWO") or (RXFDCAL_CLOCK_DIVIDE = "two")) then
               RXFDCAL_CLOCK_DIVIDE_BINARY := "01";
           elsif((RXFDCAL_CLOCK_DIVIDE = "FOUR") or (RXFDCAL_CLOCK_DIVIDE = "four")) then
               RXFDCAL_CLOCK_DIVIDE_BINARY := "10";
           else
             assert FALSE report "Error : RXFDCAL_CLOCK_DIVIDE = is not NONE, TWO, FOUR." severity error;
           end if;
--     end case;
       case RXVCO_CTRL_ENABLE is
           when FALSE   =>  RXVCO_CTRL_ENABLE_BINARY := '0';
           when TRUE    =>  RXVCO_CTRL_ENABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXVCO_CTRL_ENABLE is neither TRUE nor FALSE." severity error;
       end case;
       case VCO_CTRL_ENABLE is
           when FALSE   =>  VCO_CTRL_ENABLE_BINARY := '0';
           when TRUE    =>  VCO_CTRL_ENABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : VCO_CTRL_ENABLE is neither TRUE nor FALSE." severity error;
       end case;
       case RXCRCCLOCKDOUBLE is
           when FALSE   =>  RXCRCCLOCKDOUBLE_BINARY := '0';
           when TRUE    =>  RXCRCCLOCKDOUBLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXCRCCLOCKDOUBLE is neither TRUE nor FALSE." severity error;
       end case;
       case RXCRCINVERTGEN is
           when FALSE   =>  RXCRCINVERTGEN_BINARY := '0';
           when TRUE    =>  RXCRCINVERTGEN_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXCRCINVERTGEN is neither TRUE nor FALSE." severity error;
       end case;
       case RXCRCSAMECLOCK is
           when FALSE   =>  RXCRCSAMECLOCK_BINARY := '0';
           when TRUE    =>  RXCRCSAMECLOCK_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXCRCSAMECLOCK is neither TRUE nor FALSE." severity error;
       end case;
       case RXCRCENABLE is
           when FALSE   =>  RXCRCENABLE_BINARY := '0';
           when TRUE    =>  RXCRCENABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXCRCENABLE is neither TRUE nor FALSE." severity error;
       end case;
       case TXCRCCLOCKDOUBLE is
           when FALSE   =>  TXCRCCLOCKDOUBLE_BINARY := '0';
           when TRUE    =>  TXCRCCLOCKDOUBLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXCRCCLOCKDOUBLE is neither TRUE nor FALSE." severity error;
       end case;
       case TXCRCINVERTGEN is
           when FALSE   =>  TXCRCINVERTGEN_BINARY := '0';
           when TRUE    =>  TXCRCINVERTGEN_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXCRCINVERTGEN is neither TRUE nor FALSE." severity error;
       end case;
       case TXCRCSAMECLOCK is
           when FALSE   =>  TXCRCSAMECLOCK_BINARY := '0';
           when TRUE    =>  TXCRCSAMECLOCK_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXCRCSAMECLOCK is neither TRUE nor FALSE." severity error;
       end case;
       case TXCRCENABLE is
           when FALSE   =>  TXCRCENABLE_BINARY := '0';
           when TRUE    =>  TXCRCENABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXCRCENABLE is neither TRUE nor FALSE." severity error;
       end case;
       case RXCLK0_FORCE_PMACLK is
           when FALSE   =>  RXCLK0_FORCE_PMACLK_BINARY := '0';
           when TRUE    =>  RXCLK0_FORCE_PMACLK_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXCLK0_FORCE_PMACLK is neither TRUE nor FALSE." severity error;
       end case;
       case TXCLK0_FORCE_PMACLK is
           when FALSE   =>  TXCLK0_FORCE_PMACLK_BINARY := '0';
           when TRUE    =>  TXCLK0_FORCE_PMACLK_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXCLK0_FORCE_PMACLK is neither TRUE nor FALSE." severity error;
       end case;
       case TXOUTCLK1_USE_SYNC is
           when FALSE   =>  TXOUTCLK1_USE_SYNC_BINARY := '0';
           when TRUE    =>  TXOUTCLK1_USE_SYNC_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXOUTCLK1_USE_SYNC is neither TRUE nor FALSE." severity error;
       end case;
       case RXRECCLK1_USE_SYNC is
           when FALSE   =>  RXRECCLK1_USE_SYNC_BINARY := '0';
           when TRUE    =>  RXRECCLK1_USE_SYNC_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXRECCLK1_USE_SYNC is neither TRUE nor FALSE." severity error;
       end case;
--     case RXPMACLKSEL is
           if((RXPMACLKSEL = "REFCLK1") or (RXPMACLKSEL = "refclk1")) then
               RXPMACLKSEL_BINARY := "00";
           elsif((RXPMACLKSEL = "REFCLK2") or (RXPMACLKSEL = "refclk2")) then
               RXPMACLKSEL_BINARY := "01";
           elsif((RXPMACLKSEL = "GREFCLK") or (RXPMACLKSEL = "grefclk")) then
               RXPMACLKSEL_BINARY := "10";
           else
             assert FALSE report "Error : RXPMACLKSEL = is not REFCLK1, REFCLK2, GREFCLK." severity error;
           end if;
--     end case;
--     case TXABPMACLKSEL is
           if((TXABPMACLKSEL = "REFCLK1") or (TXABPMACLKSEL = "refclk1")) then
               TXABPMACLKSEL_BINARY := "00";
           elsif((TXABPMACLKSEL = "REFCLK2") or (TXABPMACLKSEL = "refclk2")) then
               TXABPMACLKSEL_BINARY := "01";
           elsif((TXABPMACLKSEL = "GREFCLK") or (TXABPMACLKSEL = "grefclk")) then
               TXABPMACLKSEL_BINARY := "10";
           else
             assert FALSE report "Error : TXABPMACLKSEL = is not REFCLK1, REFCLK2, GREFCLK." severity error;
           end if;
--     end case;
       case BANDGAPSEL is
           when FALSE   =>  BANDGAPSEL_BINARY := '0';
           when TRUE    =>  BANDGAPSEL_BINARY := '1';
           when others  =>  assert FALSE report "Error : BANDGAPSEL is neither TRUE nor FALSE." severity error;
       end case;
       case BIASRESSEL is
           when FALSE   =>  BIASRESSEL_BINARY := '0';
           when TRUE    =>  BIASRESSEL_BINARY := '1';
           when others  =>  assert FALSE report "Error : BIASRESSEL is neither TRUE nor FALSE." severity error;
       end case;
       case TXPHASESEL is
           when FALSE   =>  TXPHASESEL_BINARY := '0';
           when TRUE    =>  TXPHASESEL_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXPHASESEL is neither TRUE nor FALSE." severity error;
       end case;
       case PMACLKENABLE is
           when FALSE   =>  PMACLKENABLE_BINARY := '0';
           when TRUE    =>  PMACLKENABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : PMACLKENABLE is neither TRUE nor FALSE." severity error;
       end case;
       case PMACOREPWRENABLE is
           when FALSE   =>  PMACOREPWRENABLE_BINARY := '0';
           when TRUE    =>  PMACOREPWRENABLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : PMACOREPWRENABLE is neither TRUE nor FALSE." severity error;
       end case;
       case PMA_BIT_SLIP is
           when FALSE   =>  PMA_BIT_SLIP_BINARY := '0';
           when TRUE    =>  PMA_BIT_SLIP_BINARY := '1';
           when others  =>  assert FALSE report "Error : PMA_BIT_SLIP is neither TRUE nor FALSE." severity error;
       end case;
       case RXLB is
           when FALSE   =>  RXLB_BINARY := '0';
           when TRUE    =>  RXLB_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXLB is neither TRUE nor FALSE." severity error;
       end case;
       case RXDCCOUPLE is
           when FALSE   =>  RXDCCOUPLE_BINARY := '0';
           when TRUE    =>  RXDCCOUPLE_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXDCCOUPLE is neither TRUE nor FALSE." severity error;
       end case;
       case RXDIGRESET is
           when FALSE   =>  RXDIGRESET_BINARY := '0';
           when TRUE    =>  RXDIGRESET_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXDIGRESET is neither TRUE nor FALSE." severity error;
       end case;
       case RXCPTST is
           when FALSE   =>  RXCPTST_BINARY := '0';
           when TRUE    =>  RXCPTST_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXCPTST is neither TRUE nor FALSE." severity error;
       end case;
       case RXPDDTST is
           when FALSE   =>  RXPDDTST_BINARY := '0';
           when TRUE    =>  RXPDDTST_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXPDDTST is neither TRUE nor FALSE." severity error;
       end case;
       case RXACTST is
           when FALSE   =>  RXACTST_BINARY := '0';
           when TRUE    =>  RXACTST_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXACTST is neither TRUE nor FALSE." severity error;
       end case;
       case RXAFETST is
           when FALSE   =>  RXAFETST_BINARY := '0';
           when TRUE    =>  RXAFETST_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXAFETST is neither TRUE nor FALSE." severity error;
       end case;
       case RXLKAPD is
           when FALSE   =>  RXLKAPD_BINARY := '0';
           when TRUE    =>  RXLKAPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXLKAPD is neither TRUE nor FALSE." severity error;
       end case;
       case RXRSDPD is
           when FALSE   =>  RXRSDPD_BINARY := '0';
           when TRUE    =>  RXRSDPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXRSDPD is neither TRUE nor FALSE." severity error;
       end case;
       case RXRCPPD is
           when FALSE   =>  RXRCPPD_BINARY := '0';
           when TRUE    =>  RXRCPPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXRCPPD is neither TRUE nor FALSE." severity error;
       end case;
       case RXRPDPD is
           when FALSE   =>  RXRPDPD_BINARY := '0';
           when TRUE    =>  RXRPDPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXRPDPD is neither TRUE nor FALSE." severity error;
       end case;
       case RXAFEPD is
           when FALSE   =>  RXAFEPD_BINARY := '0';
           when TRUE    =>  RXAFEPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXAFEPD is neither TRUE nor FALSE." severity error;
       end case;
       case RXPD is
           when FALSE   =>  RXPD_BINARY := '0';
           when TRUE    =>  RXPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXPD is neither TRUE nor FALSE." severity error;
       end case;
       case TXOUTDIV2SEL is
           when   1  =>  TXOUTDIV2SEL_BINARY := "0001";
           when   2  =>  TXOUTDIV2SEL_BINARY := "0010";
           when   4  =>  TXOUTDIV2SEL_BINARY := "0011";
           when   8  =>  TXOUTDIV2SEL_BINARY := "0100";
           when   16  =>  TXOUTDIV2SEL_BINARY := "0101";
           when   32  =>  TXOUTDIV2SEL_BINARY := "0110";
           when others  =>  assert FALSE report "Error : TXOUTDIV2SEL is not in 1, 2, 4, 8, 16, 32." severity error;
       end case;
       case TXPLLNDIVSEL is
           when   8  =>  TXPLLNDIVSEL_BINARY := "0000";
           when   10  =>  TXPLLNDIVSEL_BINARY := "0010";
           when   16  =>  TXPLLNDIVSEL_BINARY := "0100";
           when   20  =>  TXPLLNDIVSEL_BINARY := "0110";
           when   32  =>  TXPLLNDIVSEL_BINARY := "1000";
           when   40  =>  TXPLLNDIVSEL_BINARY := "1010";
           when others  =>  assert FALSE report "Error : TXPLLNDIVSEL is not in 8, 10, 16, 20, 32, 40." severity error;
       end case;
       case TXCPSEL is
           when FALSE   =>  TXCPSEL_BINARY := '0';
           when TRUE    =>  TXCPSEL_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXCPSEL is neither TRUE nor FALSE." severity error;
       end case;
       case TXAPD is
           when FALSE   =>  TXAPD_BINARY := '0';
           when TRUE    =>  TXAPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXAPD is neither TRUE nor FALSE." severity error;
       end case;
       case TXLVLSHFTPD is
           when FALSE   =>  TXLVLSHFTPD_BINARY := '0';
           when TRUE    =>  TXLVLSHFTPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXLVLSHFTPD is neither TRUE nor FALSE." severity error;
       end case;
       case TXPRE_TAP_PD is
           when FALSE   =>  TXPRE_TAP_PD_BINARY := '0';
           when TRUE    =>  TXPRE_TAP_PD_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXPRE_TAP_PD is neither TRUE nor FALSE." severity error;
       end case;
       case TXDIGPD is
           when FALSE   =>  TXDIGPD_BINARY := '0';
           when TRUE    =>  TXDIGPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXDIGPD is neither TRUE nor FALSE." severity error;
       end case;
       case TXHIGHSIGNALEN is
           when FALSE   =>  TXHIGHSIGNALEN_BINARY := '0';
           when TRUE    =>  TXHIGHSIGNALEN_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXHIGHSIGNALEN is neither TRUE nor FALSE." severity error;
       end case;
       case TXAREFBIASSEL is
           when FALSE   =>  TXAREFBIASSEL_BINARY := '0';
           when TRUE    =>  TXAREFBIASSEL_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXAREFBIASSEL is neither TRUE nor FALSE." severity error;
       end case;
       case TXSLEWRATE is
           when FALSE   =>  TXSLEWRATE_BINARY := '0';
           when TRUE    =>  TXSLEWRATE_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXSLEWRATE is neither TRUE nor FALSE." severity error;
       end case;
       case TXPOST_TAP_PD is
           when FALSE   =>  TXPOST_TAP_PD_BINARY := '0';
           when TRUE    =>  TXPOST_TAP_PD_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXPOST_TAP_PD is neither TRUE nor FALSE." severity error;
       end case;
       case TXPD is
           when FALSE   =>  TXPD_BINARY := '0';
           when TRUE    =>  TXPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : TXPD is neither TRUE nor FALSE." severity error;
       end case;
       case RXOUTDIV2SEL is
           when   1  =>  RXOUTDIV2SEL_BINARY := "00010001";
           when   2  =>  RXOUTDIV2SEL_BINARY := "00100010";
           when   4  =>  RXOUTDIV2SEL_BINARY := "00110011";
           when   8  =>  RXOUTDIV2SEL_BINARY := "01000100";
           when   16  =>  RXOUTDIV2SEL_BINARY := "01010101";
           when   32  =>  RXOUTDIV2SEL_BINARY := "01100110";
           when others  =>  assert FALSE report "Error : RXOUTDIV2SEL is not in 1, 2, 4, 8, 16, 32." severity error;
       end case;
       case RXPLLNDIVSEL is
           when   8  =>  RXPLLNDIVSEL_BINARY := "0000";
           when   10  =>  RXPLLNDIVSEL_BINARY := "0010";
           when   16  =>  RXPLLNDIVSEL_BINARY := "0100";
           when   20  =>  RXPLLNDIVSEL_BINARY := "0110";
           when   32  =>  RXPLLNDIVSEL_BINARY := "1000";
           when   40  =>  RXPLLNDIVSEL_BINARY := "1010";
           when others  =>  assert FALSE report "Error : RXPLLNDIVSEL is not in 8, 10, 16, 20, 32, 40." severity error;
       end case;
       case RXDIGRX is
           when FALSE   =>  RXDIGRX_BINARY := '0';
           when TRUE    =>  RXDIGRX_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXDIGRX is neither TRUE nor FALSE." severity error;
       end case;
       case RXCPSEL is
           when FALSE   =>  RXCPSEL_BINARY := '0';
           when TRUE    =>  RXCPSEL_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXCPSEL is neither TRUE nor FALSE." severity error;
       end case;
       case RXAPD is
           when FALSE   =>  RXAPD_BINARY := '0';
           when TRUE    =>  RXAPD_BINARY := '1';
           when others  =>  assert FALSE report "Error : RXAPD is neither TRUE nor FALSE." severity error;
       end case;

synDigCfgChnBnd1(63) <=	'0';--RESERVED_CB1;  
synDigCfgChnBnd1(62) <=	TX_BUFFER_USE_BINARY;  
synDigCfgChnBnd1(61) <=	RX_BUFFER_USE_BINARY;  
synDigCfgChnBnd1(60 downto 58) <=	CHAN_BOND_SEQ_LEN_BINARY;  
synDigCfgChnBnd1(57) <=	CHAN_BOND_SEQ_2_USE_BINARY;  
synDigCfgChnBnd1(56) <=	CHAN_BOND_ONE_SHOT_BINARY;  
synDigCfgChnBnd1(55 downto 54) <=	CHAN_BOND_MODE_BINARY;  
synDigCfgChnBnd1(53 downto 48) <=	CHAN_BOND_LIMIT_BINARY;  
synDigCfgChnBnd1(47 downto 44) <=	CHAN_BOND_SEQ_1_MASK_BINARY;  
synDigCfgChnBnd1(43 downto 33) <=	CHAN_BOND_SEQ_1_4_BINARY;  
synDigCfgChnBnd1(32 downto 22) <=	CHAN_BOND_SEQ_1_3_BINARY;  
synDigCfgChnBnd1(21 downto 11) <=	CHAN_BOND_SEQ_1_2_BINARY;  
synDigCfgChnBnd1(10 downto 0) <=	CHAN_BOND_SEQ_1_1_BINARY;	 



synDigCfgChnBnd2(63 downto 56) <= "00000000";--	CHAN_BOND_TUNE;  
synDigCfgChnBnd2(55) <=	'0';    -- unused
synDigCfgChnBnd2(54) <=	'0';    -- unused
synDigCfgChnBnd2(53) <=	CCCB_ARBITRATOR_DISABLE_BINARY;
synDigCfgChnBnd2(52) <=	OPPOSITE_SELECT_BINARY;  
synDigCfgChnBnd2(51) <=	POWER_ENABLE_BINARY;
synDigCfgChnBnd2(50 downto 48) <=	"000";  
synDigCfgChnBnd2(47 downto 44) <=	CHAN_BOND_SEQ_2_MASK_BINARY;  
synDigCfgChnBnd2(43 downto 33) <=	CHAN_BOND_SEQ_2_4_BINARY;  
synDigCfgChnBnd2(32 downto 22) <=	CHAN_BOND_SEQ_2_3_BINARY;  
synDigCfgChnBnd2(21 downto 11) <=	CHAN_BOND_SEQ_2_2_BINARY;  
synDigCfgChnBnd2(10 downto 0) <=	CHAN_BOND_SEQ_2_1_BINARY;	 



synDigCfgClkCor1(63 downto 62) <=	RXDATA_SEL_BINARY;
synDigCfgClkCor1(61 downto 60) <=	TXDATA_SEL_BINARY;
synDigCfgClkCor1(59) <=	'0';--RESERVED_CCB;                                                          
synDigCfgClkCor1(58 downto 53) <=	CLK_COR_MIN_LAT_BINARY;  
synDigCfgClkCor1(52) <=	'0';--RESERVED_CCA;
synDigCfgClkCor1(51) <=	PCS_BIT_SLIP_BINARY;
synDigCfgClkCor1(50) <=	DIGRX_SYNC_MODE_BINARY;
synDigCfgClkCor1(49 downto 48) <=	DIGRX_FWDCLK_BINARY;
synDigCfgClkCor1(47 downto 44) <=	CLK_COR_SEQ_1_MASK_BINARY;  
synDigCfgClkCor1(43 downto 33) <=	CLK_COR_SEQ_1_4_BINARY;  
synDigCfgClkCor1(32 downto 22) <=	CLK_COR_SEQ_1_3_BINARY;  
synDigCfgClkCor1(21 downto 11) <=	CLK_COR_SEQ_1_2_BINARY;  
synDigCfgClkCor1(10 downto 0) <=	CLK_COR_SEQ_1_1_BINARY;	 



synDigCfgClkCor2(63 downto 56) <=	"00000000"; --RX_LOS_THRESHOLD_BINARY;  
synDigCfgClkCor2(55 downto 48) <=	"00000000"; --RX_LOS_INVALID_INCR_BINARY;  
synDigCfgClkCor2(47 downto 44) <=	CLK_COR_SEQ_2_MASK_BINARY;  
synDigCfgClkCor2(43 downto 33) <=	CLK_COR_SEQ_2_4_BINARY;  
synDigCfgClkCor2(32 downto 22) <=	CLK_COR_SEQ_2_3_BINARY;  
synDigCfgClkCor2(21 downto 11) <=	CLK_COR_SEQ_2_2_BINARY;  
synDigCfgClkCor2(10 downto 0) <=	CLK_COR_SEQ_2_1_BINARY;	 



synDigCfgMisc(63) <=	RXRECCLK1_USE_SYNC_BINARY;  
synDigCfgMisc(62) <=	TXOUTCLK1_USE_SYNC_BINARY;  
synDigCfgMisc(61) <=	TXCLK0_FORCE_PMACLK_BINARY;  
synDigCfgMisc(60) <=	RXCLK0_FORCE_PMACLK_BINARY;  
synDigCfgMisc(59 downto 58) <=	TX_CLOCK_DIVIDER_BINARY;  
synDigCfgMisc(57 downto 56) <=	RX_CLOCK_DIVIDER_BINARY;  
synDigCfgMisc(55) <=	TXCRCENABLE_BINARY;  
synDigCfgMisc(54) <=	TXCRCSAMECLOCK_BINARY;  
synDigCfgMisc(53) <=	TXCRCINVERTGEN_BINARY;  
synDigCfgMisc(52) <=	TXCRCCLOCKDOUBLE_BINARY;  
synDigCfgMisc(51) <=	RXCRCENABLE_BINARY;  
synDigCfgMisc(50) <=	RXCRCSAMECLOCK_BINARY;  
synDigCfgMisc(49) <=	RXCRCINVERTGEN_BINARY;  
synDigCfgMisc(48) <=	RXCRCCLOCKDOUBLE_BINARY;  
synDigCfgMisc(47 downto 46) <=	RXFDCAL_CLOCK_DIVIDE_BINARY;  
synDigCfgMisc(45 downto 44) <=	TXFDCAL_CLOCK_DIVIDE_BINARY;  
synDigCfgMisc(43) <=	RXBY_32_BINARY;  
synDigCfgMisc(42) <=	REPEATER_BINARY;  
synDigCfgMisc(41) <=	ENABLE_DCDR_BINARY;  
synDigCfgMisc(40) <=	SAMPLE_8X_BINARY;  
synDigCfgMisc(39 downto 37) <=	DCDR_FILTER_BINARY;  
synDigCfgMisc(36 downto 32) <=	RXUSRDIVISOR_BINARY;  
synDigCfgMisc(31 downto 24) <=	SH_INVALID_CNT_MAX_BINARY;  
synDigCfgMisc(23 downto 16) <=	SH_CNT_MAX_BINARY;  
synDigCfgMisc(15) <=	'0';--RESERVED_M2;  
synDigCfgMisc(14) <=	CLK_COR_8B10B_DE_BINARY;  
synDigCfgMisc(13) <=	CLK_CORRECT_USE_BINARY;  
synDigCfgMisc(12 downto 10) <=	CLK_COR_SEQ_LEN_BINARY;  
synDigCfgMisc(9) <=	CLK_COR_SEQ_DROP_BINARY;  
synDigCfgMisc(8) <=	CLK_COR_SEQ_2_USE_BINARY;  
synDigCfgMisc(7) <=	'0';--TXCLK0_INVERT_PMALEAF;  
synDigCfgMisc(6) <=	'0';--RXCLK0_INVERT_PMALEAF;  	 
synDigCfgMisc(5 downto 0) <=	CLK_COR_MAX_LAT_BINARY;	 



synDigCfgComma1(63 downto 42) <=	"0000000000000000000000";--COMMA_32B_MASK;
synDigCfgComma1(41 downto 32) <=	COMMA_10B_MASK_BINARY;
synDigCfgComma1(31 downto 8) <=	"000000000000000000000000";--RESERVED_CM;
synDigCfgComma1(7) <=	COMMA32_BINARY;  
synDigCfgComma1(6) <=	PCOMMA_DETECT_BINARY;  
synDigCfgComma1(5) <=	MCOMMA_DETECT_BINARY;  
synDigCfgComma1(4) <=	DEC_VALID_COMMA_ONLY_BINARY;  
synDigCfgComma1(3) <=	DEC_PCOMMA_DETECT_BINARY;  
synDigCfgComma1(2) <=	DEC_MCOMMA_DETECT_BINARY;  
synDigCfgComma1(1 downto 0) <=	ALIGN_COMMA_WORD_BINARY;	 



synDigCfgComma2(63 downto 32) <=	PCOMMA_32B_VALUE_BINARY;  
synDigCfgComma2(31 downto 0) <=	MCOMMA_32B_VALUE_BINARY;	 



synDigCfgSynPmaFD(63) <=       '1';--  AUTO_CAL;  
synDigCfgSynPmaFD(62 downto 53) <=	VCODAC_INIT_BINARY;  
synDigCfgSynPmaFD(52 downto 51) <=	"00";--SLOWDOWN_CAL;  
synDigCfgSynPmaFD(50) <=	'0';--  BYPASS_FDET;  
synDigCfgSynPmaFD(49 downto 48) <=	LOOPCAL_WAIT_BINARY;  
synDigCfgSynPmaFD(47) <=	'0';--  BYPASS_CAL;  
synDigCfgSynPmaFD(46 downto 44) <=	FDET_HYS_CAL_BINARY;  
synDigCfgSynPmaFD(43 downto 41) <=	FDET_LCK_CAL_BINARY;  
synDigCfgSynPmaFD(40 downto 38) <=	FDET_HYS_SEL_BINARY;  
synDigCfgSynPmaFD(37 downto 35) <=	FDET_LCK_SEL_BINARY;  
synDigCfgSynPmaFD(34) <=	VCO_CTRL_ENABLE_BINARY;  
synDigCfgSynPmaFD(33 downto 32) <=	CYCLE_LIMIT_SEL_BINARY;  
synDigCfgSynPmaFD(31) <=	'1';--  RXAUTO_CAL;  
synDigCfgSynPmaFD(30 downto 21) <=	RXVCODAC_INIT_BINARY;  
synDigCfgSynPmaFD(20 downto 19) <=	RXSLOWDOWN_CAL_BINARY;  
synDigCfgSynPmaFD(18) <=	'0';--  RXBYPASS_FDET;  
synDigCfgSynPmaFD(17 downto 16) <=	RXLOOPCAL_WAIT_BINARY;  
synDigCfgSynPmaFD(15) <=	'0';--  RXBYPASS_CAL;  
synDigCfgSynPmaFD(14 downto 12) <=	RXFDET_HYS_CAL_BINARY;  
synDigCfgSynPmaFD(11 downto 9) <=	RXFDET_LCK_CAL_BINARY;  
synDigCfgSynPmaFD(8 downto 6) <=	RXFDET_HYS_SEL_BINARY;  
synDigCfgSynPmaFD(5 downto 3) <=	RXFDET_LCK_SEL_BINARY;  
synDigCfgSynPmaFD(2) <=	RXVCO_CTRL_ENABLE_BINARY;  
synDigCfgSynPmaFD(1 downto 0) <=	RXCYCLE_LIMIT_SEL_BINARY;	 



synDigCfgCrc(63 downto 32) <=	TXCRCINITVAL_BINARY;  
synDigCfgCrc(31 downto 0) <=	RXCRCINITVAL_BINARY;	 



PMACFG(63 downto 62) <=	"00";  
PMACFG(61 downto 60) <=	RXPMACLKSEL_BINARY;  
PMACFG(59 downto 58) <=	RXPMACLKSEL_BINARY;   
PMACFG(57 downto 56) <=	TXABPMACLKSEL_BINARY;  
PMACFG(55 downto 48) <=	"00000000";  
PMACFG(47) <=	'0';--  PMATUNE;  
PMACFG(46 downto 42) <=	"00000";--  TXREGCTRL;  
PMACFG(41 downto 37) <=	RXAREGCTRL_BINARY;  
PMACFG(36 downto 32) <=	PMAVBGCTRL_BINARY;
PMACFG(31) <=	BANDGAPSEL_BINARY;  
PMACFG(30 downto 27) <=	PMAIREFTRIM_BINARY;  
PMACFG(26 downto 25) <=	IREFBIASMODE_BINARY;  
PMACFG(24) <=	BIASRESSEL_BINARY;  
PMACFG(23 downto 20) <=	PMAVREFTRIM_BINARY;  
PMACFG(19) <=	'0';--VREFSELECT;  
PMACFG(18 downto 17) <=	VREFBIASMODE_BINARY;  
PMACFG(16) <=	'0';--  PMABIASPD;  
PMACFG(15 downto 14) <=	"00";
PMACFG(13) <=	'0';  
PMACFG(12) <=	'0';--  ATBBUMPEN;  
PMACFG(11) <=	'0';--  NATBENABLE;  
PMACFG(10 downto 5) <=	"000000";  
PMACFG(4) <=	TXPHASESEL_BINARY;
PMACFG(3) <=	'0';            --UNUSED
PMACFG(2) <=	'0';--  PMACTRL;                                        
PMACFG(1) <=	PMACLKENABLE_BINARY;--'0';--  PMACLKENABLEPD;  
PMACFG(0) <=	PMACOREPWRENABLE_BINARY;	 

PMACFG2(63 downto 18) <= "0000000000000000000000000000000000000000000000";
PMACFG2(17 downto 0) <= "000000000000000000";

RXAFECFG(63 downto 58) <= RXMODE_BINARY;
RXAFECFG(57) <=	PMA_BIT_SLIP_BINARY;
RXAFECFG(56 downto 55) <=	RXASYNCDIVIDE_BINARY;
RXAFECFG(54 downto 49) <=	RXCLKMODE_BINARY;  
RXAFECFG(48) <=	RXLB_BINARY;  
RXAFECFG(47 downto 46) <=	RXFETUNE_BINARY;  
RXAFECFG(45 downto 43) <=	RXRCPADJ_BINARY;--"00";--  RXRCPADJ;  
RXAFECFG(42 downto 41) <=	RXRIBADJ_BINARY;  
RXAFECFG(40 downto 32) <=	RXAFEEQ_BINARY;  
RXAFECFG(31 downto 30) <=	RXCMADJ_BINARY;  
RXAFECFG(29 downto 24) <=	RXCDRLOS_BINARY;  
RXAFECFG(23) <=	'0';
RXAFECFG(22) <=	RXDCCOUPLE_BINARY;
RXAFECFG(21) <=	'0';  
RXAFECFG(20 downto 16) <=	RXLKADJ_BINARY;  
RXAFECFG(15) <=	RXDIGRESET_BINARY;  
RXAFECFG(14 downto 12) <=	RXFECONTROL2_BINARY;  
RXAFECFG(11) <=	RXCPTST_BINARY;  
RXAFECFG(10) <=	RXPDDTST_BINARY;  
RXAFECFG(9) <=	RXACTST_BINARY;  
RXAFECFG(8) <=	RXAFETST_BINARY;  
RXAFECFG(7 downto 6) <=	RXFECONTROL1_BINARY;  
RXAFECFG(5) <=	RXLKAPD_BINARY;  
RXAFECFG(4) <=	RXRSDPD_BINARY;  
RXAFECFG(3) <=	RXRCPPD_BINARY;  
RXAFECFG(2) <=	RXRPDPD_BINARY;  
RXAFECFG(1) <=	RXAFEPD_BINARY;  
RXAFECFG(0) <=	RXPD_BINARY;	 



RXAEQCFG(63 downto 0) <= RXEQ_BINARY;	 



TXCLCFG(63 downto 60) <=	TXOUTDIV2SEL_BINARY;  
TXCLCFG(59 downto 56) <=	TXPLLNDIVSEL_BINARY;  
TXCLCFG(55 downto 54) <=	TXCLMODE_BINARY;  
TXCLCFG(53 downto 50) <=	TXLOOPFILT_BINARY;  
TXCLCFG(49) <=	'0';--  UNUSED;  
TXCLCFG(48) <=	'0';--  UNUSED;  
TXCLCFG(47 downto 35) <= TXTUNE_BINARY;
TXCLCFG(34) <=	'0';--  UNUSED;  
TXCLCFG(33) <=	'0';--  --UNUSED;  
TXCLCFG(32) <=	TXCPSEL_BINARY;
TXCLCFG(31) <=	'0';            --TXDACTST
TXCLCFG(30 downto 27) <=	TXOUTDIV2SEL_BINARY;
TXCLCFG(26 downto 17) <=	TXCTRL1_BINARY;
TXCLCFG(16) <=	'0';--  TXQPPD;  
TXCLCFG(15) <=	'0';--  TXCMFPD;  
TXCLCFG(14) <=	'0';--  TXVCOPD;  
TXCLCFG(13) <=	'0';--  TXADCADJPD;  
TXCLCFG(12) <=	'0';--  TXDIVPD;  
TXCLCFG(11) <=	'0';--  TXBIASPD;  
TXCLCFG(10) <=	'0';--  TXDIVBUFPD;  
TXCLCFG(9) <=	'0';--  TXVCOBUFPD;  
TXCLCFG(8) <=	TXAPD_BINARY;  
TXCLCFG(7) <=	'0';--  TXAPTST;  
TXCLCFG(6) <=	'0';--  TXCMFTST;  
TXCLCFG(5) <=	'0';--  TXFILTTST;  
TXCLCFG(4) <=	'0';--  TXDIVTST;  
TXCLCFG(3) <=	'0';--  TXPFDTST;  
TXCLCFG(2) <=	'0';--  TXVCOBUFTST;  
TXCLCFG(1) <=	'0';--  TXDIVBUFTST;  
TXCLCFG(0) <=	'0';--  TXVCOTST;	 



TXACFG(63 downto 60) <=	"0000";
TXACFG(59) <=	TXLVLSHFTPD_BINARY;
TXACFG(58 downto 56) <=	TXPRE_PRDRV_DAC_BINARY;
TXACFG(55) <=	TXPRE_TAP_PD_BINARY;
TXACFG(54 downto 53) <=	TXPRE_TAP_DAC_BINARY(4 downto 3);
TXACFG(52) <=	TXDIGPD_BINARY;
TXACFG(51 downto 48) <=	TXCLKMODE_BINARY;  
TXACFG(47 downto 45) <=	TXPRE_TAP_DAC_BINARY(2 downto 0);
TXACFG(44) <=	'0';  
TXACFG(43) <=	TXHIGHSIGNALEN_BINARY;  
TXACFG(42) <=	TXAREFBIASSEL_BINARY;  
TXACFG(41 downto 38) <=	TXTERMTRIM_BINARY;  
TXACFG(37) <=	TXASYNCDIVIDE_BINARY(1);  
TXACFG(36) <=	TXSLEWRATE_BINARY;
TXACFG(35 downto 33) <=	TXPOST_PRDRV_DAC_BINARY;  
TXACFG(32 downto 30) <=	TXDAT_PRDRV_DAC_BINARY;  
TXACFG(29) <=	TXASYNCDIVIDE_BINARY(0);  
TXACFG(28) <=	TXPOST_TAP_PD_BINARY;  
TXACFG(27 downto 23) <=	TXPOST_TAP_DAC_BINARY;  
TXACFG(22 downto 21) <=	"00";--  TXTUNE1;  
TXACFG(20 downto 16) <=	TXDAT_TAP_DAC_BINARY;  
TXACFG(15 downto 1) <=	"000000000000000";--  TXDIG_TST;  
TXACFG(0) <=	TXPD_BINARY;	 



RXACLCFG(63 downto 60) <= RXOUTDIV2SEL_BINARY(7 downto 4);  
RXACLCFG(59 downto 56) <= RXPLLNDIVSEL_BINARY;  
RXACLCFG(55 downto 54) <= RXCLMODE_BINARY;  
RXACLCFG(53 downto 50) <= RXLOOPFILT_BINARY;  
RXACLCFG(49) <=	RXDIGRX_BINARY;  
RXACLCFG(48) <=	'0';--  RXPFDTX;  
RXACLCFG(47 downto 35) <= RXTUNE_BINARY;  
RXACLCFG(34) <=	'0';--  RXSLOSEL;  
RXACLCFG(33) <=	'0';--  RXDACSEL;  
RXACLCFG(32) <=	RXCPSEL_BINARY;  
RXACLCFG(31) <=	'0';--  RXDACTST;  
RXACLCFG(30 downto 27) <= RXOUTDIV2SEL_BINARY(3 downto 0);
RXACLCFG(26 downto 17) <= RXCTRL1_BINARY;
RXACLCFG(16) <=	'0';--  RXQPPD;  
RXACLCFG(15) <=	'1';--  RXCMFPD;  
RXACLCFG(14) <=	'0';--  RXVCOPD;  
RXACLCFG(13) <=	'0';--  RXADCADJPD;  
RXACLCFG(12) <=	'0';--  RXDIVPD;  
RXACLCFG(11) <=	'0';--  RXBIASPD;  
RXACLCFG(10) <=	'0';--  RXVCOBUFPD;  
RXACLCFG(9) <=	'0';--  RXDIVBUFPD;  
RXACLCFG(8) <=	RXAPD_BINARY;  
RXACLCFG(7) <=	'0';--  RXAPTST;  
RXACLCFG(6) <=	'0';--  RXCMFTST;  
RXACLCFG(5) <=	'0';--  RXFILTTST;  
RXACLCFG(4) <=	'0';-- RXDIVTST;  
RXACLCFG(3) <=	'0';--  RXPFDTST;  
RXACLCFG(2) <=	'0';--  RXVCOBUFTST;  
RXACLCFG(1) <=	'0';--  RXDIVBUFTST;  
RXACLCFG(0) <=	'0';--  RXVCOTST	                                  
     wait;
   end process INIPROC;

   TIMING : process

--  Pin timing violations (clock input pins)

--  Pin Timing Violations (all input pins)
     variable Tviol_CHBONDI0_RXUSRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CHBONDI0_RXUSRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CHBONDI1_RXUSRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CHBONDI1_RXUSRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CHBONDI2_RXUSRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CHBONDI2_RXUSRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CHBONDI3_RXUSRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CHBONDI3_RXUSRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CHBONDI4_RXUSRCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CHBONDI4_RXUSRCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_ENCHANSYNC_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_ENCHANSYNC_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_ENMCOMMAALIGN_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_ENMCOMMAALIGN_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_ENPCOMMAALIGN_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_ENPCOMMAALIGN_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCOMMADETUSE_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCOMMADETUSE_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXIGNOREBTF_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXIGNOREBTF_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXRESET_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXRESET_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXSLIDE_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXSLIDE_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B0_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B0_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B1_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B1_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B2_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B2_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B3_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B3_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B4_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B4_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B5_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B5_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B6_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B6_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXBYPASS8B10B7_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXBYPASS8B10B7_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE0_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE0_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE1_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE1_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE2_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE2_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE3_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE3_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE4_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE4_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE5_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE5_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE6_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE6_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPMODE7_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPMODE7_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL0_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL0_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL1_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL1_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL2_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL2_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL3_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL3_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL4_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL4_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL5_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL5_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL6_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL6_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARDISPVAL7_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARDISPVAL7_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK0_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK0_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK1_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK1_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK2_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK2_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK3_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK3_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK4_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK4_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK5_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK5_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK6_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK6_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCHARISK7_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCHARISK7_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA0_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA0_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA1_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA1_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA2_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA2_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA3_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA3_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA4_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA4_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA5_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA5_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA6_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA6_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA7_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA7_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA8_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA8_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA9_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA9_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA10_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA10_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA11_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA11_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA12_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA12_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA13_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA13_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA14_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA14_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA15_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA15_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA16_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA16_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA17_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA17_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA18_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA18_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA19_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA19_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA20_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA20_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA21_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA21_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA22_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA22_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA23_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA23_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA24_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA24_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA25_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA25_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA26_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA26_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA27_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA27_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA28_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA28_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA29_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA29_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA30_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA30_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA31_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA31_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA32_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA32_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA33_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA33_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA34_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA34_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA35_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA35_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA36_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA36_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA37_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA37_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA38_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA38_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA39_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA39_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA40_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA40_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA41_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA41_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA42_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA42_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA43_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA43_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA44_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA44_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA45_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA45_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA46_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA46_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA47_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA47_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA48_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA48_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA49_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA49_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA50_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA50_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA51_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA51_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA52_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA52_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA53_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA53_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA54_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA54_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA55_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA55_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA56_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA56_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA57_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA57_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA58_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA58_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA59_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA59_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA60_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA60_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA61_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA61_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA62_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA62_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXDATA63_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXDATA63_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXRESET_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXRESET_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCLKSTABLE_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCLKSTABLE_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXPMARESET_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXPMARESET_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCLKSTABLE_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCLKSTABLE_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXPMARESET_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXPMARESET_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN0_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN0_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN1_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN1_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN2_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN2_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN3_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN3_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN4_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN4_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN5_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN5_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN6_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN6_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN7_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN7_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN8_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN8_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN9_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN9_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN10_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN10_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN11_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN11_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN12_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN12_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN13_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN13_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN14_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN14_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN15_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN15_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN16_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN16_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN17_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN17_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN18_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN18_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN19_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN19_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN20_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN20_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN21_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN21_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN22_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN22_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN23_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN23_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN24_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN24_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN25_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN25_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN26_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN26_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN27_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN27_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN28_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN28_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN29_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN29_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN30_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN30_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN31_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN31_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN32_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN32_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN33_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN33_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN34_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN34_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN35_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN35_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN36_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN36_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN37_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN37_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN38_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN38_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN39_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN39_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN40_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN40_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN41_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN41_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN42_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN42_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN43_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN43_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN44_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN44_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN45_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN45_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN46_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN46_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN47_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN47_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN48_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN48_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN49_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN49_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN50_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN50_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN51_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN51_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN52_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN52_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN53_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN53_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN54_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN54_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN55_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN55_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN56_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN56_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN57_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN57_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN58_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN58_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN59_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN59_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN60_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN60_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN61_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN61_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN62_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN62_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCIN63_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCIN63_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCDATAWIDTH0_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCDATAWIDTH0_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCDATAWIDTH1_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCDATAWIDTH1_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCDATAWIDTH2_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCDATAWIDTH2_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCDATAVALID_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCDATAVALID_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCINIT_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCINIT_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXCRCRESET_RXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXCRCRESET_RXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN0_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN0_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN1_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN1_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN2_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN2_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN3_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN3_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN4_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN4_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN5_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN5_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN6_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN6_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN7_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN7_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN8_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN8_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN9_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN9_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN10_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN10_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN11_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN11_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN12_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN12_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN13_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN13_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN14_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN14_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN15_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN15_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN16_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN16_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN17_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN17_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN18_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN18_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN19_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN19_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN20_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN20_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN21_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN21_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN22_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN22_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN23_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN23_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN24_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN24_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN25_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN25_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN26_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN26_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN27_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN27_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN28_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN28_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN29_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN29_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN30_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN30_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN31_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN31_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN32_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN32_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN33_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN33_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN34_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN34_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN35_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN35_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN36_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN36_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN37_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN37_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN38_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN38_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN39_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN39_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN40_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN40_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN41_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN41_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN42_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN42_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN43_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN43_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN44_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN44_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN45_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN45_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN46_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN46_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN47_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN47_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN48_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN48_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN49_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN49_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN50_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN50_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN51_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN51_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN52_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN52_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN53_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN53_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN54_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN54_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN55_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN55_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN56_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN56_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN57_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN57_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN58_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN58_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN59_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN59_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN60_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN60_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN61_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN61_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN62_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN62_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCIN63_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCIN63_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCDATAWIDTH0_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCDATAWIDTH0_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCDATAWIDTH1_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCDATAWIDTH1_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCDATAWIDTH2_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCDATAWIDTH2_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCDATAVALID_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCDATAVALID_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCINIT_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCINIT_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXCRCRESET_TXCRCINTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXCRCRESET_TXCRCINTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXSYNC_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXSYNC_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_RXSYNC_RXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_RXSYNC_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TXENOOB_TXUSRCLK2_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TXENOOB_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR0_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR0_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR1_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR1_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR2_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR2_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR3_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR3_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR4_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR4_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR5_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR5_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR6_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR6_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DADDR7_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DADDR7_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DEN_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DEN_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DWE_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DWE_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI0_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI0_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI1_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI1_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI2_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI2_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI3_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI3_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI4_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI4_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI5_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI5_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI6_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI6_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI7_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI7_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI8_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI8_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI9_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI9_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI10_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI10_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI11_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI11_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI12_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI12_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI13_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI13_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI14_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI14_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_DI15_DCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_DI15_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;

--  Output Pin glitch declaration
     variable  CHBONDO0_GlitchData : VitalGlitchDataType;
     variable  CHBONDO1_GlitchData : VitalGlitchDataType;
     variable  CHBONDO2_GlitchData : VitalGlitchDataType;
     variable  CHBONDO3_GlitchData : VitalGlitchDataType;
     variable  CHBONDO4_GlitchData : VitalGlitchDataType;
     variable  RXSTATUS0_GlitchData : VitalGlitchDataType;
     variable  RXSTATUS1_GlitchData : VitalGlitchDataType;
     variable  RXSTATUS2_GlitchData : VitalGlitchDataType;
     variable  RXSTATUS3_GlitchData : VitalGlitchDataType;
     variable  RXSTATUS4_GlitchData : VitalGlitchDataType;
     variable  RXSTATUS5_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA0_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA1_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA2_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA3_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA4_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA5_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA6_GlitchData : VitalGlitchDataType;
     variable  RXCHARISCOMMA7_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK0_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK1_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK2_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK3_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK4_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK5_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK6_GlitchData : VitalGlitchDataType;
     variable  RXCHARISK7_GlitchData : VitalGlitchDataType;
     variable  RXCOMMADET_GlitchData : VitalGlitchDataType;
     variable  RXDATA0_GlitchData : VitalGlitchDataType;
     variable  RXDATA1_GlitchData : VitalGlitchDataType;
     variable  RXDATA2_GlitchData : VitalGlitchDataType;
     variable  RXDATA3_GlitchData : VitalGlitchDataType;
     variable  RXDATA4_GlitchData : VitalGlitchDataType;
     variable  RXDATA5_GlitchData : VitalGlitchDataType;
     variable  RXDATA6_GlitchData : VitalGlitchDataType;
     variable  RXDATA7_GlitchData : VitalGlitchDataType;
     variable  RXDATA8_GlitchData : VitalGlitchDataType;
     variable  RXDATA9_GlitchData : VitalGlitchDataType;
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
     variable  RXDATA20_GlitchData : VitalGlitchDataType;
     variable  RXDATA21_GlitchData : VitalGlitchDataType;
     variable  RXDATA22_GlitchData : VitalGlitchDataType;
     variable  RXDATA23_GlitchData : VitalGlitchDataType;
     variable  RXDATA24_GlitchData : VitalGlitchDataType;
     variable  RXDATA25_GlitchData : VitalGlitchDataType;
     variable  RXDATA26_GlitchData : VitalGlitchDataType;
     variable  RXDATA27_GlitchData : VitalGlitchDataType;
     variable  RXDATA28_GlitchData : VitalGlitchDataType;
     variable  RXDATA29_GlitchData : VitalGlitchDataType;
     variable  RXDATA30_GlitchData : VitalGlitchDataType;
     variable  RXDATA31_GlitchData : VitalGlitchDataType;
     variable  RXDATA32_GlitchData : VitalGlitchDataType;
     variable  RXDATA33_GlitchData : VitalGlitchDataType;
     variable  RXDATA34_GlitchData : VitalGlitchDataType;
     variable  RXDATA35_GlitchData : VitalGlitchDataType;
     variable  RXDATA36_GlitchData : VitalGlitchDataType;
     variable  RXDATA37_GlitchData : VitalGlitchDataType;
     variable  RXDATA38_GlitchData : VitalGlitchDataType;
     variable  RXDATA39_GlitchData : VitalGlitchDataType;
     variable  RXDATA40_GlitchData : VitalGlitchDataType;
     variable  RXDATA41_GlitchData : VitalGlitchDataType;
     variable  RXDATA42_GlitchData : VitalGlitchDataType;
     variable  RXDATA43_GlitchData : VitalGlitchDataType;
     variable  RXDATA44_GlitchData : VitalGlitchDataType;
     variable  RXDATA45_GlitchData : VitalGlitchDataType;
     variable  RXDATA46_GlitchData : VitalGlitchDataType;
     variable  RXDATA47_GlitchData : VitalGlitchDataType;
     variable  RXDATA48_GlitchData : VitalGlitchDataType;
     variable  RXDATA49_GlitchData : VitalGlitchDataType;
     variable  RXDATA50_GlitchData : VitalGlitchDataType;
     variable  RXDATA51_GlitchData : VitalGlitchDataType;
     variable  RXDATA52_GlitchData : VitalGlitchDataType;
     variable  RXDATA53_GlitchData : VitalGlitchDataType;
     variable  RXDATA54_GlitchData : VitalGlitchDataType;
     variable  RXDATA55_GlitchData : VitalGlitchDataType;
     variable  RXDATA56_GlitchData : VitalGlitchDataType;
     variable  RXDATA57_GlitchData : VitalGlitchDataType;
     variable  RXDATA58_GlitchData : VitalGlitchDataType;
     variable  RXDATA59_GlitchData : VitalGlitchDataType;
     variable  RXDATA60_GlitchData : VitalGlitchDataType;
     variable  RXDATA61_GlitchData : VitalGlitchDataType;
     variable  RXDATA62_GlitchData : VitalGlitchDataType;
     variable  RXDATA63_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR0_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR1_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR2_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR3_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR4_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR5_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR6_GlitchData : VitalGlitchDataType;
     variable  RXDISPERR7_GlitchData : VitalGlitchDataType;
     variable  RXLOSSOFSYNC0_GlitchData : VitalGlitchDataType;
     variable  RXLOSSOFSYNC1_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE0_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE1_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE2_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE3_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE4_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE5_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE6_GlitchData : VitalGlitchDataType;
     variable  RXNOTINTABLE7_GlitchData : VitalGlitchDataType;
     variable  RXREALIGN_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP0_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP1_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP2_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP3_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP4_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP5_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP6_GlitchData : VitalGlitchDataType;
     variable  RXRUNDISP7_GlitchData : VitalGlitchDataType;
     variable  RXBUFERR_GlitchData : VitalGlitchDataType;
     variable  TXBUFERR_GlitchData : VitalGlitchDataType;
     variable  TXKERR0_GlitchData : VitalGlitchDataType;
     variable  TXKERR1_GlitchData : VitalGlitchDataType;
     variable  TXKERR2_GlitchData : VitalGlitchDataType;
     variable  TXKERR3_GlitchData : VitalGlitchDataType;
     variable  TXKERR4_GlitchData : VitalGlitchDataType;
     variable  TXKERR5_GlitchData : VitalGlitchDataType;
     variable  TXKERR6_GlitchData : VitalGlitchDataType;
     variable  TXKERR7_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP0_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP1_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP2_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP3_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP4_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP5_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP6_GlitchData : VitalGlitchDataType;
     variable  TXRUNDISP7_GlitchData : VitalGlitchDataType;
     variable  RXRECCLK1_GlitchData : VitalGlitchDataType;
     variable  RXRECCLK2_GlitchData : VitalGlitchDataType;
     variable  TXOUTCLK1_GlitchData : VitalGlitchDataType;
     variable  TXOUTCLK2_GlitchData : VitalGlitchDataType;
     variable  RXLOCK_GlitchData : VitalGlitchDataType;
     variable  TXLOCK_GlitchData : VitalGlitchDataType;
     variable  RXCYCLELIMIT_GlitchData : VitalGlitchDataType;
     variable  TXCYCLELIMIT_GlitchData : VitalGlitchDataType;
     variable  RXCALFAIL_GlitchData : VitalGlitchDataType;
     variable  TXCALFAIL_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT0_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT1_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT2_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT3_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT4_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT5_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT6_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT7_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT8_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT9_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT10_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT11_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT12_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT13_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT14_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT15_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT16_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT17_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT18_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT19_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT20_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT21_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT22_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT23_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT24_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT25_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT26_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT27_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT28_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT29_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT30_GlitchData : VitalGlitchDataType;
     variable  RXCRCOUT31_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT0_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT1_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT2_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT3_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT4_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT5_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT6_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT7_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT8_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT9_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT10_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT11_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT12_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT13_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT14_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT15_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT16_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT17_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT18_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT19_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT20_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT21_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT22_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT23_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT24_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT25_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT26_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT27_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT28_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT29_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT30_GlitchData : VitalGlitchDataType;
     variable  TXCRCOUT31_GlitchData : VitalGlitchDataType;
     variable  RXSIGDET_GlitchData : VitalGlitchDataType;
     variable  DRDY_GlitchData : VitalGlitchDataType;
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
     variable  RXMCLK_GlitchData : VitalGlitchDataType;
     variable  TX1P_GlitchData : VitalGlitchDataType;
     variable  TX1N_GlitchData : VitalGlitchDataType;
     variable  TXPCSHCLKOUT_GlitchData : VitalGlitchDataType;
     variable  RXPCSHCLKOUT_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT0_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT1_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT2_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT3_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT4_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT5_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT6_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT7_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT8_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT9_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT10_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT11_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT12_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT13_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT14_GlitchData : VitalGlitchDataType;
     variable  COMBUSOUT15_GlitchData : VitalGlitchDataType;
begin

--  Setup/Hold Check Violations (all input pins)

     if (TimingChecksOn) then
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CHBONDI0_RXUSRCLK_posedge,
         TimingData     => Tmkr_CHBONDI0_RXUSRCLK_posedge,
         TestSignal     => CHBONDI_dly(0),
         TestSignalName => "CHBONDI(0)",
         TestDelay      => tisd_CHBONDI(0),
         RefSignal      => RXUSRCLK_dly,
         RefSignalName  => "RXUSRCLK",
         RefDelay       => ticd_RXUSRCLK,
         SetupHigh      => tsetup_CHBONDI_RXUSRCLK_posedge_posedge(0),
         SetupLow       => tsetup_CHBONDI_RXUSRCLK_negedge_posedge(0),
         HoldLow        => thold_CHBONDI_RXUSRCLK_posedge_posedge(0),
         HoldHigh       => thold_CHBONDI_RXUSRCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CHBONDI1_RXUSRCLK_posedge,
         TimingData     => Tmkr_CHBONDI1_RXUSRCLK_posedge,
         TestSignal     => CHBONDI_dly(1),
         TestSignalName => "CHBONDI(1)",
         TestDelay      => tisd_CHBONDI(1),
         RefSignal      => RXUSRCLK_dly,
         RefSignalName  => "RXUSRCLK",
         RefDelay       => ticd_RXUSRCLK,
         SetupHigh      => tsetup_CHBONDI_RXUSRCLK_posedge_posedge(1),
         SetupLow       => tsetup_CHBONDI_RXUSRCLK_negedge_posedge(1),
         HoldLow        => thold_CHBONDI_RXUSRCLK_posedge_posedge(1),
         HoldHigh       => thold_CHBONDI_RXUSRCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CHBONDI2_RXUSRCLK_posedge,
         TimingData     => Tmkr_CHBONDI2_RXUSRCLK_posedge,
         TestSignal     => CHBONDI_dly(2),
         TestSignalName => "CHBONDI(2)",
         TestDelay      => tisd_CHBONDI(2),
         RefSignal      => RXUSRCLK_dly,
         RefSignalName  => "RXUSRCLK",
         RefDelay       => ticd_RXUSRCLK,
         SetupHigh      => tsetup_CHBONDI_RXUSRCLK_posedge_posedge(2),
         SetupLow       => tsetup_CHBONDI_RXUSRCLK_negedge_posedge(2),
         HoldLow        => thold_CHBONDI_RXUSRCLK_posedge_posedge(2),
         HoldHigh       => thold_CHBONDI_RXUSRCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CHBONDI3_RXUSRCLK_posedge,
         TimingData     => Tmkr_CHBONDI3_RXUSRCLK_posedge,
         TestSignal     => CHBONDI_dly(3),
         TestSignalName => "CHBONDI(3)",
         TestDelay      => tisd_CHBONDI(3),
         RefSignal      => RXUSRCLK_dly,
         RefSignalName  => "RXUSRCLK",
         RefDelay       => ticd_RXUSRCLK,
         SetupHigh      => tsetup_CHBONDI_RXUSRCLK_posedge_posedge(3),
         SetupLow       => tsetup_CHBONDI_RXUSRCLK_negedge_posedge(3),
         HoldLow        => thold_CHBONDI_RXUSRCLK_posedge_posedge(3),
         HoldHigh       => thold_CHBONDI_RXUSRCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CHBONDI4_RXUSRCLK_posedge,
         TimingData     => Tmkr_CHBONDI4_RXUSRCLK_posedge,
         TestSignal     => CHBONDI_dly(4),
         TestSignalName => "CHBONDI(4)",
         TestDelay      => tisd_CHBONDI(4),
         RefSignal      => RXUSRCLK_dly,
         RefSignalName  => "RXUSRCLK",
         RefDelay       => ticd_RXUSRCLK,
         SetupHigh      => tsetup_CHBONDI_RXUSRCLK_posedge_posedge(4),
         SetupLow       => tsetup_CHBONDI_RXUSRCLK_negedge_posedge(4),
         HoldLow        => thold_CHBONDI_RXUSRCLK_posedge_posedge(4),
         HoldHigh       => thold_CHBONDI_RXUSRCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_ENCHANSYNC_RXUSRCLK2_posedge,
         TimingData     => Tmkr_ENCHANSYNC_RXUSRCLK2_posedge,
         TestSignal     => ENCHANSYNC_dly,
         TestSignalName => "ENCHANSYNC",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_ENCHANSYNC_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_ENCHANSYNC_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_ENCHANSYNC_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_ENCHANSYNC_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_ENMCOMMAALIGN_RXUSRCLK2_posedge,
         TimingData     => Tmkr_ENMCOMMAALIGN_RXUSRCLK2_posedge,
         TestSignal     => ENMCOMMAALIGN_dly,
         TestSignalName => "ENMCOMMAALIGN",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_ENMCOMMAALIGN_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_ENMCOMMAALIGN_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_ENMCOMMAALIGN_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_ENMCOMMAALIGN_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_ENPCOMMAALIGN_RXUSRCLK2_posedge,
         TimingData     => Tmkr_ENPCOMMAALIGN_RXUSRCLK2_posedge,
         TestSignal     => ENPCOMMAALIGN_dly,
         TestSignalName => "ENPCOMMAALIGN",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_ENPCOMMAALIGN_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_ENPCOMMAALIGN_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_ENPCOMMAALIGN_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_ENPCOMMAALIGN_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCOMMADETUSE_RXUSRCLK2_posedge,
         TimingData     => Tmkr_RXCOMMADETUSE_RXUSRCLK2_posedge,
         TestSignal     => RXCOMMADETUSE_dly,
         TestSignalName => "RXCOMMADETUSE",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXIGNOREBTF_RXUSRCLK2_posedge,
         TimingData     => Tmkr_RXIGNOREBTF_RXUSRCLK2_posedge,
         TestSignal     => RXIGNOREBTF_dly,
         TestSignalName => "RXIGNOREBTF",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXIGNOREBTF_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_RXIGNOREBTF_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_RXIGNOREBTF_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_RXIGNOREBTF_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXRESET_RXUSRCLK2_posedge,
         TimingData     => Tmkr_RXRESET_RXUSRCLK2_posedge,
         TestSignal     => RXRESET_dly,
         TestSignalName => "RXRESET",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXRESET_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_RXRESET_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_RXRESET_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_RXRESET_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXSLIDE_RXUSRCLK2_posedge,
         TimingData     => Tmkr_RXSLIDE_RXUSRCLK2_posedge,
         TestSignal     => RXSLIDE_dly,
         TestSignalName => "RXSLIDE",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXSLIDE_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_RXSLIDE_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_RXSLIDE_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_RXSLIDE_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B0_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B0_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(0),
         TestSignalName => "TXBYPASS8B10B(0)",
         TestDelay      => tisd_TXBYPASS8B10B(0),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(0),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(0),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(0),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B1_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B1_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(1),
         TestSignalName => "TXBYPASS8B10B(1)",
         TestDelay      => tisd_TXBYPASS8B10B(1),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(1),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(1),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(1),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B2_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B2_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(2),
         TestSignalName => "TXBYPASS8B10B(2)",
         TestDelay      => tisd_TXBYPASS8B10B(2),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(2),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(2),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(2),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B3_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B3_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(3),
         TestSignalName => "TXBYPASS8B10B(3)",
         TestDelay      => tisd_TXBYPASS8B10B(3),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(3),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(3),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(3),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B4_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B4_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(4),
         TestSignalName => "TXBYPASS8B10B(4)",
         TestDelay      => tisd_TXBYPASS8B10B(4),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(4),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(4),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(4),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B5_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B5_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(5),
         TestSignalName => "TXBYPASS8B10B(5)",
         TestDelay      => tisd_TXBYPASS8B10B(5),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(5),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(5),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(5),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B6_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B6_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(6),
         TestSignalName => "TXBYPASS8B10B(6)",
         TestDelay      => tisd_TXBYPASS8B10B(6),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(6),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(6),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(6),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXBYPASS8B10B7_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXBYPASS8B10B7_TXUSRCLK2_posedge,
         TestSignal     => TXBYPASS8B10B_dly(7),
         TestSignalName => "TXBYPASS8B10B(7)",
         TestDelay      => tisd_TXBYPASS8B10B(7),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(7),
         SetupLow       => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(7),
         HoldLow        => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(7),
         HoldHigh       => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE0_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE0_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(0),
         TestSignalName => "TXCHARDISPMODE(0)",
         TestDelay      => tisd_TXCHARDISPMODE(0),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(0),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(0),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(0),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE1_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE1_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(1),
         TestSignalName => "TXCHARDISPMODE(1)",
         TestDelay      => tisd_TXCHARDISPMODE(1),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(1),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(1),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(1),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE2_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE2_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(2),
         TestSignalName => "TXCHARDISPMODE(2)",
         TestDelay      => tisd_TXCHARDISPMODE(2),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(2),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(2),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(2),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE3_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE3_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(3),
         TestSignalName => "TXCHARDISPMODE(3)",
         TestDelay      => tisd_TXCHARDISPMODE(3),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(3),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(3),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(3),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE4_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE4_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(4),
         TestSignalName => "TXCHARDISPMODE(4)",
         TestDelay      => tisd_TXCHARDISPMODE(4),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(4),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(4),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(4),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE5_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE5_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(5),
         TestSignalName => "TXCHARDISPMODE(5)",
         TestDelay      => tisd_TXCHARDISPMODE(5),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(5),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(5),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(5),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE6_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE6_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(6),
         TestSignalName => "TXCHARDISPMODE(6)",
         TestDelay      => tisd_TXCHARDISPMODE(6),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(6),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(6),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(6),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPMODE7_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPMODE7_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPMODE_dly(7),
         TestSignalName => "TXCHARDISPMODE(7)",
         TestDelay      => tisd_TXCHARDISPMODE(7),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(7),
         SetupLow       => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(7),
         HoldLow        => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(7),
         HoldHigh       => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL0_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL0_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(0),
         TestSignalName => "TXCHARDISPVAL(0)",
         TestDelay      => tisd_TXCHARDISPVAL(0),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(0),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(0),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(0),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL1_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL1_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(1),
         TestSignalName => "TXCHARDISPVAL(1)",
         TestDelay      => tisd_TXCHARDISPVAL(1),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(1),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(1),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(1),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL2_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL2_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(2),
         TestSignalName => "TXCHARDISPVAL(2)",
         TestDelay      => tisd_TXCHARDISPVAL(2),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(2),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(2),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(2),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL3_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL3_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(3),
         TestSignalName => "TXCHARDISPVAL(3)",
         TestDelay      => tisd_TXCHARDISPVAL(3),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(3),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(3),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(3),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL4_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL4_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(4),
         TestSignalName => "TXCHARDISPVAL(4)",
         TestDelay      => tisd_TXCHARDISPVAL(4),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(4),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(4),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(4),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL5_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL5_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(5),
         TestSignalName => "TXCHARDISPVAL(5)",
         TestDelay      => tisd_TXCHARDISPVAL(5),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(5),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(5),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(5),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL6_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL6_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(6),
         TestSignalName => "TXCHARDISPVAL(6)",
         TestDelay      => tisd_TXCHARDISPVAL(6),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(6),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(6),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(6),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARDISPVAL7_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARDISPVAL7_TXUSRCLK2_posedge,
         TestSignal     => TXCHARDISPVAL_dly(7),
         TestSignalName => "TXCHARDISPVAL(7)",
         TestDelay      => tisd_TXCHARDISPVAL(7),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(7),
         SetupLow       => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(7),
         HoldLow        => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(7),
         HoldHigh       => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK0_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK0_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(0),
         TestSignalName => "TXCHARISK(0)",
         TestDelay      => tisd_TXCHARISK(0),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(0),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(0),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(0),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK1_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK1_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(1),
         TestSignalName => "TXCHARISK(1)",
         TestDelay      => tisd_TXCHARISK(1),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(1),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(1),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(1),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK2_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK2_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(2),
         TestSignalName => "TXCHARISK(2)",
         TestDelay      => tisd_TXCHARISK(2),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(2),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(2),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(2),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK3_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK3_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(3),
         TestSignalName => "TXCHARISK(3)",
         TestDelay      => tisd_TXCHARISK(3),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(3),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(3),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(3),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK4_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK4_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(4),
         TestSignalName => "TXCHARISK(4)",
         TestDelay      => tisd_TXCHARISK(4),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(4),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(4),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(4),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK5_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK5_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(5),
         TestSignalName => "TXCHARISK(5)",
         TestDelay      => tisd_TXCHARISK(5),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(5),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(5),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(5),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK6_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK6_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(6),
         TestSignalName => "TXCHARISK(6)",
         TestDelay      => tisd_TXCHARISK(6),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(6),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(6),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(6),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCHARISK7_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCHARISK7_TXUSRCLK2_posedge,
         TestSignal     => TXCHARISK_dly(7),
         TestSignalName => "TXCHARISK(7)",
         TestDelay      => tisd_TXCHARISK(7),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(7),
         SetupLow       => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(7),
         HoldLow        => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(7),
         HoldHigh       => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA0_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA0_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(0),
         TestSignalName => "TXDATA(0)",
         TestDelay      => tisd_TXDATA(0),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(0),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(0),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(0),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA1_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA1_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(1),
         TestSignalName => "TXDATA(1)",
         TestDelay      => tisd_TXDATA(1),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(1),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(1),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(1),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA2_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA2_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(2),
         TestSignalName => "TXDATA(2)",
         TestDelay      => tisd_TXDATA(2),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(2),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(2),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(2),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA3_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA3_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(3),
         TestSignalName => "TXDATA(3)",
         TestDelay      => tisd_TXDATA(3),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(3),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(3),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(3),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA4_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA4_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(4),
         TestSignalName => "TXDATA(4)",
         TestDelay      => tisd_TXDATA(4),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(4),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(4),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(4),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA5_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA5_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(5),
         TestSignalName => "TXDATA(5)",
         TestDelay      => tisd_TXDATA(5),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(5),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(5),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(5),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA6_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA6_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(6),
         TestSignalName => "TXDATA(6)",
         TestDelay      => tisd_TXDATA(6),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(6),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(6),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(6),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA7_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA7_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(7),
         TestSignalName => "TXDATA(7)",
         TestDelay      => tisd_TXDATA(7),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(7),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(7),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(7),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA8_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA8_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(8),
         TestSignalName => "TXDATA(8)",
         TestDelay      => tisd_TXDATA(8),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(8),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(8),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(8),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA9_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA9_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(9),
         TestSignalName => "TXDATA(9)",
         TestDelay      => tisd_TXDATA(9),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(9),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(9),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(9),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA10_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA10_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(10),
         TestSignalName => "TXDATA(10)",
         TestDelay      => tisd_TXDATA(10),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(10),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(10),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(10),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA11_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA11_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(11),
         TestSignalName => "TXDATA(11)",
         TestDelay      => tisd_TXDATA(11),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(11),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(11),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(11),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA12_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA12_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(12),
         TestSignalName => "TXDATA(12)",
         TestDelay      => tisd_TXDATA(12),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(12),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(12),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(12),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA13_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA13_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(13),
         TestSignalName => "TXDATA(13)",
         TestDelay      => tisd_TXDATA(13),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(13),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(13),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(13),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA14_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA14_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(14),
         TestSignalName => "TXDATA(14)",
         TestDelay      => tisd_TXDATA(14),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(14),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(14),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(14),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA15_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA15_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(15),
         TestSignalName => "TXDATA(15)",
         TestDelay      => tisd_TXDATA(15),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(15),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(15),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(15),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA16_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA16_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(16),
         TestSignalName => "TXDATA(16)",
         TestDelay      => tisd_TXDATA(16),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(16),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(16),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(16),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA17_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA17_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(17),
         TestSignalName => "TXDATA(17)",
         TestDelay      => tisd_TXDATA(17),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(17),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(17),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(17),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA18_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA18_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(18),
         TestSignalName => "TXDATA(18)",
         TestDelay      => tisd_TXDATA(18),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(18),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(18),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(18),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA19_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA19_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(19),
         TestSignalName => "TXDATA(19)",
         TestDelay      => tisd_TXDATA(19),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(19),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(19),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(19),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA20_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA20_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(20),
         TestSignalName => "TXDATA(20)",
         TestDelay      => tisd_TXDATA(20),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(20),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(20),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(20),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA21_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA21_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(21),
         TestSignalName => "TXDATA(21)",
         TestDelay      => tisd_TXDATA(21),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(21),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(21),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(21),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA22_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA22_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(22),
         TestSignalName => "TXDATA(22)",
         TestDelay      => tisd_TXDATA(22),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(22),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(22),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(22),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA23_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA23_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(23),
         TestSignalName => "TXDATA(23)",
         TestDelay      => tisd_TXDATA(23),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(23),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(23),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(23),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA24_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA24_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(24),
         TestSignalName => "TXDATA(24)",
         TestDelay      => tisd_TXDATA(24),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(24),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(24),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(24),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA25_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA25_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(25),
         TestSignalName => "TXDATA(25)",
         TestDelay      => tisd_TXDATA(25),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(25),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(25),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(25),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA26_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA26_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(26),
         TestSignalName => "TXDATA(26)",
         TestDelay      => tisd_TXDATA(26),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(26),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(26),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(26),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA27_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA27_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(27),
         TestSignalName => "TXDATA(27)",
         TestDelay      => tisd_TXDATA(27),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(27),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(27),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(27),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA28_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA28_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(28),
         TestSignalName => "TXDATA(28)",
         TestDelay      => tisd_TXDATA(28),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(28),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(28),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(28),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA29_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA29_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(29),
         TestSignalName => "TXDATA(29)",
         TestDelay      => tisd_TXDATA(29),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(29),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(29),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(29),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA30_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA30_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(30),
         TestSignalName => "TXDATA(30)",
         TestDelay      => tisd_TXDATA(30),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(30),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(30),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(30),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA31_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA31_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(31),
         TestSignalName => "TXDATA(31)",
         TestDelay      => tisd_TXDATA(31),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(31),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(31),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(31),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA32_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA32_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(32),
         TestSignalName => "TXDATA(32)",
         TestDelay      => tisd_TXDATA(32),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(32),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(32),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(32),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(32),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA33_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA33_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(33),
         TestSignalName => "TXDATA(33)",
         TestDelay      => tisd_TXDATA(33),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(33),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(33),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(33),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(33),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA34_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA34_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(34),
         TestSignalName => "TXDATA(34)",
         TestDelay      => tisd_TXDATA(34),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(34),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(34),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(34),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(34),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA35_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA35_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(35),
         TestSignalName => "TXDATA(35)",
         TestDelay      => tisd_TXDATA(35),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(35),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(35),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(35),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(35),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA36_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA36_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(36),
         TestSignalName => "TXDATA(36)",
         TestDelay      => tisd_TXDATA(36),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(36),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(36),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(36),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(36),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA37_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA37_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(37),
         TestSignalName => "TXDATA(37)",
         TestDelay      => tisd_TXDATA(37),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(37),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(37),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(37),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(37),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA38_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA38_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(38),
         TestSignalName => "TXDATA(38)",
         TestDelay      => tisd_TXDATA(38),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(38),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(38),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(38),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(38),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA39_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA39_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(39),
         TestSignalName => "TXDATA(39)",
         TestDelay      => tisd_TXDATA(39),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(39),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(39),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(39),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(39),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA40_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA40_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(40),
         TestSignalName => "TXDATA(40)",
         TestDelay      => tisd_TXDATA(40),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(40),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(40),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(40),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(40),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA41_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA41_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(41),
         TestSignalName => "TXDATA(41)",
         TestDelay      => tisd_TXDATA(41),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(41),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(41),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(41),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(41),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA42_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA42_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(42),
         TestSignalName => "TXDATA(42)",
         TestDelay      => tisd_TXDATA(42),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(42),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(42),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(42),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(42),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA43_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA43_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(43),
         TestSignalName => "TXDATA(43)",
         TestDelay      => tisd_TXDATA(43),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(43),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(43),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(43),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(43),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA44_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA44_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(44),
         TestSignalName => "TXDATA(44)",
         TestDelay      => tisd_TXDATA(44),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(44),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(44),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(44),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(44),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA45_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA45_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(45),
         TestSignalName => "TXDATA(45)",
         TestDelay      => tisd_TXDATA(45),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(45),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(45),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(45),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(45),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA46_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA46_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(46),
         TestSignalName => "TXDATA(46)",
         TestDelay      => tisd_TXDATA(46),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(46),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(46),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(46),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(46),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA47_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA47_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(47),
         TestSignalName => "TXDATA(47)",
         TestDelay      => tisd_TXDATA(47),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(47),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(47),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(47),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(47),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA48_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA48_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(48),
         TestSignalName => "TXDATA(48)",
         TestDelay      => tisd_TXDATA(48),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(48),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(48),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(48),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(48),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA49_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA49_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(49),
         TestSignalName => "TXDATA(49)",
         TestDelay      => tisd_TXDATA(49),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(49),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(49),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(49),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(49),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA50_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA50_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(50),
         TestSignalName => "TXDATA(50)",
         TestDelay      => tisd_TXDATA(50),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(50),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(50),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(50),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(50),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA51_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA51_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(51),
         TestSignalName => "TXDATA(51)",
         TestDelay      => tisd_TXDATA(51),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(51),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(51),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(51),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(51),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA52_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA52_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(52),
         TestSignalName => "TXDATA(52)",
         TestDelay      => tisd_TXDATA(52),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(52),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(52),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(52),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(52),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA53_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA53_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(53),
         TestSignalName => "TXDATA(53)",
         TestDelay      => tisd_TXDATA(53),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(53),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(53),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(53),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(53),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA54_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA54_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(54),
         TestSignalName => "TXDATA(54)",
         TestDelay      => tisd_TXDATA(54),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(54),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(54),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(54),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(54),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA55_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA55_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(55),
         TestSignalName => "TXDATA(55)",
         TestDelay      => tisd_TXDATA(55),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(55),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(55),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(55),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(55),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA56_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA56_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(56),
         TestSignalName => "TXDATA(56)",
         TestDelay      => tisd_TXDATA(56),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(56),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(56),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(56),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(56),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA57_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA57_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(57),
         TestSignalName => "TXDATA(57)",
         TestDelay      => tisd_TXDATA(57),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(57),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(57),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(57),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(57),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA58_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA58_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(58),
         TestSignalName => "TXDATA(58)",
         TestDelay      => tisd_TXDATA(58),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(58),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(58),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(58),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(58),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA59_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA59_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(59),
         TestSignalName => "TXDATA(59)",
         TestDelay      => tisd_TXDATA(59),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(59),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(59),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(59),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(59),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA60_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA60_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(60),
         TestSignalName => "TXDATA(60)",
         TestDelay      => tisd_TXDATA(60),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(60),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(60),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(60),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(60),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA61_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA61_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(61),
         TestSignalName => "TXDATA(61)",
         TestDelay      => tisd_TXDATA(61),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(61),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(61),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(61),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(61),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA62_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA62_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(62),
         TestSignalName => "TXDATA(62)",
         TestDelay      => tisd_TXDATA(62),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(62),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(62),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(62),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(62),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXDATA63_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXDATA63_TXUSRCLK2_posedge,
         TestSignal     => TXDATA_dly(63),
         TestSignalName => "TXDATA(63)",
         TestDelay      => tisd_TXDATA(63),
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => ticd_TXUSRCLK2,
         SetupHigh      => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(63),
         SetupLow       => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(63),
         HoldLow        => thold_TXDATA_TXUSRCLK2_posedge_posedge(63),
         HoldHigh       => thold_TXDATA_TXUSRCLK2_negedge_posedge(63),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXRESET_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXRESET_TXUSRCLK2_posedge,
         TestSignal     => TXRESET_dly,
         TestSignalName => "TXRESET",
         TestDelay      => 0 ns,
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXRESET_TXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_TXRESET_TXUSRCLK2_negedge_posedge,
         HoldLow        => thold_TXRESET_TXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_TXRESET_TXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCLKSTABLE_RXUSRCLK2_posedge,
         TimingData     => Tmkr_RXCLKSTABLE_RXUSRCLK2_posedge,
         TestSignal     => RXCLKSTABLE_dly,
         TestSignalName => "RXCLKSTABLE",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXCLKSTABLE_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_RXCLKSTABLE_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_RXCLKSTABLE_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_RXCLKSTABLE_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXPMARESET_RXUSRCLK2_posedge,
         TimingData     => Tmkr_RXPMARESET_RXUSRCLK2_posedge,
         TestSignal     => RXPMARESET_dly,
         TestSignalName => "RXPMARESET",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXPMARESET_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_RXPMARESET_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_RXPMARESET_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_RXPMARESET_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCLKSTABLE_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXCLKSTABLE_TXUSRCLK2_posedge,
         TestSignal     => TXCLKSTABLE_dly,
         TestSignalName => "TXCLKSTABLE",
         TestDelay      => 0 ns,
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXCLKSTABLE_TXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_TXCLKSTABLE_TXUSRCLK2_negedge_posedge,
         HoldLow        => thold_TXCLKSTABLE_TXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_TXCLKSTABLE_TXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXPMARESET_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXPMARESET_TXUSRCLK2_posedge,
         TestSignal     => TXPMARESET_dly,
         TestSignalName => "TXPMARESET",
         TestDelay      => 0 ns,
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXPMARESET_TXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_TXPMARESET_TXUSRCLK2_negedge_posedge,
         HoldLow        => thold_TXPMARESET_TXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_TXPMARESET_TXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN0_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN0_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(0),
         TestSignalName => "RXCRCIN(0)",
         TestDelay      => tisd_RXCRCIN(0),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(0),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(0),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(0),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN1_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN1_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(1),
         TestSignalName => "RXCRCIN(1)",
         TestDelay      => tisd_RXCRCIN(1),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(1),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(1),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(1),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN2_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN2_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(2),
         TestSignalName => "RXCRCIN(2)",
         TestDelay      => tisd_RXCRCIN(2),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(2),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(2),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(2),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN3_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN3_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(3),
         TestSignalName => "RXCRCIN(3)",
         TestDelay      => tisd_RXCRCIN(3),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(3),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(3),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(3),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN4_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN4_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(4),
         TestSignalName => "RXCRCIN(4)",
         TestDelay      => tisd_RXCRCIN(4),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(4),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(4),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(4),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN5_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN5_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(5),
         TestSignalName => "RXCRCIN(5)",
         TestDelay      => tisd_RXCRCIN(5),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(5),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(5),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(5),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN6_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN6_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(6),
         TestSignalName => "RXCRCIN(6)",
         TestDelay      => tisd_RXCRCIN(6),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(6),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(6),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(6),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN7_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN7_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(7),
         TestSignalName => "RXCRCIN(7)",
         TestDelay      => tisd_RXCRCIN(7),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(7),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(7),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(7),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN8_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN8_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(8),
         TestSignalName => "RXCRCIN(8)",
         TestDelay      => tisd_RXCRCIN(8),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(8),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(8),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(8),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN9_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN9_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(9),
         TestSignalName => "RXCRCIN(9)",
         TestDelay      => tisd_RXCRCIN(9),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(9),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(9),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(9),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN10_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN10_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(10),
         TestSignalName => "RXCRCIN(10)",
         TestDelay      => tisd_RXCRCIN(10),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(10),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(10),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(10),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN11_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN11_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(11),
         TestSignalName => "RXCRCIN(11)",
         TestDelay      => tisd_RXCRCIN(11),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(11),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(11),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(11),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN12_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN12_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(12),
         TestSignalName => "RXCRCIN(12)",
         TestDelay      => tisd_RXCRCIN(12),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(12),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(12),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(12),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN13_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN13_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(13),
         TestSignalName => "RXCRCIN(13)",
         TestDelay      => tisd_RXCRCIN(13),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(13),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(13),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(13),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN14_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN14_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(14),
         TestSignalName => "RXCRCIN(14)",
         TestDelay      => tisd_RXCRCIN(14),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(14),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(14),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(14),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN15_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN15_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(15),
         TestSignalName => "RXCRCIN(15)",
         TestDelay      => tisd_RXCRCIN(15),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(15),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(15),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(15),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN16_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN16_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(16),
         TestSignalName => "RXCRCIN(16)",
         TestDelay      => tisd_RXCRCIN(16),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(16),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(16),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(16),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN17_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN17_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(17),
         TestSignalName => "RXCRCIN(17)",
         TestDelay      => tisd_RXCRCIN(17),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(17),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(17),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(17),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN18_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN18_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(18),
         TestSignalName => "RXCRCIN(18)",
         TestDelay      => tisd_RXCRCIN(18),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(18),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(18),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(18),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN19_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN19_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(19),
         TestSignalName => "RXCRCIN(19)",
         TestDelay      => tisd_RXCRCIN(19),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(19),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(19),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(19),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN20_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN20_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(20),
         TestSignalName => "RXCRCIN(20)",
         TestDelay      => tisd_RXCRCIN(20),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(20),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(20),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(20),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN21_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN21_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(21),
         TestSignalName => "RXCRCIN(21)",
         TestDelay      => tisd_RXCRCIN(21),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(21),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(21),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(21),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN22_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN22_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(22),
         TestSignalName => "RXCRCIN(22)",
         TestDelay      => tisd_RXCRCIN(22),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(22),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(22),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(22),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN23_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN23_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(23),
         TestSignalName => "RXCRCIN(23)",
         TestDelay      => tisd_RXCRCIN(23),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(23),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(23),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(23),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN24_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN24_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(24),
         TestSignalName => "RXCRCIN(24)",
         TestDelay      => tisd_RXCRCIN(24),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(24),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(24),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(24),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN25_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN25_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(25),
         TestSignalName => "RXCRCIN(25)",
         TestDelay      => tisd_RXCRCIN(25),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(25),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(25),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(25),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN26_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN26_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(26),
         TestSignalName => "RXCRCIN(26)",
         TestDelay      => tisd_RXCRCIN(26),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(26),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(26),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(26),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN27_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN27_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(27),
         TestSignalName => "RXCRCIN(27)",
         TestDelay      => tisd_RXCRCIN(27),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(27),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(27),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(27),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN28_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN28_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(28),
         TestSignalName => "RXCRCIN(28)",
         TestDelay      => tisd_RXCRCIN(28),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(28),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(28),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(28),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN29_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN29_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(29),
         TestSignalName => "RXCRCIN(29)",
         TestDelay      => tisd_RXCRCIN(29),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(29),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(29),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(29),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN30_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN30_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(30),
         TestSignalName => "RXCRCIN(30)",
         TestDelay      => tisd_RXCRCIN(30),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(30),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(30),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(30),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN31_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN31_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(31),
         TestSignalName => "RXCRCIN(31)",
         TestDelay      => tisd_RXCRCIN(31),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(31),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(31),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(31),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN32_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN32_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(32),
         TestSignalName => "RXCRCIN(32)",
         TestDelay      => tisd_RXCRCIN(32),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(32),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(32),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(32),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(32),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN33_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN33_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(33),
         TestSignalName => "RXCRCIN(33)",
         TestDelay      => tisd_RXCRCIN(33),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(33),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(33),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(33),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(33),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN34_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN34_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(34),
         TestSignalName => "RXCRCIN(34)",
         TestDelay      => tisd_RXCRCIN(34),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(34),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(34),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(34),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(34),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN35_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN35_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(35),
         TestSignalName => "RXCRCIN(35)",
         TestDelay      => tisd_RXCRCIN(35),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(35),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(35),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(35),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(35),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN36_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN36_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(36),
         TestSignalName => "RXCRCIN(36)",
         TestDelay      => tisd_RXCRCIN(36),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(36),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(36),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(36),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(36),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN37_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN37_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(37),
         TestSignalName => "RXCRCIN(37)",
         TestDelay      => tisd_RXCRCIN(37),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(37),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(37),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(37),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(37),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN38_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN38_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(38),
         TestSignalName => "RXCRCIN(38)",
         TestDelay      => tisd_RXCRCIN(38),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(38),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(38),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(38),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(38),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN39_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN39_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(39),
         TestSignalName => "RXCRCIN(39)",
         TestDelay      => tisd_RXCRCIN(39),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(39),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(39),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(39),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(39),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN40_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN40_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(40),
         TestSignalName => "RXCRCIN(40)",
         TestDelay      => tisd_RXCRCIN(40),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(40),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(40),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(40),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(40),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN41_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN41_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(41),
         TestSignalName => "RXCRCIN(41)",
         TestDelay      => tisd_RXCRCIN(41),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(41),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(41),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(41),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(41),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN42_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN42_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(42),
         TestSignalName => "RXCRCIN(42)",
         TestDelay      => tisd_RXCRCIN(42),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(42),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(42),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(42),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(42),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN43_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN43_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(43),
         TestSignalName => "RXCRCIN(43)",
         TestDelay      => tisd_RXCRCIN(43),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(43),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(43),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(43),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(43),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN44_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN44_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(44),
         TestSignalName => "RXCRCIN(44)",
         TestDelay      => tisd_RXCRCIN(44),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(44),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(44),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(44),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(44),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN45_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN45_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(45),
         TestSignalName => "RXCRCIN(45)",
         TestDelay      => tisd_RXCRCIN(45),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(45),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(45),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(45),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(45),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN46_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN46_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(46),
         TestSignalName => "RXCRCIN(46)",
         TestDelay      => tisd_RXCRCIN(46),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(46),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(46),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(46),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(46),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN47_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN47_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(47),
         TestSignalName => "RXCRCIN(47)",
         TestDelay      => tisd_RXCRCIN(47),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(47),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(47),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(47),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(47),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN48_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN48_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(48),
         TestSignalName => "RXCRCIN(48)",
         TestDelay      => tisd_RXCRCIN(48),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(48),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(48),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(48),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(48),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN49_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN49_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(49),
         TestSignalName => "RXCRCIN(49)",
         TestDelay      => tisd_RXCRCIN(49),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(49),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(49),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(49),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(49),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN50_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN50_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(50),
         TestSignalName => "RXCRCIN(50)",
         TestDelay      => tisd_RXCRCIN(50),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(50),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(50),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(50),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(50),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN51_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN51_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(51),
         TestSignalName => "RXCRCIN(51)",
         TestDelay      => tisd_RXCRCIN(51),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(51),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(51),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(51),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(51),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN52_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN52_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(52),
         TestSignalName => "RXCRCIN(52)",
         TestDelay      => tisd_RXCRCIN(52),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(52),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(52),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(52),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(52),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN53_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN53_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(53),
         TestSignalName => "RXCRCIN(53)",
         TestDelay      => tisd_RXCRCIN(53),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(53),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(53),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(53),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(53),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN54_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN54_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(54),
         TestSignalName => "RXCRCIN(54)",
         TestDelay      => tisd_RXCRCIN(54),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(54),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(54),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(54),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(54),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN55_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN55_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(55),
         TestSignalName => "RXCRCIN(55)",
         TestDelay      => tisd_RXCRCIN(55),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(55),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(55),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(55),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(55),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN56_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN56_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(56),
         TestSignalName => "RXCRCIN(56)",
         TestDelay      => tisd_RXCRCIN(56),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(56),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(56),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(56),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(56),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN57_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN57_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(57),
         TestSignalName => "RXCRCIN(57)",
         TestDelay      => tisd_RXCRCIN(57),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(57),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(57),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(57),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(57),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN58_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN58_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(58),
         TestSignalName => "RXCRCIN(58)",
         TestDelay      => tisd_RXCRCIN(58),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(58),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(58),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(58),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(58),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN59_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN59_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(59),
         TestSignalName => "RXCRCIN(59)",
         TestDelay      => tisd_RXCRCIN(59),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(59),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(59),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(59),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(59),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN60_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN60_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(60),
         TestSignalName => "RXCRCIN(60)",
         TestDelay      => tisd_RXCRCIN(60),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(60),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(60),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(60),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(60),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN61_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN61_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(61),
         TestSignalName => "RXCRCIN(61)",
         TestDelay      => tisd_RXCRCIN(61),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(61),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(61),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(61),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(61),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN62_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN62_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(62),
         TestSignalName => "RXCRCIN(62)",
         TestDelay      => tisd_RXCRCIN(62),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(62),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(62),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(62),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(62),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCIN63_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCIN63_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCIN_dly(63),
         TestSignalName => "RXCRCIN(63)",
         TestDelay      => tisd_RXCRCIN(63),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCIN_RXCRCINTCLK_posedge_posedge(63),
         SetupLow       => tsetup_RXCRCIN_RXCRCINTCLK_negedge_posedge(63),
         HoldLow        => thold_RXCRCIN_RXCRCINTCLK_posedge_posedge(63),
         HoldHigh       => thold_RXCRCIN_RXCRCINTCLK_negedge_posedge(63),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCDATAWIDTH0_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCDATAWIDTH0_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCDATAWIDTH_dly(0),
         TestSignalName => "RXCRCDATAWIDTH(0)",
         TestDelay      => tisd_RXCRCDATAWIDTH(0),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge(0),
         SetupLow       => tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge(0),
         HoldLow        => thold_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge(0),
         HoldHigh       => thold_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCDATAWIDTH1_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCDATAWIDTH1_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCDATAWIDTH_dly(1),
         TestSignalName => "RXCRCDATAWIDTH(1)",
         TestDelay      => tisd_RXCRCDATAWIDTH(1),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge(1),
         SetupLow       => tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge(1),
         HoldLow        => thold_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge(1),
         HoldHigh       => thold_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCDATAWIDTH2_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCDATAWIDTH2_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCDATAWIDTH_dly(2),
         TestSignalName => "RXCRCDATAWIDTH(2)",
         TestDelay      => tisd_RXCRCDATAWIDTH(2),
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => ticd_RXCRCINTCLK,
         SetupHigh      => tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge(2),
         SetupLow       => tsetup_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge(2),
         HoldLow        => thold_RXCRCDATAWIDTH_RXCRCINTCLK_posedge_posedge(2),
         HoldHigh       => thold_RXCRCDATAWIDTH_RXCRCINTCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCDATAVALID_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCDATAVALID_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCDATAVALID_dly,
         TestSignalName => "RXCRCDATAVALID",
         TestDelay      => 0 ns,
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXCRCDATAVALID_RXCRCINTCLK_posedge_posedge,
         SetupLow       => tsetup_RXCRCDATAVALID_RXCRCINTCLK_negedge_posedge,
         HoldLow        => thold_RXCRCDATAVALID_RXCRCINTCLK_posedge_posedge,
         HoldHigh       => thold_RXCRCDATAVALID_RXCRCINTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCINIT_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCINIT_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCINIT_dly,
         TestSignalName => "RXCRCINIT",
         TestDelay      => 0 ns,
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXCRCINIT_RXCRCINTCLK_posedge_posedge,
         SetupLow       => tsetup_RXCRCINIT_RXCRCINTCLK_negedge_posedge,
         HoldLow        => thold_RXCRCINIT_RXCRCINTCLK_posedge_posedge,
         HoldHigh       => thold_RXCRCINIT_RXCRCINTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXCRCRESET_RXCRCINTCLK_posedge,
         TimingData     => Tmkr_RXCRCRESET_RXCRCINTCLK_posedge,
         TestSignal     => RXCRCRESET_dly,
         TestSignalName => "RXCRCRESET",
         TestDelay      => 0 ns,
         RefSignal      => RXCRCINTCLK_dly,
         RefSignalName  => "RXCRCINTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXCRCRESET_RXCRCINTCLK_posedge_posedge,
         SetupLow       => tsetup_RXCRCRESET_RXCRCINTCLK_negedge_posedge,
         HoldLow        => thold_RXCRCRESET_RXCRCINTCLK_posedge_posedge,
         HoldHigh       => thold_RXCRCRESET_RXCRCINTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN0_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN0_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(0),
         TestSignalName => "TXCRCIN(0)",
         TestDelay      => tisd_TXCRCIN(0),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(0),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(0),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(0),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN1_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN1_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(1),
         TestSignalName => "TXCRCIN(1)",
         TestDelay      => tisd_TXCRCIN(1),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(1),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(1),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(1),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN2_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN2_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(2),
         TestSignalName => "TXCRCIN(2)",
         TestDelay      => tisd_TXCRCIN(2),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(2),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(2),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(2),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN3_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN3_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(3),
         TestSignalName => "TXCRCIN(3)",
         TestDelay      => tisd_TXCRCIN(3),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(3),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(3),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(3),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN4_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN4_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(4),
         TestSignalName => "TXCRCIN(4)",
         TestDelay      => tisd_TXCRCIN(4),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(4),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(4),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(4),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN5_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN5_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(5),
         TestSignalName => "TXCRCIN(5)",
         TestDelay      => tisd_TXCRCIN(5),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(5),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(5),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(5),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN6_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN6_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(6),
         TestSignalName => "TXCRCIN(6)",
         TestDelay      => tisd_TXCRCIN(6),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(6),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(6),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(6),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN7_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN7_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(7),
         TestSignalName => "TXCRCIN(7)",
         TestDelay      => tisd_TXCRCIN(7),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(7),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(7),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(7),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN8_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN8_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(8),
         TestSignalName => "TXCRCIN(8)",
         TestDelay      => tisd_TXCRCIN(8),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(8),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(8),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(8),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN9_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN9_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(9),
         TestSignalName => "TXCRCIN(9)",
         TestDelay      => tisd_TXCRCIN(9),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(9),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(9),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(9),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN10_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN10_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(10),
         TestSignalName => "TXCRCIN(10)",
         TestDelay      => tisd_TXCRCIN(10),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(10),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(10),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(10),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN11_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN11_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(11),
         TestSignalName => "TXCRCIN(11)",
         TestDelay      => tisd_TXCRCIN(11),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(11),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(11),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(11),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN12_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN12_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(12),
         TestSignalName => "TXCRCIN(12)",
         TestDelay      => tisd_TXCRCIN(12),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(12),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(12),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(12),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN13_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN13_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(13),
         TestSignalName => "TXCRCIN(13)",
         TestDelay      => tisd_TXCRCIN(13),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(13),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(13),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(13),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN14_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN14_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(14),
         TestSignalName => "TXCRCIN(14)",
         TestDelay      => tisd_TXCRCIN(14),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(14),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(14),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(14),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN15_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN15_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(15),
         TestSignalName => "TXCRCIN(15)",
         TestDelay      => tisd_TXCRCIN(15),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(15),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(15),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(15),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN16_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN16_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(16),
         TestSignalName => "TXCRCIN(16)",
         TestDelay      => tisd_TXCRCIN(16),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(16),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(16),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(16),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN17_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN17_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(17),
         TestSignalName => "TXCRCIN(17)",
         TestDelay      => tisd_TXCRCIN(17),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(17),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(17),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(17),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN18_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN18_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(18),
         TestSignalName => "TXCRCIN(18)",
         TestDelay      => tisd_TXCRCIN(18),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(18),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(18),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(18),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN19_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN19_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(19),
         TestSignalName => "TXCRCIN(19)",
         TestDelay      => tisd_TXCRCIN(19),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(19),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(19),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(19),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN20_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN20_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(20),
         TestSignalName => "TXCRCIN(20)",
         TestDelay      => tisd_TXCRCIN(20),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(20),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(20),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(20),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN21_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN21_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(21),
         TestSignalName => "TXCRCIN(21)",
         TestDelay      => tisd_TXCRCIN(21),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(21),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(21),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(21),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN22_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN22_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(22),
         TestSignalName => "TXCRCIN(22)",
         TestDelay      => tisd_TXCRCIN(22),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(22),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(22),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(22),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN23_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN23_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(23),
         TestSignalName => "TXCRCIN(23)",
         TestDelay      => tisd_TXCRCIN(23),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(23),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(23),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(23),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN24_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN24_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(24),
         TestSignalName => "TXCRCIN(24)",
         TestDelay      => tisd_TXCRCIN(24),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(24),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(24),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(24),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN25_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN25_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(25),
         TestSignalName => "TXCRCIN(25)",
         TestDelay      => tisd_TXCRCIN(25),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(25),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(25),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(25),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN26_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN26_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(26),
         TestSignalName => "TXCRCIN(26)",
         TestDelay      => tisd_TXCRCIN(26),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(26),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(26),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(26),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN27_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN27_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(27),
         TestSignalName => "TXCRCIN(27)",
         TestDelay      => tisd_TXCRCIN(27),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(27),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(27),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(27),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN28_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN28_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(28),
         TestSignalName => "TXCRCIN(28)",
         TestDelay      => tisd_TXCRCIN(28),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(28),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(28),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(28),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN29_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN29_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(29),
         TestSignalName => "TXCRCIN(29)",
         TestDelay      => tisd_TXCRCIN(29),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(29),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(29),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(29),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN30_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN30_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(30),
         TestSignalName => "TXCRCIN(30)",
         TestDelay      => tisd_TXCRCIN(30),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(30),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(30),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(30),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN31_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN31_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(31),
         TestSignalName => "TXCRCIN(31)",
         TestDelay      => tisd_TXCRCIN(31),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(31),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(31),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(31),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN32_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN32_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(32),
         TestSignalName => "TXCRCIN(32)",
         TestDelay      => tisd_TXCRCIN(32),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(32),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(32),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(32),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(32),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN33_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN33_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(33),
         TestSignalName => "TXCRCIN(33)",
         TestDelay      => tisd_TXCRCIN(33),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(33),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(33),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(33),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(33),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN34_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN34_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(34),
         TestSignalName => "TXCRCIN(34)",
         TestDelay      => tisd_TXCRCIN(34),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(34),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(34),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(34),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(34),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN35_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN35_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(35),
         TestSignalName => "TXCRCIN(35)",
         TestDelay      => tisd_TXCRCIN(35),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(35),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(35),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(35),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(35),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN36_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN36_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(36),
         TestSignalName => "TXCRCIN(36)",
         TestDelay      => tisd_TXCRCIN(36),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(36),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(36),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(36),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(36),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN37_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN37_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(37),
         TestSignalName => "TXCRCIN(37)",
         TestDelay      => tisd_TXCRCIN(37),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(37),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(37),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(37),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(37),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN38_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN38_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(38),
         TestSignalName => "TXCRCIN(38)",
         TestDelay      => tisd_TXCRCIN(38),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(38),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(38),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(38),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(38),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN39_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN39_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(39),
         TestSignalName => "TXCRCIN(39)",
         TestDelay      => tisd_TXCRCIN(39),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(39),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(39),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(39),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(39),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN40_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN40_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(40),
         TestSignalName => "TXCRCIN(40)",
         TestDelay      => tisd_TXCRCIN(40),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(40),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(40),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(40),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(40),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN41_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN41_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(41),
         TestSignalName => "TXCRCIN(41)",
         TestDelay      => tisd_TXCRCIN(41),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(41),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(41),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(41),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(41),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN42_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN42_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(42),
         TestSignalName => "TXCRCIN(42)",
         TestDelay      => tisd_TXCRCIN(42),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(42),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(42),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(42),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(42),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN43_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN43_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(43),
         TestSignalName => "TXCRCIN(43)",
         TestDelay      => tisd_TXCRCIN(43),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(43),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(43),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(43),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(43),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN44_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN44_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(44),
         TestSignalName => "TXCRCIN(44)",
         TestDelay      => tisd_TXCRCIN(44),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(44),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(44),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(44),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(44),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN45_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN45_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(45),
         TestSignalName => "TXCRCIN(45)",
         TestDelay      => tisd_TXCRCIN(45),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(45),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(45),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(45),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(45),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN46_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN46_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(46),
         TestSignalName => "TXCRCIN(46)",
         TestDelay      => tisd_TXCRCIN(46),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(46),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(46),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(46),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(46),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN47_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN47_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(47),
         TestSignalName => "TXCRCIN(47)",
         TestDelay      => tisd_TXCRCIN(47),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(47),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(47),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(47),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(47),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN48_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN48_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(48),
         TestSignalName => "TXCRCIN(48)",
         TestDelay      => tisd_TXCRCIN(48),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(48),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(48),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(48),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(48),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN49_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN49_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(49),
         TestSignalName => "TXCRCIN(49)",
         TestDelay      => tisd_TXCRCIN(49),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(49),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(49),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(49),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(49),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN50_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN50_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(50),
         TestSignalName => "TXCRCIN(50)",
         TestDelay      => tisd_TXCRCIN(50),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(50),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(50),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(50),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(50),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN51_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN51_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(51),
         TestSignalName => "TXCRCIN(51)",
         TestDelay      => tisd_TXCRCIN(51),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(51),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(51),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(51),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(51),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN52_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN52_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(52),
         TestSignalName => "TXCRCIN(52)",
         TestDelay      => tisd_TXCRCIN(52),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(52),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(52),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(52),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(52),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN53_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN53_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(53),
         TestSignalName => "TXCRCIN(53)",
         TestDelay      => tisd_TXCRCIN(53),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(53),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(53),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(53),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(53),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN54_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN54_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(54),
         TestSignalName => "TXCRCIN(54)",
         TestDelay      => tisd_TXCRCIN(54),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(54),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(54),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(54),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(54),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN55_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN55_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(55),
         TestSignalName => "TXCRCIN(55)",
         TestDelay      => tisd_TXCRCIN(55),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(55),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(55),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(55),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(55),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN56_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN56_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(56),
         TestSignalName => "TXCRCIN(56)",
         TestDelay      => tisd_TXCRCIN(56),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(56),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(56),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(56),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(56),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN57_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN57_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(57),
         TestSignalName => "TXCRCIN(57)",
         TestDelay      => tisd_TXCRCIN(57),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(57),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(57),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(57),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(57),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN58_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN58_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(58),
         TestSignalName => "TXCRCIN(58)",
         TestDelay      => tisd_TXCRCIN(58),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(58),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(58),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(58),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(58),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN59_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN59_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(59),
         TestSignalName => "TXCRCIN(59)",
         TestDelay      => tisd_TXCRCIN(59),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(59),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(59),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(59),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(59),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN60_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN60_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(60),
         TestSignalName => "TXCRCIN(60)",
         TestDelay      => tisd_TXCRCIN(60),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(60),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(60),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(60),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(60),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN61_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN61_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(61),
         TestSignalName => "TXCRCIN(61)",
         TestDelay      => tisd_TXCRCIN(61),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(61),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(61),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(61),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(61),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN62_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN62_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(62),
         TestSignalName => "TXCRCIN(62)",
         TestDelay      => tisd_TXCRCIN(62),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(62),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(62),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(62),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(62),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCIN63_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCIN63_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCIN_dly(63),
         TestSignalName => "TXCRCIN(63)",
         TestDelay      => tisd_TXCRCIN(63),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCIN_TXCRCINTCLK_posedge_posedge(63),
         SetupLow       => tsetup_TXCRCIN_TXCRCINTCLK_negedge_posedge(63),
         HoldLow        => thold_TXCRCIN_TXCRCINTCLK_posedge_posedge(63),
         HoldHigh       => thold_TXCRCIN_TXCRCINTCLK_negedge_posedge(63),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCDATAWIDTH0_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCDATAWIDTH0_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCDATAWIDTH_dly(0),
         TestSignalName => "TXCRCDATAWIDTH(0)",
         TestDelay      => tisd_TXCRCDATAWIDTH(0),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge(0),
         SetupLow       => tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge(0),
         HoldLow        => thold_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge(0),
         HoldHigh       => thold_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCDATAWIDTH1_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCDATAWIDTH1_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCDATAWIDTH_dly(1),
         TestSignalName => "TXCRCDATAWIDTH(1)",
         TestDelay      => tisd_TXCRCDATAWIDTH(1),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge(1),
         SetupLow       => tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge(1),
         HoldLow        => thold_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge(1),
         HoldHigh       => thold_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCDATAWIDTH2_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCDATAWIDTH2_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCDATAWIDTH_dly(2),
         TestSignalName => "TXCRCDATAWIDTH(2)",
         TestDelay      => tisd_TXCRCDATAWIDTH(2),
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => ticd_TXCRCINTCLK,
         SetupHigh      => tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge(2),
         SetupLow       => tsetup_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge(2),
         HoldLow        => thold_TXCRCDATAWIDTH_TXCRCINTCLK_posedge_posedge(2),
         HoldHigh       => thold_TXCRCDATAWIDTH_TXCRCINTCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCDATAVALID_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCDATAVALID_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCDATAVALID_dly,
         TestSignalName => "TXCRCDATAVALID",
         TestDelay      => 0 ns,
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXCRCDATAVALID_TXCRCINTCLK_posedge_posedge,
         SetupLow       => tsetup_TXCRCDATAVALID_TXCRCINTCLK_negedge_posedge,
         HoldLow        => thold_TXCRCDATAVALID_TXCRCINTCLK_posedge_posedge,
         HoldHigh       => thold_TXCRCDATAVALID_TXCRCINTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCINIT_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCINIT_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCINIT_dly,
         TestSignalName => "TXCRCINIT",
         TestDelay      => 0 ns,
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXCRCINIT_TXCRCINTCLK_posedge_posedge,
         SetupLow       => tsetup_TXCRCINIT_TXCRCINTCLK_negedge_posedge,
         HoldLow        => thold_TXCRCINIT_TXCRCINTCLK_posedge_posedge,
         HoldHigh       => thold_TXCRCINIT_TXCRCINTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXCRCRESET_TXCRCINTCLK_posedge,
         TimingData     => Tmkr_TXCRCRESET_TXCRCINTCLK_posedge,
         TestSignal     => TXCRCRESET_dly,
         TestSignalName => "TXCRCRESET",
         TestDelay      => 0 ns,
         RefSignal      => TXCRCINTCLK_dly,
         RefSignalName  => "TXCRCINTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXCRCRESET_TXCRCINTCLK_posedge_posedge,
         SetupLow       => tsetup_TXCRCRESET_TXCRCINTCLK_negedge_posedge,
         HoldLow        => thold_TXCRCRESET_TXCRCINTCLK_posedge_posedge,
         HoldHigh       => thold_TXCRCRESET_TXCRCINTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXSYNC_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXSYNC_TXUSRCLK2_posedge,
         TestSignal     => TXSYNC_dly,
         TestSignalName => "TXSYNC",
         TestDelay      => 0 ns,
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXSYNC_TXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_TXSYNC_TXUSRCLK2_negedge_posedge,
         HoldLow        => thold_TXSYNC_TXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_TXSYNC_TXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_RXSYNC_RXUSRCLK2_posedge,
         TimingData     => Tmkr_RXSYNC_RXUSRCLK2_posedge,
         TestSignal     => RXSYNC_dly,
         TestSignalName => "RXSYNC",
         TestDelay      => 0 ns,
         RefSignal      => RXUSRCLK2_dly,
         RefSignalName  => "RXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_RXSYNC_RXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_RXSYNC_RXUSRCLK2_negedge_posedge,
         HoldLow        => thold_RXSYNC_RXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_RXSYNC_RXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TXENOOB_TXUSRCLK2_posedge,
         TimingData     => Tmkr_TXENOOB_TXUSRCLK2_posedge,
         TestSignal     => TXENOOB_dly,
         TestSignalName => "TXENOOB",
         TestDelay      => 0 ns,
         RefSignal      => TXUSRCLK2_dly,
         RefSignalName  => "TXUSRCLK2",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_TXENOOB_TXUSRCLK2_posedge_posedge,
         SetupLow       => tsetup_TXENOOB_TXUSRCLK2_negedge_posedge,
         HoldLow        => thold_TXENOOB_TXUSRCLK2_posedge_posedge,
         HoldHigh       => thold_TXENOOB_TXUSRCLK2_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR0_DCLK_posedge,
         TimingData     => Tmkr_DADDR0_DCLK_posedge,
         TestSignal     => DADDR_dly(0),
         TestSignalName => "DADDR(0)",
         TestDelay      => tisd_DADDR(0),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(0),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(0),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(0),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR1_DCLK_posedge,
         TimingData     => Tmkr_DADDR1_DCLK_posedge,
         TestSignal     => DADDR_dly(1),
         TestSignalName => "DADDR(1)",
         TestDelay      => tisd_DADDR(1),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(1),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(1),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(1),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR2_DCLK_posedge,
         TimingData     => Tmkr_DADDR2_DCLK_posedge,
         TestSignal     => DADDR_dly(2),
         TestSignalName => "DADDR(2)",
         TestDelay      => tisd_DADDR(2),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(2),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(2),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(2),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR3_DCLK_posedge,
         TimingData     => Tmkr_DADDR3_DCLK_posedge,
         TestSignal     => DADDR_dly(3),
         TestSignalName => "DADDR(3)",
         TestDelay      => tisd_DADDR(3),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(3),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(3),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(3),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR4_DCLK_posedge,
         TimingData     => Tmkr_DADDR4_DCLK_posedge,
         TestSignal     => DADDR_dly(4),
         TestSignalName => "DADDR(4)",
         TestDelay      => tisd_DADDR(4),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(4),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(4),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(4),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR5_DCLK_posedge,
         TimingData     => Tmkr_DADDR5_DCLK_posedge,
         TestSignal     => DADDR_dly(5),
         TestSignalName => "DADDR(5)",
         TestDelay      => tisd_DADDR(5),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(5),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(5),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(5),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR6_DCLK_posedge,
         TimingData     => Tmkr_DADDR6_DCLK_posedge,
         TestSignal     => DADDR_dly(6),
         TestSignalName => "DADDR(6)",
         TestDelay      => tisd_DADDR(6),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(6),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(6),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(6),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DADDR7_DCLK_posedge,
         TimingData     => Tmkr_DADDR7_DCLK_posedge,
         TestSignal     => DADDR_dly(7),
         TestSignalName => "DADDR(7)",
         TestDelay      => tisd_DADDR(7),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DADDR_DCLK_posedge_posedge(7),
         SetupLow       => tsetup_DADDR_DCLK_negedge_posedge(7),
         HoldLow        => thold_DADDR_DCLK_posedge_posedge(7),
         HoldHigh       => thold_DADDR_DCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DEN_DCLK_posedge,
         TimingData     => Tmkr_DEN_DCLK_posedge,
         TestSignal     => DEN_dly,
         TestSignalName => "DEN",
         TestDelay      => 0 ns,
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DEN_DCLK_posedge_posedge,
         SetupLow       => tsetup_DEN_DCLK_negedge_posedge,
         HoldLow        => thold_DEN_DCLK_posedge_posedge,
         HoldHigh       => thold_DEN_DCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DWE_DCLK_posedge,
         TimingData     => Tmkr_DWE_DCLK_posedge,
         TestSignal     => DWE_dly,
         TestSignalName => "DWE",
         TestDelay      => 0 ns,
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_DWE_DCLK_posedge_posedge,
         SetupLow       => tsetup_DWE_DCLK_negedge_posedge,
         HoldLow        => thold_DWE_DCLK_posedge_posedge,
         HoldHigh       => thold_DWE_DCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI0_DCLK_posedge,
         TimingData     => Tmkr_DI0_DCLK_posedge,
         TestSignal     => DI_dly(0),
         TestSignalName => "DI(0)",
         TestDelay      => tisd_DI(0),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(0),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(0),
         HoldLow        => thold_DI_DCLK_posedge_posedge(0),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI1_DCLK_posedge,
         TimingData     => Tmkr_DI1_DCLK_posedge,
         TestSignal     => DI_dly(1),
         TestSignalName => "DI(1)",
         TestDelay      => tisd_DI(1),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(1),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(1),
         HoldLow        => thold_DI_DCLK_posedge_posedge(1),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI2_DCLK_posedge,
         TimingData     => Tmkr_DI2_DCLK_posedge,
         TestSignal     => DI_dly(2),
         TestSignalName => "DI(2)",
         TestDelay      => tisd_DI(2),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(2),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(2),
         HoldLow        => thold_DI_DCLK_posedge_posedge(2),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI3_DCLK_posedge,
         TimingData     => Tmkr_DI3_DCLK_posedge,
         TestSignal     => DI_dly(3),
         TestSignalName => "DI(3)",
         TestDelay      => tisd_DI(3),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(3),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(3),
         HoldLow        => thold_DI_DCLK_posedge_posedge(3),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI4_DCLK_posedge,
         TimingData     => Tmkr_DI4_DCLK_posedge,
         TestSignal     => DI_dly(4),
         TestSignalName => "DI(4)",
         TestDelay      => tisd_DI(4),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(4),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(4),
         HoldLow        => thold_DI_DCLK_posedge_posedge(4),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI5_DCLK_posedge,
         TimingData     => Tmkr_DI5_DCLK_posedge,
         TestSignal     => DI_dly(5),
         TestSignalName => "DI(5)",
         TestDelay      => tisd_DI(5),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(5),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(5),
         HoldLow        => thold_DI_DCLK_posedge_posedge(5),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI6_DCLK_posedge,
         TimingData     => Tmkr_DI6_DCLK_posedge,
         TestSignal     => DI_dly(6),
         TestSignalName => "DI(6)",
         TestDelay      => tisd_DI(6),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(6),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(6),
         HoldLow        => thold_DI_DCLK_posedge_posedge(6),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI7_DCLK_posedge,
         TimingData     => Tmkr_DI7_DCLK_posedge,
         TestSignal     => DI_dly(7),
         TestSignalName => "DI(7)",
         TestDelay      => tisd_DI(7),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(7),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(7),
         HoldLow        => thold_DI_DCLK_posedge_posedge(7),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI8_DCLK_posedge,
         TimingData     => Tmkr_DI8_DCLK_posedge,
         TestSignal     => DI_dly(8),
         TestSignalName => "DI(8)",
         TestDelay      => tisd_DI(8),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(8),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(8),
         HoldLow        => thold_DI_DCLK_posedge_posedge(8),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI9_DCLK_posedge,
         TimingData     => Tmkr_DI9_DCLK_posedge,
         TestSignal     => DI_dly(9),
         TestSignalName => "DI(9)",
         TestDelay      => tisd_DI(9),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(9),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(9),
         HoldLow        => thold_DI_DCLK_posedge_posedge(9),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI10_DCLK_posedge,
         TimingData     => Tmkr_DI10_DCLK_posedge,
         TestSignal     => DI_dly(10),
         TestSignalName => "DI(10)",
         TestDelay      => tisd_DI(10),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(10),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(10),
         HoldLow        => thold_DI_DCLK_posedge_posedge(10),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI11_DCLK_posedge,
         TimingData     => Tmkr_DI11_DCLK_posedge,
         TestSignal     => DI_dly(11),
         TestSignalName => "DI(11)",
         TestDelay      => tisd_DI(11),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(11),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(11),
         HoldLow        => thold_DI_DCLK_posedge_posedge(11),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI12_DCLK_posedge,
         TimingData     => Tmkr_DI12_DCLK_posedge,
         TestSignal     => DI_dly(12),
         TestSignalName => "DI(12)",
         TestDelay      => tisd_DI(12),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(12),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(12),
         HoldLow        => thold_DI_DCLK_posedge_posedge(12),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI13_DCLK_posedge,
         TimingData     => Tmkr_DI13_DCLK_posedge,
         TestSignal     => DI_dly(13),
         TestSignalName => "DI(13)",
         TestDelay      => tisd_DI(13),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(13),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(13),
         HoldLow        => thold_DI_DCLK_posedge_posedge(13),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI14_DCLK_posedge,
         TimingData     => Tmkr_DI14_DCLK_posedge,
         TestSignal     => DI_dly(14),
         TestSignalName => "DI(14)",
         TestDelay      => tisd_DI(14),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(14),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(14),
         HoldLow        => thold_DI_DCLK_posedge_posedge(14),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_DI15_DCLK_posedge,
         TimingData     => Tmkr_DI15_DCLK_posedge,
         TestSignal     => DI_dly(15),
         TestSignalName => "DI(15)",
         TestDelay      => tisd_DI(15),
         RefSignal      => DCLK_dly,
         RefSignalName  => "DCLK",
         RefDelay       => ticd_DCLK,
         SetupHigh      => tsetup_DI_DCLK_posedge_posedge(15),
         SetupLow       => tsetup_DI_DCLK_negedge_posedge(15),
         HoldLow        => thold_DI_DCLK_posedge_posedge(15),
         HoldHigh       => thold_DI_DCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_GT11",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     end if;
-- End of (TimingChecksOn)

--  Output-to-Clock path delay
     VitalPathDelay01
       (
         OutSignal     => CHBONDO(0),
         GlitchData    => CHBONDO0_GlitchData,
         OutSignalName => "CHBONDO(0)",
         OutTemp       => CHBONDO_OUT(0),
         Paths         => (0 => (RXUSRCLK_dly'last_event, tpd_RXUSRCLK_CHBONDO(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => CHBONDO(1),
         GlitchData    => CHBONDO1_GlitchData,
         OutSignalName => "CHBONDO(1)",
         OutTemp       => CHBONDO_OUT(1),
         Paths         => (0 => (RXUSRCLK_dly'last_event, tpd_RXUSRCLK_CHBONDO(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => CHBONDO(2),
         GlitchData    => CHBONDO2_GlitchData,
         OutSignalName => "CHBONDO(2)",
         OutTemp       => CHBONDO_OUT(2),
         Paths         => (0 => (RXUSRCLK_dly'last_event, tpd_RXUSRCLK_CHBONDO(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => CHBONDO(3),
         GlitchData    => CHBONDO3_GlitchData,
         OutSignalName => "CHBONDO(3)",
         OutTemp       => CHBONDO_OUT(3),
         Paths         => (0 => (RXUSRCLK_dly'last_event, tpd_RXUSRCLK_CHBONDO(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => CHBONDO(4),
         GlitchData    => CHBONDO4_GlitchData,
         OutSignalName => "CHBONDO(4)",
         OutTemp       => CHBONDO_OUT(4),
         Paths         => (0 => (RXUSRCLK_dly'last_event, tpd_RXUSRCLK_CHBONDO(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXSTATUS(0),
         GlitchData    => RXSTATUS0_GlitchData,
         OutSignalName => "RXSTATUS(0)",
         OutTemp       => RXSTATUS_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXSTATUS(1),
         GlitchData    => RXSTATUS1_GlitchData,
         OutSignalName => "RXSTATUS(1)",
         OutTemp       => RXSTATUS_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXSTATUS(2),
         GlitchData    => RXSTATUS2_GlitchData,
         OutSignalName => "RXSTATUS(2)",
         OutTemp       => RXSTATUS_OUT(2),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXSTATUS(3),
         GlitchData    => RXSTATUS3_GlitchData,
         OutSignalName => "RXSTATUS(3)",
         OutTemp       => RXSTATUS_OUT(3),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXSTATUS(4),
         GlitchData    => RXSTATUS4_GlitchData,
         OutSignalName => "RXSTATUS(4)",
         OutTemp       => RXSTATUS_OUT(4),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXSTATUS(5),
         GlitchData    => RXSTATUS5_GlitchData,
         OutSignalName => "RXSTATUS(5)",
         OutTemp       => RXSTATUS_OUT(5),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(0),
         GlitchData    => RXCHARISCOMMA0_GlitchData,
         OutSignalName => "RXCHARISCOMMA(0)",
         OutTemp       => RXCHARISCOMMA_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(1),
         GlitchData    => RXCHARISCOMMA1_GlitchData,
         OutSignalName => "RXCHARISCOMMA(1)",
         OutTemp       => RXCHARISCOMMA_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(2),
         GlitchData    => RXCHARISCOMMA2_GlitchData,
         OutSignalName => "RXCHARISCOMMA(2)",
         OutTemp       => RXCHARISCOMMA_OUT(2),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(3),
         GlitchData    => RXCHARISCOMMA3_GlitchData,
         OutSignalName => "RXCHARISCOMMA(3)",
         OutTemp       => RXCHARISCOMMA_OUT(3),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(4),
         GlitchData    => RXCHARISCOMMA4_GlitchData,
         OutSignalName => "RXCHARISCOMMA(4)",
         OutTemp       => RXCHARISCOMMA_OUT(4),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(5),
         GlitchData    => RXCHARISCOMMA5_GlitchData,
         OutSignalName => "RXCHARISCOMMA(5)",
         OutTemp       => RXCHARISCOMMA_OUT(5),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(6),
         GlitchData    => RXCHARISCOMMA6_GlitchData,
         OutSignalName => "RXCHARISCOMMA(6)",
         OutTemp       => RXCHARISCOMMA_OUT(6),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISCOMMA(7),
         GlitchData    => RXCHARISCOMMA7_GlitchData,
         OutSignalName => "RXCHARISCOMMA(7)",
         OutTemp       => RXCHARISCOMMA_OUT(7),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(0),
         GlitchData    => RXCHARISK0_GlitchData,
         OutSignalName => "RXCHARISK(0)",
         OutTemp       => RXCHARISK_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(1),
         GlitchData    => RXCHARISK1_GlitchData,
         OutSignalName => "RXCHARISK(1)",
         OutTemp       => RXCHARISK_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(2),
         GlitchData    => RXCHARISK2_GlitchData,
         OutSignalName => "RXCHARISK(2)",
         OutTemp       => RXCHARISK_OUT(2),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(3),
         GlitchData    => RXCHARISK3_GlitchData,
         OutSignalName => "RXCHARISK(3)",
         OutTemp       => RXCHARISK_OUT(3),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(4),
         GlitchData    => RXCHARISK4_GlitchData,
         OutSignalName => "RXCHARISK(4)",
         OutTemp       => RXCHARISK_OUT(4),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(5),
         GlitchData    => RXCHARISK5_GlitchData,
         OutSignalName => "RXCHARISK(5)",
         OutTemp       => RXCHARISK_OUT(5),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(6),
         GlitchData    => RXCHARISK6_GlitchData,
         OutSignalName => "RXCHARISK(6)",
         OutTemp       => RXCHARISK_OUT(6),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCHARISK(7),
         GlitchData    => RXCHARISK7_GlitchData,
         OutSignalName => "RXCHARISK(7)",
         OutTemp       => RXCHARISK_OUT(7),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCOMMADET,
         GlitchData    => RXCOMMADET_GlitchData,
         OutSignalName => "RXCOMMADET",
         OutTemp       => RXCOMMADET_OUT,
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCOMMADET,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );     
     VitalPathDelay01
       (
         OutSignal     => RXDATA(0),
         GlitchData    => RXDATA0_GlitchData,
         OutSignalName => "RXDATA(0)",
         OutTemp       => RXDATA_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(1),
         GlitchData    => RXDATA1_GlitchData,
         OutSignalName => "RXDATA(1)",
         OutTemp       => RXDATA_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(2),
         GlitchData    => RXDATA2_GlitchData,
         OutSignalName => "RXDATA(2)",
         OutTemp       => RXDATA_OUT(2),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(3),
         GlitchData    => RXDATA3_GlitchData,
         OutSignalName => "RXDATA(3)",
         OutTemp       => RXDATA_OUT(3),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(4),
         GlitchData    => RXDATA4_GlitchData,
         OutSignalName => "RXDATA(4)",
         OutTemp       => RXDATA_OUT(4),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(5),
         GlitchData    => RXDATA5_GlitchData,
         OutSignalName => "RXDATA(5)",
         OutTemp       => RXDATA_OUT(5),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(6),
         GlitchData    => RXDATA6_GlitchData,
         OutSignalName => "RXDATA(6)",
         OutTemp       => RXDATA_OUT(6),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(7),
         GlitchData    => RXDATA7_GlitchData,
         OutSignalName => "RXDATA(7)",
         OutTemp       => RXDATA_OUT(7),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(8),
         GlitchData    => RXDATA8_GlitchData,
         OutSignalName => "RXDATA(8)",
         OutTemp       => RXDATA_OUT(8),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(8),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(9),
         GlitchData    => RXDATA9_GlitchData,
         OutSignalName => "RXDATA(9)",
         OutTemp       => RXDATA_OUT(9),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(9),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(10),
         GlitchData    => RXDATA10_GlitchData,
         OutSignalName => "RXDATA(10)",
         OutTemp       => RXDATA_OUT(10),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(10),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(11),
         GlitchData    => RXDATA11_GlitchData,
         OutSignalName => "RXDATA(11)",
         OutTemp       => RXDATA_OUT(11),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(11),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(12),
         GlitchData    => RXDATA12_GlitchData,
         OutSignalName => "RXDATA(12)",
         OutTemp       => RXDATA_OUT(12),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(12),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(13),
         GlitchData    => RXDATA13_GlitchData,
         OutSignalName => "RXDATA(13)",
         OutTemp       => RXDATA_OUT(13),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(13),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(14),
         GlitchData    => RXDATA14_GlitchData,
         OutSignalName => "RXDATA(14)",
         OutTemp       => RXDATA_OUT(14),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(14),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(15),
         GlitchData    => RXDATA15_GlitchData,
         OutSignalName => "RXDATA(15)",
         OutTemp       => RXDATA_OUT(15),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(15),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(16),
         GlitchData    => RXDATA16_GlitchData,
         OutSignalName => "RXDATA(16)",
         OutTemp       => RXDATA_OUT(16),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(16),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(17),
         GlitchData    => RXDATA17_GlitchData,
         OutSignalName => "RXDATA(17)",
         OutTemp       => RXDATA_OUT(17),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(17),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(18),
         GlitchData    => RXDATA18_GlitchData,
         OutSignalName => "RXDATA(18)",
         OutTemp       => RXDATA_OUT(18),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(18),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(19),
         GlitchData    => RXDATA19_GlitchData,
         OutSignalName => "RXDATA(19)",
         OutTemp       => RXDATA_OUT(19),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(19),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(20),
         GlitchData    => RXDATA20_GlitchData,
         OutSignalName => "RXDATA(20)",
         OutTemp       => RXDATA_OUT(20),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(20),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(21),
         GlitchData    => RXDATA21_GlitchData,
         OutSignalName => "RXDATA(21)",
         OutTemp       => RXDATA_OUT(21),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(21),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(22),
         GlitchData    => RXDATA22_GlitchData,
         OutSignalName => "RXDATA(22)",
         OutTemp       => RXDATA_OUT(22),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(22),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(23),
         GlitchData    => RXDATA23_GlitchData,
         OutSignalName => "RXDATA(23)",
         OutTemp       => RXDATA_OUT(23),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(23),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(24),
         GlitchData    => RXDATA24_GlitchData,
         OutSignalName => "RXDATA(24)",
         OutTemp       => RXDATA_OUT(24),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(24),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(25),
         GlitchData    => RXDATA25_GlitchData,
         OutSignalName => "RXDATA(25)",
         OutTemp       => RXDATA_OUT(25),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(25),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(26),
         GlitchData    => RXDATA26_GlitchData,
         OutSignalName => "RXDATA(26)",
         OutTemp       => RXDATA_OUT(26),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(26),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(27),
         GlitchData    => RXDATA27_GlitchData,
         OutSignalName => "RXDATA(27)",
         OutTemp       => RXDATA_OUT(27),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(27),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(28),
         GlitchData    => RXDATA28_GlitchData,
         OutSignalName => "RXDATA(28)",
         OutTemp       => RXDATA_OUT(28),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(28),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(29),
         GlitchData    => RXDATA29_GlitchData,
         OutSignalName => "RXDATA(29)",
         OutTemp       => RXDATA_OUT(29),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(29),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(30),
         GlitchData    => RXDATA30_GlitchData,
         OutSignalName => "RXDATA(30)",
         OutTemp       => RXDATA_OUT(30),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(30),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(31),
         GlitchData    => RXDATA31_GlitchData,
         OutSignalName => "RXDATA(31)",
         OutTemp       => RXDATA_OUT(31),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(31),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(32),
         GlitchData    => RXDATA32_GlitchData,
         OutSignalName => "RXDATA(32)",
         OutTemp       => RXDATA_OUT(32),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(32),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(33),
         GlitchData    => RXDATA33_GlitchData,
         OutSignalName => "RXDATA(33)",
         OutTemp       => RXDATA_OUT(33),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(33),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(34),
         GlitchData    => RXDATA34_GlitchData,
         OutSignalName => "RXDATA(34)",
         OutTemp       => RXDATA_OUT(34),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(34),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(35),
         GlitchData    => RXDATA35_GlitchData,
         OutSignalName => "RXDATA(35)",
         OutTemp       => RXDATA_OUT(35),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(35),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(36),
         GlitchData    => RXDATA36_GlitchData,
         OutSignalName => "RXDATA(36)",
         OutTemp       => RXDATA_OUT(36),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(36),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(37),
         GlitchData    => RXDATA37_GlitchData,
         OutSignalName => "RXDATA(37)",
         OutTemp       => RXDATA_OUT(37),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(37),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(38),
         GlitchData    => RXDATA38_GlitchData,
         OutSignalName => "RXDATA(38)",
         OutTemp       => RXDATA_OUT(38),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(38),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(39),
         GlitchData    => RXDATA39_GlitchData,
         OutSignalName => "RXDATA(39)",
         OutTemp       => RXDATA_OUT(39),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(39),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(40),
         GlitchData    => RXDATA40_GlitchData,
         OutSignalName => "RXDATA(40)",
         OutTemp       => RXDATA_OUT(40),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(40),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(41),
         GlitchData    => RXDATA41_GlitchData,
         OutSignalName => "RXDATA(41)",
         OutTemp       => RXDATA_OUT(41),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(41),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(42),
         GlitchData    => RXDATA42_GlitchData,
         OutSignalName => "RXDATA(42)",
         OutTemp       => RXDATA_OUT(42),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(42),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(43),
         GlitchData    => RXDATA43_GlitchData,
         OutSignalName => "RXDATA(43)",
         OutTemp       => RXDATA_OUT(43),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(43),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(44),
         GlitchData    => RXDATA44_GlitchData,
         OutSignalName => "RXDATA(44)",
         OutTemp       => RXDATA_OUT(44),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(44),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(45),
         GlitchData    => RXDATA45_GlitchData,
         OutSignalName => "RXDATA(45)",
         OutTemp       => RXDATA_OUT(45),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(45),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(46),
         GlitchData    => RXDATA46_GlitchData,
         OutSignalName => "RXDATA(46)",
         OutTemp       => RXDATA_OUT(46),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(46),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(47),
         GlitchData    => RXDATA47_GlitchData,
         OutSignalName => "RXDATA(47)",
         OutTemp       => RXDATA_OUT(47),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(47),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(48),
         GlitchData    => RXDATA48_GlitchData,
         OutSignalName => "RXDATA(48)",
         OutTemp       => RXDATA_OUT(48),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(48),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(49),
         GlitchData    => RXDATA49_GlitchData,
         OutSignalName => "RXDATA(49)",
         OutTemp       => RXDATA_OUT(49),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(49),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(50),
         GlitchData    => RXDATA50_GlitchData,
         OutSignalName => "RXDATA(50)",
         OutTemp       => RXDATA_OUT(50),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(50),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(51),
         GlitchData    => RXDATA51_GlitchData,
         OutSignalName => "RXDATA(51)",
         OutTemp       => RXDATA_OUT(51),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(51),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(52),
         GlitchData    => RXDATA52_GlitchData,
         OutSignalName => "RXDATA(52)",
         OutTemp       => RXDATA_OUT(52),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(52),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(53),
         GlitchData    => RXDATA53_GlitchData,
         OutSignalName => "RXDATA(53)",
         OutTemp       => RXDATA_OUT(53),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(53),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(54),
         GlitchData    => RXDATA54_GlitchData,
         OutSignalName => "RXDATA(54)",
         OutTemp       => RXDATA_OUT(54),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(54),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(55),
         GlitchData    => RXDATA55_GlitchData,
         OutSignalName => "RXDATA(55)",
         OutTemp       => RXDATA_OUT(55),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(55),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(56),
         GlitchData    => RXDATA56_GlitchData,
         OutSignalName => "RXDATA(56)",
         OutTemp       => RXDATA_OUT(56),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(56),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(57),
         GlitchData    => RXDATA57_GlitchData,
         OutSignalName => "RXDATA(57)",
         OutTemp       => RXDATA_OUT(57),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(57),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(58),
         GlitchData    => RXDATA58_GlitchData,
         OutSignalName => "RXDATA(58)",
         OutTemp       => RXDATA_OUT(58),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(58),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(59),
         GlitchData    => RXDATA59_GlitchData,
         OutSignalName => "RXDATA(59)",
         OutTemp       => RXDATA_OUT(59),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(59),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(60),
         GlitchData    => RXDATA60_GlitchData,
         OutSignalName => "RXDATA(60)",
         OutTemp       => RXDATA_OUT(60),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(60),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(61),
         GlitchData    => RXDATA61_GlitchData,
         OutSignalName => "RXDATA(61)",
         OutTemp       => RXDATA_OUT(61),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(61),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(62),
         GlitchData    => RXDATA62_GlitchData,
         OutSignalName => "RXDATA(62)",
         OutTemp       => RXDATA_OUT(62),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(62),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDATA(63),
         GlitchData    => RXDATA63_GlitchData,
         OutSignalName => "RXDATA(63)",
         OutTemp       => RXDATA_OUT(63),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(63),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(0),
         GlitchData    => RXDISPERR0_GlitchData,
         OutSignalName => "RXDISPERR(0)",
         OutTemp       => RXDISPERR_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(1),
         GlitchData    => RXDISPERR1_GlitchData,
         OutSignalName => "RXDISPERR(1)",
         OutTemp       => RXDISPERR_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(2),
         GlitchData    => RXDISPERR2_GlitchData,
         OutSignalName => "RXDISPERR(2)",
         OutTemp       => RXDISPERR_OUT(2),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(3),
         GlitchData    => RXDISPERR3_GlitchData,
         OutSignalName => "RXDISPERR(3)",
         OutTemp       => RXDISPERR_OUT(3),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(4),
         GlitchData    => RXDISPERR4_GlitchData,
         OutSignalName => "RXDISPERR(4)",
         OutTemp       => RXDISPERR_OUT(4),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(5),
         GlitchData    => RXDISPERR5_GlitchData,
         OutSignalName => "RXDISPERR(5)",
         OutTemp       => RXDISPERR_OUT(5),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(6),
         GlitchData    => RXDISPERR6_GlitchData,
         OutSignalName => "RXDISPERR(6)",
         OutTemp       => RXDISPERR_OUT(6),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXDISPERR(7),
         GlitchData    => RXDISPERR7_GlitchData,
         OutSignalName => "RXDISPERR(7)",
         OutTemp       => RXDISPERR_OUT(7),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXLOSSOFSYNC(0),
         GlitchData    => RXLOSSOFSYNC0_GlitchData,
         OutSignalName => "RXLOSSOFSYNC(0)",
         OutTemp       => RXLOSSOFSYNC_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXLOSSOFSYNC(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXLOSSOFSYNC(1),
         GlitchData    => RXLOSSOFSYNC1_GlitchData,
         OutSignalName => "RXLOSSOFSYNC(1)",
         OutTemp       => RXLOSSOFSYNC_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXLOSSOFSYNC(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(0),
         GlitchData    => RXNOTINTABLE0_GlitchData,
         OutSignalName => "RXNOTINTABLE(0)",
         OutTemp       => RXNOTINTABLE_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(1),
         GlitchData    => RXNOTINTABLE1_GlitchData,
         OutSignalName => "RXNOTINTABLE(1)",
         OutTemp       => RXNOTINTABLE_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(2),
         GlitchData    => RXNOTINTABLE2_GlitchData,
         OutSignalName => "RXNOTINTABLE(2)",
         OutTemp       => RXNOTINTABLE_OUT(2),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(3),
         GlitchData    => RXNOTINTABLE3_GlitchData,
         OutSignalName => "RXNOTINTABLE(3)",
         OutTemp       => RXNOTINTABLE_OUT(3),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(4),
         GlitchData    => RXNOTINTABLE4_GlitchData,
         OutSignalName => "RXNOTINTABLE(4)",
         OutTemp       => RXNOTINTABLE_OUT(4),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(5),
         GlitchData    => RXNOTINTABLE5_GlitchData,
         OutSignalName => "RXNOTINTABLE(5)",
         OutTemp       => RXNOTINTABLE_OUT(5),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(6),
         GlitchData    => RXNOTINTABLE6_GlitchData,
         OutSignalName => "RXNOTINTABLE(6)",
         OutTemp       => RXNOTINTABLE_OUT(6),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXNOTINTABLE(7),
         GlitchData    => RXNOTINTABLE7_GlitchData,
         OutSignalName => "RXNOTINTABLE(7)",
         OutTemp       => RXNOTINTABLE_OUT(7),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXREALIGN,
         GlitchData    => RXREALIGN_GlitchData,
         OutSignalName => "RXREALIGN",
         OutTemp       => RXREALIGN_OUT,
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXREALIGN,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );     
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(0),
         GlitchData    => RXRUNDISP0_GlitchData,
         OutSignalName => "RXRUNDISP(0)",
         OutTemp       => RXRUNDISP_OUT(0),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(1),
         GlitchData    => RXRUNDISP1_GlitchData,
         OutSignalName => "RXRUNDISP(1)",
         OutTemp       => RXRUNDISP_OUT(1),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(2),
         GlitchData    => RXRUNDISP2_GlitchData,
         OutSignalName => "RXRUNDISP(2)",
         OutTemp       => RXRUNDISP_OUT(2),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(3),
         GlitchData    => RXRUNDISP3_GlitchData,
         OutSignalName => "RXRUNDISP(3)",
         OutTemp       => RXRUNDISP_OUT(3),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(4),
         GlitchData    => RXRUNDISP4_GlitchData,
         OutSignalName => "RXRUNDISP(4)",
         OutTemp       => RXRUNDISP_OUT(4),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(5),
         GlitchData    => RXRUNDISP5_GlitchData,
         OutSignalName => "RXRUNDISP(5)",
         OutTemp       => RXRUNDISP_OUT(5),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(6),
         GlitchData    => RXRUNDISP6_GlitchData,
         OutSignalName => "RXRUNDISP(6)",
         OutTemp       => RXRUNDISP_OUT(6),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXRUNDISP(7),
         GlitchData    => RXRUNDISP7_GlitchData,
         OutSignalName => "RXRUNDISP(7)",
         OutTemp       => RXRUNDISP_OUT(7),
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXBUFERR,
         GlitchData    => RXBUFERR_GlitchData,
         OutSignalName => "RXBUFERR",
         OutTemp       => RXBUFERR_OUT,
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXBUFERR,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXBUFERR,
         GlitchData    => TXBUFERR_GlitchData,
         OutSignalName => "TXBUFERR",
         OutTemp       => TXBUFERR_OUT,
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXBUFERR,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );     
     VitalPathDelay01
       (
         OutSignal     => TXKERR(0),
         GlitchData    => TXKERR0_GlitchData,
         OutSignalName => "TXKERR(0)",
         OutTemp       => TXKERR_OUT(0),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXKERR(1),
         GlitchData    => TXKERR1_GlitchData,
         OutSignalName => "TXKERR(1)",
         OutTemp       => TXKERR_OUT(1),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXKERR(2),
         GlitchData    => TXKERR2_GlitchData,
         OutSignalName => "TXKERR(2)",
         OutTemp       => TXKERR_OUT(2),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXKERR(3),
         GlitchData    => TXKERR3_GlitchData,
         OutSignalName => "TXKERR(3)",
         OutTemp       => TXKERR_OUT(3),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXKERR(4),
         GlitchData    => TXKERR4_GlitchData,
         OutSignalName => "TXKERR(4)",
         OutTemp       => TXKERR_OUT(4),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXKERR(5),
         GlitchData    => TXKERR5_GlitchData,
         OutSignalName => "TXKERR(5)",
         OutTemp       => TXKERR_OUT(5),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXKERR(6),
         GlitchData    => TXKERR6_GlitchData,
         OutSignalName => "TXKERR(6)",
         OutTemp       => TXKERR_OUT(6),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXKERR(7),
         GlitchData    => TXKERR7_GlitchData,
         OutSignalName => "TXKERR(7)",
         OutTemp       => TXKERR_OUT(7),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(0),
         GlitchData    => TXRUNDISP0_GlitchData,
         OutSignalName => "TXRUNDISP(0)",
         OutTemp       => TXRUNDISP_OUT(0),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(1),
         GlitchData    => TXRUNDISP1_GlitchData,
         OutSignalName => "TXRUNDISP(1)",
         OutTemp       => TXRUNDISP_OUT(1),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(2),
         GlitchData    => TXRUNDISP2_GlitchData,
         OutSignalName => "TXRUNDISP(2)",
         OutTemp       => TXRUNDISP_OUT(2),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(3),
         GlitchData    => TXRUNDISP3_GlitchData,
         OutSignalName => "TXRUNDISP(3)",
         OutTemp       => TXRUNDISP_OUT(3),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(4),
         GlitchData    => TXRUNDISP4_GlitchData,
         OutSignalName => "TXRUNDISP(4)",
         OutTemp       => TXRUNDISP_OUT(4),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(5),
         GlitchData    => TXRUNDISP5_GlitchData,
         OutSignalName => "TXRUNDISP(5)",
         OutTemp       => TXRUNDISP_OUT(5),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(6),
         GlitchData    => TXRUNDISP6_GlitchData,
         OutSignalName => "TXRUNDISP(6)",
         OutTemp       => TXRUNDISP_OUT(6),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXRUNDISP(7),
         GlitchData    => TXRUNDISP7_GlitchData,
         OutSignalName => "TXRUNDISP(7)",
         OutTemp       => TXRUNDISP_OUT(7),
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXLOCK,
         GlitchData    => RXLOCK_GlitchData,
         OutSignalName => "RXLOCK",
         OutTemp       => RXLOCK_OUT,
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXLOCK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXLOCK,
         GlitchData    => TXLOCK_GlitchData,
         OutSignalName => "TXLOCK",
         OutTemp       => TXLOCK_OUT,
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXLOCK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCYCLELIMIT,
         GlitchData    => RXCYCLELIMIT_GlitchData,
         OutSignalName => "RXCYCLELIMIT",
         OutTemp       => RXCYCLELIMIT_OUT,
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCYCLELIMIT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCYCLELIMIT,
         GlitchData    => TXCYCLELIMIT_GlitchData,
         OutSignalName => "TXCYCLELIMIT",
         OutTemp       => TXCYCLELIMIT_OUT,
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXCYCLELIMIT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCALFAIL,
         GlitchData    => RXCALFAIL_GlitchData,
         OutSignalName => "RXCALFAIL",
         OutTemp       => RXCALFAIL_OUT,
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_RXCALFAIL,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCALFAIL,
         GlitchData    => TXCALFAIL_GlitchData,
         OutSignalName => "TXCALFAIL",
         OutTemp       => TXCALFAIL_OUT,
         Paths         => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXCALFAIL,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );     
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(0),
         GlitchData    => RXCRCOUT0_GlitchData,
         OutSignalName => "RXCRCOUT(0)",
         OutTemp       => RXCRCOUT_OUT(0),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(1),
         GlitchData    => RXCRCOUT1_GlitchData,
         OutSignalName => "RXCRCOUT(1)",
         OutTemp       => RXCRCOUT_OUT(1),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(2),
         GlitchData    => RXCRCOUT2_GlitchData,
         OutSignalName => "RXCRCOUT(2)",
         OutTemp       => RXCRCOUT_OUT(2),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(3),
         GlitchData    => RXCRCOUT3_GlitchData,
         OutSignalName => "RXCRCOUT(3)",
         OutTemp       => RXCRCOUT_OUT(3),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(4),
         GlitchData    => RXCRCOUT4_GlitchData,
         OutSignalName => "RXCRCOUT(4)",
         OutTemp       => RXCRCOUT_OUT(4),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(5),
         GlitchData    => RXCRCOUT5_GlitchData,
         OutSignalName => "RXCRCOUT(5)",
         OutTemp       => RXCRCOUT_OUT(5),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(6),
         GlitchData    => RXCRCOUT6_GlitchData,
         OutSignalName => "RXCRCOUT(6)",
         OutTemp       => RXCRCOUT_OUT(6),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(7),
         GlitchData    => RXCRCOUT7_GlitchData,
         OutSignalName => "RXCRCOUT(7)",
         OutTemp       => RXCRCOUT_OUT(7),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(8),
         GlitchData    => RXCRCOUT8_GlitchData,
         OutSignalName => "RXCRCOUT(8)",
         OutTemp       => RXCRCOUT_OUT(8),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(8),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(9),
         GlitchData    => RXCRCOUT9_GlitchData,
         OutSignalName => "RXCRCOUT(9)",
         OutTemp       => RXCRCOUT_OUT(9),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(9),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(10),
         GlitchData    => RXCRCOUT10_GlitchData,
         OutSignalName => "RXCRCOUT(10)",
         OutTemp       => RXCRCOUT_OUT(10),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(10),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(11),
         GlitchData    => RXCRCOUT11_GlitchData,
         OutSignalName => "RXCRCOUT(11)",
         OutTemp       => RXCRCOUT_OUT(11),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(11),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(12),
         GlitchData    => RXCRCOUT12_GlitchData,
         OutSignalName => "RXCRCOUT(12)",
         OutTemp       => RXCRCOUT_OUT(12),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(12),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(13),
         GlitchData    => RXCRCOUT13_GlitchData,
         OutSignalName => "RXCRCOUT(13)",
         OutTemp       => RXCRCOUT_OUT(13),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(13),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(14),
         GlitchData    => RXCRCOUT14_GlitchData,
         OutSignalName => "RXCRCOUT(14)",
         OutTemp       => RXCRCOUT_OUT(14),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(14),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(15),
         GlitchData    => RXCRCOUT15_GlitchData,
         OutSignalName => "RXCRCOUT(15)",
         OutTemp       => RXCRCOUT_OUT(15),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(15),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(16),
         GlitchData    => RXCRCOUT16_GlitchData,
         OutSignalName => "RXCRCOUT(16)",
         OutTemp       => RXCRCOUT_OUT(16),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(16),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(17),
         GlitchData    => RXCRCOUT17_GlitchData,
         OutSignalName => "RXCRCOUT(17)",
         OutTemp       => RXCRCOUT_OUT(17),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(17),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(18),
         GlitchData    => RXCRCOUT18_GlitchData,
         OutSignalName => "RXCRCOUT(18)",
         OutTemp       => RXCRCOUT_OUT(18),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(18),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(19),
         GlitchData    => RXCRCOUT19_GlitchData,
         OutSignalName => "RXCRCOUT(19)",
         OutTemp       => RXCRCOUT_OUT(19),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(19),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(20),
         GlitchData    => RXCRCOUT20_GlitchData,
         OutSignalName => "RXCRCOUT(20)",
         OutTemp       => RXCRCOUT_OUT(20),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(20),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(21),
         GlitchData    => RXCRCOUT21_GlitchData,
         OutSignalName => "RXCRCOUT(21)",
         OutTemp       => RXCRCOUT_OUT(21),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(21),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(22),
         GlitchData    => RXCRCOUT22_GlitchData,
         OutSignalName => "RXCRCOUT(22)",
         OutTemp       => RXCRCOUT_OUT(22),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(22),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(23),
         GlitchData    => RXCRCOUT23_GlitchData,
         OutSignalName => "RXCRCOUT(23)",
         OutTemp       => RXCRCOUT_OUT(23),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(23),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(24),
         GlitchData    => RXCRCOUT24_GlitchData,
         OutSignalName => "RXCRCOUT(24)",
         OutTemp       => RXCRCOUT_OUT(24),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(24),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(25),
         GlitchData    => RXCRCOUT25_GlitchData,
         OutSignalName => "RXCRCOUT(25)",
         OutTemp       => RXCRCOUT_OUT(25),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(25),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(26),
         GlitchData    => RXCRCOUT26_GlitchData,
         OutSignalName => "RXCRCOUT(26)",
         OutTemp       => RXCRCOUT_OUT(26),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(26),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(27),
         GlitchData    => RXCRCOUT27_GlitchData,
         OutSignalName => "RXCRCOUT(27)",
         OutTemp       => RXCRCOUT_OUT(27),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(27),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(28),
         GlitchData    => RXCRCOUT28_GlitchData,
         OutSignalName => "RXCRCOUT(28)",
         OutTemp       => RXCRCOUT_OUT(28),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(28),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(29),
         GlitchData    => RXCRCOUT29_GlitchData,
         OutSignalName => "RXCRCOUT(29)",
         OutTemp       => RXCRCOUT_OUT(29),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(29),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(30),
         GlitchData    => RXCRCOUT30_GlitchData,
         OutSignalName => "RXCRCOUT(30)",
         OutTemp       => RXCRCOUT_OUT(30),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(30),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXCRCOUT(31),
         GlitchData    => RXCRCOUT31_GlitchData,
         OutSignalName => "RXCRCOUT(31)",
         OutTemp       => RXCRCOUT_OUT(31),
         Paths         => (0 => (RXCRCINTCLK_dly'last_event, tpd_RXCRCINTCLK_RXCRCOUT(31),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(0),
         GlitchData    => TXCRCOUT0_GlitchData,
         OutSignalName => "TXCRCOUT(0)",
         OutTemp       => TXCRCOUT_OUT(0),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(1),
         GlitchData    => TXCRCOUT1_GlitchData,
         OutSignalName => "TXCRCOUT(1)",
         OutTemp       => TXCRCOUT_OUT(1),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(2),
         GlitchData    => TXCRCOUT2_GlitchData,
         OutSignalName => "TXCRCOUT(2)",
         OutTemp       => TXCRCOUT_OUT(2),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(3),
         GlitchData    => TXCRCOUT3_GlitchData,
         OutSignalName => "TXCRCOUT(3)",
         OutTemp       => TXCRCOUT_OUT(3),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(4),
         GlitchData    => TXCRCOUT4_GlitchData,
         OutSignalName => "TXCRCOUT(4)",
         OutTemp       => TXCRCOUT_OUT(4),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(5),
         GlitchData    => TXCRCOUT5_GlitchData,
         OutSignalName => "TXCRCOUT(5)",
         OutTemp       => TXCRCOUT_OUT(5),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(6),
         GlitchData    => TXCRCOUT6_GlitchData,
         OutSignalName => "TXCRCOUT(6)",
         OutTemp       => TXCRCOUT_OUT(6),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(7),
         GlitchData    => TXCRCOUT7_GlitchData,
         OutSignalName => "TXCRCOUT(7)",
         OutTemp       => TXCRCOUT_OUT(7),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(8),
         GlitchData    => TXCRCOUT8_GlitchData,
         OutSignalName => "TXCRCOUT(8)",
         OutTemp       => TXCRCOUT_OUT(8),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(8),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(9),
         GlitchData    => TXCRCOUT9_GlitchData,
         OutSignalName => "TXCRCOUT(9)",
         OutTemp       => TXCRCOUT_OUT(9),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(9),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(10),
         GlitchData    => TXCRCOUT10_GlitchData,
         OutSignalName => "TXCRCOUT(10)",
         OutTemp       => TXCRCOUT_OUT(10),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(10),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(11),
         GlitchData    => TXCRCOUT11_GlitchData,
         OutSignalName => "TXCRCOUT(11)",
         OutTemp       => TXCRCOUT_OUT(11),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(11),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(12),
         GlitchData    => TXCRCOUT12_GlitchData,
         OutSignalName => "TXCRCOUT(12)",
         OutTemp       => TXCRCOUT_OUT(12),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(12),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(13),
         GlitchData    => TXCRCOUT13_GlitchData,
         OutSignalName => "TXCRCOUT(13)",
         OutTemp       => TXCRCOUT_OUT(13),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(13),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(14),
         GlitchData    => TXCRCOUT14_GlitchData,
         OutSignalName => "TXCRCOUT(14)",
         OutTemp       => TXCRCOUT_OUT(14),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(14),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(15),
         GlitchData    => TXCRCOUT15_GlitchData,
         OutSignalName => "TXCRCOUT(15)",
         OutTemp       => TXCRCOUT_OUT(15),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(15),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(16),
         GlitchData    => TXCRCOUT16_GlitchData,
         OutSignalName => "TXCRCOUT(16)",
         OutTemp       => TXCRCOUT_OUT(16),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(16),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(17),
         GlitchData    => TXCRCOUT17_GlitchData,
         OutSignalName => "TXCRCOUT(17)",
         OutTemp       => TXCRCOUT_OUT(17),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(17),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(18),
         GlitchData    => TXCRCOUT18_GlitchData,
         OutSignalName => "TXCRCOUT(18)",
         OutTemp       => TXCRCOUT_OUT(18),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(18),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(19),
         GlitchData    => TXCRCOUT19_GlitchData,
         OutSignalName => "TXCRCOUT(19)",
         OutTemp       => TXCRCOUT_OUT(19),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(19),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(20),
         GlitchData    => TXCRCOUT20_GlitchData,
         OutSignalName => "TXCRCOUT(20)",
         OutTemp       => TXCRCOUT_OUT(20),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(20),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(21),
         GlitchData    => TXCRCOUT21_GlitchData,
         OutSignalName => "TXCRCOUT(21)",
         OutTemp       => TXCRCOUT_OUT(21),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(21),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(22),
         GlitchData    => TXCRCOUT22_GlitchData,
         OutSignalName => "TXCRCOUT(22)",
         OutTemp       => TXCRCOUT_OUT(22),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(22),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(23),
         GlitchData    => TXCRCOUT23_GlitchData,
         OutSignalName => "TXCRCOUT(23)",
         OutTemp       => TXCRCOUT_OUT(23),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(23),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(24),
         GlitchData    => TXCRCOUT24_GlitchData,
         OutSignalName => "TXCRCOUT(24)",
         OutTemp       => TXCRCOUT_OUT(24),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(24),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(25),
         GlitchData    => TXCRCOUT25_GlitchData,
         OutSignalName => "TXCRCOUT(25)",
         OutTemp       => TXCRCOUT_OUT(25),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(25),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(26),
         GlitchData    => TXCRCOUT26_GlitchData,
         OutSignalName => "TXCRCOUT(26)",
         OutTemp       => TXCRCOUT_OUT(26),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(26),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(27),
         GlitchData    => TXCRCOUT27_GlitchData,
         OutSignalName => "TXCRCOUT(27)",
         OutTemp       => TXCRCOUT_OUT(27),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(27),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(28),
         GlitchData    => TXCRCOUT28_GlitchData,
         OutSignalName => "TXCRCOUT(28)",
         OutTemp       => TXCRCOUT_OUT(28),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(28),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(29),
         GlitchData    => TXCRCOUT29_GlitchData,
         OutSignalName => "TXCRCOUT(29)",
         OutTemp       => TXCRCOUT_OUT(29),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(29),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(30),
         GlitchData    => TXCRCOUT30_GlitchData,
         OutSignalName => "TXCRCOUT(30)",
         OutTemp       => TXCRCOUT_OUT(30),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(30),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => TXCRCOUT(31),
         GlitchData    => TXCRCOUT31_GlitchData,
         OutSignalName => "TXCRCOUT(31)",
         OutTemp       => TXCRCOUT_OUT(31),
         Paths         => (0 => (TXCRCINTCLK_dly'last_event, tpd_TXCRCINTCLK_TXCRCOUT(31),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => RXSIGDET,
         GlitchData    => RXSIGDET_GlitchData,
         OutSignalName => "RXSIGDET",
         OutTemp       => RXSIGDET_OUT,
         Paths         => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSIGDET,TRUE)),
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
         OutSignal     => DO(0),
         GlitchData    => DO0_GlitchData,
         OutSignalName => "DO(0)",
         OutTemp       => DO_OUT(0),
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(0),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(1),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(2),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(3),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(4),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(5),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(6),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(7),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(8),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(9),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(10),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(11),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(12),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(13),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(14),TRUE)),
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
         Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(15),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );

--  Wait signal (input/output pins)
   wait on
     CHBONDO_OUT,
     RXSTATUS_OUT,
     RXCHARISCOMMA_OUT,
     RXCHARISK_OUT,
     RXCOMMADET_OUT,
     RXDATA_OUT,
     RXDISPERR_OUT,
     RXLOSSOFSYNC_OUT,
     RXNOTINTABLE_OUT,
     RXREALIGN_OUT,
     RXRUNDISP_OUT,
     RXBUFERR_OUT,
     TXBUFERR_OUT,
     TXKERR_OUT,
     TXRUNDISP_OUT,
     RXLOCK_OUT,
     TXLOCK_OUT,
     RXCYCLELIMIT_OUT,
     TXCYCLELIMIT_OUT,
     RXCALFAIL_OUT,
     TXCALFAIL_OUT,
     RXCRCOUT_OUT,
     TXCRCOUT_OUT,
     RXSIGDET_OUT,
     DRDY_OUT,
     DO_OUT,
     CHBONDI_dly,
     ENCHANSYNC_dly,
     ENMCOMMAALIGN_dly,
     ENPCOMMAALIGN_dly,
     LOOPBACK_dly,
     POWERDOWN_dly,
     RXBLOCKSYNC64B66BUSE_dly,
     RXCOMMADETUSE_dly,
     RXDATAWIDTH_dly,
     RXDEC64B66BUSE_dly,
     RXDEC8B10BUSE_dly,
     RXDESCRAM64B66BUSE_dly,
     RXIGNOREBTF_dly,
     RXINTDATAWIDTH_dly,
     RXPOLARITY_dly,
     RXRESET_dly,
     RXSLIDE_dly,
     RXUSRCLK_dly,
     RXUSRCLK2_dly,
     TXBYPASS8B10B_dly,
     TXCHARDISPMODE_dly,
     TXCHARDISPVAL_dly,
     TXCHARISK_dly,
     TXDATA_dly,
     TXDATAWIDTH_dly,
     TXENC64B66BUSE_dly,
     TXENC8B10BUSE_dly,
     TXGEARBOX64B66BUSE_dly,
     TXINHIBIT_dly,
     TXINTDATAWIDTH_dly,
     TXPOLARITY_dly,
     TXRESET_dly,
     TXSCRAM64B66BUSE_dly,
     TXUSRCLK_dly,
     TXUSRCLK2_dly,
     RXCLKSTABLE_dly,
     RXPMARESET_dly,
     TXCLKSTABLE_dly,
     TXPMARESET_dly,
     RXCRCIN_dly,
     RXCRCDATAWIDTH_dly,
     RXCRCDATAVALID_dly,
     RXCRCINIT_dly,
     RXCRCRESET_dly,
     RXCRCPD_dly,
     RXCRCCLK_dly,
     RXCRCINTCLK_dly,
     TXCRCIN_dly,
     TXCRCDATAWIDTH_dly,
     TXCRCDATAVALID_dly,
     TXCRCINIT_dly,
     TXCRCRESET_dly,
     TXCRCPD_dly,
     TXCRCCLK_dly,
     TXCRCINTCLK_dly,
     TXSYNC_dly,
     RXSYNC_dly,
     TXENOOB_dly,
     DCLK_dly,
     DADDR_dly,
     DEN_dly,
     DWE_dly,
     DI_dly,
     RX1P_dly,
     RX1N_dly,
     GREFCLK_dly,
     REFCLK1_dly,
     REFCLK2_dly;

   end process TIMING;

   RXPCSHCLKOUT <= RXPCSHCLKOUT_OUT;
   TXPCSHCLKOUT <= TXPCSHCLKOUT_OUT;
   RXMCLK <= RXMCLK_OUT;
   RXRECCLK1 <= RXRECCLK1_OUT;
   RXRECCLK2 <= RXRECCLK2_OUT;
   TXOUTCLK1 <= TXOUTCLK1_OUT;
   TXOUTCLK2 <= TXOUTCLK2_OUT;
   TX1N <= TX1N_OUT;
   TX1P <= TX1P_OUT;
   COMBUSOUT <= COMBUSOUT_OUT;  
end X_GT11_V;

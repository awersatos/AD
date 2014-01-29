-- --------------------------------------------------------------------
-- >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
-- --------------------------------------------------------------------
-- Copyright (c) 2005 by Lattice Semiconductor Corporation
-- --------------------------------------------------------------------
--
--
--                     Lattice Semiconductor Corporation
--                     5555 NE Moore Court
--                     Hillsboro, OR 97214
--                     U.S.A.
--
--                     TEL: 1-800-Lattice  (USA and Canada)
--                          1-408-826-6000 (other locations)
--
--                     web: http://www.latticesemi.com/
--                     email: techsupport@latticesemi.com
--
-- --------------------------------------------------------------------
--
-- Simulation Library File for ORCA2
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca2/src/RCS/ORCA_MEM.vhd,v 1.6 2005/05/19 20:04:10 pradeep Exp $ 
--

--
----- PACKAGE MEM -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package MEM is
   type mem_type_2 is array (natural range <>) of STD_LOGIC_VECTOR(1 downto 0);
   type mem_type_4 is array (natural range <>) of STD_LOGIC_VECTOR(3 downto 0);
   function hex2bin_2 (hex: Character) return STD_LOGIC_VECTOR;
   function hex2bin_4 (hex: Character) return STD_LOGIC_VECTOR;
   function init_ram (hex: String) return mem_type_2;
   function init_ram (hex: String) return mem_type_4;
end MEM;
 
package body MEM is

   function hex2bin_2 (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (1 downto 0);
   begin
        case hex is
          when '0' => 
             result := "00";
          when '1' => 
             result := "01";
          when '2' => 
             result := "10";
          when '3' => 
             result := "11";
          when others =>
             null;
        end case;
        return result;
   end; 

   function hex2bin_4 (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (3 downto 0);
   begin
        case hex is
          when '0' => 
             result := "0000";
          when '1' => 
             result := "0001";
          when '2' => 
             result := "0010";
          when '3' => 
             result := "0011";
          when '4' => 
             result := "0100";
          when '5' => 
             result := "0101";
          when '6' => 
             result := "0110";
          when '7' => 
             result := "0111";
          when '8' => 
             result := "1000";
          when '9' => 
             result := "1001";
          when 'A'|'a' => 
             result := "1010";
          when 'B'|'b' => 
             result := "1011";
          when 'C'|'c' => 
             result := "1100";
          when 'D'|'d' => 
             result := "1101";
          when 'E'|'e' => 
             result := "1110";
          when 'F'|'f' => 
             result := "1111";
          when others =>
             null;
        end case;
        return result;
   end; 
 
   function init_ram (hex: String) return mem_type_2 is
	-- skip 0x of hex string
        constant length : Integer := hex'length - 2;
        variable result : mem_type_2 (length-1 downto 0);
   begin
        for i in 0 to length-1 loop
           result (length-1-i) := hex2bin_2 (hex(i+3));
        end loop;
        return result;
   end;
 
   function init_ram (hex: String) return mem_type_4 is
	-- skip 0x of hex string
        constant length : Integer := hex'length - 2;
        variable result : mem_type_4 (length-1 downto 0);
   begin
        for i in 0 to length-1 loop
           result (length-1-i) := hex2bin_4 (hex(i+3));
        end loop;
        return result;
   end;
 
end MEM;


 
--
----- PACKAGE mem2 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
package mem2 is
   function hex2bin (hex: String) return STD_LOGIC_VECTOR;
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR;
end mem2;
 
package body mem2 is
 
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR is
        variable result : STD_LOGIC_VECTOR (3 downto 0);
   begin
        case hex is
          when '0' =>
             result := "0000";
          when '1' =>
             result := "0001";
          when '2' =>
             result := "0010";
          when '3' =>
             result := "0011";
          when '4' =>
             result := "0100";
          when '5' =>
             result := "0101";
          when '6' =>
             result := "0110";
          when '7' =>
             result := "0111";
          when '8' =>
             result := "1000";
          when '9' =>
             result := "1001";
          when 'A'|'a' =>
             result := "1010";
          when 'B'|'b' =>
             result := "1011";
          when 'C'|'c' =>
             result := "1100";
          when 'D'|'d' =>
             result := "1101";
          when 'E'|'e' =>
             result := "1110";
          when 'F'|'f' =>
             result := "1111";
          when others =>
             null;
        end case;
        return result;
   end;
 
   function hex2bin (hex: String) return STD_LOGIC_VECTOR is
        -- skip 0x of hex string
        constant length : Integer := hex'length - 2;
        variable result : STD_LOGIC_VECTOR (4*length-1 downto 0);
   begin
        for i in 0 to length-1 loop
           result ((length-i)*4-1 downto (length-i-1)*4) := hex2bin(hex(i+3)); 
        end loop;
        return result;
   end;
 
end mem2;
 
 

--
----- CELL DCE16X2 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity DCE16X2 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "DCE16X2";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD0 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD1 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD2 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD3 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN     : VitalDelayType := 0.1 ns;
        tpw_WREN	 : VitalDelayType := 0.1 ns;
        tperiod_WPE      : VitalDelayType := 0.1 ns;
        tpw_WPE		 : VitalDelayType := 0.1 ns;
        tperiod_CK       : VitalDelayType := 0.1 ns;
        tpw_CK		 : VitalDelayType := 0.1 ns;

        -- Propagation Delays
	tpd_CK_DO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD0_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD1_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD2_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD3_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_RDO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD0_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD1_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD2_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD3_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_RDO1	: VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        RAD0 : IN STD_LOGIC;
        RAD1 : IN STD_LOGIC;
        RAD2 : IN STD_LOGIC;
        RAD3 : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        RDO0 : OUT STD_LOGIC;
        RDO1 : OUT STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of DCE16X2 : entity is TRUE;
 
end DCE16X2;


-- architecture body --
architecture V OF DCE16X2 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal RAD0_ipd : STD_LOGIC := 'X';
   signal RAD1_ipd : STD_LOGIC := 'X';
   signal RAD2_ipd : STD_LOGIC := 'X';
   signal RAD3_ipd : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(RAD0_ipd, RAD0, tipd_RAD0);
   VitalWireDelay(RAD1_ipd, RAD1, tipd_RAD1);
   VitalWireDelay(RAD2_ipd, RAD2, tipd_RAD2);
   VitalWireDelay(RAD3_ipd, RAD3, tipd_RAD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, AD0_ipd, AD1_ipd, 
			    AD2_ipd, AD3_ipd, RAD0_ipd, RAD1_ipd, RAD2_ipd, 
			    RAD3_ipd, DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(1 downto 0) := "00";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS RDO0_zd    : STD_ULOGIC is Results(2);
     ALIAS RDO1_zd    : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData  : VitalGlitchDataType;
     VARIABLE DO1_GlitchData  : VitalGlitchDataType;
     VARIABLE RDO0_GlitchData : VitalGlitchDataType;
     VARIABLE RDO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_AD0 OR Tviol_AD1 OR 
		Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN OR Tviol_WPE OR 
		Tviol_CK;

   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "DCE16X2 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "DCE16X2 MEMORY HAZARD WRITE ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(RAD0_ipd) OR IS_X(RAD1_ipd) OR IS_X(RAD2_ipd) 
	OR IS_X(RAD3_ipd)) THEN
      assert false 
	report "DCE16X2 MEMORY HAZARD READ ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN 
	 wren_reg := WREN_ipd;
	 wpe_reg := WPE_ipd;
	 din_reg := (DI1_ipd, DI0_ipd);
	 wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (RAD3_ipd, RAD2_ipd, RAD1_ipd, RAD0_ipd);
      rindex := CONV_INTEGER(radr_reg);

      -- At the rising edge of CK, write to memory at address 
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 Results(3 downto 2) := memory(rindex);
	 Results(1 downto 0) := memory(windex);
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => RDO0,
     OutSignalName => "RDO0",
     OutTemp => RDO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO0, TRUE),
	       1 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO0, TRUE),
	       2 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO0, TRUE),
	       3 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO0, TRUE),
	       4 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO0, TRUE)),
      GlitchData => RDO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => RDO1,
     OutSignalName => "RDO1",
     OutTemp => RDO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO1, TRUE),
	       1 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO1, TRUE),
	       2 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO1, TRUE),
	       3 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO1, TRUE),
	       4 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO1, TRUE)),
      GlitchData => RDO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL DCE16X2Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity DCE16X2Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "DCE16X2Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD0 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD1 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD2 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD3 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
	tpd_CK_DO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD0_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD1_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD2_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD3_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_CK_RDO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_RDO0    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD0_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD1_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD2_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD3_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_CK_RDO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_RDO1    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        RAD0 : IN STD_LOGIC;
        RAD1 : IN STD_LOGIC;
        RAD2 : IN STD_LOGIC;
        RAD3 : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        RDO0 : OUT STD_LOGIC;
        RDO1 : OUT STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of DCE16X2Z : entity is TRUE;
 
end DCE16X2Z;


-- architecture body --
architecture V OF DCE16X2Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal RAD0_ipd : STD_LOGIC := 'X';
   signal RAD1_ipd : STD_LOGIC := 'X';
   signal RAD2_ipd : STD_LOGIC := 'X';
   signal RAD3_ipd : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(RAD0_ipd, RAD0, tipd_RAD0);
   VitalWireDelay(RAD1_ipd, RAD1, tipd_RAD1);
   VitalWireDelay(RAD2_ipd, RAD2, tipd_RAD2);
   VitalWireDelay(RAD3_ipd, RAD3, tipd_RAD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, TRI_ipd, AD0_ipd, 
			    AD1_ipd, AD2_ipd, AD3_ipd, RAD0_ipd, RAD1_ipd, 
			    RAD2_ipd, RAD3_ipd, DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(1 downto 0) := "00";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS RDO0_zd    : STD_ULOGIC is Results(2);
     ALIAS RDO1_zd    : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData  : VitalGlitchDataType;
     VARIABLE DO1_GlitchData  : VitalGlitchDataType;
     VARIABLE RDO0_GlitchData : VitalGlitchDataType;
     VARIABLE RDO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_AD0 OR Tviol_AD1 OR 
		Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN OR Tviol_WPE OR 
		Tviol_CK;

   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "DCE16X2Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "DCE16X2Z MEMORY HAZARD WRITE ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(RAD0_ipd) OR IS_X(RAD1_ipd) OR IS_X(RAD2_ipd) 
	OR IS_X(RAD3_ipd)) THEN
      assert false 
	report "DCE16X2Z MEMORY HAZARD READ ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN 
         wren_reg := WREN_ipd;
         wpe_reg := WPE_ipd;
	 din_reg := (DI1_ipd, DI0_ipd);
	 wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (RAD3_ipd, RAD2_ipd, RAD1_ipd, RAD0_ipd);
      rindex := CONV_INTEGER(radr_reg);

      -- At the rising edge of CK, write to memory at address 
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 Results(1 downto 0) := memory(windex);
	 IF (TRI_ipd = '1') THEN
	    Results(3 downto 2) := (others => 'Z');
	 ELSE
	    Results(3 downto 2) := memory(rindex);
	 END IF;
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01Z ( 
     OutSignal => RDO0,
     OutSignalName => "RDO0",
     OutTemp => RDO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO0, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_RDO0, TRUE),
	       2 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO0, TRUE),
	       3 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO0, TRUE),
	       4 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO0, TRUE),
	       5 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO0, TRUE)),
      GlitchData => RDO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => RDO1,
     OutSignalName => "RDO1",
     OutTemp => RDO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO1, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_RDO1, TRUE),
	       2 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO1, TRUE),
	       3 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO1, TRUE),
	       4 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO1, TRUE),
	       5 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO1, TRUE)),
      GlitchData => RDO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- CELL DCF16X2 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity DCF16X2 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "DCF16X2";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD0 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD1 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD2 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD3 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN     : VitalDelayType := 0.1 ns;
        tpw_WREN	 : VitalDelayType := 0.1 ns;
        tperiod_WPE      : VitalDelayType := 0.1 ns;
        tpw_WPE		 : VitalDelayType := 0.1 ns;
        tperiod_CK       : VitalDelayType := 0.1 ns;
        tpw_CK		 : VitalDelayType := 0.1 ns;

        -- Propagation Delays
	tpd_CK_DO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD0_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD1_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD2_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD3_RDO0   : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_RDO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD0_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD1_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD2_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD3_RDO1   : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_RDO1	: VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        RAD0 : IN STD_LOGIC;
        RAD1 : IN STD_LOGIC;
        RAD2 : IN STD_LOGIC;
        RAD3 : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        RDO0 : OUT STD_LOGIC;
        RDO1 : OUT STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of DCF16X2 : entity is TRUE;
 
end DCF16X2;


-- architecture body --
architecture V OF DCF16X2 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal RAD0_ipd : STD_LOGIC := 'X';
   signal RAD1_ipd : STD_LOGIC := 'X';
   signal RAD2_ipd : STD_LOGIC := 'X';
   signal RAD3_ipd : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(RAD0_ipd, RAD0, tipd_RAD0);
   VitalWireDelay(RAD1_ipd, RAD1, tipd_RAD1);
   VitalWireDelay(RAD2_ipd, RAD2, tipd_RAD2);
   VitalWireDelay(RAD3_ipd, RAD3, tipd_RAD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, AD0_ipd, AD1_ipd, 
			    AD2_ipd, AD3_ipd, RAD0_ipd, RAD1_ipd, RAD2_ipd, 
			    RAD3_ipd, DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(1 downto 0) := "00";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS RDO0_zd    : STD_ULOGIC is Results(2);
     ALIAS RDO1_zd    : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData  : VitalGlitchDataType;
     VARIABLE DO1_GlitchData  : VitalGlitchDataType;
     VARIABLE RDO0_GlitchData : VitalGlitchDataType;
     VARIABLE RDO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_AD0 OR Tviol_AD1 OR 
		Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN OR Tviol_WPE OR 
		Tviol_CK;

   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "DCF16X2 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "DCF16X2 MEMORY HAZARD WRITE ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(RAD0_ipd) OR IS_X(RAD1_ipd) OR IS_X(RAD2_ipd) 
	OR IS_X(RAD3_ipd)) THEN
      assert false 
	report "DCF16X2 MEMORY HAZARD READ ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN 
         wren_reg := WREN_ipd;
         wpe_reg := WPE_ipd;
	 din_reg := (DI1_ipd, DI0_ipd);
	 wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (RAD3_ipd, RAD2_ipd, RAD1_ipd, RAD0_ipd);
      rindex := CONV_INTEGER(radr_reg);

      -- At the rising edge of CK, write to memory at address 
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 Results(3 downto 2) := memory(rindex);
	 Results(1 downto 0) := memory(windex);
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => RDO0,
     OutSignalName => "RDO0",
     OutTemp => RDO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO0, TRUE),
	       1 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO0, TRUE),
	       2 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO0, TRUE),
	       3 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO0, TRUE),
	       4 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO0, TRUE)),
      GlitchData => RDO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => RDO1,
     OutSignalName => "RDO1",
     OutTemp => RDO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO1, TRUE),
	       1 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO1, TRUE),
	       2 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO1, TRUE),
	       3 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO1, TRUE),
	       4 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO1, TRUE)),
      GlitchData => RDO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL DCF16X2Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity DCF16X2Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "DCF16X2Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD0 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD1 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD2 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_RAD3 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
	tpd_CK_DO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_RAD0_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD1_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD2_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD3_RDO0   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_CK_RDO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_RDO0    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD0_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD1_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD2_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_RAD3_RDO1   : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_CK_RDO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_RDO1    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        RAD0 : IN STD_LOGIC;
        RAD1 : IN STD_LOGIC;
        RAD2 : IN STD_LOGIC;
        RAD3 : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        RDO0 : OUT STD_LOGIC;
        RDO1 : OUT STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of DCF16X2Z : entity is TRUE;
 
end DCF16X2Z;


-- architecture body --
architecture V OF DCF16X2Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal RAD0_ipd : STD_LOGIC := 'X';
   signal RAD1_ipd : STD_LOGIC := 'X';
   signal RAD2_ipd : STD_LOGIC := 'X';
   signal RAD3_ipd : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(RAD0_ipd, RAD0, tipd_RAD0);
   VitalWireDelay(RAD1_ipd, RAD1, tipd_RAD1);
   VitalWireDelay(RAD2_ipd, RAD2, tipd_RAD2);
   VitalWireDelay(RAD3_ipd, RAD3, tipd_RAD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, TRI_ipd, AD0_ipd, 
			    AD1_ipd, AD2_ipd, AD3_ipd, RAD0_ipd, RAD1_ipd, 
			    RAD2_ipd, RAD3_ipd, DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(1 downto 0) := "00";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS RDO0_zd    : STD_ULOGIC is Results(2);
     ALIAS RDO1_zd    : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData  : VitalGlitchDataType;
     VARIABLE DO1_GlitchData  : VitalGlitchDataType;
     VARIABLE RDO0_GlitchData : VitalGlitchDataType;
     VARIABLE RDO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_AD0 OR Tviol_AD1 OR 
		Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN OR Tviol_WPE OR 
		Tviol_CK;

   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "DCF16X2Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "DCF16X2Z MEMORY HAZARD WRITE ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(RAD0_ipd) OR IS_X(RAD1_ipd) OR IS_X(RAD2_ipd) 
	OR IS_X(RAD3_ipd)) THEN
      assert false 
	report "DCF16X2Z MEMORY HAZARD READ ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN 
         wren_reg := WREN_ipd;
         wpe_reg := WPE_ipd;
	 din_reg := (DI1_ipd, DI0_ipd);
	 wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (RAD3_ipd, RAD2_ipd, RAD1_ipd, RAD0_ipd);
      rindex := CONV_INTEGER(radr_reg);

      -- At the rising edge of CK, write to memory at address 
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 Results(1 downto 0) := memory(windex);
	 IF (TRI_ipd = '1') THEN
	    Results(3 downto 2) := (others => 'Z');
	 ELSE
	    Results(3 downto 2) := memory(rindex);
	 END IF;
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01Z ( 
     OutSignal => RDO0,
     OutSignalName => "RDO0",
     OutTemp => RDO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO0, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_RDO0, TRUE),
	       2 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO0, TRUE),
	       3 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO0, TRUE),
	       4 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO0, TRUE),
	       5 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO0, TRUE)),
      GlitchData => RDO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => RDO1,
     OutSignalName => "RDO1",
     OutTemp => RDO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_RDO1, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_RDO1, TRUE),
	       2 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_RDO1, TRUE),
	       3 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_RDO1, TRUE),
	       4 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_RDO1, TRUE),
	       5 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_RDO1, TRUE)),
      GlitchData => RDO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- CELL RCE16X4 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RCE16X4 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RCE16X4";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI2_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI3_CK_negedge : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI3_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_AD0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO2	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO3	: VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RCE16X4 : entity is TRUE;
 
end RCE16X4;


-- architecture body --
architecture V OF RCE16X4 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, AD0_ipd, AD1_ipd, 
			    AD2_ipd, AD3_ipd, DI0_ipd, DI1_ipd, DI2_ipd, 
			    DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI3_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI2_CK_negedge, 
		SetupLow => tsetup_DI2_CK_negedge,
                HoldHigh => thold_CK_DI2_negedge, 
		HoldLow => thold_CK_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_CK_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI3_CK_negedge, 
		SetupLow => tsetup_DI3_CK_negedge,
                HoldHigh => thold_CK_DI3_negedge, 
		HoldLow => thold_CK_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_CK_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
		Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR 
		Tviol_WREN OR Tviol_WPE OR Tviol_CK;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RCE16X4 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RCE16X4 MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN 
         wren_reg := WREN_ipd;
         wpe_reg := WPE_ipd;
	 din_reg := (DI3_ipd, DI2_ipd, DI1_ipd, DI0_ipd);
	 wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      rindex := CONV_INTEGER(radr_reg);

      -- At the rising edge of CK, write to memory at address 
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 Results := memory(rindex);
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO2, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO3, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL RCE16X4Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RCE16X4Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RCE16X4Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge  : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge  : VitalDelayType := 0.1 ns;
        tsetup_DI2_CK_negedge  : VitalDelayType := 0.1 ns;
        tsetup_DI3_CK_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI2_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI3_negedge   : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_AD0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO0	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO2	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO3	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RCE16X4Z : entity is TRUE;
 
end RCE16X4Z;


-- architecture body --
architecture V OF RCE16X4Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, TRI_ipd, AD0_ipd, 
			    AD1_ipd, AD2_ipd, AD3_ipd, DI0_ipd, DI1_ipd, 
			    DI2_ipd, DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI3_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI2_CK_negedge, 
		SetupLow => tsetup_DI2_CK_negedge,
                HoldHigh => thold_CK_DI2_negedge, 
		HoldLow => thold_CK_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_CK_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI3_CK_negedge, 
		SetupLow => tsetup_DI3_CK_negedge,
                HoldHigh => thold_CK_DI3_negedge, 
		HoldLow => thold_CK_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_CK_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
		Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR 
		Tviol_WREN OR Tviol_WPE OR Tviol_CK;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RCE16X4Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RCE16X4Z MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN
         wren_reg := WREN_ipd;
         wpe_reg := WPE_ipd;
	 din_reg := (DI3_ipd, DI2_ipd, DI1_ipd, DI0_ipd);
         wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      rindex := CONV_INTEGER(radr_reg);
 
      -- At the rising edge of CK, write to memory at address
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 IF (TRI_ipd = '1') THEN
	    Results := (others => 'Z');
	 ELSE 
	    Results := memory(rindex);
	 END IF;
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01Z ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO0, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO1, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO2, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO2, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO3, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO3, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- CELL RCF16X4 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RCF16X4 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RCF16X4";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI2_CK_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI3_CK_negedge : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI2_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_DI3_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_AD0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO2	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_CK_DO3	: VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RCF16X4 : entity is TRUE;
 
end RCF16X4;


-- architecture body --
architecture V OF RCF16X4 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, AD0_ipd, AD1_ipd, 
			    AD2_ipd, AD3_ipd, DI0_ipd, DI1_ipd, DI2_ipd, 
			    DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI3_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI2_CK_negedge, 
		SetupLow => tsetup_DI2_CK_negedge,
                HoldHigh => thold_CK_DI2_negedge, 
		HoldLow => thold_CK_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_CK_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI3_CK_negedge, 
		SetupLow => tsetup_DI3_CK_negedge,
                HoldHigh => thold_CK_DI3_negedge, 
		HoldLow => thold_CK_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_CK_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
		Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR 
		Tviol_WREN OR Tviol_WPE OR Tviol_CK;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RCF16X4 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RCF16X4 MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN 
         wren_reg := WREN_ipd;
         wpe_reg := WPE_ipd;
	 din_reg := (DI3_ipd, DI2_ipd, DI1_ipd, DI0_ipd);
	 wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      rindex := CONV_INTEGER(radr_reg);

      -- At the rising edge of CK, write to memory at address 
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 Results := memory(rindex);
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO2, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (CK_ipd'LAST_EVENT, tpd_CK_DO3, TRUE),
	       1 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       2 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       3 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	       4 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL RCF16X4Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RCF16X4Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RCF16X4Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK   : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_AD1_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_AD2_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_AD3_CK_posedge  : VitalDelayType := 0.1 ns;
        tsetup_DI0_CK_negedge  : VitalDelayType := 0.1 ns;
        tsetup_DI1_CK_negedge  : VitalDelayType := 0.1 ns;
        tsetup_DI2_CK_negedge  : VitalDelayType := 0.1 ns;
        tsetup_DI3_CK_negedge  : VitalDelayType := 0.1 ns;
        thold_CK_AD0_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_AD1_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_AD2_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_AD3_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI0_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI1_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI2_negedge   : VitalDelayType := 0.1 ns;
        thold_CK_DI3_negedge   : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_AD0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO0	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO1	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO2	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
	tpd_CK_DO3	: VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        CK   : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RCF16X4Z : entity is TRUE;
 
end RCF16X4Z;


-- architecture body --
architecture V OF RCF16X4Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';
   signal CK_ipd   : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   VitalWireDelay(CK_ipd, CK, tipd_CK);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (CK_ipd, WREN_ipd, WPE_ipd, TRI_ipd, AD0_ipd, 
			    AD1_ipd, AD2_ipd, AD3_ipd, DI0_ipd, DI1_ipd, 
			    DI2_ipd, DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE din_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE wren_reg, wpe_reg : STD_LOGIC := '0';
     VARIABLE rindex, windex : INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE Tviol_CK   : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_CK   : VitalPeriodDataType;
     VARIABLE AD0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE AD3_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI0_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI1_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI2_CK_TimingDataSH  : VitalTimingDataType;
     VARIABLE DI3_CK_TimingDataSH  : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD0_CK_posedge, 
		SetupLow => tsetup_AD0_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD0_negedge, 
		HoldLow => thold_CK_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_CK_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD1_CK_posedge, 
		SetupLow => tsetup_AD1_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD1_negedge, 
		HoldLow => thold_CK_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_CK_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD2_CK_posedge, 
		SetupLow => tsetup_AD2_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD2_negedge, 
		HoldLow => thold_CK_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_CK_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_AD3_CK_posedge, 
		SetupLow => tsetup_AD3_CK_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_CK_AD3_negedge, 
		HoldLow => thold_CK_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_CK_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI0_CK_negedge, 
		SetupLow => tsetup_DI0_CK_negedge,
                HoldHigh => thold_CK_DI0_negedge, 
		HoldLow => thold_CK_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI1_CK_negedge, 
		SetupLow => tsetup_DI1_CK_negedge,
                HoldHigh => thold_CK_DI1_negedge, 
		HoldLow => thold_CK_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_CK_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI2_CK_negedge, 
		SetupLow => tsetup_DI2_CK_negedge,
                HoldHigh => thold_CK_DI2_negedge, 
		HoldLow => thold_CK_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_CK_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => CK_ipd, RefSignalName => "CK",
                SetupHigh => tsetup_DI3_CK_negedge, 
		SetupLow => tsetup_DI3_CK_negedge,
                HoldHigh => thold_CK_DI3_negedge, 
		HoldLow => thold_CK_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_CK_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => CK_ipd, TestSignalName => "CK", 
               Period => tperiod_CK,
               PulseWidthHigh => tpw_CK, 
               PulseWidthLow => tpw_CK, 
               PeriodData => PeriodCheckInfo_CK, Violation => Tviol_CK, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WREN_ipd, TestSignalName => "WREN", 
               Period => tperiod_WREN,
               PulseWidthHigh => tpw_WREN, 
               PulseWidthLow => tpw_WREN, 
               PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);
           VitalPeriodPulseCheck (
               TestSignal => WPE_ipd, TestSignalName => "WPE", 
               Period => tperiod_WPE,
               PulseWidthHigh => tpw_WPE, 
               PulseWidthLow => tpw_WPE, 
               PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
		Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR 
		Tviol_WREN OR Tviol_WPE OR Tviol_CK;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RCF16X4Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RCF16X4Z MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      -- Latch the write address, write enables and data but not the 
      -- read address
      IF (CK_ipd = '0') THEN
         wren_reg := WREN_ipd;
         wpe_reg := WPE_ipd;
	 din_reg := (DI3_ipd, DI2_ipd, DI1_ipd, DI0_ipd);
         wadr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      END IF;
      windex := CONV_INTEGER(wadr_reg);
      radr_reg := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      rindex := CONV_INTEGER(radr_reg);
 
      -- At the rising edge of CK, write to memory at address
      IF (wren_reg = '1' AND wpe_reg = '1') THEN
	 IF (CK_ipd'EVENT AND CK_ipd = '1') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- Asynchronous read
      IF (Violation = '0') THEN
	 IF (TRI_ipd = '1') THEN
	    Results := (others => 'Z');
	 ELSE 
	    Results := memory(rindex);
	 END IF;
      ELSE 
         Results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01Z ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO0, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO0, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO1, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO1, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO2, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO2, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO3, TRUE),
	       1 => (CK_ipd'LAST_EVENT, tpd_CK_DO3, TRUE),
	       2 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       3 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       4 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	       5 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- CELL RPE16X2 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPE16X2 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPE16X2";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WPE_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WPE_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPE16X2 : entity is TRUE;
 
end RPE16X2;


-- architecture body --
architecture V OF RPE16X2 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, WPE_ipd, AD0_ipd, AD1_ipd, AD2_ipd, 
			    AD3_ipd, DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE   : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (1 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write enable and port enable
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
            TestSignal => WPE_ipd, TestSignalName => "WPE", 
            Period => tperiod_WPE,
            PulseWidthHigh => tpw_WPE, 
            PulseWidthLow => tpw_WPE, 
            PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI0 OR Tviol_AD0 OR Tviol_AD1 OR 
			Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN OR Tviol_WPE;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RPE16X2 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPE16X2 MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1' AND WPE_ipd = '1') THEN
	 memory(index) := (DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 Results := memory(index);
      ELSE 
	 Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO0, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       4 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       5 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       6 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       7 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO1, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       4 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       5 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       6 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       7 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL RPE16X2Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPE16X2Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPE16X2Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WPE_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WPE_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPE16X2Z : entity is TRUE;
 
end RPE16X2Z;


-- architecture body --
architecture V OF RPE16X2Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, WPE_ipd, TRI_ipd, AD0_ipd, AD1_ipd, 
			    AD2_ipd, AD3_ipd, DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE   : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (1 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write enable and port enable
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
            TestSignal => WPE_ipd, TestSignalName => "WPE", 
            Period => tperiod_WPE,
            PulseWidthHigh => tpw_WPE, 
            PulseWidthLow => tpw_WPE, 
            PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI0 OR Tviol_AD0 OR Tviol_AD1 OR 
			Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN OR Tviol_WPE;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RPE16X2Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPE16X2Z MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1' AND WPE_ipd = '1') THEN
	 memory(index) := (DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 IF (TRI_ipd = '1') THEN
	    Results := (others => 'Z');
	 ELSE 
	    Results := memory(index);
	 END IF;
      ELSE 
	 Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01Z ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO0, TRUE),
	       2 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO0, TRUE),
	       3 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       4 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       5 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       6 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       7 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       8 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO1, TRUE),
	       2 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO1, TRUE),
	       3 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       4 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       5 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       6 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       7 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       8 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- CELL RPE16X4 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPE16X4 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPE16X4";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI2_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI3_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI3_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WPE_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WPE_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO2    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WPE_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO3    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WPE_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPE16X4 : entity is TRUE;
 
end RPE16X4;


-- architecture body --
architecture V OF RPE16X4 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, WPE_ipd, AD0_ipd, AD1_ipd, AD2_ipd, 
			    AD3_ipd, DI0_ipd, DI1_ipd, DI2_ipd, DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE   : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI3_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI2_WREN_negedge, 
		SetupLow => tsetup_DI2_WREN_negedge,
                HoldHigh => thold_WREN_DI2_negedge, 
		HoldLow => thold_WREN_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_WREN_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI3_WREN_negedge, 
		SetupLow => tsetup_DI3_WREN_negedge,
                HoldHigh => thold_WREN_DI3_negedge, 
		HoldLow => thold_WREN_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_WREN_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
            TestSignal => WPE_ipd, TestSignalName => "WPE", 
            Period => tperiod_WPE,
            PulseWidthHigh => tpw_WPE, 
            PulseWidthLow => tpw_WPE, 
            PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
		Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR 
		Tviol_WREN OR Tviol_WPE;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RPE16X4 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPE16X4 MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1' AND WPE_ipd = '1') THEN
	 memory(index) := (DI3, DI2, DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 Results := memory(index);
      ELSE 
         Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO0, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO0, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO0, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO1, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO1, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO1, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO2, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO2, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO2, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO2, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO2, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO2, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO3, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO3, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO3, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO3, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO3, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO3, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL RPE16X4Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPE16X4Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPE16X4Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WPE  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI2_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI3_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI3_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;
        tperiod_WPE     : VitalDelayType := 0.1 ns;
        tpw_WPE		: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WPE_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WPE_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO2    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WPE_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO3    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WPE_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        WPE  : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPE16X4Z : entity is TRUE;
 
end RPE16X4Z;


-- architecture body --
architecture V OF RPE16X4Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal WPE_ipd  : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, WPE_ipd, TRI_ipd, AD0_ipd, AD1_ipd, 
			    AD2_ipd, AD3_ipd, DI0_ipd, DI1_ipd, DI2_ipd, 
			    DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE Tviol_WPE  : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_WPE   : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI3_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI2_WREN_negedge, 
		SetupLow => tsetup_DI2_WREN_negedge,
                HoldHigh => thold_WREN_DI2_negedge, 
		HoldLow => thold_WREN_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_WREN_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI3_WREN_negedge, 
		SetupLow => tsetup_DI3_WREN_negedge,
                HoldHigh => thold_WREN_DI3_negedge, 
		HoldLow => thold_WREN_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_WREN_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write and port enables
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);
        VitalPeriodPulseCheck (
            TestSignal => WPE_ipd, TestSignalName => "WPE", 
            Period => tperiod_WPE,
            PulseWidthHigh => tpw_WPE, 
            PulseWidthLow => tpw_WPE, 
            PeriodData => PeriodCheckInfo_WPE, Violation => Tviol_WPE, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
		Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR 
		Tviol_WREN OR Tviol_WPE;
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "RPE16X4Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPE16X4Z MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1' AND WPE_ipd = '1') THEN
	 memory(index) := (DI3, DI2, DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 IF (TRI_ipd = '1') THEN
	    Results := (others => 'Z');
	 ELSE 
	    Results := memory(index);
	 END IF;
      ELSE 
         Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01Z ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO0, TRUE),
	       2 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO0, TRUE),
	       3 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       4 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       5 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO0, TRUE),
	       6 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO0, TRUE),
	       7 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       8 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       9 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	      10 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO1, TRUE),
	       2 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO1, TRUE),
	       3 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       4 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       5 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO1, TRUE),
	       6 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO1, TRUE),
	       7 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       8 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       9 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	      10 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO2, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO2, TRUE),
	       2 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO2, TRUE),
	       3 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO2, TRUE),
	       4 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO2, TRUE),
	       5 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO2, TRUE),
	       6 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO2, TRUE),
	       7 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       8 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       9 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	      10 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO3, TRUE),
	       1 => (WPE_ipd'LAST_EVENT, tpd_WPE_DO3, TRUE),
	       2 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO3, TRUE),
	       3 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO3, TRUE),
	       4 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO3, TRUE),
	       5 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO3, TRUE),
	       6 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO3, TRUE),
	       7 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       8 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       9 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	      10 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- CELL RPP16X2 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPP16X2 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPP16X2";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPP16X2 : entity is TRUE;
 
end RPP16X2;


-- architecture body --
architecture V OF RPP16X2 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, AD0_ipd, AD1_ipd, AD2_ipd, AD3_ipd, 
			    DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (1 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write enable
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI0 OR Tviol_AD0 OR Tviol_AD1 OR 
			Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN;
   IF (IS_X(WREN_ipd)) THEN
      assert false
        report "RPP16X2 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPP16X2 MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1') THEN
	 memory(index) := (DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 Results := memory(index);
      ELSE 
	 Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       2 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       3 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       4 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       5 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       6 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       2 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       3 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       4 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       5 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       6 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL RPP16X2Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPP16X2Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPP16X2Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPP16X2Z : entity is TRUE;
 
end RPP16X2Z;


-- architecture body --
architecture V OF RPP16X2Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, TRI_ipd, AD0_ipd, AD1_ipd, AD2_ipd, 
			    AD3_ipd, DI0_ipd, DI1_ipd)

     VARIABLE memory : mem_type_2 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (1 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);

	   -- period and pulse width checks on write enable
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI0 OR Tviol_AD0 OR Tviol_AD1 OR 
			Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN;
   IF (IS_X(WREN_ipd)) THEN
      assert false
        report "RPP16X2Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPP16X2Z MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1') THEN
	 memory(index) := (DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 IF (TRI_ipd = '1') THEN
	    Results := (others => 'Z');
	 ELSE 
	    Results := memory(index);
	 END IF;
      ELSE 
         Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01Z ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO0, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       4 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       5 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       6 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       7 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO1, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       4 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       5 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       6 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       7 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- CELL RPP16X4 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPP16X4 is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPP16X4";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI2_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI3_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI3_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO2    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI0_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI1_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI2_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_DI3_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_WREN_DO3    : VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPP16X4 : entity is TRUE;
 
end RPP16X4;


-- architecture body --
architecture V OF RPP16X4 IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, AD0_ipd, AD1_ipd, AD2_ipd, AD3_ipd, 
			    DI0_ipd, DI1_ipd, DI2_ipd, DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI3_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI2_WREN_negedge, 
		SetupLow => tsetup_DI2_WREN_negedge,
                HoldHigh => thold_WREN_DI2_negedge, 
		HoldLow => thold_WREN_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_WREN_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI3_WREN_negedge, 
		SetupLow => tsetup_DI3_WREN_negedge,
                HoldHigh => thold_WREN_DI3_negedge, 
		HoldLow => thold_WREN_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_WREN_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write enable
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
	Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN;
   IF (IS_X(WREN_ipd)) THEN
      assert false
        report "RPP16X4 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPP16X4 MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1') THEN
	 memory(index) := (DI3, DI2, DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 Results := memory(index);
      ELSE 
         Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       2 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       3 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO0, TRUE),
	       4 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO0, TRUE),
	       5 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       6 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       7 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       8 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       2 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       3 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO1, TRUE),
	       4 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO1, TRUE),
	       5 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       6 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       7 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       8 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO2, TRUE),
	       1 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO2, TRUE),
	       2 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO2, TRUE),
	       3 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO2, TRUE),
	       4 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO2, TRUE),
	       5 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       6 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       7 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	       8 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO3, TRUE),
	       1 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO3, TRUE),
	       2 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO3, TRUE),
	       3 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO3, TRUE),
	       4 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO3, TRUE),
	       5 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       6 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       7 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	       8 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn);

   end process;

end V;


--
----- CELL RPP16X4Z -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.MEM.all;

-- entity declaration --
entity RPP16X4Z is
  generic (
	initval : String := "0x0000000000000000"; 

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "RPP16X4Z";

        -- Input Signal Delays
        tipd_AD0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_AD3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_DI3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_WREN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TRI  : VitalDelayType01 := (0.1 ns, 0.1 ns);

        -- Setup and Hold Constraints
        tsetup_AD0_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD1_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD2_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_AD3_WREN_posedge : VitalDelayType := 0.1 ns;
        tsetup_DI0_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI1_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI2_WREN_negedge : VitalDelayType := 0.1 ns;
        tsetup_DI3_WREN_negedge : VitalDelayType := 0.1 ns;
        thold_WREN_AD0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_AD3_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI0_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI1_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI2_negedge  : VitalDelayType := 0.1 ns;
        thold_WREN_DI3_negedge  : VitalDelayType := 0.1 ns;

        -- Pulse Width Constraints
        tperiod_WREN    : VitalDelayType := 0.1 ns;
        tpw_WREN	: VitalDelayType := 0.1 ns;

        -- Propagation Delays
        tpd_DI0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO0    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO0     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO1    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO1     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO2     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO2    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI0_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI1_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI2_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_DI3_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD0_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD1_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD2_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_AD3_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_TRI_DO3     : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
        tpd_WREN_DO3    : VitalDelayType01Z := 
		(0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns));

  port (DI0  : IN STD_LOGIC;
	DI1  : IN STD_LOGIC;
	DI2  : IN STD_LOGIC;
	DI3  : IN STD_LOGIC;
        AD0  : IN STD_LOGIC;
        AD1  : IN STD_LOGIC;
        AD2  : IN STD_LOGIC;
        AD3  : IN STD_LOGIC;
        WREN : IN STD_LOGIC;
        TRI  : IN STD_LOGIC;
        DO0  : OUT STD_LOGIC;
        DO1  : OUT STD_LOGIC;
        DO2  : OUT STD_LOGIC;
        DO3  : OUT STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RPP16X4Z : entity is TRUE;
 
end RPP16X4Z;


-- architecture body --
architecture V OF RPP16X4Z IS
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

   signal DI0_ipd  : STD_LOGIC := 'X';
   signal DI1_ipd  : STD_LOGIC := 'X';
   signal DI2_ipd  : STD_LOGIC := 'X';
   signal DI3_ipd  : STD_LOGIC := 'X';
   signal AD0_ipd  : STD_LOGIC := 'X';
   signal AD1_ipd  : STD_LOGIC := 'X';
   signal AD2_ipd  : STD_LOGIC := 'X';
   signal AD3_ipd  : STD_LOGIC := 'X';
   signal WREN_ipd : STD_LOGIC := 'X';
   signal TRI_ipd  : STD_LOGIC := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(DI0_ipd, DI0, tipd_DI0);
   VitalWireDelay(DI1_ipd, DI1, tipd_DI1);
   VitalWireDelay(DI2_ipd, DI2, tipd_DI2);
   VitalWireDelay(DI3_ipd, DI3, tipd_DI3);
   VitalWireDelay(AD0_ipd, AD0, tipd_AD0);
   VitalWireDelay(AD1_ipd, AD1, tipd_AD1);
   VitalWireDelay(AD2_ipd, AD2, tipd_AD2);
   VitalWireDelay(AD3_ipd, AD3, tipd_AD3);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(TRI_ipd, TRI, tipd_TRI);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WREN_ipd, TRI_ipd, AD0_ipd, AD1_ipd, AD2_ipd, 
			    AD3_ipd, DI0_ipd, DI1_ipd, DI2_ipd, DI3_ipd)

     VARIABLE memory : mem_type_4 ((2**4)-1 downto 0) := init_ram(initval);
     VARIABLE temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
     VARIABLE index: INTEGER := 0;

     -- Timing Check Results
     VARIABLE Tviol_DI0  : X01 := '0';
     VARIABLE Tviol_DI1  : X01 := '0';
     VARIABLE Tviol_DI2  : X01 := '0';
     VARIABLE Tviol_DI3  : X01 := '0';
     VARIABLE Tviol_AD0  : X01 := '0';
     VARIABLE Tviol_AD1  : X01 := '0';
     VARIABLE Tviol_AD2  : X01 := '0';
     VARIABLE Tviol_AD3  : X01 := '0';
     VARIABLE Tviol_WREN : X01 := '0';
     VARIABLE PeriodCheckInfo_WREN  : VitalPeriodDataType;
     VARIABLE AD0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE AD3_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI0_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI1_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI2_WREN_TimingDataSH : VitalTimingDataType;
     VARIABLE DI3_WREN_TimingDataSH : VitalTimingDataType;

     -- Functionality Results
     VARIABLE Violation : X01 := '0';
     VARIABLE Results : STD_LOGIC_VECTOR (3 downto 0) := (others => 'X');
     ALIAS DO0_zd     : STD_ULOGIC is Results(0);
     ALIAS DO1_zd     : STD_ULOGIC is Results(1);
     ALIAS DO2_zd     : STD_ULOGIC is Results(2);
     ALIAS DO3_zd     : STD_ULOGIC is Results(3);

     -- Output Glitch Results
     VARIABLE DO0_GlitchData : VitalGlitchDataType;
     VARIABLE DO1_GlitchData : VitalGlitchDataType;
     VARIABLE DO2_GlitchData : VitalGlitchDataType;
     VARIABLE DO3_GlitchData : VitalGlitchDataType;

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD0_WREN_posedge, 
		SetupLow => tsetup_AD0_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD0_ipd, TestSignalName => "AD0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD0_negedge, 
		HoldLow => thold_WREN_AD0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD0_WREN_TimingDataSH,
		Violation => Tviol_AD0, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD1_WREN_posedge, 
		SetupLow => tsetup_AD1_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD1_ipd, TestSignalName => "AD1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD1_negedge, 
		HoldLow => thold_WREN_AD1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD1_WREN_TimingDataSH,
		Violation => Tviol_AD1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD2_WREN_posedge, 
		SetupLow => tsetup_AD2_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD2_ipd, TestSignalName => "AD2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD2_negedge, 
		HoldLow => thold_WREN_AD2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD2_WREN_TimingDataSH,
		Violation => Tviol_AD2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_AD3_WREN_posedge, 
		SetupLow => tsetup_AD3_WREN_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => AD3_ipd, TestSignalName => "AD3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
		SetupHigh => 0.1 ns, SetupLow => 0.1 ns,
                HoldHigh => thold_WREN_AD3_negedge, 
		HoldLow => thold_WREN_AD3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => AD3_WREN_TimingDataSH,
		Violation => Tviol_AD3, MsgSeverity => WARNING);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => DI0_ipd, TestSignalName => "DI0", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI0_WREN_negedge, 
		SetupLow => tsetup_DI0_WREN_negedge,
                HoldHigh => thold_WREN_DI0_negedge, 
		HoldLow => thold_WREN_DI0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI0_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI1_ipd, TestSignalName => "DI1", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI1_WREN_negedge, 
		SetupLow => tsetup_DI1_WREN_negedge,
                HoldHigh => thold_WREN_DI1_negedge, 
		HoldLow => thold_WREN_DI1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI1_WREN_TimingDataSH,
		Violation => Tviol_DI1, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI2_ipd, TestSignalName => "DI2", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI2_WREN_negedge, 
		SetupLow => tsetup_DI2_WREN_negedge,
                HoldHigh => thold_WREN_DI2_negedge, 
		HoldLow => thold_WREN_DI2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI2_WREN_TimingDataSH,
		Violation => Tviol_DI2, MsgSeverity => WARNING);
           VitalSetupHoldCheck (
		TestSignal => DI3_ipd, TestSignalName => "DI3", 
		RefSignal => WREN_ipd, RefSignalName => "WREN",
                SetupHigh => tsetup_DI3_WREN_negedge, 
		SetupLow => tsetup_DI3_WREN_negedge,
                HoldHigh => thold_WREN_DI3_negedge, 
		HoldLow => thold_WREN_DI3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => DI3_WREN_TimingDataSH,
		Violation => Tviol_DI3, MsgSeverity => WARNING);

	   -- period and pulse width checks on write enable
        VitalPeriodPulseCheck (
            TestSignal => WREN_ipd, TestSignalName => "WREN", 
            Period => tperiod_WREN,
            PulseWidthHigh => tpw_WREN, 
            PulseWidthLow => tpw_WREN, 
            PeriodData => PeriodCheckInfo_WREN, Violation => Tviol_WREN, 
            MsgOn => MsgOn, XOn => XOn, 
            HeaderMsg => InstancePath, CheckEnabled => TRUE, 
            MsgSeverity => WARNING);

        END IF;

   ------------------------
   -- Functionality Section
   ------------------------
   Violation := Tviol_DI0 OR Tviol_DI1 OR Tviol_DI2 OR Tviol_DI3 OR 
	Tviol_AD0 OR Tviol_AD1 OR Tviol_AD2 OR Tviol_AD3 OR Tviol_WREN;
   IF (IS_X(WREN_ipd)) THEN
      assert false
        report "RPP16X4Z MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      Results := (others => 'X');
   ELSIF (IS_X(AD0_ipd) OR IS_X(AD1_ipd) OR IS_X(AD2_ipd) 
	OR IS_X(AD3_ipd)) THEN
      assert false 
	report "RPP16X4Z MEMORY HAZARD ADDRESS UNKNOWN!"
	severity WARNING;
      Results := (others => 'X');
   ELSE
      temp := (AD3_ipd, AD2_ipd, AD1_ipd, AD0_ipd);
      index := CONV_INTEGER(temp);
      IF (WREN_ipd = '1') THEN
	 memory(index) := (DI3, DI2, DI1, DI0);
      END IF;
      IF (Violation = '0') THEN
	 IF (TRI_ipd = '1') THEN
	    Results := (others => 'Z');
	 ELSE 
	    Results := memory(index);
	 END IF;
      ELSE 
         Results := (others => 'X');
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01Z ( 
     OutSignal => DO0,
     OutSignalName => "DO0",
     OutTemp => DO0_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO0, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO0, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO0, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO0, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO0, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO0, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO0, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO0, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO0, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO0, TRUE)),
      GlitchData => DO0_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO1,
     OutSignalName => "DO1",
     OutTemp => DO1_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO1, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO1, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO1, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO1, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO1, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO1, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO1, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO1, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO1, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO1, TRUE)),
      GlitchData => DO1_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO2,
     OutSignalName => "DO2",
     OutTemp => DO2_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO2, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO2, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO2, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO2, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO2, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO2, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO2, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO2, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO2, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO2, TRUE)),
      GlitchData => DO2_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");
   VitalPathDelay01Z ( 
     OutSignal => DO3,
     OutSignalName => "DO3",
     OutTemp => DO3_zd,
     Paths => (0 => (WREN_ipd'LAST_EVENT, tpd_WREN_DO3, TRUE),
	       1 => (TRI_ipd'LAST_EVENT, tpd_TRI_DO3, TRUE),
	       2 => (DI0_ipd'LAST_EVENT, tpd_DI0_DO3, TRUE),
	       3 => (DI1_ipd'LAST_EVENT, tpd_DI1_DO3, TRUE),
	       4 => (DI2_ipd'LAST_EVENT, tpd_DI2_DO3, TRUE),
	       5 => (DI3_ipd'LAST_EVENT, tpd_DI3_DO3, TRUE),
	       6 => (AD0_ipd'LAST_EVENT, tpd_AD0_DO3, TRUE),
	       7 => (AD1_ipd'LAST_EVENT, tpd_AD1_DO3, TRUE),
	       8 => (AD2_ipd'LAST_EVENT, tpd_AD2_DO3, TRUE),
	       9 => (AD3_ipd'LAST_EVENT, tpd_AD3_DO3, TRUE)),
      GlitchData => DO3_GlitchData,
      Mode => OnDetect,
      XOn => XOn, MsgOn => MsgOn, OutputMap => "UX01ZWHL-");

   end process;

end V;


--
----- cell rom16x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom16x1 IS
  GENERIC (
        initval : string := "0x0000";
 
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "rom16x1";
 
        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_ad1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_ad2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_ad3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
 
 
        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom16x1 : ENTITY IS TRUE;
 
END rom16x1;
 
-- architecture body --
ARCHITECTURE v OF rom16x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
 
BEGIN
 
   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   END BLOCK;
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd)

     VARIABLE memory   : std_logic_vector((2**4)-1 downto 0) := hex2bin(initval);

     -- functionality results
     VARIABLE do0_zd : std_logic :='X';

     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;

BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0_zd := VitalMUX (data => memory,
                         dselect => (ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd));

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
               1 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
               2 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
               3 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn,
      MsgOn => MsgOn);

   end process;

end V;



--
----- cell rom32x1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem2.all;
 
-- entity declaration --
ENTITY rom32x1 IS
  GENERIC (
        initval : string := "0x00000000";
 
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "rom32x1";
 
        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_ad1  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_ad2  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_ad3  : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_ad4  : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
 
 
        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
  port (ad0  : IN   std_logic;
        ad1  : IN   std_logic;
        ad2  : IN   std_logic;
        ad3  : IN   std_logic;
        ad4  : IN   std_logic;
        do0   : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom32x1 : ENTITY IS TRUE;
 
END rom32x1;
 
-- architecture body --
ARCHITECTURE v OF rom32x1 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
   SIGNAL ad4_ipd  : std_logic := 'X';
 
BEGIN
 
   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   VitalWireDelay(ad4_ipd, ad4, tipd_ad4);
   END BLOCK;
 
   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd, ad4_ipd)

     VARIABLE memory   : std_logic_vector((2**5)-1 downto 0) := hex2bin(initval);

     -- functionality results
     VARIABLE do0_zd : std_logic :='X';

     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;

BEGIN

   ------------------------
   -- functionality section
   ------------------------

      do0_zd := VitalMUX (data => memory,
                         dselect => (ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd));

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
               1 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
               2 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
               3 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE),
               4 => (ad4_ipd'last_event, tpd_ad4_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn,
      MsgOn => MsgOn);

   end process;

end V;


 
 


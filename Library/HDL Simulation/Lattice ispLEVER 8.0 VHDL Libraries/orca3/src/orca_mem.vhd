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
-- Simulation Library File for ORCA3
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCA_MEM.vhd,v 1.20 2005/05/19 20:04:55 pradeep Exp $ 
--


 
--
----- package mem1 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE mem1 IS
   TYPE mem_type_4 IS array (natural range <>) OF std_logic_vector(3 downto 0);
   FUNCTION hex2bin_4 (hex: character) RETURN std_logic_vector;
   FUNCTION init_ram (hex: string) RETURN mem_type_4;
END mem1;
 
PACKAGE BODY mem1 IS

   FUNCTION hex2bin_4 (hex: character) RETURN std_logic_vector IS
        VARIABLE result : std_logic_vector (3 downto 0);
   BEGIN
        CASE hex IS
          WHEN '0' => 
             result := "0000";
          WHEN '1' => 
             result := "0001";
          WHEN '2' => 
             result := "0010";
          WHEN '3' => 
             result := "0011";
          WHEN '4' => 
             result := "0100";
          WHEN '5' => 
             result := "0101";
          WHEN '6' => 
             result := "0110";
          WHEN '7' => 
             result := "0111";
          WHEN '8' => 
             result := "1000";
          WHEN '9' => 
             result := "1001";
          WHEN 'A'|'a' => 
             result := "1010";
          WHEN 'B'|'b' => 
             result := "1011";
          WHEN 'C'|'c' => 
             result := "1100";
          WHEN 'D'|'d' => 
             result := "1101";
          WHEN 'E'|'e' => 
             result := "1110";
          WHEN 'F'|'f' => 
             result := "1111";
          WHEN others =>
             NULL;
        END CASE;
        RETURN result;
   END; 
 
   FUNCTION init_ram (hex: string) RETURN mem_type_4 IS
	-- skip 0x OF hex string
        CONSTANT length : integer := hex'length - 2;
        VARIABLE result : mem_type_4 (length-1 downto 0);
   BEGIN
        FOR i in 0 to length-1 LOOP
           result (length-1-i) := hex2bin_4 (hex(i+3));
        END LOOP;
        RETURN result;
   END;
 
END mem1;



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
           result ((length-i)*4-1 downto (length-i-1)*4) := hex2bin(hex(i+3))
;
        end loop;
        return result;
   end;
 
end mem2;


--
----- cell dce32x4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY dce32x4 IS
  GENERIC (

        disabled_gsr  : string := "0";

	initval : string := "0x00000000000000000000000000000000"; 

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "dce32x4";

        -- input SIGNAL delays
        tipd_rad0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rad1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rad2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rad3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rad4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wad4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wren : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wpe0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wpe1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck   : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- setup and hold constraints
        tsetup_wad0_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_wad1_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_wad2_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_wad3_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_wad4_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_wren_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_wpe0_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_wpe1_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_di0_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        tsetup_di1_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        tsetup_di2_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        tsetup_di3_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wad0_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wad1_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wad2_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wad3_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wad4_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wren_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wpe0_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_wpe1_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_di0_ck_noedge_posedge   : VitalDelayType := 0.01 ns;
        thold_di1_ck_noedge_posedge   : VitalDelayType := 0.01 ns;
        thold_di2_ck_noedge_posedge   : VitalDelayType := 0.01 ns;
        thold_di3_ck_noedge_posedge   : VitalDelayType := 0.01 ns;

        -- pulse width constraints
        tperiod_wren            : VitalDelayType := 0.01 ns;
        tpw_wren_posedge	: VitalDelayType := 0.01 ns;
        tpw_wren_negedge	: VitalDelayType := 0.01 ns;
        tperiod_wpe0            : VitalDelayType := 0.01 ns;
        tperiod_wpe1            : VitalDelayType := 0.01 ns;
        tpw_wpe0_posedge	: VitalDelayType := 0.01 ns;
        tpw_wpe0_negedge	: VitalDelayType := 0.01 ns;
        tpw_wpe1_posedge	: VitalDelayType := 0.01 ns;
        tpw_wpe1_negedge	: VitalDelayType := 0.01 ns;
        tperiod_ck              : VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;

        -- propagation delays
	tpd_ck_do0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad0_do0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad1_do0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad2_do0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad3_do0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad4_do0    : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad0_do1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad1_do1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad2_do1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad3_do1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad4_do1    : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do2	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad0_do2    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad1_do2    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad2_do2    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad3_do2    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad4_do2    : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do3	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad0_do3    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad1_do3    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad2_do3    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad3_do3    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_rad4_do3    : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_qdo0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_qdo1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_qdo2	: VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_qdo3	: VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (di0  : IN std_logic;
	di1  : IN std_logic;
	di2  : IN std_logic;
	di3  : IN std_logic;
        ck   : IN std_logic;
        wren : IN std_logic;
        wpe0 : IN std_logic;
        wpe1 : IN std_logic;
        rad0 : IN std_logic;
        rad1 : IN std_logic;
        rad2 : IN std_logic;
        rad3 : IN std_logic;
        rad4 : IN std_logic;
        wad0 : IN std_logic;
        wad1 : IN std_logic;
        wad2 : IN std_logic;
        wad3 : IN std_logic;
        wad4 : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic;
        do2  : OUT std_logic;
        do3  : OUT std_logic;
        qdo0 : OUT std_logic;
        qdo1 : OUT std_logic;
        qdo2 : OUT std_logic;
        qdo3 : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF dce32x4 : ENTITY IS TRUE;
 
END dce32x4;


-- architecture body --
ARCHITECTURE v OF dce32x4 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL di0_ipd  : std_logic := 'X';
   SIGNAL di1_ipd  : std_logic := 'X';
   SIGNAL di2_ipd  : std_logic := 'X';
   SIGNAL di3_ipd  : std_logic := 'X';
   SIGNAL rad0_ipd : std_logic := 'X';
   SIGNAL rad1_ipd : std_logic := 'X';
   SIGNAL rad2_ipd : std_logic := 'X';
   SIGNAL rad3_ipd : std_logic := 'X';
   SIGNAL rad4_ipd : std_logic := 'X';
   SIGNAL wad0_ipd : std_logic := 'X';
   SIGNAL wad1_ipd : std_logic := 'X';
   SIGNAL wad2_ipd : std_logic := 'X';
   SIGNAL wad3_ipd : std_logic := 'X';
   SIGNAL wad4_ipd : std_logic := 'X';
   SIGNAL wren_ipd : std_logic := 'X';
   SIGNAL wpe0_ipd : std_logic := 'X';
   SIGNAL wpe1_ipd : std_logic := 'X';
   SIGNAL ck_ipd   : std_logic := 'X';

BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(di0_ipd, di0, tipd_di0);
   VitalWireDelay(di1_ipd, di1, tipd_di1);
   VitalWireDelay(di2_ipd, di2, tipd_di2);
   VitalWireDelay(di3_ipd, di3, tipd_di3);
   VitalWireDelay(rad0_ipd, rad0, tipd_rad0);
   VitalWireDelay(rad1_ipd, rad1, tipd_rad1);
   VitalWireDelay(rad2_ipd, rad2, tipd_rad2);
   VitalWireDelay(rad3_ipd, rad3, tipd_rad3);
   VitalWireDelay(rad4_ipd, rad4, tipd_rad4);
   VitalWireDelay(wad0_ipd, wad0, tipd_wad0);
   VitalWireDelay(wad1_ipd, wad1, tipd_wad1);
   VitalWireDelay(wad2_ipd, wad2, tipd_wad2);
   VitalWireDelay(wad3_ipd, wad3, tipd_wad3);
   VitalWireDelay(wad4_ipd, wad4, tipd_wad4);
   VitalWireDelay(wren_ipd, wren, tipd_wren);
   VitalWireDelay(wpe0_ipd, wpe0, tipd_wpe0);
   VitalWireDelay(wpe1_ipd, wpe1, tipd_wpe1);
   VitalWireDelay(ck_ipd, ck, tipd_ck);
   END BLOCK;

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (ck_ipd, wren_ipd, wpe0_ipd, wpe1_ipd, wad0_ipd, 
     wad1_ipd, wad2_ipd, wad3_ipd, wad4_ipd, rad0_ipd, rad1_ipd, rad2_ipd, 
     rad3_ipd, rad4_ipd, di0_ipd, di1_ipd, di2_ipd, di3_ipd, gsrnet, purnet)

     VARIABLE memory : mem_type_4 ((2**5)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(4 downto 0) := "00000";
     VARIABLE din_reg : std_logic_vector(3 downto 0) := "0000";
     VARIABLE wren_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- timing check results
     VARIABLE tviol_di0   : x01 := '0';
     VARIABLE tviol_di1   : x01 := '0';
     VARIABLE tviol_di2   : x01 := '0';
     VARIABLE tviol_di3   : x01 := '0';
     VARIABLE tviol_wad0  : x01 := '0';
     VARIABLE tviol_wad1  : x01 := '0';
     VARIABLE tviol_wad2  : x01 := '0';
     VARIABLE tviol_wad3  : x01 := '0';
     VARIABLE tviol_wad4  : x01 := '0';
     VARIABLE tviol_wren  : x01 := '0';
     VARIABLE tsviol_wren : x01 := '0';
     VARIABLE tviol_wpe0  : x01 := '0';
     VARIABLE tsviol_wpe0 : x01 := '0';
     VARIABLE tviol_wpe1  : x01 := '0';
     VARIABLE tsviol_wpe1 : x01 := '0';
     VARIABLE tviol_ck    : x01 := '0';
     VARIABLE PeriodCheckInfo_wren : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_wpe0 : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_wpe1 : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_ck   : VitalPeriodDataType;
     VARIABLE wad0_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wad1_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wad2_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wad3_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wad4_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wren_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wpe0_ck_TimingDatash : VitalTimingDataType;
     VARIABLE wpe1_ck_TimingDatash : VitalTimingDataType;
     VARIABLE di0_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di1_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di2_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di3_ck_TimingDatash  : VitalTimingDataType;

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (7 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);
     ALIAS qdo0_zd      : std_ulogic IS results(4);
     ALIAS qdo1_zd      : std_ulogic IS results(5);
     ALIAS qdo2_zd      : std_ulogic IS results(6);
     ALIAS qdo3_zd      : std_ulogic IS results(7);

     -- output glitch results
     VARIABLE do0_GlitchData  : VitalGlitchDataType;
     VARIABLE do1_GlitchData  : VitalGlitchDataType;
     VARIABLE do2_GlitchData  : VitalGlitchDataType;
     VARIABLE do3_GlitchData  : VitalGlitchDataType;
     VARIABLE qdo0_GlitchData : VitalGlitchDataType;
     VARIABLE qdo1_GlitchData : VitalGlitchDataType;
     VARIABLE qdo2_GlitchData : VitalGlitchDataType;
     VARIABLE qdo3_GlitchData : VitalGlitchDataType;

   BEGIN

   -----------------------
   -- timing check section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on the write address lines
           VitalSetupHoldCheck (
		TestSignal => wad0_ipd, 
                TestSignalName => "wad0", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wad0_ck_noedge_posedge, 
		setuplow => tsetup_wad0_ck_noedge_posedge,
		HoldHigh => thold_wad0_ck_noedge_posedge, 
                HoldLow => thold_wad0_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wad0_ck_timingdatash,
		Violation => tviol_wad0, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => wad1_ipd, 
                TestSignalName => "wad1", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wad1_ck_noedge_posedge, 
		setuplow => tsetup_wad1_ck_noedge_posedge,
		HoldHigh => thold_wad1_ck_noedge_posedge, 
                HoldLow =>  thold_wad1_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wad1_ck_timingdatash,
		Violation => tviol_wad1, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => wad2_ipd, 
                TestSignalName => "wad2", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wad2_ck_noedge_posedge, 
		setuplow => tsetup_wad2_ck_noedge_posedge,
		HoldHigh => thold_wad2_ck_noedge_posedge, 
                HoldLow => thold_wad2_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wad2_ck_timingdatash,
		Violation => tviol_wad2, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => wad3_ipd,
                TestSignalName => "wad3", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wad3_ck_noedge_posedge, 
		setuplow => tsetup_wad3_ck_noedge_posedge,
		HoldHigh => thold_wad3_ck_noedge_posedge, 
                HoldLow => thold_wad3_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wad3_ck_timingdatash,
		Violation => tviol_wad3, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => wad4_ipd, 
                TestSignalName => "wad4", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wad4_ck_noedge_posedge, 
		setuplow => tsetup_wad4_ck_noedge_posedge,
		HoldHigh => thold_wad4_ck_noedge_posedge, 
                HoldLow => thold_wad4_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wad4_ck_timingdatash,
		Violation => tviol_wad4, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => wren_ipd, 
                TestSignalName => "wren", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wren_ck_noedge_posedge, 
		setuplow => tsetup_wren_ck_noedge_posedge,
		HoldHigh => thold_wren_ck_noedge_posedge, 
                HoldLow => thold_wren_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wren_ck_timingdatash,
		Violation => tsviol_wren, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => wpe0_ipd, 
                TestSignalName => "wpe0", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wpe0_ck_noedge_posedge, 
		setuplow => tsetup_wpe0_ck_noedge_posedge,
		HoldHigh => thold_wpe0_ck_noedge_posedge, 
                HoldLow => thold_wpe0_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wpe0_ck_timingdatash,
		Violation => tsviol_wpe0, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => wpe1_ipd, 
                TestSignalName => "wpe1", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_wpe1_ck_noedge_posedge, 
		setuplow => tsetup_wpe1_ck_noedge_posedge,
		HoldHigh => thold_wpe1_ck_noedge_posedge, 
                HoldLow => thold_wpe1_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => wpe1_ck_timingdatash,
		Violation => tsviol_wpe1, 
                MsgSeverity => warning);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => di0_ipd, 
                TestSignalName => "di0", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_di0_ck_noedge_posedge, 
		setuplow => tsetup_di0_ck_noedge_posedge,
                HoldHigh => thold_di0_ck_noedge_posedge, 
		HoldLow => thold_di0_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => di0_ck_timingdatash,
		Violation => tviol_di1, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => di1_ipd, 
                TestSignalName => "di1", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_di1_ck_noedge_posedge, 
		setuplow => tsetup_di1_ck_noedge_posedge,
                HoldHigh => thold_di1_ck_noedge_posedge, 
		HoldLow => thold_di1_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => di1_ck_timingdatash,
		Violation => tviol_di1, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => di2_ipd, 
                TestSignalName => "di2", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_di2_ck_noedge_posedge, 
		setuplow => tsetup_di2_ck_noedge_posedge,
                HoldHigh => thold_di2_ck_noedge_posedge, 
		HoldLow => thold_di2_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => di2_ck_timingdatash,
		Violation => tviol_di2, 
                MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => di3_ipd, 
                TestSignalName => "di3", 
		RefSignal => ck_ipd, 
                RefSignalName => "ck",
                SetupHigh => tsetup_di3_ck_noedge_posedge, 
		setuplow => tsetup_di3_ck_noedge_posedge,
                HoldHigh => thold_di3_ck_noedge_posedge, 
		HoldLow => thold_di3_ck_noedge_posedge,
		CheckEnabled => (set_reset='1'), 
                RefTransition => '/', 
                MsgOn => MsgOn, XOn => XOn,
                HeaderMsg => InstancePath, 
                TimingData => di3_ck_timingdatash,
		Violation => tviol_di3, 
                MsgSeverity => warning);

	   -- Period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => ck_ipd, 
               TestSignalName => "ck", 
               Period => tperiod_ck,
               PulseWidthHigh => tpw_ck_posedge, 
               PulseWidthLow => tpw_ck_posedge, 
               Perioddata => periodcheckinfo_ck, 
               Violation => tviol_ck, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, 
               CheckEnabled => TRUE, 
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wren_ipd, 
               TestSignalName => "wren", 
               Period => tperiod_wren,
               PulseWidthHigh => tpw_wren_posedge, 
               PulseWidthLow => tpw_wren_posedge, 
               Perioddata => periodcheckinfo_wren, 
               Violation => tviol_wren, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, 
               CheckEnabled => TRUE, 
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wpe0_ipd, 
               TestSignalName => "wpe0", 
               Period => tperiod_wpe0,
               PulseWidthHigh => tpw_wpe0_posedge, 
               PulseWidthLow => tpw_wpe0_posedge, 
               Perioddata => periodcheckinfo_wpe0, 
               Violation => tviol_wpe0, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, 
               CheckEnabled => TRUE, 
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wpe1_ipd, 
               TestSignalName => "wpe1", 
               Period => tperiod_wpe1,
               PulseWidthHigh => tpw_wpe1_posedge, 
               PulseWidthLow => tpw_wpe1_posedge, 
               Perioddata => periodcheckinfo_wpe1, 
               Violation => tviol_wpe1, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, 
               CheckEnabled => TRUE, 
               MsgSeverity => warning);

        END IF;

   ------------------------
   -- functionality section
   ------------------------
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

   IF (set_reset= '0') THEN
      wren_reg := '0';
      wadr_reg := "00000";
      results(7 downto 4) := "0000";
   END IF;
 
   Violation := tviol_di0 or tviol_di1 or tviol_di2 or tviol_di3 or
                tviol_wad0 or tviol_wad1 or tviol_wad2 or tviol_wad3 or
                tviol_wad4 or tviol_wren or tviol_wpe0 or tviol_wpe1 or
                tviol_ck or tsviol_wren or tsviol_wpe0 or tsviol_wpe1;


   IF ((is_x(wren_ipd) or is_x(wpe0_ipd) or is_x(wpe1_ipd)) and (set_reset='1')) THEN
      assert FALSE
        report "dce32x4 memory hazard write enable unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF (is_x(rad0_ipd) or is_x(rad1_ipd) or is_x(rad2_ipd) 
	or is_x(rad3_ipd) or is_x(rad4_ipd)) THEN
      assert FALSE 
	report "dce32x4 memory hazard read address unknown!"
	severity warning;
      results := (others => 'X');
   ELSIF ((is_x(wad0_ipd) or is_x(wad1_ipd) or is_x(wad2_ipd) 
	or is_x(wad3_ipd) or is_x(wad4_ipd)) and (set_reset='1')) THEN
      assert FALSE 
	report "dce32x4 memory hazard write address unknown!"
	severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the 
      -- read address
      IF ((ck_ipd'event and ck_ipd = '1') and (set_reset= '1')) THEN
	 wren_reg := (wren_ipd and wpe0_ipd and wpe1_ipd);
	 din_reg := (di3_ipd, di2_ipd, di1_ipd, di0_ipd);
	 wadr_reg := (wad4_ipd, wad3_ipd, wad2_ipd, wad1_ipd, wad0_ipd);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (rad4_ipd, rad3_ipd, rad2_ipd, rad1_ipd, rad0_ipd);
      rindex := conv_integer(radr_reg);

      -- at the falling edge of ck, write to memory at address 
      IF (wren_reg = '1') THEN
	 IF (ck_ipd'event and ck_ipd = '0') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
	 results(3 downto 0) := memory(rindex);
	 IF ((ck_ipd'event and ck_ipd = '1') and (set_reset= '1')) THEN
	    results(7 downto 4) := memory(rindex);
	 END IF;
      ELSE 
         results := (others => 'X');
      END IF;
  
   END IF;

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 ( 
     OutSignal => qdo0,
     OutSignalName => "qdo0",
     OutTemp => qdo0_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo0, TRUE)),
      GlitchData => qdo0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => qdo1,
     OutSignalName => "qdo1",
     OutTemp => qdo1_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo1, TRUE)),
      GlitchData => qdo1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => qdo2,
     OutSignalName => "qdo2",
     OutTemp => qdo2_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo2, TRUE)),
      GlitchData => qdo2_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => qdo3,
     OutSignalName => "qdo3",
     OutTemp => qdo3_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo3, TRUE)),
      GlitchData => qdo3_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do0, TRUE),
	       1 => (rad0_ipd'last_event, tpd_rad0_do0, TRUE),
	       2 => (rad1_ipd'last_event, tpd_rad1_do0, TRUE),
	       3 => (rad2_ipd'last_event, tpd_rad2_do0, TRUE),
	       4 => (rad3_ipd'last_event, tpd_rad3_do0, TRUE),
	       5 => (rad4_ipd'last_event, tpd_rad4_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do1,
     OutSignalName => "do1",
     OutTemp => do1_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do1, TRUE),
	       1 => (rad0_ipd'last_event, tpd_rad0_do1, TRUE),
	       2 => (rad1_ipd'last_event, tpd_rad1_do1, TRUE),
	       3 => (rad2_ipd'last_event, tpd_rad2_do1, TRUE),
	       4 => (rad3_ipd'last_event, tpd_rad3_do1, TRUE),
	       5 => (rad4_ipd'last_event, tpd_rad4_do1, TRUE)),
      GlitchData => do1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do2,
     OutSignalName => "do2",
     OutTemp => do2_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do2, TRUE),
	       1 => (rad0_ipd'last_event, tpd_rad0_do2, TRUE),
	       2 => (rad1_ipd'last_event, tpd_rad1_do2, TRUE),
	       3 => (rad2_ipd'last_event, tpd_rad2_do2, TRUE),
	       4 => (rad3_ipd'last_event, tpd_rad3_do2, TRUE),
	       5 => (rad4_ipd'last_event, tpd_rad4_do2, TRUE)),
      GlitchData => do2_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do3,
     OutSignalName => "do3",
     OutTemp => do3_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do3, TRUE),
	       1 => (rad0_ipd'last_event, tpd_rad0_do3, TRUE),
	       2 => (rad1_ipd'last_event, tpd_rad1_do3, TRUE),
	       3 => (rad2_ipd'last_event, tpd_rad2_do3, TRUE),
	       4 => (rad3_ipd'last_event, tpd_rad3_do3, TRUE),
	       5 => (rad4_ipd'last_event, tpd_rad4_do3, TRUE)),
      GlitchData => do3_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);

   END PROCESS;

END v;


--
----- cell rce32x4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY rce32x4 IS
  GENERIC (

        disabled_gsr  : string := "0";

	initval : string := "0x00000000000000000000000000000000"; 

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "rce32x4";

        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wren : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wpe0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wpe1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck   : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- setup and hold constraints
        tsetup_ad0_ck_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad1_ck_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad2_ck_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad3_ck_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad4_ck_posedge : VitalDelayType := 0.01 ns;
        tsetup_di0_ck_negedge : VitalDelayType := 0.01 ns;
        tsetup_di1_ck_negedge : VitalDelayType := 0.01 ns;
        tsetup_di2_ck_negedge : VitalDelayType := 0.01 ns;
        tsetup_di3_ck_negedge : VitalDelayType := 0.01 ns;
        thold_ck_ad0_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_ad1_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_ad2_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_ad3_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_ad4_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_di0_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_di1_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_di2_negedge  : VitalDelayType := 0.01 ns;
        thold_ck_di3_negedge  : VitalDelayType := 0.01 ns;

        -- pulse width constraints
        tperiod_wren    : VitalDelayType := 0.01 ns;
        tpw_wren	: VitalDelayType := 0.01 ns;
        tperiod_wpe0    : VitalDelayType := 0.01 ns;
        tpw_wpe0	: VitalDelayType := 0.01 ns;
        tperiod_wpe1    : VitalDelayType := 0.01 ns;
        tpw_wpe1	: VitalDelayType := 0.01 ns;
        tperiod_ck      : VitalDelayType := 0.01 ns;
        tpw_ck		: VitalDelayType := 0.01 ns;

        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad0_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad0_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do2	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad0_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do3	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo3     : VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (di0  : IN std_logic;
	di1  : IN std_logic;
	di2  : IN std_logic;
	di3  : IN std_logic;
        ad0  : IN std_logic;
        ad1  : IN std_logic;
        ad2  : IN std_logic;
        ad3  : IN std_logic;
        ad4  : IN std_logic;
        wren : IN std_logic;
        wpe0 : IN std_logic;
        wpe1 : IN std_logic;
        ck   : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic;
        do2  : OUT std_logic;
        do3  : OUT std_logic;
        qdo0 : OUT std_logic;
        qdo1 : OUT std_logic;
        qdo2 : OUT std_logic;
        qdo3 : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF rce32x4 : ENTITY IS TRUE;
 
END rce32x4;


-- architecture body --
ARCHITECTURE v OF rce32x4 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL di0_ipd  : std_logic := 'X';
   SIGNAL di1_ipd  : std_logic := 'X';
   SIGNAL di2_ipd  : std_logic := 'X';
   SIGNAL di3_ipd  : std_logic := 'X';
   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
   SIGNAL ad4_ipd  : std_logic := 'X';
   SIGNAL wren_ipd : std_logic := 'X';
   SIGNAL wpe0_ipd : std_logic := 'X';
   SIGNAL wpe1_ipd : std_logic := 'X';
   SIGNAL ck_ipd   : std_logic := 'X';

BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(di0_ipd, di0, tipd_di0);
   VitalWireDelay(di1_ipd, di1, tipd_di1);
   VitalWireDelay(di2_ipd, di2, tipd_di2);
   VitalWireDelay(di3_ipd, di3, tipd_di3);
   VitalWireDelay(ad0_ipd, ad0, tipd_ad0);
   VitalWireDelay(ad1_ipd, ad1, tipd_ad1);
   VitalWireDelay(ad2_ipd, ad2, tipd_ad2);
   VitalWireDelay(ad3_ipd, ad3, tipd_ad3);
   VitalWireDelay(ad4_ipd, ad4, tipd_ad4);
   VitalWireDelay(wren_ipd, wren, tipd_wren);
   VitalWireDelay(wpe0_ipd, wpe0, tipd_wpe0);
   VitalWireDelay(wpe1_ipd, wpe1, tipd_wpe1);
   VitalWireDelay(ck_ipd, ck, tipd_ck);
   END BLOCK;

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (purnet, gsrnet, ck_ipd, wren_ipd, wpe0_ipd, wpe1_ipd, ad0_ipd, 
	ad1_ipd, ad2_ipd, ad3_ipd, ad4_ipd, di0_ipd, di1_ipd, di2_ipd, di3_ipd)

     VARIABLE memory : mem_type_4 ((2**5)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg, wadr_reg : std_logic_vector(4 downto 0) := "00000";
     VARIABLE din_reg :  std_logic_vector(3 downto 0) := "0000";
     VARIABLE wren_reg : std_logic := '0';
     VARIABLE rindex, windex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- timing check results
     VARIABLE tviol_di0  : x01 := '0';
     VARIABLE tviol_di1  : x01 := '0';
     VARIABLE tviol_di2  : x01 := '0';
     VARIABLE tviol_di3  : x01 := '0';
     VARIABLE tviol_ad0  : x01 := '0';
     VARIABLE tviol_ad1  : x01 := '0';
     VARIABLE tviol_ad2  : x01 := '0';
     VARIABLE tviol_ad3  : x01 := '0';
     VARIABLE tviol_ad4  : x01 := '0';
     VARIABLE tviol_wren : x01 := '0';
     VARIABLE tviol_wpe0 : x01 := '0';
     VARIABLE tviol_wpe1 : x01 := '0';
     VARIABLE tviol_ck   : x01 := '0';
     VARIABLE PeriodCheckInfo_wren : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_wpe0 : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_wpe1 : VitalPeriodDataType;
     VARIABLE PeriodCheckInfo_ck   : VitalPeriodDataType;
     VARIABLE ad0_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad1_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad2_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad3_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad4_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di0_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di1_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di2_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE di3_ck_TimingDatash  : VitalTimingDataType;

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (7 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);
     ALIAS qdo0_zd      : std_ulogic IS results(4);
     ALIAS qdo1_zd      : std_ulogic IS results(5);
     ALIAS qdo2_zd      : std_ulogic IS results(6);
     ALIAS qdo3_zd      : std_ulogic IS results(7);

     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;
     VARIABLE do1_GlitchData : VitalGlitchDataType;
     VARIABLE do2_GlitchData : VitalGlitchDataType;
     VARIABLE do3_GlitchData : VitalGlitchDataType;
     VARIABLE qdo0_GlitchData : VitalGlitchDataType;
     VARIABLE qdo1_GlitchData : VitalGlitchDataType;
     VARIABLE qdo2_GlitchData : VitalGlitchDataType;
     VARIABLE qdo3_GlitchData : VitalGlitchDataType;

   BEGIN

   -----------------------
   -- timing check section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => ad0_ipd, TestSignalName => "ad0", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad0_ck_posedge, 
		setuplow => tsetup_ad0_ck_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad0_ck_timingdatash,
		violation => tviol_ad0, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad1_ipd, TestSignalName => "ad1", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad1_ck_posedge, 
		setuplow => tsetup_ad1_ck_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad1_ck_timingdatash,
		violation => tviol_ad1, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad2_ipd, TestSignalName => "ad2", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad2_ck_posedge, 
		setuplow => tsetup_ad2_ck_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad2_ck_timingdatash,
		violation => tviol_ad2, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad3_ipd, TestSignalName => "ad3", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad3_ck_posedge, 
		setuplow => tsetup_ad3_ck_posedge,
		HoldHigh => 0.1 ns, HoldLow => 0.1 ns,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad3_ck_timingdatash,
		violation => tviol_ad3, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad4_ipd, TestSignalName => "ad4", 
		RefSignal => ck_ipd, RefSignalName => "ck",
		SetupHigh => 0.1 ns, setuplow => 0.1 ns,
                HoldHigh => thold_ck_ad4_negedge, 
		HoldLow => thold_ck_ad4_negedge,
		CheckEnabled => TRUE, RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad4_ck_timingdatash,
		violation => tviol_ad4, MsgSeverity => warning);

	   -- setup and hold checks on data 
           VitalSetupHoldCheck (
		TestSignal => di0_ipd, TestSignalName => "di0", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_di0_ck_negedge, 
		setuplow => tsetup_di0_ck_negedge,
                HoldHigh => thold_ck_di0_negedge, 
		HoldLow => thold_ck_di0_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => di0_ck_timingdatash,
		violation => tviol_di1, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => di1_ipd, TestSignalName => "di1", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_di1_ck_negedge, 
		setuplow => tsetup_di1_ck_negedge,
                HoldHigh => thold_ck_di1_negedge, 
		HoldLow => thold_ck_di1_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => di1_ck_timingdatash,
		violation => tviol_di1, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => di2_ipd, TestSignalName => "di2", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_di2_ck_negedge, 
		setuplow => tsetup_di2_ck_negedge,
                HoldHigh => thold_ck_di2_negedge, 
		HoldLow => thold_ck_di2_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => di2_ck_timingdatash,
		violation => tviol_di2, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => di3_ipd, TestSignalName => "di3", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_di3_ck_negedge, 
		setuplow => tsetup_di3_ck_negedge,
                HoldHigh => thold_ck_di3_negedge, 
		HoldLow => thold_ck_di3_negedge,
		CheckEnabled => TRUE, RefTransition => '\', 
                HeaderMsg => InstancePath, TimingData => di3_ck_timingdatash,
		violation => tviol_di3, MsgSeverity => warning);

	   -- Period and pulse width checks on write and port enables
           VitalPeriodPulseCheck (
               TestSignal => ck_ipd, TestSignalName => "ck", 
               Period => tperiod_ck,
               PulseWidthHigh => tpw_ck, 
               PulseWidthLow => tpw_ck, 
               Perioddata => periodcheckinfo_ck, violation => tviol_ck, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wren_ipd, TestSignalName => "wren", 
               Period => tperiod_wren,
               PulseWidthHigh => tpw_wren, 
               PulseWidthLow => tpw_wren, 
               Perioddata => periodcheckinfo_wren, violation => tviol_wren, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wpe0_ipd, TestSignalName => "wpe0", 
               Period => tperiod_wpe0,
               PulseWidthHigh => tpw_wpe0, 
               PulseWidthLow => tpw_wpe0, 
               Perioddata => periodcheckinfo_wpe0, violation => tviol_wpe0, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => warning);
           VitalPeriodPulseCheck (
               TestSignal => wpe1_ipd, TestSignalName => "wpe1", 
               Period => tperiod_wpe1,
               PulseWidthHigh => tpw_wpe1, 
               PulseWidthLow => tpw_wpe1, 
               Perioddata => periodcheckinfo_wpe1, violation => tviol_wpe1, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => warning);

        END IF;

   ------------------------
   -- functionality section
   ------------------------
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

   IF (set_reset= '0') THEN
      wren_reg := '0';
      wadr_reg := "00000";
      results(7 downto 4) := "0000";
   END IF;

   violation := tviol_di0 or tviol_di1 or tviol_di2 or tviol_di3 or 
		tviol_ad0 or tviol_ad1 or tviol_ad2 or tviol_ad3 or 
		tviol_ad4 or tviol_wren or tviol_wpe0 or tviol_wpe1 or 
		tviol_ck;
   IF ((is_x(wren_ipd) or is_x(wpe0_ipd) or is_x(wpe1_ipd)) and (set_reset='1')) THEN
      assert FALSE
        report "rce32x4 memory hazard write enable unknown!"
        severity warning;
      results := (others => 'X');
   ELSIF ((is_x(ad0_ipd) or is_x(ad1_ipd) or is_x(ad2_ipd) 
	or is_x(ad3_ipd) or is_x(ad4_ipd)) and (set_reset='1')) THEN
      assert FALSE 
	report "rce32x4 memory hazard address unknown!"
	severity warning;
      results := (others => 'X');
   ELSE
      -- register the write address, write enables and data but not the 
      -- read address
      IF ((ck_ipd'event and ck_ipd = '1') and (set_reset='1')) THEN
	 wren_reg := (wren_ipd and wpe0_ipd and wpe1_ipd);
	 din_reg := (di3_ipd, di2_ipd, di1_ipd, di0_ipd);
	 wadr_reg := (ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd);
      END IF;
      windex := conv_integer(wadr_reg);
      radr_reg := (ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd);
      rindex := conv_integer(radr_reg);

      -- at the falling edge of ck, write to memory at address 
      IF (wren_reg = '1') THEN
	 IF (ck_ipd'event and ck_ipd = '0') THEN 
	     memory(windex) := din_reg;
	 END IF;
      END IF;

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
	 results(3 downto 0) := memory(rindex);
         IF ((ck_ipd'event and ck_ipd = '1') and (set_reset='1')) THEN
            results(7 downto 4) := memory(rindex);
         END IF;
      ELSE 
         results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => qdo0,
     OutSignalName => "qdo0",
     OutTemp => qdo0_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo0, TRUE)),
      GlitchData => qdo0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => qdo1,
     OutSignalName => "qdo1",
     OutTemp => qdo1_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo1, TRUE)),
      GlitchData => qdo1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => qdo2,
     OutSignalName => "qdo2",
     OutTemp => qdo2_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo2, TRUE)),
      GlitchData => qdo2_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => qdo3,
     OutSignalName => "qdo3",
     OutTemp => qdo3_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo3, TRUE)),
      GlitchData => qdo3_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do0, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do1,
     OutSignalName => "do1",
     OutTemp => do1_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do1, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do1, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do1, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do1, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do1, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do1, TRUE)),
      GlitchData => do1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do2,
     OutSignalName => "do2",
     OutTemp => do2_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do2, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do2, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do2, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do2, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do2, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do2, TRUE)),
      GlitchData => do2_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do3,
     OutSignalName => "do3",
     OutTemp => do3_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do3, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do3, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do3, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do3, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do3, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do3, TRUE)),
      GlitchData => do3_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);

   END PROCESS;

END v;


--
----- cell rom32x4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.mem1.all;
USE work.global.gsrnet;
USE work.global.purnet;

-- entity declaration --
ENTITY rom32x4 IS
  GENERIC (

        disabled_gsr    : string := "0";

	initval : string := "0x00000000000000000000000000000000"; 

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "rom32x4";

        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ck   : VitalDelayType01 := (0.0 ns, 0.0 ns);

        -- setup and hold constraints
        tsetup_ad0_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad1_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad2_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad3_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        tsetup_ad4_ck_noedge_posedge : VitalDelayType := 0.01 ns;
        thold_ad0_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_ad1_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_ad2_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_ad3_ck_noedge_posedge  : VitalDelayType := 0.01 ns;
        thold_ad4_ck_noedge_posedge  : VitalDelayType := 0.01 ns;

        -- pulse width constraints
        tperiod_ck              : VitalDelayType := 0.01 ns;
        tpw_ck_posedge		: VitalDelayType := 0.01 ns;
        tpw_ck_negedge		: VitalDelayType := 0.01 ns;

        -- propagation delays
        tpd_ad0_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do0	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad0_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do1	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad0_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do2	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad0_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad1_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad2_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad3_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ad4_do3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tpd_ck_do3	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_ck_qdo3     : VitalDelayType01 := (0.1 ns, 0.1 ns));

  port (ad0  : IN std_logic;
        ad1  : IN std_logic;
        ad2  : IN std_logic;
        ad3  : IN std_logic;
        ad4  : IN std_logic;
        ck   : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic;
        do2  : OUT std_logic;
        do3  : OUT std_logic;
        qdo0 : OUT std_logic;
        qdo1 : OUT std_logic;
        qdo2 : OUT std_logic;
        qdo3 : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF rom32x4 : ENTITY IS TRUE;
 
END rom32x4;


-- architecture body --
ARCHITECTURE v OF rom32x4 IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL ad0_ipd  : std_logic := 'X';
   SIGNAL ad1_ipd  : std_logic := 'X';
   SIGNAL ad2_ipd  : std_logic := 'X';
   SIGNAL ad3_ipd  : std_logic := 'X';
   SIGNAL ad4_ipd  : std_logic := 'X';
   SIGNAL ck_ipd   : std_logic := 'X';

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
   VitalWireDelay(ck_ipd, ck, tipd_ck);
   END BLOCK;

   -----------------------
   -- behavior section
   -----------------------
   VitalBehavior : PROCESS (purnet, gsrnet, ck_ipd, ad0_ipd, ad1_ipd, ad2_ipd, ad3_ipd, ad4_ipd)

     VARIABLE memory : mem_type_4 ((2**5)-1 downto 0) := init_ram(initval);
     VARIABLE radr_reg : std_logic_vector(4 downto 0) := "00000";
     VARIABLE rindex : integer := 0;
     VARIABLE set_reset : std_logic := '1';

     -- timing check results
     VARIABLE tviol_ad0  : x01 := '0';
     VARIABLE tviol_ad1  : x01 := '0';
     VARIABLE tviol_ad2  : x01 := '0';
     VARIABLE tviol_ad3  : x01 := '0';
     VARIABLE tviol_ad4  : x01 := '0';
     VARIABLE tviol_ck   : x01 := '0';
     VARIABLE PeriodCheckInfo_ck   : VitalPeriodDataType;
     VARIABLE ad0_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad1_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad2_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad3_ck_TimingDatash  : VitalTimingDataType;
     VARIABLE ad4_ck_TimingDatash  : VitalTimingDataType;

     -- functionality results
     VARIABLE violation : x01 := '0';
     VARIABLE results   : std_logic_vector (7 downto 0) := (others => 'X');
     ALIAS do0_zd       : std_ulogic IS results(0);
     ALIAS do1_zd       : std_ulogic IS results(1);
     ALIAS do2_zd       : std_ulogic IS results(2);
     ALIAS do3_zd       : std_ulogic IS results(3);
     ALIAS qdo0_zd      : std_ulogic IS results(4);
     ALIAS qdo1_zd      : std_ulogic IS results(5);
     ALIAS qdo2_zd      : std_ulogic IS results(6);
     ALIAS qdo3_zd      : std_ulogic IS results(7);

     -- output glitch results
     VARIABLE do0_GlitchData : VitalGlitchDataType;
     VARIABLE do1_GlitchData : VitalGlitchDataType;
     VARIABLE do2_GlitchData : VitalGlitchDataType;
     VARIABLE do3_GlitchData : VitalGlitchDataType;
     VARIABLE qdo0_GlitchData : VitalGlitchDataType;
     VARIABLE qdo1_GlitchData : VitalGlitchDataType;
     VARIABLE qdo2_GlitchData : VitalGlitchDataType;
     VARIABLE qdo3_GlitchData : VitalGlitchDataType;

   BEGIN

   -----------------------
   -- timing check section
   -----------------------
        IF (TimingChecksOn) THEN

	   -- setup and hold checks on address lines
           VitalSetupHoldCheck (
		TestSignal => ad0_ipd, TestSignalName => "ad0", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad0_ck_noedge_posedge, 
		setuplow => tsetup_ad0_ck_noedge_posedge,
		HoldHigh => thold_ad0_ck_noedge_posedge, 
                HoldLow => thold_ad0_ck_noedge_posedge,
		CheckEnabled => (set_reset = '1'), RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad0_ck_timingdatash,
		Violation => tviol_ad0, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad1_ipd, TestSignalName => "ad1", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad1_ck_noedge_posedge, 
		setuplow => tsetup_ad1_ck_noedge_posedge,
		HoldHigh => thold_ad1_ck_noedge_posedge, 
                HoldLow => thold_ad1_ck_noedge_posedge,
		CheckEnabled => (set_reset = '1'), RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad1_ck_timingdatash,
		Violation => tviol_ad1, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad2_ipd, TestSignalName => "ad2", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad2_ck_noedge_posedge, 
		setuplow => tsetup_ad2_ck_noedge_posedge,
		HoldHigh => thold_ad2_ck_noedge_posedge, 
                HoldLow => thold_ad2_ck_noedge_posedge,
		CheckEnabled => (set_reset = '1'), RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad2_ck_timingdatash,
		Violation => tviol_ad2, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad3_ipd, TestSignalName => "ad3", 
		RefSignal => ck_ipd, RefSignalName => "ck",
                SetupHigh => tsetup_ad3_ck_noedge_posedge, 
		setuplow => tsetup_ad3_ck_noedge_posedge,
		HoldHigh => thold_ad3_ck_noedge_posedge, 
                HoldLow => thold_ad3_ck_noedge_posedge,
		CheckEnabled => (set_reset = '1'), RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad3_ck_timingdatash,
		Violation => tviol_ad3, MsgSeverity => warning);
           VitalSetupHoldCheck (
		TestSignal => ad4_ipd, TestSignalName => "ad4", 
		RefSignal => ck_ipd, RefSignalName => "ck",
		SetupHigh => tsetup_ad4_ck_noedge_posedge, 
                setuplow => tsetup_ad4_ck_noedge_posedge,
                HoldHigh => thold_ad4_ck_noedge_posedge, 
		HoldLow => thold_ad4_ck_noedge_posedge,
		CheckEnabled => (set_reset = '1'), RefTransition => '/', 
                HeaderMsg => InstancePath, TimingData => ad4_ck_timingdatash,
		Violation => tviol_ad4, MsgSeverity => warning);

	   -- Period and pulse width checks on clock 
           VitalPeriodPulseCheck (
               TestSignal => ck_ipd, TestSignalName => "ck", 
               Period => tperiod_ck,
               PulseWidthHigh => tpw_ck_posedge, 
               PulseWidthLow => tpw_ck_negedge, 
               Perioddata => periodcheckinfo_ck, Violation => tviol_ck, 
               MsgOn => MsgOn, XOn => XOn, 
               HeaderMsg => InstancePath, CheckEnabled => TRUE, 
               MsgSeverity => warning);

        END IF;

   ------------------------
   -- functionality section
   ------------------------
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

   IF (set_reset= '0') THEN
      results(7 downto 4) := "0000";
   END IF;

   violation := tviol_ad0 or tviol_ad1 or tviol_ad2 or tviol_ad3 or 
		tviol_ad4 or tviol_ck;
   IF (is_x(ad0_ipd) or is_x(ad1_ipd) or is_x(ad2_ipd) 
	or is_x(ad3_ipd) or is_x(ad4_ipd)) THEN
      assert FALSE 
	report "rom32x4 memory hazard address unknown!"
	severity warning;
      results := (others => 'X');
   ELSE
      -- calculate the read address
      radr_reg := (ad4_ipd, ad3_ipd, ad2_ipd, ad1_ipd, ad0_ipd);
      rindex := conv_integer(radr_reg);

      -- asynchronous and synchronous reads
      IF (violation = '0') THEN
	 results(3 downto 0) := memory(rindex);
         IF ((ck_ipd'event and ck_ipd = '1') and (set_reset='1')) THEN
            results(7 downto 4) := memory(rindex);
         END IF;
      ELSE 
         results := (others => 'X');
      END IF;

   END IF;

   ------------------------
   -- path delay section
   ------------------------
   VitalPathDelay01 (
     OutSignal => qdo0,
     OutSignalName => "qdo0",
     OutTemp => qdo0_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo0, TRUE)),
      GlitchData => qdo0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => qdo1,
     OutSignalName => "qdo1",
     OutTemp => qdo1_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo1, TRUE)),
      GlitchData => qdo1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => qdo2,
     OutSignalName => "qdo2",
     OutTemp => qdo2_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo2, TRUE)),
      GlitchData => qdo2_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 (
     OutSignal => qdo3,
     OutSignalName => "qdo3",
     OutTemp => qdo3_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_qdo3, TRUE)),
      GlitchData => qdo3_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do0,
     OutSignalName => "do0",
     OutTemp => do0_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do0, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do0, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do0, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do0, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do0, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do0, TRUE)),
      GlitchData => do0_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do1,
     OutSignalName => "do1",
     OutTemp => do1_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do1, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do1, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do1, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do1, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do1, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do1, TRUE)),
      GlitchData => do1_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do2,
     OutSignalName => "do2",
     OutTemp => do2_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do2, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do2, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do2, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do2, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do2, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do2, TRUE)),
      GlitchData => do2_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);
   VitalPathDelay01 ( 
     OutSignal => do3,
     OutSignalName => "do3",
     OutTemp => do3_zd,
     Paths => (0 => (ck_ipd'last_event, tpd_ck_do3, TRUE),
	       1 => (ad0_ipd'last_event, tpd_ad0_do3, TRUE),
	       2 => (ad1_ipd'last_event, tpd_ad1_do3, TRUE),
	       3 => (ad2_ipd'last_event, tpd_ad2_do3, TRUE),
	       4 => (ad3_ipd'last_event, tpd_ad3_do3, TRUE),
	       5 => (ad4_ipd'last_event, tpd_ad4_do3, TRUE)),
      GlitchData => do3_glitchdata,
      Mode => ondetect,
      XOn => XOn, MsgOn => MsgOn);

   END PROCESS;

END v;


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
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
 
 
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
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "rom16x1";

        -- input SIGNAL delays
        tipd_ad0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ad3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
 
 
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


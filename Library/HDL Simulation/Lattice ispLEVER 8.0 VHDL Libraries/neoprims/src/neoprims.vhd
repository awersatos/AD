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
-- Simulation Library File for NEOPRIMS
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/neoprims/src/RCS/NEOPRIMS.vhd,v 1.10 2005/05/19 20:03:15 pradeep Exp $ 
--

----- PACKAGE NEOMEM -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
package NEOMEM is
   function hex2bin (hex: String) return STD_LOGIC_VECTOR;
   function hex2bin (hex: Character) return STD_LOGIC_VECTOR;
end NEOMEM;

package body NEOMEM is

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

end NEOMEM;

       
--
----- CELL NEOAND2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND2 is
    generic (
	TimingChecksOn	: BOOLEAN := TRUE;
	XOn		: BOOLEAN := FALSE;
	MsgOn		: BOOLEAN := FALSE;
 	InstancePath	: STRING := "NEOAND2";
 	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
 	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
 	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
 	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns)) ;
    port (
	VIN0	 : in STD_LOGIC;
	VIN1 	 : in STD_LOGIC;
	VOUT 	 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND2 : entity is TRUE;

end NEOAND2 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND2 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd)

   -- functionality results 
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOAND2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('1', '1', '1'),
            ('0', '-', '0'),
            ('-', '0', '0'),
            ('B', 'B', '0'));

   -- output glitch detection variables  
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;
 
   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOAND2_0_tab,
        DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01(
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND3 is
    generic (
	TimingChecksOn	: BOOLEAN := TRUE;
	XOn		: BOOLEAN := FALSE;
	MsgOn		: BOOLEAN := FALSE;
	InstancePath: STRING := "NEOAND3";
	tpd_VIN0_VOUT : VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN1_VOUT : VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN2_VOUT : VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN0  : VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN1  : VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN2  : VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1 		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VOUT		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND3 : entity is TRUE;

end NEOAND3 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND3 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOAND3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('1', '1', '1', '1'),
            ('0', '-', '-', '0'),
            ('-', '0', '-', '0'),
            ('-', '-', '0', '0'),
            ('B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOAND3_0_tab,
       DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd, VIN2_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01(
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND4 is
    generic (
	TimingChecksOn	: BOOLEAN := TRUE;
	XOn		: BOOLEAN := FALSE;
	MsgOn		: BOOLEAN := FALSE;
	InstancePath	: STRING := "NEOAND4";
	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns)) ;
 
    port (
	VIN0		: in STD_LOGIC;
	VIN1 		: in STD_LOGIC;
	VIN2		: in STD_LOGIC;
	VIN3		: in STD_LOGIC;
	VOUT		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND4 : entity is TRUE;

end NEOAND4 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND4 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process ( VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd)

   -- functionality results 
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOAND4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('1', '1', '1', '1', '1'),
            ('0', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '0'),
            ('-', '-', '0', '-', '0'),
            ('-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOAND4_0_tab,
       DataIn => STD_LOGIC_VECTOR'( VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND5 is
    generic (
	TimingChecksOn	: BOOLEAN := TRUE;
	XOn		: BOOLEAN := FALSE;
	MsgOn		: BOOLEAN := FALSE;
	InstancePath	: STRING := "NEOAND5";
	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
	VIN0		: in STD_LOGIC;
	VIN1		: in STD_LOGIC;
	VIN2		: in STD_LOGIC;
	VIN3		: in STD_LOGIC;
	VIN4		: in STD_LOGIC;
	VOUT 		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND5 : entity is TRUE;

end NEOAND5 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND5 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process ( VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd)

   
   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOAND5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('1', '1', '1', '1', '1', '1'),
            ('0', '-', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '-', '0'),
            ('-', '-', '0', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData	 : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOAND5_0_tab,
        DataIn => STD_LOGIC_VECTOR'( VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
    	       3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND6 is
    generic (
      	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
        InstancePath   	: STRING  := "NEOAND6";
        tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0 		: in STD_LOGIC;
        VIN1 		: in STD_LOGIC;
        VIN2 		: in STD_LOGIC;
        VIN3 		: in STD_LOGIC;
        VIN4 		: in STD_LOGIC;
        VIN5 		: in STD_LOGIC;
        VOUT		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND6 : entity is TRUE;

end NEOAND6 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND6 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
					VIN4_ipd, VIN5_ipd)
   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;
   CONSTANT NEOAND6_0_tab : VitalTruthTableType (0 to 7, 0 to 6) := (
            ('1', '1', '1', '1', '1', '1', '1'),
            ('0', '-', '-', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '-', '-', '0'),
            ('-', '-', '0', '-', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '-', '0'),
            ('-', '-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', 'B', '0'));
   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOAND6_0_tab,
        DataIn => STD_LOGIC_VECTOR'( VIN0_ipd, VIN1_ipd, VIN2_ipd, 
				  VIN3_ipd, VIN4_ipd, VIN5_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND7 is
    generic (
        TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
        InstancePath  	: STRING  := "NEOAND7";
        tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN6_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND7 : entity is TRUE;

end NEOAND7 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND7 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';
    signal VIN6_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOAND7_0_tab : VitalTruthTableType (0 to 8, 0 to 7) := (
            ('1', '1', '1', '1', '1', '1', '1', '1'),
            ('0', '-', '-', '-', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '-', '-', '-', '0'),
            ('-', '-', '0', '-', '-', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '-', '-', '0'),
            ('-', '-', '-', '-', '0', '-', '-', '0'),
            ('-', '-', '-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOAND7_0_tab,
        DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd, VIN2_ipd, 
				VIN3_ipd, VIN4_ipd, VIN5_ipd, VIN6_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND8 is
    generic (
        TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
        InstancePath  	: STRING  := "NEOAND8";
        tpd_VIN0_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN6_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN7_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VIN7		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND8 : entity is TRUE;

end NEOAND8 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND8 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';
    signal VIN6_ipd  : STD_LOGIC := 'X';
    signal VIN7_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd, VIN7_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOAND8_0_tab : VitalTruthTableType (0 to 9, 0 to 8) := (
            ('1', '1', '1', '1', '1', '1', '1', '1', '1'),
            ('0', '-', '-', '-', '-', '-', '-', '-', '0'),
            ('-', '0', '-', '-', '-', '-', '-', '-', '0'),
            ('-', '-', '0', '-', '-', '-', '-', '-', '0'),
            ('-', '-', '-', '0', '-', '-', '-', '-', '0'),
            ('-', '-', '-', '-', '0', '-', '-', '-', '0'),
            ('-', '-', '-', '-', '-', '0', '-', '-', '0'),
            ('-', '-', '-', '-', '-', '-', '0', '-', '0'),
            ('-', '-', '-', '-', '-', '-', '-', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOAND8_0_tab,
        DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd, VIN7_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND16 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND16 is
    generic (
        TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
        InstancePath   	: STRING  := "NEOAND16";
        tpd_VIN0_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN1_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN2_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN3_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN4_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN5_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN6_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN7_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN8_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN9_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN10_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN11_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN12_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN13_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN14_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN15_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN8  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN9  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN10  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN11  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN12  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN13 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN14  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN15  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VIN7		 : in STD_LOGIC;
        VIN8		 : in STD_LOGIC;
        VIN9		 : in STD_LOGIC;
        VIN10		 : in STD_LOGIC;
        VIN11		 : in STD_LOGIC;
        VIN12		 : in STD_LOGIC;
        VIN13		 : in STD_LOGIC;
        VIN14		 : in STD_LOGIC;
        VIN15		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND16 : entity is TRUE;

end NEOAND16 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND16 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  	: STD_LOGIC := 'X';
    signal VIN1_ipd  	: STD_LOGIC := 'X';
    signal VIN2_ipd  	: STD_LOGIC := 'X';
    signal VIN3_ipd  	: STD_LOGIC := 'X';
    signal VIN4_ipd  	: STD_LOGIC := 'X';
    signal VIN5_ipd  	: STD_LOGIC := 'X';
    signal VIN6_ipd  	: STD_LOGIC := 'X';
    signal VIN7_ipd  	: STD_LOGIC := 'X';
    signal VIN8_ipd  	: STD_LOGIC := 'X';
    signal VIN9_ipd  	: STD_LOGIC := 'X';
    signal VIN10_ipd  	: STD_LOGIC := 'X';
    signal VIN11_ipd  	: STD_LOGIC := 'X';
    signal VIN12_ipd  	: STD_LOGIC := 'X';
    signal VIN13_ipd  	: STD_LOGIC := 'X';
    signal VIN14_ipd  	: STD_LOGIC := 'X';
    signal VIN15_ipd  	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   VitalWireDelay(VIN8_ipd, VIN8, tipd_VIN8);
   VitalWireDelay(VIN9_ipd, VIN9, tipd_VIN9);
   VitalWireDelay(VIN10_ipd, VIN10, tipd_VIN10);
   VitalWireDelay(VIN11_ipd, VIN11, tipd_VIN11);
   VitalWireDelay(VIN12_ipd, VIN12, tipd_VIN12);
   VitalWireDelay(VIN13_ipd, VIN13, tipd_VIN13);
   VitalWireDelay(VIN14_ipd, VIN14, tipd_VIN14);
   VitalWireDelay(VIN15_ipd, VIN15, tipd_VIN15);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd,
				VIN5_ipd, VIN6_ipd, VIN7_ipd, VIN8_ipd, 
				VIN9_ipd, VIN10_ipd, VIN11_ipd, VIN12_ipd,
				VIN13_ipd, VIN14_ipd, VIN15_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := 	(VIN0_ipd AND VIN1_ipd AND VIN2_ipd AND VIN3_ipd AND
	      	 VIN4_ipd AND VIN5_ipd AND VIN6_ipd AND VIN7_ipd AND
		 VIN8_ipd AND VIN9_ipd AND VIN10_ipd AND VIN11_ipd AND
		 VIN12_ipd AND VIN13_ipd AND VIN14_ipd AND VIN15_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE),
               8 => (VIN8_ipd'LAST_EVENT, tpd_VIN8_VOUT, TRUE),
               9 => (VIN9_ipd'LAST_EVENT, tpd_VIN9_VOUT, TRUE),
               10 => (VIN10_ipd'LAST_EVENT, tpd_VIN10_VOUT, TRUE),
               11 => (VIN11_ipd'LAST_EVENT, tpd_VIN11_VOUT, TRUE),
               12 => (VIN12_ipd'LAST_EVENT, tpd_VIN12_VOUT, TRUE),
               13 => (VIN13_ipd'LAST_EVENT, tpd_VIN13_VOUT, TRUE),
               14 => (VIN14_ipd'LAST_EVENT, tpd_VIN14_VOUT, TRUE),
               15 => (VIN15_ipd'LAST_EVENT, tpd_VIN15_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOAND32 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOAND32 is
    generic (
        TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
        InstancePath   	: STRING  := "NEOAND32";
        tpd_VIN0_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN1_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN2_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN3_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN4_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN5_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN6_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN7_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN8_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN9_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN10_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN11_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN12_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN13_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN14_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN15_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN16_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN17_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN18_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN19_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN20_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN21_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN22_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN23_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN24_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN25_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN26_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN27_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN28_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN29_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN30_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN31_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN8  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN9  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN10  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN11  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN12  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN13 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN14  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN15  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN16  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN17  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN18  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN19  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN20  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN21  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN22  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN23  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN24  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN25  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN26  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN27  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN28 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN29  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN30  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN31  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VIN7		 : in STD_LOGIC;
        VIN8		 : in STD_LOGIC;
        VIN9		 : in STD_LOGIC;
        VIN10		 : in STD_LOGIC;
        VIN11		 : in STD_LOGIC;
        VIN12		 : in STD_LOGIC;
        VIN13		 : in STD_LOGIC;
        VIN14		 : in STD_LOGIC;
        VIN15		 : in STD_LOGIC;
        VIN16		 : in STD_LOGIC;
        VIN17		 : in STD_LOGIC;
        VIN18		 : in STD_LOGIC;
        VIN19		 : in STD_LOGIC;
        VIN20		 : in STD_LOGIC;
        VIN21		 : in STD_LOGIC;
        VIN22		 : in STD_LOGIC;
        VIN23		 : in STD_LOGIC;
        VIN24		 : in STD_LOGIC;
        VIN25		 : in STD_LOGIC;
        VIN26		 : in STD_LOGIC;
        VIN27		 : in STD_LOGIC;
        VIN28		 : in STD_LOGIC;
        VIN29		 : in STD_LOGIC;
        VIN30		 : in STD_LOGIC;
        VIN31		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOAND32 : entity is TRUE;

end NEOAND32 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOAND32 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  	: STD_LOGIC := 'X';
    signal VIN1_ipd  	: STD_LOGIC := 'X';
    signal VIN2_ipd  	: STD_LOGIC := 'X';
    signal VIN3_ipd  	: STD_LOGIC := 'X';
    signal VIN4_ipd  	: STD_LOGIC := 'X';
    signal VIN5_ipd  	: STD_LOGIC := 'X';
    signal VIN6_ipd  	: STD_LOGIC := 'X';
    signal VIN7_ipd  	: STD_LOGIC := 'X';
    signal VIN8_ipd  	: STD_LOGIC := 'X';
    signal VIN9_ipd  	: STD_LOGIC := 'X';
    signal VIN10_ipd  	: STD_LOGIC := 'X';
    signal VIN11_ipd  	: STD_LOGIC := 'X';
    signal VIN12_ipd  	: STD_LOGIC := 'X';
    signal VIN13_ipd  	: STD_LOGIC := 'X';
    signal VIN14_ipd  	: STD_LOGIC := 'X';
    signal VIN15_ipd  	: STD_LOGIC := 'X';
    signal VIN16_ipd  	: STD_LOGIC := 'X';
    signal VIN17_ipd  	: STD_LOGIC := 'X';
    signal VIN18_ipd  	: STD_LOGIC := 'X';
    signal VIN19_ipd  	: STD_LOGIC := 'X';
    signal VIN20_ipd  	: STD_LOGIC := 'X';
    signal VIN21_ipd  	: STD_LOGIC := 'X';
    signal VIN22_ipd  	: STD_LOGIC := 'X';
    signal VIN23_ipd  	: STD_LOGIC := 'X';
    signal VIN24_ipd  	: STD_LOGIC := 'X';
    signal VIN25_ipd  	: STD_LOGIC := 'X';
    signal VIN26_ipd  	: STD_LOGIC := 'X';
    signal VIN27_ipd  	: STD_LOGIC := 'X';
    signal VIN28_ipd  	: STD_LOGIC := 'X';
    signal VIN29_ipd  	: STD_LOGIC := 'X';
    signal VIN30_ipd  	: STD_LOGIC := 'X';
    signal VIN31_ipd  	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   VitalWireDelay(VIN8_ipd, VIN8, tipd_VIN8);
   VitalWireDelay(VIN9_ipd, VIN9, tipd_VIN9);
   VitalWireDelay(VIN10_ipd, VIN10, tipd_VIN10);
   VitalWireDelay(VIN11_ipd, VIN11, tipd_VIN11);
   VitalWireDelay(VIN12_ipd, VIN12, tipd_VIN12);
   VitalWireDelay(VIN13_ipd, VIN13, tipd_VIN13);
   VitalWireDelay(VIN14_ipd, VIN14, tipd_VIN14);
   VitalWireDelay(VIN15_ipd, VIN15, tipd_VIN15);
   VitalWireDelay(VIN16_ipd, VIN16, tipd_VIN16);
   VitalWireDelay(VIN17_ipd, VIN17, tipd_VIN17);
   VitalWireDelay(VIN18_ipd, VIN18, tipd_VIN18);
   VitalWireDelay(VIN19_ipd, VIN19, tipd_VIN19);
   VitalWireDelay(VIN20_ipd, VIN20, tipd_VIN20);
   VitalWireDelay(VIN21_ipd, VIN21, tipd_VIN21);
   VitalWireDelay(VIN22_ipd, VIN22, tipd_VIN22);
   VitalWireDelay(VIN23_ipd, VIN23, tipd_VIN23);
   VitalWireDelay(VIN24_ipd, VIN24, tipd_VIN24);
   VitalWireDelay(VIN25_ipd, VIN25, tipd_VIN25);
   VitalWireDelay(VIN26_ipd, VIN26, tipd_VIN26);
   VitalWireDelay(VIN27_ipd, VIN27, tipd_VIN27);
   VitalWireDelay(VIN28_ipd, VIN28, tipd_VIN28);
   VitalWireDelay(VIN29_ipd, VIN29, tipd_VIN29);
   VitalWireDelay(VIN30_ipd, VIN30, tipd_VIN30);
   VitalWireDelay(VIN31_ipd, VIN31, tipd_VIN31);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd,
				VIN5_ipd, VIN6_ipd, VIN7_ipd, VIN8_ipd, 
				VIN9_ipd, VIN10_ipd, VIN11_ipd, VIN12_ipd,
				VIN13_ipd, VIN14_ipd, VIN15_ipd, VIN16_ipd,
				VIN17_ipd, VIN18_ipd, VIN19_ipd, VIN20_ipd,
				VIN21_ipd, VIN22_ipd, VIN23_ipd, VIN24_ipd,
				VIN25_ipd, VIN26_ipd, VIN27_ipd, VIN28_ipd,
				VIN29_ipd, VIN30_ipd, VIN31_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd :=  ((VIN0_ipd AND VIN1_ipd AND VIN2_ipd AND VIN3_ipd AND
	      	 VIN4_ipd AND VIN5_ipd AND VIN6_ipd AND VIN7_ipd AND
		 VIN8_ipd AND VIN9_ipd AND VIN10_ipd AND VIN11_ipd AND
		 VIN12_ipd AND VIN13_ipd AND VIN14_ipd AND VIN15_ipd) AND
		(VIN16_ipd AND VIN17_ipd AND VIN18_ipd AND VIN19_ipd AND
		 VIN20_ipd AND VIN21_ipd AND VIN22_ipd AND VIN23_ipd AND
		 VIN24_ipd AND VIN25_ipd AND VIN26_ipd AND VIN27_ipd AND
		 VIN28_ipd AND VIN29_ipd AND VIN30_ipd AND VIN31_ipd));
		

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE),
               8 => (VIN8_ipd'LAST_EVENT, tpd_VIN8_VOUT, TRUE),
               9 => (VIN9_ipd'LAST_EVENT, tpd_VIN9_VOUT, TRUE),
               10 => (VIN10_ipd'LAST_EVENT, tpd_VIN10_VOUT, TRUE),
               11 => (VIN11_ipd'LAST_EVENT, tpd_VIN11_VOUT, TRUE),
               12 => (VIN12_ipd'LAST_EVENT, tpd_VIN12_VOUT, TRUE),
               13 => (VIN13_ipd'LAST_EVENT, tpd_VIN13_VOUT, TRUE),
               14 => (VIN14_ipd'LAST_EVENT, tpd_VIN14_VOUT, TRUE),
               15 => (VIN15_ipd'LAST_EVENT, tpd_VIN15_VOUT, TRUE),
               16 => (VIN16_ipd'LAST_EVENT, tpd_VIN16_VOUT, TRUE),
               17 => (VIN17_ipd'LAST_EVENT, tpd_VIN17_VOUT, TRUE),
               18 => (VIN18_ipd'LAST_EVENT, tpd_VIN18_VOUT, TRUE),
               19 => (VIN19_ipd'LAST_EVENT, tpd_VIN19_VOUT, TRUE),
               20 => (VIN20_ipd'LAST_EVENT, tpd_VIN20_VOUT, TRUE),
               21 => (VIN21_ipd'LAST_EVENT, tpd_VIN21_VOUT, TRUE),
               22 => (VIN22_ipd'LAST_EVENT, tpd_VIN22_VOUT, TRUE),
               23 => (VIN23_ipd'LAST_EVENT, tpd_VIN23_VOUT, TRUE),
               24 => (VIN14_ipd'LAST_EVENT, tpd_VIN24_VOUT, TRUE),
               25 => (VIN25_ipd'LAST_EVENT, tpd_VIN25_VOUT, TRUE),
               26 => (VIN26_ipd'LAST_EVENT, tpd_VIN26_VOUT, TRUE),
               27 => (VIN27_ipd'LAST_EVENT, tpd_VIN27_VOUT, TRUE),
               28 => (VIN28_ipd'LAST_EVENT, tpd_VIN28_VOUT, TRUE),
               29 => (VIN29_ipd'LAST_EVENT, tpd_VIN29_VOUT, TRUE),
               30 => (VIN30_ipd'LAST_EVENT, tpd_VIN30_VOUT, TRUE),
               31 => (VIN31_ipd'LAST_EVENT, tpd_VIN31_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOBPAD -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOBPAD is
    generic (
        TimingChecksOn  : BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
        InstancePath    : STRING  := "NEOBPAD";
        tipd_PAD  	: VitalDelayType01 	:= (0 ns, 0 ns)) ;

    port (
        PAD 		: inout STD_LOGIC := 'Z');

    attribute VITAL_LEVEL0 of NEOBPAD : entity is TRUE;

end NEOBPAD ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOBPAD is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal PAD_ipd  : STD_LOGIC := 'X';
begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(PAD_ipd, PAD, tipd_PAD);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process(PAD_ipd) 

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS PAD_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables

   begin

   IF (TimingChecksOn) THEN
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   PAD_zd := PAD_ipd;

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------

   end process;

end V;


--
----- CELL NEOBUF -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOBUF is
    generic (
	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
	InstancePath	: STRING := "NEOBUF";
	tpd_VIN_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
	VIN  : in STD_LOGIC;
	VOUT : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOBUF : entity is TRUE;

end NEOBUF ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOBUF is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN_ipd, VIN, tipd_VIN);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
    VitalBehavior : process (VIN_ipd)
    
    -- functionality results
    VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
    ALIAS VOUT_zd : STD_ULOGIC is Results(1);

    -- output glitch detection variables
    VARIABLE VOUT_GlitchData : VitalGlitchDataType;

    begin

    IF (TimingChecksOn) THEN
    -----------------------------------
    -- No Timing Checks for a comb gate
    -----------------------------------
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    VOUT_zd := VitalBUF(VIN_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN_ipd'LAST_EVENT, tpd_VIN_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOCKBUF -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;

-- entity declaration --
entity NEOCKBUF is
    generic (
	TimingChecksOn		: BOOLEAN := TRUE;
      	XOn                     : BOOLEAN := FALSE;
      	MsgOn                   : BOOLEAN := TRUE;
	InstancePath		: STRING  := "NEOCKBUF";
	tpd_VIN_VOUT            : VitalDelayType01 := (0 ns, 0 ns);
	tipd_VIN                : VitalDelayType01 := (0 ns, 0 ns);
	-- Period check generic declarations
	tperiod_VIN		: VitalDelayType := 0 ns;
	tpw_VIN_posedge		: VitalDelayType := 0 ns;
	tpw_VIN_negedge		: VitalDelayType := 0 ns);

   port(
	VIN                       :	in    STD_LOGIC;
	VOUT                      :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOCKBUF : entity is TRUE;

end NEOCKBUF;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOCKBUF is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   signal VIN_ipd  : STD_LOGIC := 'X';
  
begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (VIN_ipd, VIN, tipd_VIN);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd    : STD_ULOGIC is Results(1);

   -- PeriodCheck variables
   VARIABLE Tviol_VIN	: STD_ULOGIC := '0';
   VARIABLE PeriodCheckInfo_VIN : VitalPeriodDataType := VitalPeriodDataInit;
					
   -- output glitch detection variables
   VARIABLE VOUT_GlitchData 	: VitalGlitchDataType;

   begin

	IF (TimingChecksOn) THEN

	-- perform max & min period and pulse checks
	VitalPeriodPulseCheck (
		TestSignal 	=> VIN_ipd, 
		TestSignalName 	=> "VIN", 
		Period 		=> tperiod_VIN, 
		PulseWidthHigh 	=> tpw_VIN_posedge, 
		PulseWidthlow 	=> tpw_VIN_negedge, 
	  	PeriodData 	=> PeriodCheckInfo_VIN, 
		Violation 	=> Tviol_VIN, 
	  	MsgOn 		=> MsgOn, 
		XOn 		=> XOn, 
		HeaderMsg 	=> InstancePath, 
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);

	END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    VOUT_zd := VitalBUF(VIN_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN_ipd'LAST_EVENT, tpd_VIN_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOFF -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOFF is
    generic (
        TimingChecksOn 	: BOOLEAN := TRUE;
	XOn		: BOOLEAN := FALSE;
	MsgOn		: BOOLEAN := TRUE;
	InstancePath   	: STRING := "NEOFF";
	-- Propagation Delays
        tpd_CLK_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_CE_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_SET_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_RST_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
	-- Setup and Hold Constraints
        tsetup_VIN_CLK_noedge_posedge   : VitalDelayType := 0 ns ;
        thold_VIN_CLK_noedge_posedge    : VitalDelayType := 0 ns ;
        tsetup_SET_CLK_noedge_posedge   : VitalDelayType := 0 ns ;
        thold_SET_CLK_noedge_posedge    : VitalDelayType := 0 ns ;
        tsetup_RST_CLK_noedge_posedge   : VitalDelayType := 0 ns ;
        thold_RST_CLK_noedge_posedge    : VitalDelayType := 0 ns ;
        tsetup_CE_CLK_noedge_posedge    : VitalDelayType := 0 ns ;
        thold_CE_CLK_noedge_posedge     : VitalDelayType := 0 ns ;
	-- Input Signal Delays
        tipd_VIN  		: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_CLK  		: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_CE  		: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_SET  		: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_RST  		: VitalDelayType01 := (0 ns, 0 ns) ;
	-- Pulse Width Constraints
	tperiod_CLK		: VitalDelayType := 0 ns;
	tpw_CLK_posedge		: VitalDelayType := 0 ns;
	tpw_CLK_negedge		: VitalDelayType := 0 ns;
	tperiod_RST		: VitalDelayType := 0 ns;
	tpw_RST_posedge		: VitalDelayType := 0 ns;
	tpw_RST_negedge		: VitalDelayType := 0 ns;
	tperiod_SET		: VitalDelayType := 0 ns;
	tpw_SET_posedge		: VitalDelayType := 0 ns;
	tpw_SET_negedge		: VitalDelayType := 0 ns);

    port (
        VIN			: in STD_LOGIC;
        CLK			: in STD_LOGIC;
        SET 			: in STD_LOGIC;
	RST 			: in STD_LOGIC;
	CE			: in STD_LOGIC;
        VOUT 			: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOFF : entity is TRUE;

end NEOFF ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOFF is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN_ipd  : STD_LOGIC := 'X';
    signal CLK_ipd  : STD_LOGIC := 'X';
    signal CE_ipd   : STD_LOGIC := 'X';
    signal SET_ipd  : STD_LOGIC := 'X';
    signal RST_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
       VitalWireDelay(VIN_ipd, VIN, tipd_VIN);
       VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
       VitalWireDelay(CE_ipd, CE, tipd_CE);
       VitalWireDelay(SET_ipd, SET, tipd_SET);
       VitalWireDelay(RST_ipd, RST, tipd_RST);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (VIN_ipd, CLK_ipd, CE_ipd, SET_ipd, RST_ipd)

   CONSTANT DFF_table : VitalStateTableType(0 to 8, 0 to 7) := (
         -- viol CLK  CLR  PRE   CE   D    Q   Qnew
           ('X', '-', '-', '-', '-', '-', '-', 'X'),    -- Timing Violation
           ('-', '-', '1', '-', '-', '-', '-', '0'),    -- Async. Clear
           ('-', '-', '0', '1', '-', '-', '-', '1'),    -- Async. Preset
           ('-', '-', '0', '0', '0', '-', '-', 'S'),    -- Clock disabled
           ('-', '/', '0', '0', '1', '0', '-', '0'),    -- Low d->q on rising edge CLK
           ('-', '/', '0', '0', '1', '1', '-', '1'),    -- High d->q on rising edge CLK
           ('-', '/', '0', '0', '1', 'X', '-', 'X'),    -- Clock an X if d is X
           ('-', '/', '0', '0', 'X', '-', '-', 'X'),    -- CE is unknown on rising edge
           ('-', 'B', '0', '0', '-', '-', '-', 'S')) ;  -- Non-X clock (e.g. falling)  preserve Q

   -- Timing Check Results :
   VARIABLE Tviol_CLK 	: STD_ULOGIC := '0';
   VARIABLE Tviol_VIN 	: STD_ULOGIC := '0';
   VARIABLE Tviol_CE 	: STD_ULOGIC := '0';
   VARIABLE Tviol_SET 	: STD_ULOGIC := '0';
   VARIABLE Tviol_RST 	: STD_ULOGIC := '0';
   VARIABLE Tviol_SETPW	: STD_ULOGIC := '0';
   VARIABLE Tviol_RSTPW	: STD_ULOGIC := '0';
   VARIABLE PeriodCheckInfo_CLK : VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE PeriodCheckInfo_RST : VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE PeriodCheckInfo_SET : VitalPeriodDataType := VitalPeriodDataInit;

   -- Functionality Results :
   VARIABLE Violation 	: STD_ULOGIC := '0';
   VARIABLE PrevData 	: STD_LOGIC_VECTOR (0 to 5);
   VARIABLE Results 	: STD_LOGIC_VECTOR (1 to 1) := "X";

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData	: VitalGlitchDataType;
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   VARIABLE VIN_CLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE SET_CLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE RST_CLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE CE_CLK_TimingDataSH  : VitalTimingDataType := VitalTimingDataInit;

   begin
   ------------------------
   --  Timing Check Section
   ------------------------

    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
		TestSignal	=> VIN_ipd, 
		TestSignalName 	=> "VIN", 
		RefSignal 	=> CLK_ipd,
		RefSignalName 	=> "CLK",
		SetupHigh 	=> tsetup_VIN_CLK_noedge_posedge, 
		SetupLow 	=> tsetup_VIN_CLK_noedge_posedge, 
		HoldHigh 	=> thold_VIN_CLK_noedge_posedge, 
		HoldLow 	=> thold_VIN_CLK_noedge_posedge, 
		CheckEnabled	=> (CE_ipd='1' AND RST_ipd='0' 
						AND SET_ipd='0'),
		RefTransition 	=> '/',
		MsgOn 		=> MsgOn, 
		XOn		=> XOn,
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> VIN_CLK_TimingDataSH, 
		Violation 	=> Tviol_VIN, 
		MsgSeverity 	=> WARNING);
	VitalSetupHoldCheck (
		TestSignal 	=> SET_ipd, 
		TestSignalName 	=> "SET", 
		RefSignal 	=> CLK_ipd,
		RefSignalName 	=> "CLK",
		SetupHigh 	=> tsetup_SET_CLK_noedge_posedge, 
		SetupLow 	=> tsetup_SET_CLK_noedge_posedge, 
		HoldHigh 	=> thold_SET_CLK_noedge_posedge, 
		HoldLow 	=> thold_SET_CLK_noedge_posedge, 
		CheckEnabled 	=> TRUE, -- check enabled
		RefTransition 	=> '/',
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> SET_CLK_TimingDataSH, 
		Violation 	=> Tviol_SET, 
		MsgSeverity 	=> WARNING);
	VitalSetupHoldCheck (
		TestSignal 	=> RST_ipd, 
		TestSignalName 	=> "RST", 
		RefSignal 	=> CLK_ipd,
		RefSignalName 	=> "CLK",
		SetupHigh 	=> tsetup_RST_CLK_noedge_posedge, 
		SetupLow 	=> tsetup_RST_CLK_noedge_posedge, 
		HoldHigh 	=> thold_RST_CLK_noedge_posedge, 
		HoldLow 	=> thold_RST_CLK_noedge_posedge, 
		CheckEnabled 	=> TRUE, -- check enabled
		RefTransition 	=> '/',
		MsgOn 		=> MsgOn, 
		XOn	 	=> XOn,
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> RST_CLK_TimingDataSH, 
		Violation 	=> Tviol_RST, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> CE_ipd, 
		TestSignalName 	=> "CE", 
		RefSignal 	=> CLK_ipd,
		RefSignalName 	=> "CLK",
		SetupHigh 	=> tsetup_CE_CLK_noedge_posedge, 
		SetupLow 	=> tsetup_CE_CLK_noedge_posedge, 
		HoldHigh 	=> thold_CE_CLK_noedge_posedge, 
		HoldLow 	=> thold_CE_CLK_noedge_posedge, 
		CheckEnabled	=> (RST_ipd='0' AND SET_ipd='0'),
		RefTransition 	=> '/',
		MsgOn 		=> MsgOn, 
		XOn	 	=> XOn,
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> CE_CLK_TimingDataSH, 
		Violation 	=> Tviol_CE, 
		MsgSeverity 	=> WARNING);
        VitalPeriodPulseCheck (
		TestSignal 	=> CLK_ipd, 
		TestSignalName 	=> "CLK", 
		Period 	=> tperiod_CLK,
		PulseWidthHigh 	=> tpw_CLK_posedge, 
		PulseWidthLow 	=> tpw_CLK_negedge, 
		PeriodData 	=> PeriodCheckInfo_CLK,
	    	Violation 	=> Tviol_CLK,
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath, 
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
        VitalPeriodPulseCheck (
		TestSignal 	=> RST_ipd,
		TestSignalName 	=> "RST",
		Period 		=> tperiod_RST,
		PulseWidthHigh 	=> tpw_RST_posedge,
		PulseWidthLow 	=> tpw_RST_negedge,
		PeriodData 	=> PeriodCheckInfo_RST,
		Violation 	=> Tviol_RSTPW,
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
        VitalPeriodPulseCheck (
		TestSignal 	=> SET_ipd,
		TestSignalName 	=> "SET",
		Period 		=> tperiod_SET,
		PulseWidthHigh 	=> tpw_SET_posedge,
		PulseWidthLow 	=> tpw_SET_negedge,
		PeriodData 	=> PeriodCheckInfo_SET,
		Violation 	=> Tviol_SETPW,
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
    END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
--   Violation := Tviol_VIN OR Tviol_SET OR Tviol_RST OR Tviol_CE OR Tviol_CLK
--			OR Tviol_RSTPW OR Tviol_SETPW;

    VitalStateTable(StateTable => DFF_table,
            DataIn => (Violation, CLK_ipd, RST_ipd, SET_ipd, CE_ipd, VIN_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (CLK_ipd'LAST_EVENT, tpd_CLK_VOUT, TRUE),
               1 => (RST_ipd'LAST_EVENT, tpd_RST_VOUT, TRUE),
               2 => (SET_ipd'LAST_EVENT, tpd_SET_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOINV -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOINV is
    generic (
        TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
	InstancePath  	: STRING  := "NEOINV";
	tpd_VIN_VOUT 	: VitalDelayType01 := (0 ns, 0 ns);
	tipd_VIN  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
	VIN 		: in STD_LOGIC;
	VOUT 		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOINV : entity is TRUE;

end NEOINV ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOINV is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN_ipd, VIN, tipd_VIN);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData	: VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
    -----------------------------------
    -- No Timing Checks for a comb gate
    -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalINV(VIN_ipd);

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN_ipd'LAST_EVENT, tpd_VIN_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOIPAD -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOIPAD is
    generic (
        TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
      	MsgOn		: BOOLEAN := FALSE;
        InstancePath  	: STRING  := "NEOIPAD";
        tipd_PAD  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        PAD 		: in STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOIPAD : entity is TRUE;

end NEOIPAD ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOIPAD is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal PAD_ipd  : STD_LOGIC := 'X';
begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
    VitalWireDelay(PAD_ipd, PAD, tipd_PAD);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
    VitalBehavior : process (PAD_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS PAD_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   -- VARIABLE PAD_GlitchData     : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   PAD_zd := PAD_ipd;

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------

   end process;

end V;


--
----- CELL NEOLATCH -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOLATCH is
    generic (
	TimingChecksOn 		: BOOLEAN := TRUE;
      	XOn                     : BOOLEAN := FALSE;
      	MsgOn                   : BOOLEAN := TRUE;
	InstancePath		: STRING := "NEOLATCH";
	-- Propagation Delays
        tpd_CLK_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN_VOUT		: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_SET_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_RST_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
	-- Setup and Hold Constraints
        tsetup_VIN_CLK_noedge_negedge  : VitalDelayType := 0 ns ;
        thold_VIN_CLK_noedge_negedge   : VitalDelayType := 0 ns ;
        tsetup_SET_CLK_noedge_negedge  : VitalDelayType := 0 ns ;
        thold_SET_CLK_noedge_negedge   : VitalDelayType := 0 ns ;
        tsetup_RST_CLK_noedge_negedge  : VitalDelayType := 0 ns ;
        thold_RST_CLK_noedge_negedge   : VitalDelayType := 0 ns ;
	-- Input Signal Delays
        tipd_VIN 		: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_CLK  		: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_SET  		: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_RST  		: VitalDelayType01 := (0 ns, 0 ns) ;
        -- Pulse Width Constraints
        tperiod_CLK             : VitalDelayType := 0 ns;
        tpw_CLK_posedge         : VitalDelayType := 0 ns;
        tpw_CLK_negedge         : VitalDelayType := 0 ns;
        tperiod_RST             : VitalDelayType := 0 ns;
        tpw_RST_posedge         : VitalDelayType := 0 ns;
        tpw_RST_negedge         : VitalDelayType := 0 ns;
        tperiod_SET             : VitalDelayType := 0 ns;
        tpw_SET_posedge         : VitalDelayType := 0 ns;
        tpw_SET_negedge         : VitalDelayType := 0 ns);

    port (
        VIN	 : in STD_LOGIC;
        CLK	 : in STD_LOGIC;
        SET	 : in STD_LOGIC;
        RST  	 : in STD_LOGIC;
        VOUT 	 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOLATCH : entity is TRUE;

end NEOLATCH ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOLATCH is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN_ipd  : STD_LOGIC := 'X';
    signal CLK_ipd  : STD_LOGIC := 'X';
    signal SET_ipd  : STD_LOGIC := 'X';
    signal RST_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay(VIN_ipd, VIN, tipd_VIN);
   VitalWireDelay(SET_ipd, SET, tipd_SET);
   VitalWireDelay(RST_ipd, RST, tipd_RST);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (CLK_ipd, VIN_ipd, SET_ipd, RST_ipd)

   CONSTANT LATCH1_table : VitalStateTableType (0 to 6, 0 to 7) := (
         -- viol  L   CLR  PRE   CE   D    Q   Qnew
           ('X', '-', '-', '-', '-', '-', '-', 'X'),    -- Timing Violation
           ('-', '-', '1', '-', '-', '-', '-', '0'),    -- Async. Clear
           ('-', '-', '0', '1', '-', '-', '-', '1'),    -- Async. Preset
           ('-', '1', '0', '0', '1', '0', '-', '0'),    -- Low d->q on High L
           ('-', '1', '0', '0', '1', '1', '-', '1'),    -- High d->q on High L
           ('-', '1', '0', '0', '1', 'X', '-', 'X'),    -- Clock an X if d is X
           ('-', '0', '-', '-', '-', '-', '-', 'S')) ;  -- Low L : preserve Q


   -- Timing Check Results :
   VARIABLE Tviol_CLK : STD_ULOGIC := '0';
   VARIABLE Tviol_VIN : STD_ULOGIC := '0';
   VARIABLE Tviol_SET : STD_ULOGIC := '0';
   VARIABLE Tviol_RST : STD_ULOGIC := '0';
   VARIABLE Tviol_SETPW : STD_ULOGIC := '0';
   VARIABLE Tviol_RSTPW	: STD_ULOGIC := '0';
   VARIABLE PeriodCheckInfo_CLK : VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE PeriodCheckInfo_RST : VitalPeriodDataType := VitalPeriodDataInit;
   VARIABLE PeriodCheckInfo_SET : VitalPeriodDataType := VitalPeriodDataInit;

   -- Functionality Results :
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData : STD_LOGIC_VECTOR (0 to 5);
   VARIABLE Results  : STD_LOGIC_VECTOR (1 to 1) := "X";


   -- Output Glitch Results :
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;
   ALIAS VOUT_zd  : STD_ULOGIC IS Results(1);
 
   VARIABLE VIN_CLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE SET_CLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE RST_CLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;

   begin

   IF (TimingChecksOn) THEN
	VitalSetupHoldCheck (
		TestSignal 	=> VIN_ipd,
		TestSignalName 	=> "VIN",
		RefSignal 	=> CLK_ipd,
		RefSignalName 	=> "CLK",
		SetupHigh 	=> tsetup_VIN_CLK_noedge_negedge,
		SetupLow 	=> tsetup_VIN_CLK_noedge_negedge,
		HoldHigh 	=> thold_VIN_CLK_noedge_negedge,
		HoldLow 	=> thold_VIN_CLK_noedge_negedge,
		CheckEnabled	=> (RST_ipd='0' AND SET_ipd='0'),
		RefTransition 	=> '\',
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath,
		TimingData 	=> VIN_CLK_TimingDataSH,
		Violation 	=> Tviol_VIN, 
		MsgSeverity 	=> WARNING);
	VitalSetupHoldCheck (
		TestSignal 	=> SET_ipd,                
		TestSignalName 	=> "SET",
		RefSignal 	=> CLK_ipd,
		RefSignalName 	=> "CLK",
		SetupHigh 	=> tsetup_SET_CLK_noedge_negedge,
		SetupLow 	=> tsetup_SET_CLK_noedge_negedge,
		HoldHigh 	=> thold_SET_CLK_noedge_negedge,
		HoldLow 	=> thold_SET_CLK_noedge_negedge,
		CheckEnabled 	=> TRUE, -- check enabled
		RefTransition 	=> '\',
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath,
		TimingData 	=> SET_CLK_TimingDataSH,
		Violation 	=> Tviol_SET, 
		MsgSeverity 	=> WARNING);
	VitalSetupHoldCheck (
		TestSignal 	=> RST_ipd,		     
		TestSignalName 	=> "RST",
		RefSignal 	=> CLK_ipd,
		RefSignalName 	=> "CLK",
		SetupHigh 	=> tsetup_RST_CLK_noedge_negedge,
		SetupLow 	=> tsetup_RST_CLK_noedge_negedge,
		HoldHigh 	=> thold_RST_CLK_noedge_negedge,
		HoldLow 	=> thold_RST_CLK_noedge_negedge,
		CheckEnabled 	=> TRUE, -- check enabled
		RefTransition 	=> '\',
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath,
		TimingData 	=> RST_CLK_TimingDataSH,
		Violation 	=> Tviol_RST, 
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> CLK_ipd,
		TestSignalName 	=> "CLK",
		Period 		=> tperiod_CLK,
		PulseWidthHigh 	=> tpw_CLK_posedge,
		PulseWidthLow 	=> tpw_CLK_negedge,
		PeriodData 	=> PeriodCheckInfo_CLK,
		Violation 	=> Tviol_CLK,
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> RST_ipd,
		TestSignalName 	=> "RST",
		Period 		=> tperiod_RST,
		PulseWidthHigh 	=> tpw_RST_posedge,
		PulseWidthLow 	=> tpw_RST_negedge,
		PeriodData 	=> PeriodCheckInfo_RST,
		Violation 	=> Tviol_RSTPW,
		MsgOn 		=> MsgOn, 
		XOn 		=> XOn,
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> SET_ipd,
		TestSignalName 	=> "SET",
		Period 		=> tperiod_SET,
		PulseWidthHigh 	=> tpw_SET_posedge,
		PulseWidthLow 	=> tpw_SET_negedge,
		PeriodData 	=> PeriodCheckInfo_SET,
		Violation 	=> Tviol_SETPW,
		MsgOn 		=> MsgOn, 
		XOn	 	=> XOn,
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
--   Violation := Tviol_VIN OR Tviol_SET OR Tviol_RST OR Tviol_SETPW OR
--			Tviol_RSTPW;

   VitalStateTable(StateTable => LATCH1_table,
            DataIn => (Violation, CLK_ipd, RST_ipd, SET_ipd, '1', VIN_ipd),
            NumStates => 1,
            Result => Results,
            PreviousDataIn => PrevData);

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN_ipd'LAST_EVENT, tpd_VIN_VOUT, TRUE),
               1 => (CLK_ipd'LAST_EVENT, tpd_CLK_VOUT, TRUE),
               2 => (RST_ipd'LAST_EVENT, tpd_RST_VOUT, TRUE),
               3 => (SET_ipd'LAST_EVENT, tpd_SET_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOONE -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NEOONE is
   generic(
	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
	InstancePath	: STRING  := "NEOONE");

   port(
	VOUT            : out   STD_LOGIC := '1');

    attribute VITAL_LEVEL0 of NEOONE : entity is TRUE;

end NEOONE;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOONE is

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   --  empty
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VOUT <= '1';

end V;


--
----- CELL NEOOPAD -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOPAD is
    generic (
        TimingChecksOn  : BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
        InstancePath    : STRING  := "NEOOPAD");

    port (
        PAD 		: out STD_LOGIC := 'Z');

    attribute VITAL_LEVEL0 of NEOOPAD : entity is TRUE;

end NEOOPAD ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOPAD is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal PAD_ipd  : STD_LOGIC := 'X';
begin
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin

   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (PAD_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS PAD_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   -- VARIABLE PAD_GlitchData     : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   PAD_zd := PAD_ipd;

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------

   end process;

end V;


--
----- CELL NEOOR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR2 is
    generic (
        TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
        InstancePath	: STRING  := "NEOOR2";
        tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
        tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0	 	: in STD_LOGIC;
        VIN1		: in STD_LOGIC;
        VOUT		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR2 : entity is TRUE;

end NEOOR2 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR2 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOOR2_0_tab : VitalTruthTableType (0 to 3, 0 to 2) := (
            ('1', '-', '1'),
            ('-', '1', '1'),
            ('0', '0', '0'),
            ('B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

    begin

    IF (TimingChecksOn) THEN
    -----------------------------------
    -- No Timing Checks for a comb gate
    -----------------------------------
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    VOUT_zd := VitalTruthTable(TruthTable => NEOOR2_0_tab,
        DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR3 is
    generic (
	TimingChecksOn  : BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
	InstancePath    : STRING := "NEOOR3";
	tpd_VIN0_VOUT   : VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN1_VOUT   : VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN2_VOUT   : VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN0       : VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN1       : VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN2       : VitalDelayType01 := (0 ns, 0 ns));

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2 		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR3 : entity is TRUE;

end NEOOR3 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR3 is

    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process ( VIN0_ipd, VIN1_ipd, VIN2_ipd)


   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';

   CONSTANT NEOOR3_0_tab : VitalTruthTableType (0 to 4, 0 to 3) := (
            ('1', '-', '-', '1'),
            ('-', '1', '-', '1'),
            ('-', '-', '1', '1'),
            ('0', '0', '0', '0'),
            ('B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOOR3_0_tab,
        DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd, VIN2_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR4 is
    generic (
	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
 	InstancePath	: STRING  := "NEOOR4";
	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0	 	: in STD_LOGIC;
        VIN1	 	: in STD_LOGIC;
        VIN2	 	: in STD_LOGIC;
        VIN3	 	: in STD_LOGIC;
        VOUT 	 	: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR4 : entity is TRUE;

end NEOOR4 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR4 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
    WireDelay : block
    begin
    VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
    VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
    VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
    VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
    end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process ( VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';

   CONSTANT NEOOR4_0_tab : VitalTruthTableType (0 to 5, 0 to 4) := (
            ('1', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '1'),
            ('-', '-', '1', '-', '1'),
            ('-', '-', '-', '1', '1'),
            ('0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData 	: VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOOR4_0_tab,
        DataIn => STD_LOGIC_VECTOR'( VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR5 is
    generic (
 	TimingChecksOn		: BOOLEAN := TRUE;
      	XOn			: BOOLEAN := FALSE;
    	MsgOn			: BOOLEAN := FALSE;
 	InstancePath		: STRING := "NEOOR5";
	tpd_VIN0_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN1_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN2_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN3_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
	tpd_VIN4_VOUT 		: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN0 	 	: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN1  		: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN2  		: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN3  		: VitalDelayType01 := (0 ns, 0 ns) ;
	tipd_VIN4  		: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0			: in STD_LOGIC;
        VIN1			: in STD_LOGIC;
        VIN2			: in STD_LOGIC;
        VIN3			: in STD_LOGIC;
        VIN4			: in STD_LOGIC;
        VOUT 			: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR5 : entity is TRUE;

end NEOOR5 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR5 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOOR5_0_tab : VitalTruthTableType (0 to 6, 0 to 5) := (
            ('1', '-', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '-', '1'),
            ('-', '-', '1', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '1', '1'),
            ('0', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOOR5_0_tab,
       DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
  	       3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR6 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath   	: STRING  := "NEOOR6";
  	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0 		: in STD_LOGIC;
        VIN1 		: in STD_LOGIC;
        VIN2 		: in STD_LOGIC;
        VIN3 		: in STD_LOGIC;
        VIN4 		: in STD_LOGIC;
        VIN5 		: in STD_LOGIC;
        VOUT		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR6 : entity is TRUE;

end NEOOR6 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR6 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
					VIN4_ipd, VIN5_ipd)
   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;
   CONSTANT NEOOR6_0_tab : VitalTruthTableType (0 to 7, 0 to 6) := (
            ('1', '-', '-', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '-', '-', '1'),
            ('-', '-', '1', '-', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '-', '1'),
            ('-', '-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '-', '1', '1'),
            ('0', '0', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', 'B', '0'));
   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOOR6_0_tab,
        DataIn => STD_LOGIC_VECTOR'( VIN0_ipd, VIN1_ipd, VIN2_ipd, 
				  VIN3_ipd, VIN4_ipd, VIN5_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR7 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath  	: STRING  := "NEOOR7";
  	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR7 : entity is TRUE;

end NEOOR7 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR7 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';
    signal VIN6_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOOR7_0_tab : VitalTruthTableType (0 to 8, 0 to 7) := (
            ('1', '-', '-', '-', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '-', '-', '-', '1'),
            ('-', '-', '1', '-', '-', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '-', '-', '1'),
            ('-', '-', '-', '-', '1', '-', '-', '1'),
            ('-', '-', '-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '-', '-', '1', '1'),
            ('0', '0', '0', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOOR7_0_tab,
        DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd, VIN2_ipd, 
				VIN3_ipd, VIN4_ipd, VIN5_ipd, VIN6_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR8 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath  	: STRING  := "NEOOR8";
  	tpd_VIN0_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN7_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VIN7		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR8 : entity is TRUE;

end NEOOR8 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR8 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';
    signal VIN6_ipd  : STD_LOGIC := 'X';
    signal VIN7_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd, VIN7_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOOR8_0_tab : VitalTruthTableType (0 to 9, 0 to 8) := (
            ('1', '-', '-', '-', '-', '-', '-', '-', '1'),
            ('-', '1', '-', '-', '-', '-', '-', '-', '1'),
            ('-', '-', '1', '-', '-', '-', '-', '-', '1'),
            ('-', '-', '-', '1', '-', '-', '-', '-', '1'),
            ('-', '-', '-', '-', '1', '-', '-', '-', '1'),
            ('-', '-', '-', '-', '-', '1', '-', '-', '1'),
            ('-', '-', '-', '-', '-', '-', '1', '-', '1'),
            ('-', '-', '-', '-', '-', '-', '-', '1', '1'),
            ('0', '0', '0', '0', '0', '0', '0', '0', '0'),
            ('B', 'B', 'B', 'B', 'B', 'B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOOR8_0_tab,
        DataIn => STD_LOGIC_VECTOR'(VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd, VIN7_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR16 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR16 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath   	: STRING  := "NEOOR16";
  	tpd_VIN0_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN7_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN8_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN9_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN10_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN11_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN12_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN13_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN14_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN15_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN8  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN9  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN10  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN11  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN12  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN13 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN14  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN15  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VIN7		 : in STD_LOGIC;
        VIN8		 : in STD_LOGIC;
        VIN9		 : in STD_LOGIC;
        VIN10		 : in STD_LOGIC;
        VIN11		 : in STD_LOGIC;
        VIN12		 : in STD_LOGIC;
        VIN13		 : in STD_LOGIC;
        VIN14		 : in STD_LOGIC;
        VIN15		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR16 : entity is TRUE;

end NEOOR16 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR16 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  	: STD_LOGIC := 'X';
    signal VIN1_ipd  	: STD_LOGIC := 'X';
    signal VIN2_ipd  	: STD_LOGIC := 'X';
    signal VIN3_ipd  	: STD_LOGIC := 'X';
    signal VIN4_ipd  	: STD_LOGIC := 'X';
    signal VIN5_ipd  	: STD_LOGIC := 'X';
    signal VIN6_ipd  	: STD_LOGIC := 'X';
    signal VIN7_ipd  	: STD_LOGIC := 'X';
    signal VIN8_ipd  	: STD_LOGIC := 'X';
    signal VIN9_ipd  	: STD_LOGIC := 'X';
    signal VIN10_ipd  	: STD_LOGIC := 'X';
    signal VIN11_ipd  	: STD_LOGIC := 'X';
    signal VIN12_ipd  	: STD_LOGIC := 'X';
    signal VIN13_ipd  	: STD_LOGIC := 'X';
    signal VIN14_ipd  	: STD_LOGIC := 'X';
    signal VIN15_ipd  	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   VitalWireDelay(VIN8_ipd, VIN8, tipd_VIN8);
   VitalWireDelay(VIN9_ipd, VIN9, tipd_VIN9);
   VitalWireDelay(VIN10_ipd, VIN10, tipd_VIN10);
   VitalWireDelay(VIN11_ipd, VIN11, tipd_VIN11);
   VitalWireDelay(VIN12_ipd, VIN12, tipd_VIN12);
   VitalWireDelay(VIN13_ipd, VIN13, tipd_VIN13);
   VitalWireDelay(VIN14_ipd, VIN14, tipd_VIN14);
   VitalWireDelay(VIN15_ipd, VIN15, tipd_VIN15);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd,
				VIN5_ipd, VIN6_ipd, VIN7_ipd, VIN8_ipd, 
				VIN9_ipd, VIN10_ipd, VIN11_ipd, VIN12_ipd,
				VIN13_ipd, VIN14_ipd, VIN15_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := 	(VIN0_ipd OR VIN1_ipd OR VIN2_ipd OR VIN3_ipd OR
	      	 VIN4_ipd OR VIN5_ipd OR VIN6_ipd OR VIN7_ipd OR
		 VIN8_ipd OR VIN9_ipd OR VIN10_ipd OR VIN11_ipd OR
		 VIN12_ipd OR VIN13_ipd OR VIN14_ipd OR VIN15_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE),
               8 => (VIN8_ipd'LAST_EVENT, tpd_VIN8_VOUT, TRUE),
               9 => (VIN9_ipd'LAST_EVENT, tpd_VIN9_VOUT, TRUE),
               10 => (VIN10_ipd'LAST_EVENT, tpd_VIN10_VOUT, TRUE),
               11 => (VIN11_ipd'LAST_EVENT, tpd_VIN11_VOUT, TRUE),
               12 => (VIN12_ipd'LAST_EVENT, tpd_VIN12_VOUT, TRUE),
               13 => (VIN13_ipd'LAST_EVENT, tpd_VIN13_VOUT, TRUE),
               14 => (VIN14_ipd'LAST_EVENT, tpd_VIN14_VOUT, TRUE),
               15 => (VIN15_ipd'LAST_EVENT, tpd_VIN15_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOOR32 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOOR32 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath   	: STRING  := "NEOOR32";
  	tpd_VIN0_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN7_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN8_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN9_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN10_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN11_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN12_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN13_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN14_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN15_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN16_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN17_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN18_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN19_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN20_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN21_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN22_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN23_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN24_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN25_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN26_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN27_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN28_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN29_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN30_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN31_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN8  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN9  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN10  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN11  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN12  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN13 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN14  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN15  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN16  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN17  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN18  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN19  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN20  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN21  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN22  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN23  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN24  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN25  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN26  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN27  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN28 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN29  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN30  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN31  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VIN7		 : in STD_LOGIC;
        VIN8		 : in STD_LOGIC;
        VIN9		 : in STD_LOGIC;
        VIN10		 : in STD_LOGIC;
        VIN11		 : in STD_LOGIC;
        VIN12		 : in STD_LOGIC;
        VIN13		 : in STD_LOGIC;
        VIN14		 : in STD_LOGIC;
        VIN15		 : in STD_LOGIC;
        VIN16		 : in STD_LOGIC;
        VIN17		 : in STD_LOGIC;
        VIN18		 : in STD_LOGIC;
        VIN19		 : in STD_LOGIC;
        VIN20		 : in STD_LOGIC;
        VIN21		 : in STD_LOGIC;
        VIN22		 : in STD_LOGIC;
        VIN23		 : in STD_LOGIC;
        VIN24		 : in STD_LOGIC;
        VIN25		 : in STD_LOGIC;
        VIN26		 : in STD_LOGIC;
        VIN27		 : in STD_LOGIC;
        VIN28		 : in STD_LOGIC;
        VIN29		 : in STD_LOGIC;
        VIN30		 : in STD_LOGIC;
        VIN31		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOOR32 : entity is TRUE;

end NEOOR32 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOOR32 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  	: STD_LOGIC := 'X';
    signal VIN1_ipd  	: STD_LOGIC := 'X';
    signal VIN2_ipd  	: STD_LOGIC := 'X';
    signal VIN3_ipd  	: STD_LOGIC := 'X';
    signal VIN4_ipd  	: STD_LOGIC := 'X';
    signal VIN5_ipd  	: STD_LOGIC := 'X';
    signal VIN6_ipd  	: STD_LOGIC := 'X';
    signal VIN7_ipd  	: STD_LOGIC := 'X';
    signal VIN8_ipd  	: STD_LOGIC := 'X';
    signal VIN9_ipd  	: STD_LOGIC := 'X';
    signal VIN10_ipd  	: STD_LOGIC := 'X';
    signal VIN11_ipd  	: STD_LOGIC := 'X';
    signal VIN12_ipd  	: STD_LOGIC := 'X';
    signal VIN13_ipd  	: STD_LOGIC := 'X';
    signal VIN14_ipd  	: STD_LOGIC := 'X';
    signal VIN15_ipd  	: STD_LOGIC := 'X';
    signal VIN16_ipd  	: STD_LOGIC := 'X';
    signal VIN17_ipd  	: STD_LOGIC := 'X';
    signal VIN18_ipd  	: STD_LOGIC := 'X';
    signal VIN19_ipd  	: STD_LOGIC := 'X';
    signal VIN20_ipd  	: STD_LOGIC := 'X';
    signal VIN21_ipd  	: STD_LOGIC := 'X';
    signal VIN22_ipd  	: STD_LOGIC := 'X';
    signal VIN23_ipd  	: STD_LOGIC := 'X';
    signal VIN24_ipd  	: STD_LOGIC := 'X';
    signal VIN25_ipd  	: STD_LOGIC := 'X';
    signal VIN26_ipd  	: STD_LOGIC := 'X';
    signal VIN27_ipd  	: STD_LOGIC := 'X';
    signal VIN28_ipd  	: STD_LOGIC := 'X';
    signal VIN29_ipd  	: STD_LOGIC := 'X';
    signal VIN30_ipd  	: STD_LOGIC := 'X';
    signal VIN31_ipd  	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   VitalWireDelay(VIN8_ipd, VIN8, tipd_VIN8);
   VitalWireDelay(VIN9_ipd, VIN9, tipd_VIN9);
   VitalWireDelay(VIN10_ipd, VIN10, tipd_VIN10);
   VitalWireDelay(VIN11_ipd, VIN11, tipd_VIN11);
   VitalWireDelay(VIN12_ipd, VIN12, tipd_VIN12);
   VitalWireDelay(VIN13_ipd, VIN13, tipd_VIN13);
   VitalWireDelay(VIN14_ipd, VIN14, tipd_VIN14);
   VitalWireDelay(VIN15_ipd, VIN15, tipd_VIN15);
   VitalWireDelay(VIN16_ipd, VIN16, tipd_VIN16);
   VitalWireDelay(VIN17_ipd, VIN17, tipd_VIN17);
   VitalWireDelay(VIN18_ipd, VIN18, tipd_VIN18);
   VitalWireDelay(VIN19_ipd, VIN19, tipd_VIN19);
   VitalWireDelay(VIN20_ipd, VIN20, tipd_VIN20);
   VitalWireDelay(VIN21_ipd, VIN21, tipd_VIN21);
   VitalWireDelay(VIN22_ipd, VIN22, tipd_VIN22);
   VitalWireDelay(VIN23_ipd, VIN23, tipd_VIN23);
   VitalWireDelay(VIN24_ipd, VIN24, tipd_VIN24);
   VitalWireDelay(VIN25_ipd, VIN25, tipd_VIN25);
   VitalWireDelay(VIN26_ipd, VIN26, tipd_VIN26);
   VitalWireDelay(VIN27_ipd, VIN27, tipd_VIN27);
   VitalWireDelay(VIN28_ipd, VIN28, tipd_VIN28);
   VitalWireDelay(VIN29_ipd, VIN29, tipd_VIN29);
   VitalWireDelay(VIN30_ipd, VIN30, tipd_VIN30);
   VitalWireDelay(VIN31_ipd, VIN31, tipd_VIN31);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd,
				VIN5_ipd, VIN6_ipd, VIN7_ipd, VIN8_ipd, 
				VIN9_ipd, VIN10_ipd, VIN11_ipd, VIN12_ipd,
				VIN13_ipd, VIN14_ipd, VIN15_ipd, VIN16_ipd,
				VIN17_ipd, VIN18_ipd, VIN19_ipd, VIN20_ipd,
				VIN21_ipd, VIN22_ipd, VIN23_ipd, VIN24_ipd,
				VIN25_ipd, VIN26_ipd, VIN27_ipd, VIN28_ipd,
				VIN29_ipd, VIN30_ipd, VIN31_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd :=  ((VIN0_ipd OR VIN1_ipd OR VIN2_ipd OR VIN3_ipd OR
	      	 VIN4_ipd OR VIN5_ipd OR VIN6_ipd OR VIN7_ipd OR
		 VIN8_ipd OR VIN9_ipd OR VIN10_ipd OR VIN11_ipd OR
		 VIN12_ipd OR VIN13_ipd OR VIN14_ipd OR VIN15_ipd) OR
		(VIN16_ipd OR VIN17_ipd OR VIN18_ipd OR VIN19_ipd OR
		 VIN20_ipd OR VIN21_ipd OR VIN22_ipd OR VIN23_ipd OR
		 VIN24_ipd OR VIN25_ipd OR VIN26_ipd OR VIN27_ipd OR
		 VIN28_ipd OR VIN29_ipd OR VIN30_ipd OR VIN31_ipd));
		

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE),
               8 => (VIN8_ipd'LAST_EVENT, tpd_VIN8_VOUT, TRUE),
               9 => (VIN9_ipd'LAST_EVENT, tpd_VIN9_VOUT, TRUE),
               10 => (VIN10_ipd'LAST_EVENT, tpd_VIN10_VOUT, TRUE),
               11 => (VIN11_ipd'LAST_EVENT, tpd_VIN11_VOUT, TRUE),
               12 => (VIN12_ipd'LAST_EVENT, tpd_VIN12_VOUT, TRUE),
               13 => (VIN13_ipd'LAST_EVENT, tpd_VIN13_VOUT, TRUE),
               14 => (VIN14_ipd'LAST_EVENT, tpd_VIN14_VOUT, TRUE),
               15 => (VIN15_ipd'LAST_EVENT, tpd_VIN15_VOUT, TRUE),
               16 => (VIN16_ipd'LAST_EVENT, tpd_VIN16_VOUT, TRUE),
               17 => (VIN17_ipd'LAST_EVENT, tpd_VIN17_VOUT, TRUE),
               18 => (VIN18_ipd'LAST_EVENT, tpd_VIN18_VOUT, TRUE),
               19 => (VIN19_ipd'LAST_EVENT, tpd_VIN19_VOUT, TRUE),
               20 => (VIN20_ipd'LAST_EVENT, tpd_VIN20_VOUT, TRUE),
               21 => (VIN21_ipd'LAST_EVENT, tpd_VIN21_VOUT, TRUE),
               22 => (VIN22_ipd'LAST_EVENT, tpd_VIN22_VOUT, TRUE),
               23 => (VIN23_ipd'LAST_EVENT, tpd_VIN23_VOUT, TRUE),
               24 => (VIN14_ipd'LAST_EVENT, tpd_VIN24_VOUT, TRUE),
               25 => (VIN25_ipd'LAST_EVENT, tpd_VIN25_VOUT, TRUE),
               26 => (VIN26_ipd'LAST_EVENT, tpd_VIN26_VOUT, TRUE),
               27 => (VIN27_ipd'LAST_EVENT, tpd_VIN27_VOUT, TRUE),
               28 => (VIN28_ipd'LAST_EVENT, tpd_VIN28_VOUT, TRUE),
               29 => (VIN29_ipd'LAST_EVENT, tpd_VIN29_VOUT, TRUE),
               30 => (VIN30_ipd'LAST_EVENT, tpd_VIN30_VOUT, TRUE),
               31 => (VIN31_ipd'LAST_EVENT, tpd_VIN31_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOPD -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NEOPD is
   generic(
 	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
 	InstancePath	: STRING := "NEOPD");

   port(
      VOUT            :	out   STD_LOGIC := '0');

    attribute VITAL_LEVEL0 of NEOPD : entity is TRUE;

end NEOPD;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOPD is

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   --  empty
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VOUT <= 'L';

end V;


--
----- CELL NEOPU -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NEOPU is
   generic(
 	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
 	InstancePath	: STRING := "NEOPU");

   port(
        VOUT            : out   STD_LOGIC := '1');

   attribute VITAL_LEVEL0 of NEOPU : entity is TRUE;

end NEOPU;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOPU is

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   --  empty
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VOUT <= 'H';

end V;


--
----- CELL NEORAM16 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.NEOMEM.all;


-- entity declaration --
entity NEORAM16 is
  generic (
        initval : String := "0x0000";

        -- Miscellaneous IEEE.Generics
        TimingChecksOn  : BOOLEAN := TRUE;
        XOn             : BOOLEAN := FALSE;
        MsgOn           : BOOLEAN := TRUE;
        InstancePath    : STRING  := "NEORAM16";

        -- Input Signal Delays
        tipd_ADR0 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_ADR1 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_ADR2 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_ADR3 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_VIN  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WE   : VitalDelayType01 := (0 ns, 0 ns);

        -- Setup and Hold Constraints
        tsetup_ADR0_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_ADR1_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_ADR2_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_ADR3_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_VIN_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR0_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR1_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR2_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR3_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_VIN_WE_noedge_negedge   : VitalDelayType := 0 ns;

        -- Pulse Width Constraints
        tperiod_WE     : VitalDelayType := 0 ns;
        tpw_WE_posedge : VitalDelayType := 0 ns;
        tpw_WE_negedge : VitalDelayType := 0 ns;

        -- Propagation Delays
        tpd_VIN_VOUT   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR0_VOUT  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR1_VOUT  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR2_VOUT  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR3_VOUT  : VitalDelayType01 := (0 ns, 0 ns);
        tpd_WE_VOUT    : VitalDelayType01 := (0 ns, 0 ns));

  port (VIN   : IN std_logic;
        WE    : IN std_logic;
        ADR0  : IN std_logic;
        ADR1  : IN std_logic;
        ADR2  : IN std_logic;
        ADR3  : IN std_logic;
        VOUT  : OUT std_logic);

    attribute VITAL_LEVEL0 of NEORAM16 : entity is TRUE;

end NEORAM16;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V OF NEORAM16 IS

   signal VIN_ipd  : std_logic := 'X';
   signal ADR0_ipd : std_logic := 'X';
   signal ADR1_ipd : std_logic := 'X';
   signal ADR2_ipd : std_logic := 'X';
   signal ADR3_ipd : std_logic := 'X';
   signal WE_ipd   : std_logic := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN_ipd, VIN, tipd_VIN);
   VitalWireDelay(ADR0_ipd, ADR0, tipd_ADR0);
   VitalWireDelay(ADR1_ipd, ADR1, tipd_ADR1);
   VitalWireDelay(ADR2_ipd, ADR2, tipd_ADR2);
   VitalWireDelay(ADR3_ipd, ADR3, tipd_ADR3);
   VitalWireDelay(WE_ipd, WE, tipd_WE);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WE_ipd, ADR0_ipd, ADR1_ipd, ADR2_ipd, ADR3_ipd, VIN_ipd)

     variable memory: std_logic_vector((2**4)-1 downto 0) := hex2bin(initval);
     variable temp: std_logic_vector(3 downto 0) := "0000";
     variable index: integer := 0;

     -- Timing Check Results
     variable Tviol_VIN   : STD_ULOGIC := '0';
     variable Tviol_ADR0  : STD_ULOGIC := '0';
     variable Tviol_ADR0H : STD_ULOGIC := '0';
     variable Tviol_ADR1  : STD_ULOGIC := '0';
     variable Tviol_ADR1H : STD_ULOGIC := '0';
     variable Tviol_ADR2  : STD_ULOGIC := '0';
     variable Tviol_ADR2H : STD_ULOGIC := '0';
     variable Tviol_ADR3  : STD_ULOGIC := '0';
     variable Tviol_ADR3H : STD_ULOGIC := '0';
     variable Tviol_WE    : STD_ULOGIC := '0';
     variable PeriodCheckInfo_WE : VitalPeriodDataType := VitalPeriodDataInit;
     variable ADR0_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR0_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable ADR1_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR1_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable ADR2_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR2_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable ADR3_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR3_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable VIN_WE_TimingDataSH  : VitalTimingDataType := VitalTimingDataInit;

     -- Functionality Results
     variable Violation : STD_ULOGIC := '0';

     -- Output Glitch Results
     variable VOUT_GlitchData : VitalGlitchDataType;
     variable VOUT_zd : STD_ULOGIC := 'X';
   begin

   -----------------------
   -- Timing Check Section
   -----------------------
   IF (TimingChecksOn) THEN

           -- setup and hold checks on address lines
           VitalSetupHoldCheck (
                TestSignal      => ADR0_ipd,
                TestSignalName  => "ADR0",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR0_WE_noedge_posedge,
                SetupLow        => tsetup_ADR0_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> ADR0_WE_TimingDataS,
		Violation	=> Tviol_ADR0,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR0_ipd,
                TestSignalName  => "ADR0",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR0_WE_noedge_negedge,
                HoldLow         => thold_ADR0_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> ADR0_WE_TimingDataH,
		Violation	=> Tviol_ADR0H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR1_ipd,
                TestSignalName  => "ADR1",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR1_WE_noedge_posedge,
                SetupLow        => tsetup_ADR1_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> ADR1_WE_TimingDataS,
		Violation	=> Tviol_ADR1,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR1_ipd,
                TestSignalName  => "ADR1",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR1_WE_noedge_negedge,
                HoldLow         => thold_ADR1_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> ADR1_WE_TimingDataH,
		Violation	=> Tviol_ADR1H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR2_ipd,
                TestSignalName  => "ADR2",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR2_WE_noedge_posedge,
                SetupLow        => tsetup_ADR2_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> ADR2_WE_TimingDataS,
		Violation	=> Tviol_ADR2,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR2_ipd,
                TestSignalName  => "ADR2",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR2_WE_noedge_negedge,
                HoldLow         => thold_ADR2_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> ADR2_WE_TimingDataH,
		Violation	=> Tviol_ADR2H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR3_ipd,
                TestSignalName  => "ADR3",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR3_WE_noedge_posedge,
                SetupLow        => tsetup_ADR3_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> ADR3_WE_TimingDataS,
		Violation	=> Tviol_ADR3,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR3_ipd,
                TestSignalName  => "ADR3",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR3_WE_noedge_negedge,
                HoldLow         => thold_ADR3_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> ADR3_WE_TimingDataH,
		Violation	=> Tviol_ADR3H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
	-- setup and hold checks on data
        VitalSetupHoldCheck (
		TestSignal 	=> VIN_ipd, 
		TestSignalName 	=> "VIN", 
		RefSignal 	=> WE_ipd,
		RefSignalName 	=> "WE",
		SetupHigh 	=> tsetup_VIN_WE_noedge_negedge, 
		SetupLow 	=> tsetup_VIN_WE_noedge_negedge, 
		HoldHigh 	=> thold_VIN_WE_noedge_negedge, 
		HoldLow 	=> thold_VIN_WE_noedge_negedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '\',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> VIN_WE_TimingDataSH, 
		Violation 	=> Tviol_VIN, 
		MsgSeverity 	=> WARNING);
        VitalPeriodPulseCheck (
		TestSignal 	=> WE_ipd, 
		TestSignalName 	=> "WE", 
		Period 		=> tperiod_WE,
		PulseWidthHigh 	=> tpw_WE_posedge, 
		PulseWidthLow 	=> tpw_WE_negedge, 
		PeriodData 	=> PeriodCheckInfo_WE,
		Violation 	=> Tviol_WE,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
--   Violation := Tviol_VIN OR Tviol_ADR0 OR Tviol_ADR0H OR Tviol_ADR1 
--		OR Tviol_ADR1H OR Tviol_ADR2 OR Tviol_ADR2H OR Tviol_ADR3 
--		OR Tviol_ADR3H OR Tviol_WE;

   -- Check for unknowns on the address lines
   IF (IS_X(ADR0_ipd) OR IS_X(ADR1_ipd) OR IS_X(ADR2_ipd)
        OR IS_X(ADR3_ipd)) THEN
      assert false
        report "NEORAM16 MEMORY HAZARD ADDRESS UNKNOWN!"
        severity WARNING;
      VOUT_zd := 'X';
   ELSE
      temp := (ADR3_ipd, ADR2_ipd, ADR1_ipd, ADR0_ipd);
      index := CONV_INTEGER(temp);
      IF (WE_ipd = '1') THEN
         memory(index) := VIN_ipd;
      END IF;
      IF (Violation = '0') THEN
         VOUT_zd := memory(index);
      ELSE
         VOUT_zd := 'X';
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (WE_ipd'LAST_EVENT, tpd_WE_VOUT, TRUE),
               1 => (VIN_ipd'LAST_EVENT, tpd_VIN_VOUT, TRUE),
               2 => (ADR0_ipd'LAST_EVENT, tpd_ADR0_VOUT, TRUE),
               3 => (ADR1_ipd'LAST_EVENT, tpd_ADR1_VOUT, TRUE),
               4 => (ADR2_ipd'LAST_EVENT, tpd_ADR2_VOUT, TRUE),
               5 => (ADR3_ipd'LAST_EVENT, tpd_ADR3_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEORAM32 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.NEOMEM.all;

-- entity declaration --
entity NEORAM32 is
  generic (
        initval : String := "0x00000";

        -- Miscellaneous IEEE.Generics
        TimingChecksOn  : BOOLEAN := TRUE;
        XOn             : BOOLEAN := FALSE;
        MsgOn           : BOOLEAN := TRUE;
        InstancePath    : STRING  := "NEORAM32";

        -- Input Signal Delays
        tipd_ADR0 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_ADR1 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_ADR2 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_ADR3 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_ADR4 : VitalDelayType01 := (0 ns, 0 ns);
        tipd_VIN  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WE   : VitalDelayType01 := (0 ns, 0 ns);

        -- Setup and Hold Constraints
        tsetup_ADR0_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_ADR1_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_ADR2_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_ADR3_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_ADR4_WE_noedge_posedge : VitalDelayType := 0 ns;
        tsetup_VIN_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR0_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR1_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR2_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR3_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_ADR4_WE_noedge_negedge  : VitalDelayType := 0 ns;
        thold_VIN_WE_noedge_negedge   : VitalDelayType := 0 ns;

        -- Pulse Width Constraints
        tperiod_WE     : VitalDelayType := 0 ns;
        tpw_WE_posedge : VitalDelayType := 0 ns;
        tpw_WE_negedge : VitalDelayType := 0 ns;

        -- Propagation Delays
        tpd_VIN_VOUT : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR0_VOUT : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR1_VOUT : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR2_VOUT : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR3_VOUT : VitalDelayType01 := (0 ns, 0 ns);
        tpd_ADR4_VOUT : VitalDelayType01 := (0 ns, 0 ns);
        tpd_WE_VOUT : VitalDelayType01 := (0 ns, 0 ns));

  port (VIN   : IN std_logic;
        WE    : IN std_logic;
        ADR0  : IN std_logic;
        ADR1  : IN std_logic;
        ADR2  : IN std_logic;
        ADR3  : IN std_logic;
        ADR4  : IN std_logic;
        VOUT  : OUT std_logic);

  attribute VITAL_LEVEL0 of NEORAM32 : entity is TRUE;

end NEORAM32;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V OF NEORAM32 IS
   signal VIN_ipd  : std_logic := 'X';
   signal ADR0_ipd : std_logic := 'X';
   signal ADR1_ipd : std_logic := 'X';
   signal ADR2_ipd : std_logic := 'X';
   signal ADR3_ipd : std_logic := 'X';
   signal ADR4_ipd : std_logic := 'X';
   signal WE_ipd   : std_logic := 'X';
begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN_ipd, VIN, tipd_VIN);
   VitalWireDelay(ADR0_ipd, ADR0, tipd_ADR0);
   VitalWireDelay(ADR1_ipd, ADR1, tipd_ADR1);
   VitalWireDelay(ADR2_ipd, ADR2, tipd_ADR2);
   VitalWireDelay(ADR3_ipd, ADR3, tipd_ADR3);
   VitalWireDelay(ADR4_ipd, ADR4, tipd_ADR4);
   VitalWireDelay(WE_ipd, WE, tipd_WE);
   end block;

   -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WE_ipd, ADR0_ipd, ADR1_ipd, ADR2_ipd, ADR3_ipd, ADR4_ipd, VIN_ipd)

     variable memory: std_logic_vector((2**5)-1 downto 0) := hex2bin(initval);
     variable temp: std_logic_vector(4 downto 0) := "00000";
     variable index: integer := 0;

     -- Timing Check Results
     variable Tviol_VIN   : STD_ULOGIC := '0';
     variable Tviol_ADR0  : STD_ULOGIC := '0';
     variable Tviol_ADR0H : STD_ULOGIC := '0';
     variable Tviol_ADR1  : STD_ULOGIC := '0';
     variable Tviol_ADR1H : STD_ULOGIC := '0'; 
     variable Tviol_ADR2  : STD_ULOGIC := '0';
     variable Tviol_ADR2H : STD_ULOGIC := '0';
     variable Tviol_ADR3  : STD_ULOGIC := '0';
     variable Tviol_ADR3H : STD_ULOGIC := '0';
     variable Tviol_ADR4  : STD_ULOGIC := '0';
     variable Tviol_ADR4H : STD_ULOGIC := '0';
     variable Tviol_WE    : STD_ULOGIC := '0';
     variable PeriodCheckInfo_WE   : VitalPeriodDataType := VitalPeriodDataInit;
     variable ADR0_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR0_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable ADR1_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR1_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable ADR2_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR2_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable ADR3_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR3_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable ADR4_WE_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable ADR4_WE_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable VIN_WE_TimingDataSH  : VitalTimingDataType := VitalTimingDataInit;

     -- Functionality Results
     variable Violation : STD_ULOGIC := '0';

     -- Output Glitch Results
     variable VOUT_GlitchData : VitalGlitchDataType;
     variable VOUT_zd : STD_ULOGIC := 'X';
   begin

   -----------------------
   -- Timing Check Section
   -----------------------
   IF (TimingChecksOn) THEN

           -- setup and hold checks on address lines
           VitalSetupHoldCheck (
                TestSignal      => ADR0_ipd,
                TestSignalName  => "ADR0",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR0_WE_noedge_posedge,
                SetupLow        => tsetup_ADR0_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'), 
		RefTransition   => '/',
		TimingData 	=> ADR0_WE_TimingDataS,
		Violation	=> Tviol_ADR0,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR0_ipd,
                TestSignalName  => "ADR0",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR0_WE_noedge_negedge,
                HoldLow         => thold_ADR0_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> ADR0_WE_TimingDataH,
		Violation	=> Tviol_ADR0H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR1_ipd,
                TestSignalName  => "ADR1",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR1_WE_noedge_posedge,
                SetupLow        => tsetup_ADR1_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> ADR1_WE_TimingDataS,
		Violation	=> Tviol_ADR1,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR1_ipd,
                TestSignalName  => "ADR1",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR1_WE_noedge_negedge,
                HoldLow         => thold_ADR1_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'), 
		RefTransition   => '\',
		TimingData 	=> ADR1_WE_TimingDataH,
		Violation	=> Tviol_ADR1H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR2_ipd,
                TestSignalName  => "ADR2",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR2_WE_noedge_posedge,
                SetupLow        => tsetup_ADR2_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> ADR2_WE_TimingDataS,
		Violation	=> Tviol_ADR2,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR2_ipd,
                TestSignalName  => "ADR2",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR2_WE_noedge_negedge,
                HoldLow         => thold_ADR2_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> ADR2_WE_TimingDataH,
		Violation	=> Tviol_ADR2H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR3_ipd,
                TestSignalName  => "ADR3",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR3_WE_noedge_posedge,
                SetupLow        => tsetup_ADR3_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> ADR3_WE_TimingDataS,
		Violation	=> Tviol_ADR3,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR3_ipd,
                TestSignalName  => "ADR3",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR3_WE_noedge_negedge,
                HoldLow         => thold_ADR3_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'), 
		RefTransition   => '\',
		TimingData 	=> ADR3_WE_TimingDataH,
		Violation	=> Tviol_ADR3H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR4_ipd,
                TestSignalName  => "ADR4",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_ADR4_WE_noedge_posedge,
                SetupLow        => tsetup_ADR4_WE_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (WE_ipd='1'), 
		RefTransition   => '/',
		TimingData 	=> ADR4_WE_TimingDataS,
		Violation	=> Tviol_ADR4,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
           VitalSetupHoldCheck (
                TestSignal      => ADR4_ipd,
                TestSignalName  => "ADR4",
                TestDelay       => 0 ns,
                RefSignal       => WE_ipd,
                RefSignalName   => "WE",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns,
                SetupLow        => 0 ns,
                HoldHigh        => thold_ADR4_WE_noedge_negedge,
                HoldLow         => thold_ADR4_WE_noedge_negedge,
		CheckEnabled	=> (WE_ipd='0'), 
		RefTransition   => '\',
		TimingData 	=> ADR4_WE_TimingDataH,
		Violation	=> Tviol_ADR4H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);	
	-- setup and hold checks on data
        VitalSetupHoldCheck (
		TestSignal 	=> VIN_ipd, 
		TestSignalName 	=> "VIN", 
		RefSignal 	=> WE_ipd,
		RefSignalName 	=> "WE",
		SetupHigh 	=> tsetup_VIN_WE_noedge_negedge, 
		SetupLow 	=> tsetup_VIN_WE_noedge_negedge, 
		HoldHigh 	=> thold_VIN_WE_noedge_negedge, 
		HoldLow 	=> thold_VIN_WE_noedge_negedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '\',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData	=> VIN_WE_TimingDataSH, 
		Violation 	=> Tviol_VIN, 
		MsgSeverity 	=> WARNING);
        VitalPeriodPulseCheck (
		TestSignal 	=> WE_ipd, 
		TestSignalName 	=> "WE", 
		Period 		=> tperiod_WE,
		PulseWidthHigh 	=> tpw_WE_posedge, 
		PulseWidthLow 	=> tpw_WE_negedge, 
		PeriodData 	=> PeriodCheckInfo_WE,
		Violation 	=> Tviol_WE,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
--   Violation := Tviol_VIN OR Tviol_ADR0 OR Tviol_ADR0H OR Tviol_ADR1 
--		OR Tviol_ADR1H OR Tviol_ADR2 OR Tviol_ADR2H OR Tviol_ADR3 
--		OR Tviol_ADR3H OR Tviol_ADR4 OR Tviol_ADR4H OR Tviol_WE;

   -- Check for unknowns on the address lines
   IF (IS_X(ADR0_ipd) OR IS_X(ADR1_ipd) OR IS_X(ADR2_ipd)
        OR IS_X(ADR3_ipd) OR IS_X(ADR4_ipd)) THEN
      assert false
        report "NEORAM32 MEMORY HAZARD ADDRESS UNKNOWN!"
        severity WARNING;
      VOUT_zd := 'X';
   ELSE
      temp := (ADR4_ipd, ADR3_ipd, ADR2_ipd, ADR1_ipd, ADR0_ipd);
      index := CONV_INTEGER(temp);
      IF (WE_ipd = '1') THEN
         memory(index) := VIN_ipd;
      END IF;
      IF (Violation = '0') THEN
         VOUT_zd := memory(index);
      ELSE
         VOUT_zd := 'X';
      END IF;
   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (WE_ipd'LAST_EVENT, tpd_WE_VOUT, TRUE),
               1 => (VIN_ipd'LAST_EVENT, tpd_VIN_VOUT, TRUE),
               2 => (ADR0_ipd'LAST_EVENT, tpd_ADR0_VOUT, TRUE),
               3 => (ADR1_ipd'LAST_EVENT, tpd_ADR1_VOUT, TRUE),
               4 => (ADR2_ipd'LAST_EVENT, tpd_ADR2_VOUT, TRUE),
               5 => (ADR3_ipd'LAST_EVENT, tpd_ADR3_VOUT, TRUE),
               6 => (ADR4_ipd'LAST_EVENT, tpd_ADR4_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOSR16 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.NEOMEM.all;


-- entity declaration --
entity NEOSR16 is
  generic (
        initval : String := "0x0000";

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : BOOLEAN := TRUE;
	XOn             : BOOLEAN := FALSE;
        MsgOn           : BOOLEAN := TRUE;
        InstancePath    : STRING  := "NEOSR16";

        -- Input Signal Delays
        tipd_WAD0  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WAD1  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WAD2  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WAD3  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD0  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD1  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD2  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD3  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WCLK  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RCLK  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_SET   : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RST   : VitalDelayType01 := (0 ns, 0 ns);
        tipd_DIN   : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WREN  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WPE   : VitalDelayType01 := (0 ns, 0 ns);

        -- Setup and Hold Constraints
        tsetup_DIN_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_RAD0_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_RAD1_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_RAD2_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_RAD3_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD0_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD1_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD2_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD3_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WREN_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WPE_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_DIN_WCLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_RAD0_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_RAD1_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_RAD2_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_RAD3_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_WAD0_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WAD1_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WAD2_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WAD3_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WREN_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WPE_WCLK_noedge_posedge    : VitalDelayType := 0 ns;

        -- Pulse Width Constraints
        tperiod_WCLK       : VitalDelayType := 0 ns;
        tpw_WCLK_posedge   : VitalDelayType := 0 ns;
        tpw_WCLK_negedge   : VitalDelayType := 0 ns;
        tperiod_RCLK       : VitalDelayType := 0 ns;
        tpw_RCLK_posedge   : VitalDelayType := 0 ns;
        tpw_RCLK_negedge   : VitalDelayType := 0 ns;
        tperiod_RST        : VitalDelayType := 0 ns;
        tpw_RST_posedge    : VitalDelayType := 0 ns;
        tpw_RST_negedge    : VitalDelayType := 0 ns;
        tperiod_SET        : VitalDelayType := 0 ns;
        tpw_SET_posedge    : VitalDelayType := 0 ns;
        tpw_SET_negedge    : VitalDelayType := 0 ns;

        -- Propagation Delays
	tpd_DIN_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WREN_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WPE_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD0_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD1_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD2_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD3_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_WCLK_DOUT      : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD0_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD1_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD2_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD3_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RCLK_DOUT      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_SET_DOUT       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DOUT       : VitalDelayType01 := (0 ns, 0 ns));

  port (DIN   		   : IN std_logic;
        RAD0  		   : IN std_logic;
        RAD1  		   : IN std_logic;
        RAD2  		   : IN std_logic;
        RAD3  		   : IN std_logic;
        RCLK  		   : IN std_logic;
        WAD0  		   : IN std_logic;
        WAD1  		   : IN std_logic;
        WAD2  		   : IN std_logic;
        WAD3  		   : IN std_logic;
        WCLK  		   : IN std_logic;
        WREN  		   : IN std_logic;
        WPE   		   : IN std_logic;
	SET   		   : IN std_logic;
	RST   		   : IN std_logic;
        DOUT  		   : OUT std_logic);

    attribute VITAL_LEVEL0 of NEOSR16 : entity is TRUE;

end NEOSR16;


-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V OF NEOSR16 IS

   signal DIN_ipd   : std_logic := 'X';
   signal RAD0_ipd  : std_logic := 'X';
   signal RAD1_ipd  : std_logic := 'X';
   signal RAD2_ipd  : std_logic := 'X';
   signal RAD3_ipd  : std_logic := 'X';
   signal RCLK_ipd  : std_logic := 'X';
   signal WAD0_ipd  : std_logic := 'X';
   signal WAD1_ipd  : std_logic := 'X';
   signal WAD2_ipd  : std_logic := 'X';
   signal WAD3_ipd  : std_logic := 'X';
   signal WCLK_ipd  : std_logic := 'X';
   signal WREN_ipd  : std_logic := 'X';
   signal WPE_ipd   : std_logic := 'X';
   signal SET_ipd   : std_logic := 'X';
   signal RST_ipd   : std_logic := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WIRE_DELAY : block
   begin
   VitalWireDelay(DIN_ipd, DIN, tipd_DIN);
   VitalWireDelay(RAD0_ipd, RAD0, tipd_RAD0);
   VitalWireDelay(RAD1_ipd, RAD1, tipd_RAD1);
   VitalWireDelay(RAD2_ipd, RAD2, tipd_RAD2);
   VitalWireDelay(RAD3_ipd, RAD3, tipd_RAD3);
   VitalWireDelay(RCLK_ipd, RCLK, tipd_RCLK);
   VitalWireDelay(WAD0_ipd, WAD0, tipd_WAD0);
   VitalWireDelay(WAD1_ipd, WAD1, tipd_WAD1);
   VitalWireDelay(WAD2_ipd, WAD2, tipd_WAD2);
   VitalWireDelay(WAD3_ipd, WAD3, tipd_WAD3);
   VitalWireDelay(WCLK_ipd, WCLK, tipd_WCLK);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(SET_ipd, SET, tipd_SET);
   VitalWireDelay(RST_ipd, RST, tipd_RST);
   end block;

  -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WCLK_ipd, RCLK_ipd, RST_ipd, SET_ipd, DIN_ipd, 
			    RAD0_ipd, RAD1_ipd, RAD2_ipd, RAD3_ipd, WAD0_ipd, 
			    WAD1_ipd, WAD2_ipd, WAD3_ipd, WREN_ipd, WPE_ipd)

     variable memory   : std_logic_vector((2**4)-1 downto 0) := hex2bin(initval);
     variable wadr_reg : std_logic_vector(3 downto 0) := "0000";
     variable radr_reg : std_logic_vector(3 downto 0) := "0000";
     variable wren_reg : std_logic := '0';
     variable wpe_reg  : std_logic := '0';
     variable din_reg  : std_logic := '0';
     variable rindex   : integer := 0;
     variable windex   : integer := 0;

     -- Timing Check Results
     variable Tviol_DIN   : STD_ULOGIC := '0';
     variable Tviol_WAD0  : STD_ULOGIC := '0';
     variable Tviol_WAD1  : STD_ULOGIC := '0';
     variable Tviol_WAD2  : STD_ULOGIC := '0';
     variable Tviol_WAD3  : STD_ULOGIC := '0';
     variable Tviol_RAD0  : STD_ULOGIC := '0';
     variable Tviol_RAD0H : STD_ULOGIC := '0';
     variable Tviol_RAD1  : STD_ULOGIC := '0';
     variable Tviol_RAD1H : STD_ULOGIC := '0';
     variable Tviol_RAD2  : STD_ULOGIC := '0';
     variable Tviol_RAD2H : STD_ULOGIC := '0';
     variable Tviol_RAD3  : STD_ULOGIC := '0';
     variable Tviol_RAD3H : STD_ULOGIC := '0';
     variable Tviol_WCLK  : STD_ULOGIC := '0';
     variable Tviol_RCLK  : STD_ULOGIC := '0';
     variable Tviol_WREN  : STD_ULOGIC := '0';
     variable Tviol_WPE   : STD_ULOGIC := '0';
     variable Tviol_RST   : STD_ULOGIC := '0';
     variable Tviol_SET   : STD_ULOGIC := '0';
     variable PeriodCheckInfo_WCLK : VitalPeriodDataType:= VitalPeriodDataInit;
     variable PeriodCheckInfo_RCLK : VitalPeriodDataType:= VitalPeriodDataInit;
     variable PeriodCheckInfo_RST  : VitalPeriodDataType:= VitalPeriodDataInit;
     variable PeriodCheckInfo_SET  : VitalPeriodDataType:= VitalPeriodDataInit;
     variable RAD0_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD0_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable RAD1_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD1_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable RAD2_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD2_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable RAD3_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD3_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD0_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD1_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD2_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD3_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable DIN_WCLK_TimingDataSH  : VitalTimingDataType := VitalTimingDataInit;
     variable WREN_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WPE_WCLK_TimingDataSH  : VitalTimingDataType := VitalTimingDataInit;

     -- Functionality Results
     variable Violation : STD_ULOGIC := '0';

     -- Output Glitch Results
     variable DOUT_GlitchData : VitalGlitchDataType;
     variable DOUT_zd : STD_LOGIC := 'X';

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
   IF (TimingChecksOn) THEN

           -- setup and hold checks on read address lines
           VitalSetupHoldCheck (
                TestSignal      => RAD0_ipd,
                TestSignalName  => "RAD0",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD0_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD0_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD0_RCLK_TimingDataS,
		Violation	=> Tviol_RAD0,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD0_ipd,
                TestSignalName  => "RAD0",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD0_RCLK_noedge_negedge,
                HoldLow         => thold_RAD0_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD0_RCLK_TimingDataH,
		Violation	=> Tviol_RAD0H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD1_ipd,
                TestSignalName  => "RAD1",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD1_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD1_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD1_RCLK_TimingDataS,
		Violation	=> Tviol_RAD1,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD1_ipd,
                TestSignalName  => "RAD1",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD1_RCLK_noedge_negedge,
                HoldLow         => thold_RAD1_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD1_RCLK_TimingDataH,
		Violation	=> Tviol_RAD1H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD2_ipd,
                TestSignalName  => "RAD2",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD2_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD2_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD2_RCLK_TimingDataS,
		Violation	=> Tviol_RAD2,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD2_ipd,
                TestSignalName  => "RAD2",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD2_RCLK_noedge_negedge,
                HoldLow         => thold_RAD2_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD2_RCLK_TimingDataH,
		Violation	=> Tviol_RAD2H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD3_ipd,
                TestSignalName  => "RAD3",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD3_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD3_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD3_RCLK_TimingDataS,
		Violation	=> Tviol_RAD3,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD3_ipd,
                TestSignalName  => "RAD3",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD3_RCLK_noedge_negedge,
                HoldLow         => thold_RAD3_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD3_RCLK_TimingDataH,
		Violation	=> Tviol_RAD3H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD0_ipd, 
		TestSignalName 	=> "WAD0", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD0_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD0_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD0_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD0_WCLK_noedge_posedge, 
		CheckEnabled 	=> (WPE_ipd='1' and WREN_ipd='1'),
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD0_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD0, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD1_ipd, 
		TestSignalName 	=> "WAD1", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD1_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD1_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD1_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD1_WCLK_noedge_posedge, 
		CheckEnabled 	=> (WPE_ipd='1' and WREN_ipd='1'),
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD1_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD1, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD2_ipd, 
		TestSignalName 	=> "WAD2", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD2_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD2_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD2_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD2_WCLK_noedge_posedge, 
		CheckEnabled 	=> (WPE_ipd='1' and WREN_ipd='1'),
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD2_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD2, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD3_ipd, 
		TestSignalName 	=> "WAD3", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD3_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD3_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD3_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD3_WCLK_noedge_posedge, 
		CheckEnabled 	=> (WPE_ipd='1' and WREN_ipd='1'),
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD3_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD3, 
		MsgSeverity 	=> WARNING);
	-- setup and hold checks on data
        VitalSetupHoldCheck (
		TestSignal 	=> DIN_ipd, 
		TestSignalName 	=> "DIN", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_DIN_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_DIN_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_DIN_WCLK_noedge_posedge, 
		HoldLow 	=> thold_DIN_WCLK_noedge_posedge, 
		CheckEnabled 	=> (WPE_ipd='1' and WREN_ipd='1'),
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> DIN_WCLK_TimingDataSH, 
		Violation 	=> Tviol_DIN, 
		MsgSeverity 	=> WARNING);
	-- setup and hold checks on write enable
        VitalSetupHoldCheck (
		TestSignal 	=> WREN_ipd, 
		TestSignalName 	=> "WREN", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WREN_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WREN_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WREN_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WREN_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WREN_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WREN, 
		MsgSeverity 	=> WARNING);
	-- setup and hold checks on port enable
        VitalSetupHoldCheck (
		TestSignal 	=> WPE_ipd, 
		TestSignalName 	=> "WPE", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WPE_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WPE_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WPE_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WPE_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WPE_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WPE, 
		MsgSeverity 	=> WARNING);
	-- period and pulse width checks on write and read clocks,
	-- reset and set
	VitalPeriodPulseCheck (
		TestSignal 	=> WCLK_ipd,
		TestSignalName 	=> "WCLK",
		Period 		=> tperiod_WCLK,
		PulseWidthHigh 	=> tpw_WCLK_posedge,
		PulseWidthLow 	=> tpw_WCLK_negedge,
		PeriodData 	=> PeriodCheckInfo_WCLK,
		Violation 	=> Tviol_WCLK,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> RCLK_ipd,
		TestSignalName 	=> "RCLK",
		Period 		=> tperiod_RCLK,
		PulseWidthHigh 	=> tpw_RCLK_posedge,
		PulseWidthLow 	=> tpw_RCLK_negedge,
		PeriodData 	=> PeriodCheckInfo_RCLK,
		Violation 	=> Tviol_RCLK,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> RST_ipd,
		TestSignalName 	=> "RST",
		Period 		=> tperiod_RST,
		PulseWidthHigh 	=> tpw_RST_posedge,
		PulseWidthLow 	=> tpw_RST_negedge,
		PeriodData 	=> PeriodCheckInfo_RST,
		Violation 	=> Tviol_RST,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> SET_ipd,
		TestSignalName 	=> "SET",
		Period 		=> tperiod_SET,
		PulseWidthHigh 	=> tpw_SET_posedge,
		PulseWidthLow 	=> tpw_SET_negedge,
		PeriodData 	=> PeriodCheckInfo_SET,
		Violation 	=> Tviol_SET,
		XOn	 	=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
   END IF;

   ------------------------
   -- Functionality Section
   ------------------------
--   Violation := Tviol_DIN OR Tviol_WAD0 OR Tviol_WAD1 OR Tviol_WAD2
--		OR Tviol_WAD3 OR Tviol_WCLK OR Tviol_RAD0 OR Tviol_RAD1 OR
--		Tviol_RAD2 OR Tviol_RAD3 OR Tviol_RCLK OR
--		Tviol_WREN OR Tviol_WPE OR Tviol_RST OR Tviol_SET;

   -- Check for unknowns 
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "NEOSR16 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      DOUT_zd := 'X';
   ELSIF (IS_X(WAD0_ipd) OR IS_X(WAD1_ipd) OR IS_X(WAD2_ipd)
        OR IS_X(WAD3_ipd)) THEN
      assert false
        report "NEOSR16 MEMORY HAZARD WRITE ADDRESS UNKNOWN!"
        severity WARNING;
      DOUT_zd := 'X';
   ELSIF (IS_X(RAD0_ipd) OR IS_X(RAD1_ipd) OR IS_X(RAD2_ipd)
        OR IS_X(RAD3_ipd)) THEN
      assert false
        report "NEOSR16 MEMORY HAZARD READ ADDRESS UNKNOWN!"
        severity WARNING;
      DOUT_zd := 'X';

   ELSE

      -- Latch-in WADm, WREN, WPE and DIN when WCLK is high
      IF (RST_ipd = '1') THEN
         wadr_reg := (others => '0');
         wren_reg := '0';
         wpe_reg  := '0';
         din_reg  := '0';
      ELSIF (SET_ipd = '1') THEN
         wadr_reg := (others => '1');
         wren_reg := '1';
         wpe_reg  := '1';
         din_reg  := '1';
      ELSIF (WCLK_ipd = '0') THEN
         wadr_reg := (WAD3_ipd, WAD2_ipd, WAD1_ipd, WAD0_ipd);
         wren_reg := WREN_ipd;
         wpe_reg  := WPE_ipd;
         din_reg  := DIN_ipd;
      END IF;
      windex := CONV_INTEGER(wadr_reg);

      -- At the rising edge of WCLK, write to memory at address WADm
      -- if RST and SET are low
      -- and if WREN and WPE are high and there are no timing violations
      IF (WCLK_ipd'EVENT and WCLK_ipd = '1') THEN
         IF (RST = '0' AND SET = '0') THEN
            IF (wren_reg = '1' AND wpe_reg = '1' AND Violation = '0') THEN
                memory(windex) := din_reg;
            END IF;
         END IF;
      END IF;

      -- Latch-in RADm when RCLK is high
      IF (RST_ipd = '1') THEN
         radr_reg := (others => '0');
      ELSIF (SET_ipd = '1') THEN
         radr_reg := (others => '1');
      ELSIF (RCLK_ipd = '1') THEN
         radr_reg := (RAD3_ipd, RAD2_ipd, RAD1_ipd, RAD0_ipd);
      END IF;
      rindex := CONV_INTEGER(radr_reg);

      -- Read from memory if there are no violations, and RST and SET are low
      IF (Violation = '0') THEN
         DOUT_zd := memory(rindex);
      ELSE
         DOUT_zd := 'X';
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 (
     OutSignal => DOUT,
     OutSignalName => "DOUT",
     OutTemp => DOUT_zd,
     Paths => (0 => (WCLK_ipd'LAST_EVENT, tpd_WCLK_DOUT, TRUE),
	       1 => (RCLK_ipd'LAST_EVENT, tpd_RCLK_DOUT, TRUE),
	       2 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_DOUT, TRUE),
	       3 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_DOUT, TRUE),
	       4 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_DOUT, TRUE),
	       5 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_DOUT, TRUE),
	       6 => (SET_ipd'LAST_EVENT, tpd_SET_DOUT, TRUE),
	       7 => (RST_ipd'LAST_EVENT, tpd_RST_DOUT, TRUE)),
     GlitchData => DOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;	


--
----- CELL NEOSRN32 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_primitives.all;
use WORK.NEOMEM.all;


-- entity declaration --
entity NEOSRN32 is
  generic (
        initval : String := "0x00000000";

        -- Miscellaneous VITAL Generics
        TimingChecksOn  : BOOLEAN := TRUE;
	XOn             : BOOLEAN := FALSE;
        MsgOn           : BOOLEAN := TRUE;
        InstancePath    : STRING  := "NEOSRN32";

        -- Input Signal Delays
        tipd_WAD0  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WAD1  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WAD2  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WAD3  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WAD4  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD0  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD1  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD2  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD3  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RAD4  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WCLK  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RCLK  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_SET   : VitalDelayType01 := (0 ns, 0 ns);
        tipd_RST   : VitalDelayType01 := (0 ns, 0 ns);
        tipd_DIN   : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WREN  : VitalDelayType01 := (0 ns, 0 ns);
        tipd_WPE   : VitalDelayType01 := (0 ns, 0 ns);

        -- Setup and Hold Constraints
        tsetup_DIN_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        tsetup_RAD0_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_RAD1_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_RAD2_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_RAD3_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_RAD4_RCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD0_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD1_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD2_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD3_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WAD4_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WREN_WCLK_noedge_posedge  : VitalDelayType := 0 ns;
        tsetup_WPE_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_DIN_WCLK_noedge_posedge    : VitalDelayType := 0 ns;
        thold_RAD0_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_RAD1_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_RAD2_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_RAD3_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_RAD4_RCLK_noedge_negedge   : VitalDelayType := 0 ns;
        thold_WAD0_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WAD1_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WAD2_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WAD3_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WAD4_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WREN_WCLK_noedge_posedge   : VitalDelayType := 0 ns;
        thold_WPE_WCLK_noedge_posedge    : VitalDelayType := 0 ns;

        -- Pulse Width Constraints
        tperiod_WCLK       : VitalDelayType := 0 ns;
        tpw_WCLK_posedge   : VitalDelayType := 0 ns;
        tpw_WCLK_negedge   : VitalDelayType := 0 ns;
        tperiod_RCLK       : VitalDelayType := 0 ns;
        tpw_RCLK_posedge   : VitalDelayType := 0 ns;
        tpw_RCLK_negedge   : VitalDelayType := 0 ns;
        tperiod_RST        : VitalDelayType := 0 ns;
        tpw_RST_posedge    : VitalDelayType := 0 ns;
        tpw_RST_negedge    : VitalDelayType := 0 ns;
        tperiod_SET        : VitalDelayType := 0 ns;
        tpw_SET_posedge    : VitalDelayType := 0 ns;
        tpw_SET_negedge    : VitalDelayType := 0 ns;

        -- Propagation Delays
	tpd_DIN_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WREN_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WPE_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD0_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD1_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD2_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD3_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_WAD4_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_WCLK_DOUT      : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD0_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD1_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD2_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD3_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
	tpd_RAD4_DOUT	   : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RCLK_DOUT      : VitalDelayType01 := (0 ns, 0 ns);
        tpd_SET_DOUT       : VitalDelayType01 := (0 ns, 0 ns);
        tpd_RST_DOUT       : VitalDelayType01 := (0 ns, 0 ns));

  port (DIN   		   : IN std_logic;
        RAD0  		   : IN std_logic;
        RAD1  		   : IN std_logic;
        RAD2  		   : IN std_logic;
        RAD3  		   : IN std_logic;
        RAD4  		   : IN std_logic;
        RCLK  		   : IN std_logic;
        WAD0  		   : IN std_logic;
        WAD1  		   : IN std_logic;
        WAD2  		   : IN std_logic;
        WAD3  		   : IN std_logic;
        WAD4  		   : IN std_logic;
        WCLK  		   : IN std_logic;
        WREN  		   : IN std_logic;
        WPE   		   : IN std_logic;
	SET   		   : IN std_logic;
	RST   		   : IN std_logic;
        DOUT  		   : OUT std_logic);

    attribute VITAL_LEVEL0 of NEOSRN32 : entity is TRUE;

end NEOSRN32;


-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V OF NEOSRN32 IS

   signal DIN_ipd   : std_logic := 'X';
   signal RAD0_ipd  : std_logic := 'X';
   signal RAD1_ipd  : std_logic := 'X';
   signal RAD2_ipd  : std_logic := 'X';
   signal RAD3_ipd  : std_logic := 'X';
   signal RAD4_ipd  : std_logic := 'X';
   signal RCLK_ipd  : std_logic := 'X';
   signal WAD0_ipd  : std_logic := 'X';
   signal WAD1_ipd  : std_logic := 'X';
   signal WAD2_ipd  : std_logic := 'X';
   signal WAD3_ipd  : std_logic := 'X';
   signal WAD4_ipd  : std_logic := 'X';
   signal WCLK_ipd  : std_logic := 'X';
   signal WREN_ipd  : std_logic := 'X';
   signal WPE_ipd   : std_logic := 'X';
   signal SET_ipd   : std_logic := 'X';
   signal RST_ipd   : std_logic := 'X';

begin

   -----------------------
   -- INPUT PATH DELAYS
   -----------------------
   WIRE_DELAY : block
   begin
   VitalWireDelay(DIN_ipd, DIN, tipd_DIN);
   VitalWireDelay(RAD0_ipd, RAD0, tipd_RAD0);
   VitalWireDelay(RAD1_ipd, RAD1, tipd_RAD1);
   VitalWireDelay(RAD2_ipd, RAD2, tipd_RAD2);
   VitalWireDelay(RAD3_ipd, RAD3, tipd_RAD3);
   VitalWireDelay(RAD4_ipd, RAD4, tipd_RAD4);
   VitalWireDelay(RCLK_ipd, RCLK, tipd_RCLK);
   VitalWireDelay(WAD0_ipd, WAD0, tipd_WAD0);
   VitalWireDelay(WAD1_ipd, WAD1, tipd_WAD1);
   VitalWireDelay(WAD2_ipd, WAD2, tipd_WAD2);
   VitalWireDelay(WAD3_ipd, WAD3, tipd_WAD3);
   VitalWireDelay(WAD4_ipd, WAD4, tipd_WAD4);
   VitalWireDelay(WCLK_ipd, WCLK, tipd_WCLK);
   VitalWireDelay(WREN_ipd, WREN, tipd_WREN);
   VitalWireDelay(WPE_ipd, WPE, tipd_WPE);
   VitalWireDelay(SET_ipd, SET, tipd_SET);
   VitalWireDelay(RST_ipd, RST, tipd_RST);
   end block;

  -----------------------
   -- BEHAVIOR SECTION
   -----------------------
   VitalBehavior : process (WCLK_ipd, RCLK_ipd, RST_ipd, SET_ipd, DIN_ipd, 
	RAD0_ipd, RAD1_ipd, RAD2_ipd, RAD3_ipd, RAD4_ipd, WAD0_ipd, WAD1_ipd, 
	WAD2_ipd, WAD3_ipd, WAD4_ipd, WREN_ipd, WPE_ipd)

     variable memory   : std_logic_vector((2**5)-1 downto 0) := hex2bin(initval);
     variable wadr_reg : std_logic_vector(4 downto 0) := "00000";
     variable radr_reg : std_logic_vector(4 downto 0) := "00000";
     variable wren_reg : std_logic := '0';
     variable wpe_reg  : std_logic := '0';
     variable din_reg  : std_logic := '0';
     variable rindex   : integer := 0;
     variable windex   : integer := 0;

     -- Timing Check Results
     variable Tviol_DIN   : STD_ULOGIC := '0';
     variable Tviol_WAD0  : STD_ULOGIC := '0';
     variable Tviol_WAD1  : STD_ULOGIC := '0';
     variable Tviol_WAD2  : STD_ULOGIC := '0';
     variable Tviol_WAD3  : STD_ULOGIC := '0';
     variable Tviol_WAD4  : STD_ULOGIC := '0';
     variable Tviol_RAD0  : STD_ULOGIC := '0';
     variable Tviol_RAD0H : STD_ULOGIC := '0';
     variable Tviol_RAD1  : STD_ULOGIC := '0';
     variable Tviol_RAD1H : STD_ULOGIC := '0';
     variable Tviol_RAD2  : STD_ULOGIC := '0';
     variable Tviol_RAD2H : STD_ULOGIC := '0';
     variable Tviol_RAD3  : STD_ULOGIC := '0';
     variable Tviol_RAD3H : STD_ULOGIC := '0';
     variable Tviol_RAD4  : STD_ULOGIC := '0';
     variable Tviol_RAD4H : STD_ULOGIC := '0';
     variable Tviol_WCLK  : STD_ULOGIC := '0';
     variable Tviol_RCLK  : STD_ULOGIC := '0';
     variable Tviol_WREN  : STD_ULOGIC := '0';
     variable Tviol_WPE   : STD_ULOGIC := '0';
     variable Tviol_RST   : STD_ULOGIC := '0';
     variable Tviol_SET   : STD_ULOGIC := '0';
     variable PeriodCheckInfo_WCLK : VitalPeriodDataType:= VitalPeriodDataInit;
     variable PeriodCheckInfo_RCLK : VitalPeriodDataType:= VitalPeriodDataInit;
     variable PeriodCheckInfo_RST  : VitalPeriodDataType:= VitalPeriodDataInit;
     variable PeriodCheckInfo_SET  : VitalPeriodDataType:= VitalPeriodDataInit;
     variable RAD0_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD0_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable RAD1_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD1_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable RAD2_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD2_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable RAD3_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD3_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable RAD4_RCLK_TimingDataS : VitalTimingDataType := VitalTimingDataInit;
     variable RAD4_RCLK_TimingDataH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD0_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD1_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD2_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD3_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WAD4_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable DIN_WCLK_TimingDataSH  : VitalTimingDataType := VitalTimingDataInit;
     variable WREN_WCLK_TimingDataSH : VitalTimingDataType := VitalTimingDataInit;
     variable WPE_WCLK_TimingDataSH  : VitalTimingDataType := VitalTimingDataInit;

     -- Functionality Results
     variable Violation : STD_ULOGIC := '0';

     -- Output Glitch Results
     variable DOUT_GlitchData : VitalGlitchDataType;
     variable DOUT_zd : STD_LOGIC := 'X';

   begin

   -----------------------
   -- Timing Check Section
   -----------------------
   IF (TimingChecksOn) THEN

           -- setup and hold checks on read address lines
           VitalSetupHoldCheck (
                TestSignal      => RAD0_ipd,
                TestSignalName  => "RAD0",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD0_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD0_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD0_RCLK_TimingDataS,
		Violation	=> Tviol_RAD0,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD0_ipd,
                TestSignalName  => "RAD0",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD0_RCLK_noedge_negedge,
                HoldLow         => thold_RAD0_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD0_RCLK_TimingDataH,
		Violation	=> Tviol_RAD0H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD1_ipd,
                TestSignalName  => "RAD1",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD1_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD1_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD1_RCLK_TimingDataS,
		Violation	=> Tviol_RAD1,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD1_ipd,
                TestSignalName  => "RAD1",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD1_RCLK_noedge_negedge,
                HoldLow         => thold_RAD1_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD1_RCLK_TimingDataH,
		Violation	=> Tviol_RAD1H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD2_ipd,
                TestSignalName  => "RAD2",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD2_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD2_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD2_RCLK_TimingDataS,
		Violation	=> Tviol_RAD2,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD2_ipd,
                TestSignalName  => "RAD2",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD2_RCLK_noedge_negedge,
                HoldLow         => thold_RAD2_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD2_RCLK_TimingDataH,
		Violation	=> Tviol_RAD2H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD3_ipd,
                TestSignalName  => "RAD3",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD3_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD3_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD3_RCLK_TimingDataS,
		Violation	=> Tviol_RAD3,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD3_ipd,
                TestSignalName  => "RAD3",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD3_RCLK_noedge_negedge,
                HoldLow         => thold_RAD3_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD3_RCLK_TimingDataH,
		Violation	=> Tviol_RAD3H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD4_ipd,
                TestSignalName  => "RAD4",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => tsetup_RAD4_RCLK_noedge_posedge,
                SetupLow        => tsetup_RAD4_RCLK_noedge_posedge,
                HoldHigh        => 0 ns,
                HoldLow         => 0 ns,
		CheckEnabled	=> (RCLK_ipd='1'),
		RefTransition   => '/',
		TimingData 	=> RAD4_RCLK_TimingDataS,
		Violation	=> Tviol_RAD4,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
           VitalSetupHoldCheck (
                TestSignal      => RAD4_ipd,
                TestSignalName  => "RAD4",
                TestDelay       => 0 ns,
                RefSignal       => RCLK_ipd,
                RefSignalName   => "RCLK",
                RefDelay        => 0 ns,
                SetupHigh       => 0 ns, 
                SetupLow        => 0 ns,
                HoldHigh        => thold_RAD4_RCLK_noedge_negedge,
                HoldLow         => thold_RAD4_RCLK_noedge_negedge,
		CheckEnabled	=> (RCLK_ipd='0'),
		RefTransition   => '\',
		TimingData 	=> RAD4_RCLK_TimingDataH,
		Violation	=> Tviol_RAD4H,
		HeaderMsg       => InstancePath,
		XOn             => XOn,
		MsgOn           => MsgOn,
		MsgSeverity     => WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD0_ipd, 
		TestSignalName 	=> "WAD0", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD0_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD0_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD0_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD0_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD0_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD0, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD1_ipd, 
		TestSignalName 	=> "WAD1", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD1_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD1_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD1_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD1_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD1_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD1, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD2_ipd, 
		TestSignalName 	=> "WAD2", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD2_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD2_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD2_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD2_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD2_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD2, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD3_ipd, 
		TestSignalName 	=> "WAD3", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD3_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD3_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD3_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD3_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD3_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD3, 
		MsgSeverity 	=> WARNING);
        VitalSetupHoldCheck (
		TestSignal 	=> WAD4_ipd, 
		TestSignalName 	=> "WAD4", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WAD4_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WAD4_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WAD4_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WAD4_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WAD4_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WAD4, 
		MsgSeverity 	=> WARNING);
	-- setup and hold checks on data
        VitalSetupHoldCheck (
		TestSignal 	=> DIN_ipd, 
		TestSignalName 	=> "DIN", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_DIN_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_DIN_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_DIN_WCLK_noedge_posedge, 
		HoldLow 	=> thold_DIN_WCLK_noedge_posedge, 
		CheckEnabled 	=> (WPE_ipd='1' and WREN_ipd='1'),
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> DIN_WCLK_TimingDataSH, 
		Violation 	=> Tviol_DIN, 
		MsgSeverity 	=> WARNING);
	-- setup and hold checks on write enable
        VitalSetupHoldCheck (
		TestSignal 	=> WREN_ipd, 
		TestSignalName 	=> "WREN", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WREN_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WREN_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WREN_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WREN_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WREN_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WREN, 
		MsgSeverity 	=> WARNING);
	-- setup and hold checks on port enable
        VitalSetupHoldCheck (
		TestSignal 	=> WPE_ipd, 
		TestSignalName 	=> "WPE", 
		RefSignal 	=> WCLK_ipd,
		RefSignalName 	=> "WCLK",
		SetupHigh 	=> tsetup_WPE_WCLK_noedge_posedge, 
		SetupLow 	=> tsetup_WPE_WCLK_noedge_posedge, 
		HoldHigh 	=> thold_WPE_WCLK_noedge_posedge, 
		HoldLow 	=> thold_WPE_WCLK_noedge_posedge, 
		CheckEnabled 	=> TRUE,
		RefTransition 	=> '/',
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath, 
		TimingData 	=> WPE_WCLK_TimingDataSH, 
		Violation 	=> Tviol_WPE, 
		MsgSeverity 	=> WARNING);
	-- period and pulse width checks on write and read clocks,
	-- reset and set
	VitalPeriodPulseCheck (
		TestSignal 	=> WCLK_ipd,
		TestSignalName 	=> "WCLK",
		Period 		=> tperiod_WCLK,
		PulseWidthHigh 	=> tpw_WCLK_posedge,
		PulseWidthLow 	=> tpw_WCLK_negedge,
		PeriodData 	=> PeriodCheckInfo_WCLK,
		Violation 	=> Tviol_WCLK,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> RCLK_ipd,
		TestSignalName 	=> "RCLK",
		Period 		=> tperiod_RCLK,
		PulseWidthHigh 	=> tpw_RCLK_posedge,
		PulseWidthLow 	=> tpw_RCLK_negedge,
		PeriodData 	=> PeriodCheckInfo_RCLK,
		Violation 	=> Tviol_RCLK,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> RST_ipd,
		TestSignalName 	=> "RST",
		Period 		=> tperiod_RST,
		PulseWidthHigh 	=> tpw_RST_posedge,
		PulseWidthLow 	=> tpw_RST_negedge,
		PeriodData 	=> PeriodCheckInfo_RST,
		Violation 	=> Tviol_RST,
		XOn 		=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
	VitalPeriodPulseCheck (
		TestSignal 	=> SET_ipd,
		TestSignalName 	=> "SET",
		Period 		=> tperiod_SET,
		PulseWidthHigh 	=> tpw_SET_posedge,
		PulseWidthLow 	=> tpw_SET_negedge,
		PeriodData 	=> PeriodCheckInfo_SET,
		Violation 	=> Tviol_SET,
		XOn	 	=> XOn,
		MsgOn 		=> MsgOn, 
		HeaderMsg 	=> InstancePath,
		CheckEnabled 	=> TRUE,
		MsgSeverity 	=> WARNING);
   END IF;

   ------------------------
   -- Functionality Section
   ------------------------
--   Violation := Tviol_DIN OR Tviol_WAD0 OR Tviol_WAD1 OR Tviol_WAD2
--		OR Tviol_WAD3 OR Tviol_WCLK OR Tviol_RAD0 OR Tviol_RAD1 OR
--		Tviol_RAD2 OR Tviol_RAD3 OR Tviol_RCLK OR
--		Tviol_WREN OR Tviol_WPE OR Tviol_RST OR Tviol_SET;

   -- Check for unknowns 
   IF (IS_X(WREN_ipd) OR IS_X(WPE_ipd)) THEN
      assert false
        report "NEOSRN32 MEMORY HAZARD WRITE ENABLE UNKNOWN!"
        severity WARNING;
      DOUT_zd := 'X';
   ELSIF (IS_X(WAD0_ipd) OR IS_X(WAD1_ipd) OR IS_X(WAD2_ipd)
        OR IS_X(WAD3_ipd)) THEN
      assert false
        report "NEOSRN32 MEMORY HAZARD WRITE ADDRESS UNKNOWN!"
        severity WARNING;
      DOUT_zd := 'X';
   ELSIF (IS_X(RAD0_ipd) OR IS_X(RAD1_ipd) OR IS_X(RAD2_ipd)
        OR IS_X(RAD3_ipd)) THEN
      assert false
        report "NEOSRN32 MEMORY HAZARD READ ADDRESS UNKNOWN!"
        severity WARNING;
      DOUT_zd := 'X';

   ELSE

      -- At the rising edge of WCLK register WADm, WREN, WPE and DIN 
      IF (RST_ipd = '1') THEN
         wadr_reg := (others => '0');
         wren_reg := '0';
         wpe_reg  := '0';
         din_reg  := '0';
      ELSIF (SET_ipd = '1') THEN
         wadr_reg := (others => '1');
         wren_reg := '1';
         wpe_reg  := '1';
         din_reg  := '1';
      ELSIF (WCLK_ipd'EVENT and WCLK_ipd = '1') THEN
         wadr_reg := (WAD4_ipd, WAD3_ipd, WAD2_ipd, WAD1_ipd, WAD0_ipd);
         wren_reg := WREN_ipd;
         wpe_reg  := WPE_ipd;
         din_reg  := DIN_ipd;
      END IF;
      windex := CONV_INTEGER(wadr_reg);

      -- At the falling edge of WCLK, write to memory at address WADm
      -- if RST and SET are low
      -- and if WREN and WPE are high and there are no timing violations
      IF (WCLK_ipd'EVENT and WCLK_ipd = '0') THEN
         IF (RST = '0' AND SET = '0') THEN
            IF (wren_reg = '1' AND wpe_reg = '1' AND Violation = '0') THEN
                memory(windex) := din_reg;
            END IF;
         END IF;
      END IF;

      -- Latch-in RADm when RCLK is high
      IF (RST_ipd = '1') THEN
         radr_reg := (others => '0');
      ELSIF (SET_ipd = '1') THEN
         radr_reg := (others => '1');
      ELSIF (RCLK_ipd = '1') THEN
         radr_reg := (RAD4_ipd, RAD3_ipd, RAD2_ipd, RAD1_ipd, RAD0_ipd);
      END IF;
      rindex := CONV_INTEGER(radr_reg);

      -- Read from memory if there are no violations, and RST and SET are low
      IF (Violation = '0') THEN
         DOUT_zd := memory(rindex);
      ELSE
         DOUT_zd := 'X';
      END IF;

   END IF;

   ------------------------
   -- Path Delay Section
   ------------------------
   VitalPathDelay01 (
     OutSignal => DOUT,
     OutSignalName => "DOUT",
     OutTemp => DOUT_zd,
     Paths => (0 => (WCLK_ipd'LAST_EVENT, tpd_WCLK_DOUT, TRUE),
	       1 => (RCLK_ipd'LAST_EVENT, tpd_RCLK_DOUT, TRUE),
	       2 => (RAD0_ipd'LAST_EVENT, tpd_RAD0_DOUT, TRUE),
	       3 => (RAD1_ipd'LAST_EVENT, tpd_RAD1_DOUT, TRUE),
	       4 => (RAD2_ipd'LAST_EVENT, tpd_RAD2_DOUT, TRUE),
	       5 => (RAD3_ipd'LAST_EVENT, tpd_RAD3_DOUT, TRUE),
	       6 => (RAD4_ipd'LAST_EVENT, tpd_RAD4_DOUT, TRUE),
	       7 => (SET_ipd'LAST_EVENT, tpd_SET_DOUT, TRUE),
	       8 => (RST_ipd'LAST_EVENT, tpd_RST_DOUT, TRUE)),
     GlitchData => DOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;	

		
--
----- CELL NEOTRI -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOTRI is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath  	: STRING  := "NEOTRI";
  	tipd_VIN  	: VitalDelayType01 := (0 ns, 0 ns);
  	tipd_CTL  	: VitalDelayType01 := (0 ns, 0 ns);
  	tpd_VIN_VOUT 	: VitalDelayType01Z := 
				(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
  	tpd_CTL_VOUT 	: VitalDelayType01Z := 
				(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns));

    port (
        VIN		: in STD_LOGIC;
        CTL	 	: in STD_LOGIC;
        VOUT 		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOTRI : entity is TRUE;

end NEOTRI ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOTRI is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN_ipd  : STD_LOGIC := 'X';
    signal CTL_ipd  : STD_LOGIC := 'X';

begin

    WireDelay : block
    begin
    VitalWireDelay(VIN_ipd, VIN, tipd_VIN);
    VitalWireDelay(CTL_ipd, CTL, tipd_CTL);
    end block;

    VitalBehavior : process (VIN_ipd, CTL_ipd)
        VARIABLE VOUT_GlitchData : VitalGlitchDataType;
        VARIABLE VOUT_zd  : STD_ULOGIC := 'X';

    begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    VOUT_zd := VitalBUFIF1(VIN_ipd, CTL_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01Z(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN_ipd'LAST_EVENT, tpd_VIN_VOUT, TRUE),
               1 => (CTL_ipd'LAST_EVENT, tpd_CTL_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn,
     OutputMap => "UX01ZWLH-");

   end process;

end V;


--
----- CELL NEOUPAD -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOUPAD is
    generic (
   	TimingChecksOn  : BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath    : STRING  := "NEOUPAD";
  	tipd_PAD  	: VitalDelayType01 	:= (0 ns, 0 ns)) ;

    port (
        PAD 		: inout STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOUPAD : entity is TRUE;

end NEOUPAD ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOUPAD is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal PAD_ipd  : STD_LOGIC := 'X';
begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(PAD_ipd, PAD, tipd_PAD);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (PAD_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS PAD_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   -- VARIABLE PAD_GlitchData     : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   PAD_zd := PAD_ipd;

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------

   end process;

end V;


--
----- CELL NEOXOR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR2 is
    generic (
   	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath 	: STRING  := "NEOXOR2";
  	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0	 	: in STD_LOGIC;
        VIN1	 	: in STD_LOGIC;
        VOUT	 	: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR2 : entity is TRUE;

end NEOXOR2 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR2 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process ( VIN0_ipd, VIN1_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOXOR2_0_tab : VitalTruthTableType (0 to 4, 0 to 2) := (
            ('0', '1', '1'),
            ('1', '0', '1'),
            ('1', '1', '0'),
            ('0', '0', '0'),
            ('B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;
   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOXOR2_0_tab,
        DataIn => STD_LOGIC_VECTOR'( VIN0_ipd, VIN1_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01(
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declararion --
entity NEOXOR3 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath 	: STRING  := "NEOXOR3";
  	tpd_VIN0_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2 	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0	 	: in STD_LOGIC;
        VIN1	 	: in STD_LOGIC;
        VIN2	 	: in STD_LOGIC;
        VOUT	 	: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR3 : entity is TRUE;

end NEOXOR3 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR3 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd)

   -- functionality results
   VARIABLE VOUT_zd : STD_ULOGIC := 'X';
   CONSTANT NEOXOR3_0_tab : VitalTruthTableType (0 to 8, 0 to 3) := (
            ('1', '1', '1', '1'),
            ('0', '0', '1', '1'),
            ('0', '1', '0', '1'),
            ('1', '0', '0', '1'),
            ('0', '1', '1', '0'),
            ('1', '0', '1', '0'),
            ('1', '1', '0', '0'),
            ('0', '0', '0', '0'),
            ('B', 'B', 'B', '0'));

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := VitalTruthTable(TruthTable => NEOXOR3_0_tab,
        DataIn => STD_LOGIC_VECTOR'( VIN0_ipd, VIN1_ipd, VIN2_ipd));

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01(
     OutSignal => VOUT, 
     OutSignalName => "VOUT", 
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR4 is
    generic (
   	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath 	: STRING  := "NEOXOR4";
  	tpd_VIN0_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3 	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		: in STD_LOGIC;
        VIN1		: in STD_LOGIC;
        VIN2		: in STD_LOGIC;
        VIN3		: in STD_LOGIC;
        VOUT		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR4 : entity is TRUE;

end NEOXOR4 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR4 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process ( VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

    begin

    IF (TimingChecksOn) THEN
    -----------------------------------
    -- No Timing Checks for a comb gate
    -----------------------------------
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    VOUT_zd := (VIN0_ipd) XOR (VIN1_ipd) XOR (VIN2_ipd) XOR (VIN3_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
                1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
                2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
                3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR5 is
    generic (
   	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath	: STRING  := "NEOXOR5";	
  	tpd_VIN0_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4 	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		: in STD_LOGIC;
        VIN1		: in STD_LOGIC;
        VIN2		: in STD_LOGIC;
        VIN3		: in STD_LOGIC;
        VIN4		: in STD_LOGIC;
        VOUT		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR5 : entity is TRUE;

end NEOXOR5 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR5 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData	 : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := (VIN0_ipd) XOR (VIN1_ipd) XOR (VIN2_ipd) XOR (VIN3_ipd) XOR
		(VIN4_ipd); 

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
     	       3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR6 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath   	: STRING  := "NEOXOR6";
  	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0 		: in STD_LOGIC;
        VIN1 		: in STD_LOGIC;
        VIN2 		: in STD_LOGIC;
        VIN3 		: in STD_LOGIC;
        VIN4 		: in STD_LOGIC;
        VIN5 		: in STD_LOGIC;
        VOUT		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR6 : entity is TRUE;

end NEOXOR6 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR6 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
					VIN4_ipd, VIN5_ipd)
   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData 	: VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := (VIN0_ipd) XOR (VIN1_ipd) XOR (VIN2_ipd) XOR (VIN3_ipd) XOR
		(VIN4_ipd) XOR (VIN5_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR7 is
    generic (
   	TimingChecksOn  : BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath    : STRING  := "NEOXOR7";
  	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		: in STD_LOGIC;
        VIN1		: in STD_LOGIC;
        VIN2		: in STD_LOGIC;
        VIN3		: in STD_LOGIC;
        VIN4	 	: in STD_LOGIC;
        VIN5		: in STD_LOGIC;
        VIN6		: in STD_LOGIC;
        VOUT 		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR7 : entity is TRUE;

end NEOXOR7 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR7 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';
    signal VIN6_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := (VIN0_ipd) XOR (VIN1_ipd) XOR (VIN2_ipd) XOR (VIN3_ipd) XOR
		(VIN4_ipd) XOR (VIN5_ipd) XOR (VIN6_ipd);

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR8 is
    generic (
   	TimingChecksOn  : BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath    : STRING  := "NEOXOR8";
  	tpd_VIN0_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN7_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		 : in STD_LOGIC;
        VIN1		 : in STD_LOGIC;
        VIN2		 : in STD_LOGIC;
        VIN3		 : in STD_LOGIC;
        VIN4	 	 : in STD_LOGIC;
        VIN5		 : in STD_LOGIC;
        VIN6		 : in STD_LOGIC;
        VIN7		 : in STD_LOGIC;
        VOUT 		 : out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR8 : entity is TRUE;

end NEOXOR8 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR8 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  : STD_LOGIC := 'X';
    signal VIN1_ipd  : STD_LOGIC := 'X';
    signal VIN2_ipd  : STD_LOGIC := 'X';
    signal VIN3_ipd  : STD_LOGIC := 'X';
    signal VIN4_ipd  : STD_LOGIC := 'X';
    signal VIN5_ipd  : STD_LOGIC := 'X';
    signal VIN6_ipd  : STD_LOGIC := 'X';
    signal VIN7_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, 
				VIN4_ipd, VIN5_ipd, VIN6_ipd, VIN7_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd := (VIN0_ipd) XOR (VIN1_ipd) XOR (VIN2_ipd) XOR (VIN3_ipd) XOR
		(VIN4_ipd) XOR (VIN5_ipd) XOR (VIN6_ipd) XOR (VIN7_ipd);

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR16 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR16 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath   	: STRING  := "NEOXOR16";
  	tpd_VIN0_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN7_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN8_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN9_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN10_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN11_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN12_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN13_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN14_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN15_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN8  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN9  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN10  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN11  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN12  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN13 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN14  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN15  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		: in STD_LOGIC;
        VIN1		: in STD_LOGIC;
        VIN2		: in STD_LOGIC;
        VIN3		: in STD_LOGIC;
        VIN4	 	: in STD_LOGIC;
        VIN5		: in STD_LOGIC;
        VIN6		: in STD_LOGIC;
        VIN7		: in STD_LOGIC;
        VIN8		: in STD_LOGIC;
        VIN9		: in STD_LOGIC;
        VIN10		: in STD_LOGIC;
        VIN11		: in STD_LOGIC;
        VIN12		: in STD_LOGIC;
        VIN13		: in STD_LOGIC;
        VIN14		: in STD_LOGIC;
        VIN15		: in STD_LOGIC;
        VOUT 		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR16 : entity is TRUE;


end NEOXOR16 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR16 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  	: STD_LOGIC := 'X';
    signal VIN1_ipd  	: STD_LOGIC := 'X';
    signal VIN2_ipd  	: STD_LOGIC := 'X';
    signal VIN3_ipd  	: STD_LOGIC := 'X';
    signal VIN4_ipd  	: STD_LOGIC := 'X';
    signal VIN5_ipd  	: STD_LOGIC := 'X';
    signal VIN6_ipd  	: STD_LOGIC := 'X';
    signal VIN7_ipd  	: STD_LOGIC := 'X';
    signal VIN8_ipd  	: STD_LOGIC := 'X';
    signal VIN9_ipd  	: STD_LOGIC := 'X';
    signal VIN10_ipd  	: STD_LOGIC := 'X';
    signal VIN11_ipd  	: STD_LOGIC := 'X';
    signal VIN12_ipd  	: STD_LOGIC := 'X';
    signal VIN13_ipd  	: STD_LOGIC := 'X';
    signal VIN14_ipd  	: STD_LOGIC := 'X';
    signal VIN15_ipd  	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   VitalWireDelay(VIN8_ipd, VIN8, tipd_VIN8);
   VitalWireDelay(VIN9_ipd, VIN9, tipd_VIN9);
   VitalWireDelay(VIN10_ipd, VIN10, tipd_VIN10);
   VitalWireDelay(VIN11_ipd, VIN11, tipd_VIN11);
   VitalWireDelay(VIN12_ipd, VIN12, tipd_VIN12);
   VitalWireDelay(VIN13_ipd, VIN13, tipd_VIN13);
   VitalWireDelay(VIN14_ipd, VIN14, tipd_VIN14);
   VitalWireDelay(VIN15_ipd, VIN15, tipd_VIN15);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd,
				VIN5_ipd, VIN6_ipd, VIN7_ipd, VIN8_ipd, 
				VIN9_ipd, VIN10_ipd, VIN11_ipd, VIN12_ipd,
				VIN13_ipd, VIN14_ipd, VIN15_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd :=   (VIN0_ipd XOR VIN1_ipd XOR VIN2_ipd XOR VIN3_ipd XOR
	      	 VIN4_ipd XOR VIN5_ipd XOR VIN6_ipd XOR VIN7_ipd XOR
		 VIN8_ipd XOR VIN9_ipd XOR VIN10_ipd XOR VIN11_ipd XOR
		 VIN12_ipd XOR VIN13_ipd XOR VIN14_ipd XOR VIN15_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE),
               8 => (VIN8_ipd'LAST_EVENT, tpd_VIN8_VOUT, TRUE),
               9 => (VIN9_ipd'LAST_EVENT, tpd_VIN9_VOUT, TRUE),
               10 => (VIN10_ipd'LAST_EVENT, tpd_VIN10_VOUT, TRUE),
               11 => (VIN11_ipd'LAST_EVENT, tpd_VIN11_VOUT, TRUE),
               12 => (VIN12_ipd'LAST_EVENT, tpd_VIN12_VOUT, TRUE),
               13 => (VIN13_ipd'LAST_EVENT, tpd_VIN13_VOUT, TRUE),
               14 => (VIN14_ipd'LAST_EVENT, tpd_VIN14_VOUT, TRUE),
               15 => (VIN15_ipd'LAST_EVENT, tpd_VIN15_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOXOR32 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity NEOXOR32 is
    generic (
   	TimingChecksOn 	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
   	InstancePath   	: STRING  := "NEOXOR32";
  	tpd_VIN0_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN1_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN2_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN3_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN4_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN5_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN6_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN7_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN8_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN9_VOUT  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN10_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN11_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN12_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN13_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN14_VOUT 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN15_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN16_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN17_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN18_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN19_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN20_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN21_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN22_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN23_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN24_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN25_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN26_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN27_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN28_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN29_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN30_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tpd_VIN31_VOUT	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN0  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN1  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN2  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN3  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN4  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN5  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN6  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN7  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN8  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN9  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN10  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN11  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN12  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN13 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN14  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN15  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN16  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN17  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN18  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN19  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN20  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN21  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN22  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN23  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN24  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN25  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN26  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN27  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN28 	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN29  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN30  	: VitalDelayType01 := (0 ns, 0 ns) ;
  	tipd_VIN31  	: VitalDelayType01 := (0 ns, 0 ns)) ;

    port (
        VIN0		: in STD_LOGIC;
        VIN1		: in STD_LOGIC;
        VIN2		: in STD_LOGIC;
        VIN3		: in STD_LOGIC;
        VIN4	 	: in STD_LOGIC;
        VIN5		: in STD_LOGIC;
        VIN6		: in STD_LOGIC;
        VIN7		: in STD_LOGIC;
        VIN8		: in STD_LOGIC;
        VIN9		: in STD_LOGIC;
        VIN10		: in STD_LOGIC;
        VIN11		: in STD_LOGIC;
        VIN12		: in STD_LOGIC;
        VIN13		: in STD_LOGIC;
        VIN14		: in STD_LOGIC;
        VIN15		: in STD_LOGIC;
        VIN16		: in STD_LOGIC;
        VIN17		: in STD_LOGIC;
        VIN18		: in STD_LOGIC;
        VIN19		: in STD_LOGIC;
        VIN20		: in STD_LOGIC;
        VIN21		: in STD_LOGIC;
        VIN22		: in STD_LOGIC;
        VIN23		: in STD_LOGIC;
        VIN24		: in STD_LOGIC;
        VIN25		: in STD_LOGIC;
        VIN26		: in STD_LOGIC;
        VIN27		: in STD_LOGIC;
        VIN28		: in STD_LOGIC;
        VIN29		: in STD_LOGIC;
        VIN30		: in STD_LOGIC;
        VIN31		: in STD_LOGIC;
        VOUT 		: out STD_LOGIC);

    attribute VITAL_LEVEL0 of NEOXOR32 : entity is TRUE;


end NEOXOR32 ;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOXOR32 is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal VIN0_ipd  	: STD_LOGIC := 'X';
    signal VIN1_ipd  	: STD_LOGIC := 'X';
    signal VIN2_ipd  	: STD_LOGIC := 'X';
    signal VIN3_ipd  	: STD_LOGIC := 'X';
    signal VIN4_ipd  	: STD_LOGIC := 'X';
    signal VIN5_ipd  	: STD_LOGIC := 'X';
    signal VIN6_ipd  	: STD_LOGIC := 'X';
    signal VIN7_ipd  	: STD_LOGIC := 'X';
    signal VIN8_ipd  	: STD_LOGIC := 'X';
    signal VIN9_ipd  	: STD_LOGIC := 'X';
    signal VIN10_ipd  	: STD_LOGIC := 'X';
    signal VIN11_ipd  	: STD_LOGIC := 'X';
    signal VIN12_ipd  	: STD_LOGIC := 'X';
    signal VIN13_ipd  	: STD_LOGIC := 'X';
    signal VIN14_ipd  	: STD_LOGIC := 'X';
    signal VIN15_ipd  	: STD_LOGIC := 'X';
    signal VIN16_ipd  	: STD_LOGIC := 'X';
    signal VIN17_ipd  	: STD_LOGIC := 'X';
    signal VIN18_ipd  	: STD_LOGIC := 'X';
    signal VIN19_ipd  	: STD_LOGIC := 'X';
    signal VIN20_ipd  	: STD_LOGIC := 'X';
    signal VIN21_ipd  	: STD_LOGIC := 'X';
    signal VIN22_ipd  	: STD_LOGIC := 'X';
    signal VIN23_ipd  	: STD_LOGIC := 'X';
    signal VIN24_ipd  	: STD_LOGIC := 'X';
    signal VIN25_ipd  	: STD_LOGIC := 'X';
    signal VIN26_ipd  	: STD_LOGIC := 'X';
    signal VIN27_ipd  	: STD_LOGIC := 'X';
    signal VIN28_ipd  	: STD_LOGIC := 'X';
    signal VIN29_ipd  	: STD_LOGIC := 'X';
    signal VIN30_ipd  	: STD_LOGIC := 'X';
    signal VIN31_ipd  	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(VIN0_ipd, VIN0, tipd_VIN0);
   VitalWireDelay(VIN1_ipd, VIN1, tipd_VIN1);
   VitalWireDelay(VIN2_ipd, VIN2, tipd_VIN2);
   VitalWireDelay(VIN3_ipd, VIN3, tipd_VIN3);
   VitalWireDelay(VIN4_ipd, VIN4, tipd_VIN4);
   VitalWireDelay(VIN5_ipd, VIN5, tipd_VIN5);
   VitalWireDelay(VIN6_ipd, VIN6, tipd_VIN6);
   VitalWireDelay(VIN7_ipd, VIN7, tipd_VIN7);
   VitalWireDelay(VIN8_ipd, VIN8, tipd_VIN8);
   VitalWireDelay(VIN9_ipd, VIN9, tipd_VIN9);
   VitalWireDelay(VIN10_ipd, VIN10, tipd_VIN10);
   VitalWireDelay(VIN11_ipd, VIN11, tipd_VIN11);
   VitalWireDelay(VIN12_ipd, VIN12, tipd_VIN12);
   VitalWireDelay(VIN13_ipd, VIN13, tipd_VIN13);
   VitalWireDelay(VIN14_ipd, VIN14, tipd_VIN14);
   VitalWireDelay(VIN15_ipd, VIN15, tipd_VIN15);
   VitalWireDelay(VIN16_ipd, VIN16, tipd_VIN16);
   VitalWireDelay(VIN17_ipd, VIN17, tipd_VIN17);
   VitalWireDelay(VIN18_ipd, VIN18, tipd_VIN18);
   VitalWireDelay(VIN19_ipd, VIN19, tipd_VIN19);
   VitalWireDelay(VIN20_ipd, VIN20, tipd_VIN20);
   VitalWireDelay(VIN21_ipd, VIN21, tipd_VIN21);
   VitalWireDelay(VIN22_ipd, VIN22, tipd_VIN22);
   VitalWireDelay(VIN23_ipd, VIN23, tipd_VIN23);
   VitalWireDelay(VIN24_ipd, VIN24, tipd_VIN24);
   VitalWireDelay(VIN25_ipd, VIN25, tipd_VIN25);
   VitalWireDelay(VIN26_ipd, VIN26, tipd_VIN26);
   VitalWireDelay(VIN27_ipd, VIN27, tipd_VIN27);
   VitalWireDelay(VIN28_ipd, VIN28, tipd_VIN28);
   VitalWireDelay(VIN29_ipd, VIN29, tipd_VIN29);
   VitalWireDelay(VIN30_ipd, VIN30, tipd_VIN30);
   VitalWireDelay(VIN31_ipd, VIN31, tipd_VIN31);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (VIN0_ipd, VIN1_ipd, VIN2_ipd, VIN3_ipd, VIN4_ipd,
				VIN5_ipd, VIN6_ipd, VIN7_ipd, VIN8_ipd, 
				VIN9_ipd, VIN10_ipd, VIN11_ipd, VIN12_ipd,
				VIN13_ipd, VIN14_ipd, VIN15_ipd, VIN16_ipd,
				VIN17_ipd, VIN18_ipd, VIN19_ipd, VIN20_ipd,
				VIN21_ipd, VIN22_ipd, VIN23_ipd, VIN24_ipd,
				VIN25_ipd, VIN26_ipd, VIN27_ipd, VIN28_ipd,
				VIN29_ipd, VIN30_ipd, VIN31_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS VOUT_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE VOUT_GlitchData : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   -----------------------------------
   -- No Timing Checks for a comb gate
   -----------------------------------
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   VOUT_zd :=  ((VIN0_ipd XOR VIN1_ipd XOR VIN2_ipd XOR VIN3_ipd XOR
	      	 VIN4_ipd XOR VIN5_ipd XOR VIN6_ipd XOR VIN7_ipd XOR
		 VIN8_ipd XOR VIN9_ipd XOR VIN10_ipd XOR VIN11_ipd XOR
		 VIN12_ipd XOR VIN13_ipd XOR VIN14_ipd XOR VIN15_ipd) XOR
		(VIN16_ipd XOR VIN17_ipd XOR VIN18_ipd XOR VIN19_ipd XOR
		 VIN20_ipd XOR VIN21_ipd XOR VIN22_ipd XOR VIN23_ipd XOR
		 VIN24_ipd XOR VIN25_ipd XOR VIN26_ipd XOR VIN27_ipd XOR
		 VIN28_ipd XOR VIN29_ipd XOR VIN30_ipd XOR VIN31_ipd));


    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => VOUT,
     OutSignalName => "VOUT",
     OutTemp => VOUT_zd,
     Paths => (0 => (VIN0_ipd'LAST_EVENT, tpd_VIN0_VOUT, TRUE),
               1 => (VIN1_ipd'LAST_EVENT, tpd_VIN1_VOUT, TRUE),
               2 => (VIN2_ipd'LAST_EVENT, tpd_VIN2_VOUT, TRUE),
               3 => (VIN3_ipd'LAST_EVENT, tpd_VIN3_VOUT, TRUE),
               4 => (VIN4_ipd'LAST_EVENT, tpd_VIN4_VOUT, TRUE),
               5 => (VIN5_ipd'LAST_EVENT, tpd_VIN5_VOUT, TRUE),
               6 => (VIN6_ipd'LAST_EVENT, tpd_VIN6_VOUT, TRUE),
               7 => (VIN7_ipd'LAST_EVENT, tpd_VIN7_VOUT, TRUE),
               8 => (VIN8_ipd'LAST_EVENT, tpd_VIN8_VOUT, TRUE),
               9 => (VIN9_ipd'LAST_EVENT, tpd_VIN9_VOUT, TRUE),
               10 => (VIN10_ipd'LAST_EVENT, tpd_VIN10_VOUT, TRUE),
               11 => (VIN11_ipd'LAST_EVENT, tpd_VIN11_VOUT, TRUE),
               12 => (VIN12_ipd'LAST_EVENT, tpd_VIN12_VOUT, TRUE),
               13 => (VIN13_ipd'LAST_EVENT, tpd_VIN13_VOUT, TRUE),
               14 => (VIN14_ipd'LAST_EVENT, tpd_VIN14_VOUT, TRUE),
               15 => (VIN15_ipd'LAST_EVENT, tpd_VIN15_VOUT, TRUE),
               16 => (VIN16_ipd'LAST_EVENT, tpd_VIN16_VOUT, TRUE),
               17 => (VIN17_ipd'LAST_EVENT, tpd_VIN17_VOUT, TRUE),
               18 => (VIN18_ipd'LAST_EVENT, tpd_VIN18_VOUT, TRUE),
               19 => (VIN19_ipd'LAST_EVENT, tpd_VIN19_VOUT, TRUE),
               20 => (VIN20_ipd'LAST_EVENT, tpd_VIN20_VOUT, TRUE),
               21 => (VIN21_ipd'LAST_EVENT, tpd_VIN21_VOUT, TRUE),
               22 => (VIN22_ipd'LAST_EVENT, tpd_VIN22_VOUT, TRUE),
               23 => (VIN23_ipd'LAST_EVENT, tpd_VIN23_VOUT, TRUE),
               24 => (VIN14_ipd'LAST_EVENT, tpd_VIN24_VOUT, TRUE),
               25 => (VIN25_ipd'LAST_EVENT, tpd_VIN25_VOUT, TRUE),
               26 => (VIN26_ipd'LAST_EVENT, tpd_VIN26_VOUT, TRUE),
               27 => (VIN27_ipd'LAST_EVENT, tpd_VIN27_VOUT, TRUE),
               28 => (VIN28_ipd'LAST_EVENT, tpd_VIN28_VOUT, TRUE),
               29 => (VIN29_ipd'LAST_EVENT, tpd_VIN29_VOUT, TRUE),
               30 => (VIN30_ipd'LAST_EVENT, tpd_VIN30_VOUT, TRUE),
               31 => (VIN31_ipd'LAST_EVENT, tpd_VIN31_VOUT, TRUE)),
     GlitchData => VOUT_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

   end process;

end V;


--
----- CELL NEOZERO -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NEOZERO is
   generic(
 	TimingChecksOn	: BOOLEAN := TRUE;
      	XOn		: BOOLEAN := FALSE;
    	MsgOn		: BOOLEAN := FALSE;
 	InstancePath	: STRING := "NEOZERO");

   port(
	VOUT           	: out STD_LOGIC := '0');

    attribute VITAL_LEVEL0 of NEOZERO : entity is TRUE;

end NEOZERO;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NEOZERO is

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   --  empty
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VOUT <= '0';

end V;




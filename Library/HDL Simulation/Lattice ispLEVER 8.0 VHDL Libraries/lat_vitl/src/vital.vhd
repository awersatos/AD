--------------------------------------------------------------
-- Lattice Semiconductor Corporation.
-- Copyright c 1998
--	DATE : May 28, 1998
--
--	FILE NAME : vital30.vhd
--  REVISION  : 7.0
--
--  DESCRIPTION : 	This file contains the VHDL source for 
--					the Lattice Simulation Library that
--					uses the VITAL 3.0 acceleration functions
--					and can be used in the Cadence Leapfrog
--					VHDL, Synopsys VSS, ModelTech V-System
--					Simulator Environment.
--
--
--	LIBRARY COMPILATION: Please refer to the LATTICE VHDL 
--						 manual for instructions on how to 
--						 compile the LSC VITAL library for
--						 each of the above platforms.
--
--
-----------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND1 : entity is TRUE;

end PGAND1;

architecture BEHAV of PGAND1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND10 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND10 : entity is TRUE;

end PGAND10;

architecture BEHAV of PGAND10 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND11 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND11 : entity is TRUE;

end PGAND11;

architecture BEHAV of PGAND11 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND12 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND12 : entity is TRUE;

end PGAND12;

architecture BEHAV of PGAND12 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND13 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND13 : entity is TRUE;

end PGAND13;

architecture BEHAV of PGAND13 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND14 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND14 : entity is TRUE;

end PGAND14;

architecture BEHAV of PGAND14 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND15 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND15 : entity is TRUE;

end PGAND15;

architecture BEHAV of PGAND15 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND16 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND16 : entity is TRUE;

end PGAND16;

architecture BEHAV of PGAND16 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND17 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND17 : entity is TRUE;

end PGAND17;

architecture BEHAV of PGAND17 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND18 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND18 : entity is TRUE;

end PGAND18;

architecture BEHAV of PGAND18 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND19 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND19 : entity is TRUE;

end PGAND19;

architecture BEHAV of PGAND19 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND2 : entity is TRUE;

end PGAND2;

architecture BEHAV of PGAND2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND20 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND20 : entity is TRUE;

end PGAND20;

architecture BEHAV of PGAND20 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND21 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND21 : entity is TRUE;

end PGAND21;

architecture BEHAV of PGAND21 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND22 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND22 : entity is TRUE;

end PGAND22;

architecture BEHAV of PGAND22 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND23 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND23 : entity is TRUE;

end PGAND23;

architecture BEHAV of PGAND23 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND24 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND24 : entity is TRUE;

end PGAND24;

architecture BEHAV of PGAND24 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event,tpd_A22_Z0, TRUE),
			23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND25 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND25 : entity is TRUE;

end PGAND25;

architecture BEHAV of PGAND25 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event,tpd_A22_Z0, TRUE),
			23 => (A23_ipd'last_event,tpd_A23_Z0, TRUE),
			24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND26 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 A25 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND26 : entity is TRUE;

end PGAND26;

architecture BEHAV of PGAND26 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event,tpd_A22_Z0, TRUE),
			23 => (A23_ipd'last_event,tpd_A23_Z0, TRUE),
			24 => (A24_ipd'last_event,tpd_A24_Z0, TRUE),
			25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND3 : entity is TRUE;

end PGAND3;

architecture BEHAV of PGAND3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND4 : entity is TRUE;

end PGAND4;

architecture BEHAV of PGAND4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND5 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND5 : entity is TRUE;

end PGAND5;

architecture BEHAV of PGAND5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND6 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND6 : entity is TRUE;

end PGAND6;

architecture BEHAV of PGAND6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND7 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND7 : entity is TRUE;

end PGAND7;

architecture BEHAV of PGAND7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND8 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND8 : entity is TRUE;

end PGAND8;

architecture BEHAV of PGAND8 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND9 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGAND9 : entity is TRUE;

end PGAND9;

architecture BEHAV of PGAND9 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD1 : entity is TRUE;

end PGANDD1;

architecture BEHAV of PGANDD1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD10 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD10 : entity is TRUE;

end PGANDD10;

architecture BEHAV of PGANDD10 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD11 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD11 : entity is TRUE;

end PGANDD11;

architecture BEHAV of PGANDD11 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD12 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD12 : entity is TRUE;

end PGANDD12;

architecture BEHAV of PGANDD12 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD13 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD13 : entity is TRUE;

end PGANDD13;

architecture BEHAV of PGANDD13 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD14 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD14 : entity is TRUE;

end PGANDD14;

architecture BEHAV of PGANDD14 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD15 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD15 : entity is TRUE;

end PGANDD15;

architecture BEHAV of PGANDD15 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD16 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD16 : entity is TRUE;

end PGANDD16;

architecture BEHAV of PGANDD16 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD17 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD17 : entity is TRUE;

end PGANDD17;

architecture BEHAV of PGANDD17 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD18 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD18 : entity is TRUE;

end PGANDD18;

architecture BEHAV of PGANDD18 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD19 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD19 : entity is TRUE;

end PGANDD19;

architecture BEHAV of PGANDD19 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD2 : entity is TRUE;

end PGANDD2;

architecture BEHAV of PGANDD2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD20 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD20 : entity is TRUE;

end PGANDD20;

architecture BEHAV of PGANDD20 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD21 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD21 : entity is TRUE;

end PGANDD21;

architecture BEHAV of PGANDD21 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD22 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD22 : entity is TRUE;

end PGANDD22;

architecture BEHAV of PGANDD22 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD23 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD23 : entity is TRUE;

end PGANDD23;

architecture BEHAV of PGANDD23 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD24 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD24 : entity is TRUE;

end PGANDD24;

architecture BEHAV of PGANDD24 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event,tpd_A22_Z0, TRUE),
			23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD25 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD25 : entity is TRUE;

end PGANDD25;

architecture BEHAV of PGANDD25 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event,tpd_A22_Z0, TRUE),
			23 => (A23_ipd'last_event,tpd_A23_Z0, TRUE),
			24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD26 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 A25 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD26 : entity is TRUE;

end PGANDD26;

architecture BEHAV of PGANDD26 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event,tpd_A8_Z0, TRUE),
			9 => (A9_ipd'last_event,tpd_A9_Z0, TRUE),
			10 => (A10_ipd'last_event,tpd_A10_Z0, TRUE),
			11 => (A11_ipd'last_event,tpd_A11_Z0, TRUE),
			12 => (A12_ipd'last_event,tpd_A12_Z0, TRUE),
			13 => (A13_ipd'last_event,tpd_A13_Z0, TRUE),
			14 => (A14_ipd'last_event,tpd_A14_Z0, TRUE),
			15 => (A15_ipd'last_event,tpd_A15_Z0, TRUE),
			16 => (A16_ipd'last_event,tpd_A16_Z0, TRUE),
			17 => (A17_ipd'last_event,tpd_A17_Z0, TRUE),
			18 => (A18_ipd'last_event,tpd_A18_Z0, TRUE),
			19 => (A19_ipd'last_event,tpd_A19_Z0, TRUE),
			20 => (A20_ipd'last_event,tpd_A20_Z0, TRUE),
			21 => (A21_ipd'last_event,tpd_A21_Z0, TRUE),
			22 => (A22_ipd'last_event,tpd_A22_Z0, TRUE),
			23 => (A23_ipd'last_event,tpd_A23_Z0, TRUE),
			24 => (A24_ipd'last_event,tpd_A24_Z0, TRUE),
			25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD3 : entity is TRUE;

end PGANDD3;

architecture BEHAV of PGANDD3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD4 : entity is TRUE;

end PGANDD4;

architecture BEHAV of PGANDD4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD5 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD5 : entity is TRUE;

end PGANDD5;

architecture BEHAV of PGANDD5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD6 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD6 : entity is TRUE;

end PGANDD6;

architecture BEHAV of PGANDD6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD7 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD7 : entity is TRUE;

end PGANDD7;

architecture BEHAV of PGANDD7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD8 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD8 : entity is TRUE;

end PGANDD8;

architecture BEHAV of PGANDD8 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGANDD9 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGANDD9 : entity is TRUE;

end PGANDD9;

architecture BEHAV of PGANDD9 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event,tpd_A6_Z0, TRUE),
			7 => (A7_ipd'last_event,tpd_A7_Z0, TRUE),
			8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFE is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFE : entity is TRUE;

end PGBUFE;

architecture BEHAV of PGBUFE is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFF is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFF : entity is TRUE;

end PGBUFF;

architecture BEHAV of PGBUFF is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFI is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFI : entity is TRUE;

end PGBUFI;

architecture BEHAV of PGBUFI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFK is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFK : entity is TRUE;

end PGBUFK;

architecture BEHAV of PGBUFK is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFKI is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFKI : entity is TRUE;

end PGBUFKI;

architecture BEHAV of PGBUFKI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFR is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFR : entity is TRUE;

end PGBUFR;

architecture BEHAV of PGBUFR is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFXA is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFXA : entity is TRUE;

end PGBUFXA;

architecture BEHAV of PGBUFXA is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFXI is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFXI : entity is TRUE;

end PGBUFXI;

architecture BEHAV of PGBUFXI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGBUFXO is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGBUFXO : entity is TRUE;

end PGBUFXO;

architecture BEHAV of PGBUFXO is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PGDFF.				  --
--------------------------------------------------------
library IEEE;
USE IEEE.STD_LOGIC_1164.all;

USE IEEE.VITAL_Timing.all;
USE IEEE.VITAL_Primitives.all;

entity PGDFF is
	generic (tpd_CLK_Q0_posedge	 : VitalDelayType01 :=( 0 ps, 0 ps);-- LHCQ
			 tpd_CD_Q0_posedge   : VitalDelayType01 := (0 ps, 0 ps);-- HLRQ

			 tsetup_D0_CLK_noedge_posedge	: VitalDelayType := 15 ps; -- SUD(D0/D1)
			 thold_D0_CLK_noedge_posedge	: VitalDelayType := 0 ps; -- HOLD(D0/D1)

			trecovery_CD_CLK_negedge_posedge : VitalDelayType := 0 ps; -- RECRC
			trecovery_CLK_CD_posedge_negedge : VitalDelayType := 0 ps; -- HOLDRC

			 tpw_CLK_posedge		: VitalDelayType := 50 ps;
			 tpw_CLK_negedge		: VitalDelayType := 20 ps;
			
			 tipd_D0				: VitalDelayType01 := (0 ps, 0 ps);
			 tipd_CLK				: VitalDelayType01 := (0 ps, 0 ps);
			 tipd_CD				: VitalDelayType01 := (0 ps, 0 ps);

			 InstancePath			: STRING := "*";
			 TimingChecksOn 			: Boolean 	:= TRUE);

	port (	D0, CLK, CD : IN std_logic ;
		  	Q0 			: OUT std_logic);
	attribute VITAL_LEVEL0 of PGDFF : entity is TRUE;

end PGDFF;

---------------------------------------------
--		INPUT  WIRE DELAY 				----		
---------------------------------------------

architecture behav of PGDFF is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd   : STD_ULOGIC;
	 SIGNAL CLK_ipd  : STD_ULOGIC;
	 SIGNAL CD_ipd  : STD_ULOGIC; 


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0,tipd_D0);
		VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
		VitalWireDelay (CD_ipd, CD, tipd_CD);
	END BLOCK;

-----------------------------------------------
--		BEHAVIORAL DESCRIPTION				--	
--		contains TIMING CHECK,				--
--		FUNCTIONAL SECTION & PATH DELAYS	--
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, CLK_ipd, CD_ipd)
	

	VARIABLE Timing_Viol_D0_CLK 	: std_ulogic := '0';
	VARIABLE Time_Data_D0_CLK 		: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_CD_CLK 	: std_ulogic := '0';
	VARIABLE Time_Data_CD_CLK 		: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Period_Viol_CLK		: std_ulogic := '0';
	VARIABLE Period_Info_CLK		: VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation 		: std_ulogic := '0';
	VARIABLE PrevData 		: Std_Logic_Vector(1 to 4);
	VARIABLE Results 		: Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd				: Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData 	: VitalGlitchDataType;

-- State Table for the D flip-flop--

--	-----------------------------------------------
--		Viol	D0		CLK		CD	 IQ   	Q0 	---
--	-----------------------------------------------
	CONSTANT PGDFF_tab : VitalStateTableType := (
	(	'-',	'-',	'-',	'1', '-',	'0'		),
	(	'-',	'X',	'/',	'0', '-',	'X'		),
	(	'-',	'0',	'/',	'0', '-',	'0'		),
	(	'-',	'1',	'/',	'0', '-',	'1'		),
	(	'-',	'-',	'B',	'0', '-',	'S'		));
						

begin 

--	Timing Check Section --
	
	if TimingChecksOn  THEN
		
		VitalSetupHoldCheck(
			Violation			=> Timing_Viol_D0_CLK,
			TimingData			=> Time_Data_D0_CLK,
			TestSignal 			=> D0_ipd, 
			TestSignalName 		=> "D0",
			TestDelay			=> 0 ns,
			RefSignal 			=> CLK_ipd,
			RefSignalName		=> "CLK", 
			SetupHigh			=> tsetup_D0_CLK_noedge_posedge,
			SetupLow			=> tsetup_D0_CLK_noedge_posedge,
			HoldHigh			=> thold_D0_CLK_noedge_posedge,
			HoldLow				=> thold_D0_CLK_noedge_posedge,
		 	Checkenabled		=> CD_ipd = '0',
			RefTransition		=> 'R',
			HeaderMsg			=> InstancePath & "/PGDFF",
		 	MsgOn				=> TRUE,
			XOn					=> TRUE,
			MsgSeverity			=> ERROR);


		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_CD_CLK,
			TimingData          => Time_Data_CD_CLK,
			TestSignal          => CD_ipd,
			TestSignalName      => "CD",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay  	        => 0 ns,
			Recovery            => trecovery_CD_CLK_negedge_posedge,
			Removal	            => trecovery_CLK_CD_posedge_negedge,
			ActiveLow			=> FALSE,
			Checkenabled        => TRUE,
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PGDFF",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);

		VitalPeriodPulseCheck  (
			Violation			=> Period_Viol_CLK,
			PeriodData			=> Period_Info_CLK,
			TestSignal			=> CLK_ipd,
			TestSignalName		=> "CLK",
			TestDelay			=> 0 ns,
			Period				=> 0 ns,
			PulseWidthHigh		=> tpw_CLK_posedge, 
		  	PulseWidthLow		=> tpw_CLK_negedge,
			CheckEnabled		=> CD_ipd = '0',
			HeaderMsg			=> InstancePath & "/PGDFF",
			XOn					=> TRUE,
			MsgOn				=> TRUE,
			MsgSeverity			=> ERROR);

	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_CLK or Timing_Viol_CD_CLK or Period_Viol_CLK;


	VitalStateTable ( StateTable => PGDFF_tab,
					  DataIn	 => ( Violation, D0_ipd, CLK_ipd, CD_ipd),
					  NumStates	 => 1, 
					  Result	 => Results,
					  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path

	VitalPathDelay01(
		OutSignal => Q0,
		OutSignalName => "Q0",
		OutTemp	=> Q0_zd,
		Paths =>(0 => (CD_ipd'last_event, tpd_CD_Q0_posedge,TRUE),
				--	(CD_ipd = '1') ),

		 		1 => (CLK_ipd'last_event,tpd_CLK_Q0_posedge, TRUE),
--					(CD_ipd = '0') AND (CLK_ipd = '1') AND (Q0_zd = '1')),

				2 => (CLK_ipd'last_event, tpd_CLK_Q0_posedge, TRUE )),
--					(CD_ipd = '0') AND (Q0_zd = '0') AND (CLK_ipd = '1'))),

		GlitchData => Q0_GlitchData,
		MsgOn => TRUE,
		XOn => TRUE,
		Mode => VitalTransport);

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PGDFFR.				  --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity PGDFFR is
	generic(
		tpd_CLK_Q0_posedge	 	: VitalDelayType01 :=( 0 ps, 0 ps);-- LHCQ
		tpd_CD_Q0_posedge   	: VitalDelayType01 := (0 ps, 0 ps);-- HLRQ
		tpd_RNESET_Q0_negedge  	: VitalDelayType01 := (0 ps, 0 ps);-- HLRQ

		tsetup_D0_CLK_noedge_posedge	: VitalDelayType := 15 ps; -- SUD(D0/D1)
		thold_D0_CLK_noedge_posedge		: VitalDelayType := 0 ps; -- HOLD(D0/D1)

		trecovery_CD_CLK_negedge_posedge : VitalDelayType := 0 ps; -- RECRC
		trecovery_CLK_CD_posedge_negedge : VitalDelayType := 0 ps; -- HOLDRC

		trecovery_RNESET_CLK_posedge_posedge	: VitalDelayType := 0 ps; -- RECRC
		trecovery_CLK_RNESET_posedge_posedge 	: VitalDelayType := 0 ps; -- HOLDRC

		tpw_CLK_posedge		: VitalDelayType := 50 ps;
		tpw_CLK_negedge		: VitalDelayType := 20 ps;
			
		tipd_D0				: VitalDelayType01 := (0 ps, 0 ps);
		tipd_CLK				: VitalDelayType01 := (0 ps, 0 ps);
		tipd_CD				: VitalDelayType01 := (0 ps, 0 ps);
		tipd_RNESET			: VitalDelayType01 := (0 ps, 0 ps);

		InstancePath			: STRING := "*";
		TimingChecksOn 			: Boolean 	:= TRUE);

	port( D0, CLK, CD, RNESET : IN std_logic ;
		  	Q0 			: OUT std_logic);
	attribute VITAL_LEVEL0 of PGDFFR : entity is TRUE;

end PGDFFR;

---------------------------------------------
--		INPUT  WIRE DELAY 				----		
---------------------------------------------

architecture behav of PGDFFR is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd   	: STD_ULOGIC;
	 SIGNAL CLK_ipd  	: STD_ULOGIC;
	 SIGNAL CD_ipd  	: STD_ULOGIC; 
	 SIGNAL RNESET_ipd  : STD_ULOGIC; 


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0,tipd_D0);
		VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
		VitalWireDelay (CD_ipd, CD, tipd_CD);
		VitalWireDelay (RNESET_ipd, RNESET, tipd_RNESET);
	END BLOCK;

-----------------------------------------------
--		BEHAVIORAL DESCRIPTION				--	
--		contains TIMING CHECK,				--
--		FUNCTIONAL SECTION & PATH DELAYS	--
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, CLK_ipd, CD_ipd, RNESET_ipd)
	

	VARIABLE Timing_Viol_D0_CLK 	: std_ulogic := '0';
	VARIABLE Time_Data_D0_CLK 		: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_CD_CLK 	: std_ulogic := '0';
	VARIABLE Time_Data_CD_CLK 		: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_RNESET_CLK	: std_ulogic := '0';
	VARIABLE Time_Data_RNESET_CLK	: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Period_Viol_CLK		: std_ulogic := '0';
	VARIABLE Period_Info_CLK		: VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation 		: std_ulogic := '0';
	VARIABLE PrevData 		: Std_Logic_Vector(1 to 5);
	VARIABLE Results 		: Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd				: Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData 	: VitalGlitchDataType;

-- State Table for the D flip-flop--

--  -------------------------------------------------------
--      Viol    D0      CLK     CD   RNESET     IQ      Q0  ---
--  -------------------------------------------------------
	CONSTANT PGDFFR_tab : VitalStateTableType := (
	(   '-',    '-',    '-',    '1',    '-',    '-',    '0'     ),
	(   '-',    '-',    '-',    '-',    '0',    '-',    '0'     ),
	(   '-',    'X',    '/',    '0',    '1',    '-',    'X'     ),
	(   '-',    '0',    '/',    '0',    '1',    '-',    '0'     ),
	(   '-',    '1',    '/',    '0',    '1',    '-',    '1'     ),
	(   '-',    '-',    'B',    '0',    '1',    '-',    'S'     ));


begin 

--	Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation			=> Timing_Viol_D0_CLK,
			TimingData			=> Time_Data_D0_CLK,
			TestSignal 			=> D0_ipd, 
			TestSignalName 		=> "D0",
			TestDelay			=> 0 ns,
			RefSignal 			=> CLK_ipd,
			RefSignalName		=> "CLK", 
			SetupHigh			=> tsetup_D0_CLK_noedge_posedge,
			SetupLow			=> tsetup_D0_CLK_noedge_posedge,
			HoldHigh			=> thold_D0_CLK_noedge_posedge,
			HoldLow				=> thold_D0_CLK_noedge_posedge,
		 	Checkenabled		=> (RNESET_ipd = '1') AND (CD_ipd = '0'),
			RefTransition		=> 'R',
			HeaderMsg			=> InstancePath & "/PGDFFR",
		 	MsgOn				=> TRUE,
			XOn					=> TRUE,
			MsgSeverity			=> ERROR);


		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_CD_CLK,
			TimingData          => Time_Data_CD_CLK,
			TestSignal          => CD_ipd,
			TestSignalName      => "CD",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay	        => 0 ns,
			Recovery            => trecovery_CD_CLK_negedge_posedge,
			Removal            	=> trecovery_CLK_CD_posedge_negedge,
			ActiveLow			=> FALSE,
			Checkenabled        => RNESET_ipd = '1',
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PGDFFR",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);


		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_RNESET_CLK,
			TimingData          => Time_Data_RNESET_CLK,
			TestSignal          => RNESET_ipd,
			TestSignalName      => "RNESET",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay	        => 0 ns,
			Recovery           	=> trecovery_RNESET_CLK_posedge_posedge,
			Removal            	=> trecovery_CLK_RNESET_posedge_posedge,
			ActiveLow			=> TRUE,
			Checkenabled        => TRUE,
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PGDFFR",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);

		VitalPeriodPulseCheck  (
			Violation			=> Period_Viol_CLK,
			PeriodData			=> Period_Info_CLK,
			TestSignal			=> CLK_ipd,
			TestSignalName		=> "CLK",
			TestDelay			=> 0 ns,
			Period				=> 0 ns,
			PulseWidthHigh		=> tpw_CLK_posedge, 
		  	PulseWidthLow		=> tpw_CLK_negedge,
			CheckEnabled		=> (RNESET_ipd ='1') AND (CD_ipd = '0'),
			HeaderMsg			=> InstancePath & "/PGDFFR",
			XOn					=> TRUE,
			MsgOn				=> TRUE,
			MsgSeverity			=> ERROR);

	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_CLK or Timing_Viol_CD_CLK
				or Timing_Viol_RNESET_CLK or  Period_Viol_CLK;


	VitalStateTable ( StateTable => PGDFFR_tab,
					  DataIn	 => ( Violation, D0_ipd, CLK_ipd, CD_ipd, RNESET_ipd),
					  NumStates	 => 1, 
					  Result	 => Results,
					  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path

	VitalPathDelay01(
		OutSignal => Q0,
		OutSignalName => "Q0",
		OutTemp	=> Q0_zd,
		Paths =>(0 => (CD_ipd'last_event, tpd_CD_Q0_posedge,TRUE),
				--	(CD_ipd = '1') ),

		 		1 => (CLK_ipd'last_event,tpd_CLK_Q0_posedge, TRUE),
--					(CD_ipd = '0') AND (CLK_ipd = '1') AND (Q0_zd = '1')),

				2 => (RNESET_ipd'last_event, tpd_RNESET_Q0_negedge, TRUE )),
--					(CD_ipd = '0') AND (Q0_zd = '0') AND (CLK_ipd = '1'))),

		GlitchData => Q0_GlitchData,
		MsgOn => TRUE,
		XOn => TRUE,
		Mode => VitalTransport);

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGINVI is
	generic ( tpd_A0_ZN0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGINVI : entity is TRUE;

end PGINVI;

architecture BEHAV of PGINVI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias ZN0_zd : std_logic is Results(1);
		variable ZN0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	ZN0_zd := VitalINV(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => ZN0,
	OutSignalName => "ZN0",
	OutTemp => ZN0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_ZN0, TRUE)),
	GlitchData => ZN0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGINVK is
	generic ( tpd_A0_ZN0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGINVK : entity is TRUE;

end PGINVK;

architecture BEHAV of PGINVK is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias ZN0_zd : std_logic is Results(1);
		variable ZN0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	ZN0_zd := VitalINV(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => ZN0,
	OutSignalName => "ZN0",
	OutTemp => ZN0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_ZN0, TRUE)),
	GlitchData => ZN0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGINVKI is
	generic ( tpd_A0_ZN0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGINVKI : entity is TRUE;

end PGINVKI;

architecture BEHAV of PGINVKI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias ZN0_zd : std_logic is Results(1);
		variable ZN0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	ZN0_zd := VitalINV(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => ZN0,
	OutSignalName => "ZN0",
	OutTemp => ZN0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_ZN0, TRUE)),
	GlitchData => ZN0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF41 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF41 : entity is TRUE;

end PGORF41;

architecture BEHAV of PGORF41 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF42 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF42 : entity is TRUE;

end PGORF42;

architecture BEHAV of PGORF42 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF43 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF43 : entity is TRUE;

end PGORF43;

architecture BEHAV of PGORF43 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF44 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF44 : entity is TRUE;

end PGORF44;

architecture BEHAV of PGORF44 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF51 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF51 : entity is TRUE;

end PGORF51;

architecture BEHAV of PGORF51 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF52 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF52 : entity is TRUE;

end PGORF52;

architecture BEHAV of PGORF52 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF53 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF53 : entity is TRUE;

end PGORF53;

architecture BEHAV of PGORF53 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF54 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF54 : entity is TRUE;

end PGORF54;

architecture BEHAV of PGORF54 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF55 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF55 : entity is TRUE;

end PGORF55;

architecture BEHAV of PGORF55 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF71 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF71 : entity is TRUE;

end PGORF71;

architecture BEHAV of PGORF71 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF72 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF72 : entity is TRUE;

end PGORF72;

architecture BEHAV of PGORF72 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF73 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF73 : entity is TRUE;

end PGORF73;

architecture BEHAV of PGORF73 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF74 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF74 : entity is TRUE;

end PGORF74;

architecture BEHAV of PGORF74 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF75 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF75 : entity is TRUE;

end PGORF75;

architecture BEHAV of PGORF75 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF76 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF76 : entity is TRUE;

end PGORF76;

architecture BEHAV of PGORF76 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORF77 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORF77 : entity is TRUE;

end PGORF77;

architecture BEHAV of PGORF77 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event,tpd_A3_Z0, TRUE),
			4 => (A4_ipd'last_event,tpd_A4_Z0, TRUE),
			5 => (A5_ipd'last_event,tpd_A5_Z0, TRUE),
			6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFB1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFB1 : entity is TRUE;

end PGORFB1;

architecture BEHAV of PGORFB1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFB2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFB2 : entity is TRUE;

end PGORFB2;

architecture BEHAV of PGORFB2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFB3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFB3 : entity is TRUE;

end PGORFB3;

architecture BEHAV of PGORFB3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFB4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFB4 : entity is TRUE;

end PGORFB4;

architecture BEHAV of PGORFB4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFBO1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFBO1 : entity is TRUE;

end PGORFBO1;

architecture BEHAV of PGORFBO1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFBO2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFBO2 : entity is TRUE;

end PGORFBO2;

architecture BEHAV of PGORFBO2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFBO3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFBO3 : entity is TRUE;

end PGORFBO3;

architecture BEHAV of PGORFBO3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORFBO4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORFBO4 : entity is TRUE;

end PGORFBO4;

architecture BEHAV of PGORFBO4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORG1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORG1 : entity is TRUE;

end PGORG1;

architecture BEHAV of PGORG1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORG2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORG2 : entity is TRUE;

end PGORG2;

architecture BEHAV of PGORG2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORG3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORG3 : entity is TRUE;

end PGORG3;

architecture BEHAV of PGORG3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGORG4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGORG4 : entity is TRUE;

end PGORG4;

architecture BEHAV of PGORG4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalOR(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event,tpd_A1_Z0, TRUE),
			2 => (A2_ipd'last_event,tpd_A2_Z0, TRUE),
			3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGXOR2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PGXOR2 : entity is TRUE;

end PGXOR2;

architecture BEHAV of PGXOR2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalXOR(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKBUFG1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKBUFG1 : entity is TRUE;

end PKBUFG1;

architecture BEHAV of PKBUFG1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKBUFG2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKBUFG2 : entity is TRUE;

end PKBUFG2;

architecture BEHAV of PKBUFG2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKBUFX0 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKBUFX0 : entity is TRUE;

end PKBUFX0;

architecture BEHAV of PKBUFX0 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKBUFX1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKBUFX1 : entity is TRUE;

end PKBUFX1;

architecture BEHAV of PKBUFX1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN0 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN0 : entity is TRUE;

end PKIN0;

architecture BEHAV of PKIN0 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN1 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN1 : entity is TRUE;

end PKIN1;

architecture BEHAV of PKIN1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN2 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN2 : entity is TRUE;

end PKIN2;

architecture BEHAV of PKIN2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN3 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN3 : entity is TRUE;

end PKIN3;

architecture BEHAV of PKIN3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN4 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN4 : entity is TRUE;

end PKIN4;

architecture BEHAV of PKIN4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN5 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN5 : entity is TRUE;

end PKIN5;

architecture BEHAV of PKIN5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN6 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN6 : entity is TRUE;

end PKIN6;

architecture BEHAV of PKIN6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PKIN7 is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PKIN7 : entity is TRUE;

end PKIN7;

architecture BEHAV of PKIN7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFB is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFB : entity is TRUE;

end PRBUFB;

architecture BEHAV of PRBUFB is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD1 : entity is TRUE;

end PRBUFD1;

architecture BEHAV of PRBUFD1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD2 : entity is TRUE;

end PRBUFD2;

architecture BEHAV of PRBUFD2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD3 : entity is TRUE;

end PRBUFD3;

architecture BEHAV of PRBUFD3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD4 : entity is TRUE;

end PRBUFD4;

architecture BEHAV of PRBUFD4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD5 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD5 : entity is TRUE;

end PRBUFD5;

architecture BEHAV of PRBUFD5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD6 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD6 : entity is TRUE;

end PRBUFD6;

architecture BEHAV of PRBUFD6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD7 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD7 : entity is TRUE;

end PRBUFD7;

architecture BEHAV of PRBUFD7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFD8 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFD8 : entity is TRUE;

end PRBUFD8;

architecture BEHAV of PRBUFD8 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE1 : entity is TRUE;

end PRBUFE1;

architecture BEHAV of PRBUFE1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE10 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE10 : entity is TRUE;

end PRBUFE10;

architecture BEHAV of PRBUFE10 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE11 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE11 : entity is TRUE;

end PRBUFE11;

architecture BEHAV of PRBUFE11 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE12 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE12 : entity is TRUE;

end PRBUFE12;

architecture BEHAV of PRBUFE12 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE13 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE13 : entity is TRUE;

end PRBUFE13;

architecture BEHAV of PRBUFE13 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE14 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE14 : entity is TRUE;

end PRBUFE14;

architecture BEHAV of PRBUFE14 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE15 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE15 : entity is TRUE;

end PRBUFE15;

architecture BEHAV of PRBUFE15 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE16 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE16 : entity is TRUE;

end PRBUFE16;

architecture BEHAV of PRBUFE16 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE17 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE17 : entity is TRUE;

end PRBUFE17;

architecture BEHAV of PRBUFE17 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE18 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE18 : entity is TRUE;

end PRBUFE18;

architecture BEHAV of PRBUFE18 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE19 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE19 : entity is TRUE;

end PRBUFE19;

architecture BEHAV of PRBUFE19 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE2 : entity is TRUE;

end PRBUFE2;

architecture BEHAV of PRBUFE2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE20 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE20 : entity is TRUE;

end PRBUFE20;

architecture BEHAV of PRBUFE20 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE21 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE21 : entity is TRUE;

end PRBUFE21;

architecture BEHAV of PRBUFE21 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE22 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE22 : entity is TRUE;

end PRBUFE22;

architecture BEHAV of PRBUFE22 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE23 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE23 : entity is TRUE;

end PRBUFE23;

architecture BEHAV of PRBUFE23 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE24 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE24 : entity is TRUE;

end PRBUFE24;

architecture BEHAV of PRBUFE24 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE25 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE25 : entity is TRUE;

end PRBUFE25;

architecture BEHAV of PRBUFE25 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE26 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE26 : entity is TRUE;

end PRBUFE26;

architecture BEHAV of PRBUFE26 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE27 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE27 : entity is TRUE;

end PRBUFE27;

architecture BEHAV of PRBUFE27 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE28 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE28 : entity is TRUE;

end PRBUFE28;

architecture BEHAV of PRBUFE28 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE29 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE29 : entity is TRUE;

end PRBUFE29;

architecture BEHAV of PRBUFE29 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE3 : entity is TRUE;

end PRBUFE3;

architecture BEHAV of PRBUFE3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE30 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE30 : entity is TRUE;

end PRBUFE30;

architecture BEHAV of PRBUFE30 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE31 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE31 : entity is TRUE;

end PRBUFE31;

architecture BEHAV of PRBUFE31 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE32 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE32 : entity is TRUE;

end PRBUFE32;

architecture BEHAV of PRBUFE32 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE4 : entity is TRUE;

end PRBUFE4;

architecture BEHAV of PRBUFE4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE5 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE5 : entity is TRUE;

end PRBUFE5;

architecture BEHAV of PRBUFE5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE6 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE6 : entity is TRUE;

end PRBUFE6;

architecture BEHAV of PRBUFE6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE7 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE7 : entity is TRUE;

end PRBUFE7;

architecture BEHAV of PRBUFE7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE8 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE8 : entity is TRUE;

end PRBUFE8;

architecture BEHAV of PRBUFE8 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFE9 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFE9 : entity is TRUE;

end PRBUFE9;

architecture BEHAV of PRBUFE9 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFG1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFG1 : entity is TRUE;

end PRBUFG1;

architecture BEHAV of PRBUFG1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFG2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFG2 : entity is TRUE;

end PRBUFG2;

architecture BEHAV of PRBUFG2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFG3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFG3 : entity is TRUE;

end PRBUFG3;

architecture BEHAV of PRBUFG3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFG4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFG4 : entity is TRUE;

end PRBUFG4;

architecture BEHAV of PRBUFG4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFGE is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFGE : entity is TRUE;

end PRBUFGE;

architecture BEHAV of PRBUFGE is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK1 : entity is TRUE;

end PRBUFK1;

architecture BEHAV of PRBUFK1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK10 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK10 : entity is TRUE;

end PRBUFK10;

architecture BEHAV of PRBUFK10 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK11 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK11 : entity is TRUE;

end PRBUFK11;

architecture BEHAV of PRBUFK11 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK12 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK12 : entity is TRUE;

end PRBUFK12;

architecture BEHAV of PRBUFK12 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK13 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK13 : entity is TRUE;

end PRBUFK13;

architecture BEHAV of PRBUFK13 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK14 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK14 : entity is TRUE;

end PRBUFK14;

architecture BEHAV of PRBUFK14 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK15 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK15 : entity is TRUE;

end PRBUFK15;

architecture BEHAV of PRBUFK15 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK16 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK16 : entity is TRUE;

end PRBUFK16;

architecture BEHAV of PRBUFK16 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK17 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK17 : entity is TRUE;

end PRBUFK17;

architecture BEHAV of PRBUFK17 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK18 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK18 : entity is TRUE;

end PRBUFK18;

architecture BEHAV of PRBUFK18 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK19 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK19 : entity is TRUE;

end PRBUFK19;

architecture BEHAV of PRBUFK19 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK2 : entity is TRUE;

end PRBUFK2;

architecture BEHAV of PRBUFK2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK20 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK20 : entity is TRUE;

end PRBUFK20;

architecture BEHAV of PRBUFK20 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK21 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK21 : entity is TRUE;

end PRBUFK21;

architecture BEHAV of PRBUFK21 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK22 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK22 : entity is TRUE;

end PRBUFK22;

architecture BEHAV of PRBUFK22 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK23 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK23 : entity is TRUE;

end PRBUFK23;

architecture BEHAV of PRBUFK23 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK24 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK24 : entity is TRUE;

end PRBUFK24;

architecture BEHAV of PRBUFK24 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK25 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK25 : entity is TRUE;

end PRBUFK25;

architecture BEHAV of PRBUFK25 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK26 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK26 : entity is TRUE;

end PRBUFK26;

architecture BEHAV of PRBUFK26 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK27 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK27 : entity is TRUE;

end PRBUFK27;

architecture BEHAV of PRBUFK27 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK28 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK28 : entity is TRUE;

end PRBUFK28;

architecture BEHAV of PRBUFK28 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK29 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK29 : entity is TRUE;

end PRBUFK29;

architecture BEHAV of PRBUFK29 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK3 : entity is TRUE;

end PRBUFK3;

architecture BEHAV of PRBUFK3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK30 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK30 : entity is TRUE;

end PRBUFK30;

architecture BEHAV of PRBUFK30 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK31 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK31 : entity is TRUE;

end PRBUFK31;

architecture BEHAV of PRBUFK31 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK32 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK32 : entity is TRUE;

end PRBUFK32;

architecture BEHAV of PRBUFK32 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK33 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK33 : entity is TRUE;

end PRBUFK33;

architecture BEHAV of PRBUFK33 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK34 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK34 : entity is TRUE;

end PRBUFK34;

architecture BEHAV of PRBUFK34 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK35 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK35 : entity is TRUE;

end PRBUFK35;

architecture BEHAV of PRBUFK35 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK36 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK36 : entity is TRUE;

end PRBUFK36;

architecture BEHAV of PRBUFK36 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK37 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK37 : entity is TRUE;

end PRBUFK37;

architecture BEHAV of PRBUFK37 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK38 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK38 : entity is TRUE;

end PRBUFK38;

architecture BEHAV of PRBUFK38 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK39 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK39 : entity is TRUE;

end PRBUFK39;

architecture BEHAV of PRBUFK39 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK4 : entity is TRUE;

end PRBUFK4;

architecture BEHAV of PRBUFK4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK40 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK40 : entity is TRUE;

end PRBUFK40;

architecture BEHAV of PRBUFK40 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK41 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK41 : entity is TRUE;

end PRBUFK41;

architecture BEHAV of PRBUFK41 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK42 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK42 : entity is TRUE;

end PRBUFK42;

architecture BEHAV of PRBUFK42 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK43 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK43 : entity is TRUE;

end PRBUFK43;

architecture BEHAV of PRBUFK43 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK44 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK44 : entity is TRUE;

end PRBUFK44;

architecture BEHAV of PRBUFK44 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK45 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK45 : entity is TRUE;

end PRBUFK45;

architecture BEHAV of PRBUFK45 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK46 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK46 : entity is TRUE;

end PRBUFK46;

architecture BEHAV of PRBUFK46 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK47 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK47 : entity is TRUE;

end PRBUFK47;

architecture BEHAV of PRBUFK47 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK48 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK48 : entity is TRUE;

end PRBUFK48;

architecture BEHAV of PRBUFK48 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK5 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK5 : entity is TRUE;

end PRBUFK5;

architecture BEHAV of PRBUFK5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK6 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK6 : entity is TRUE;

end PRBUFK6;

architecture BEHAV of PRBUFK6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK7 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK7 : entity is TRUE;

end PRBUFK7;

architecture BEHAV of PRBUFK7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK8 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK8 : entity is TRUE;

end PRBUFK8;

architecture BEHAV of PRBUFK8 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFK9 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFK9 : entity is TRUE;

end PRBUFK9;

architecture BEHAV of PRBUFK9 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL1 : entity is TRUE;

end PRBUFL1;

architecture BEHAV of PRBUFL1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL2 : entity is TRUE;

end PRBUFL2;

architecture BEHAV of PRBUFL2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL3 : entity is TRUE;

end PRBUFL3;

architecture BEHAV of PRBUFL3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL4 : entity is TRUE;

end PRBUFL4;

architecture BEHAV of PRBUFL4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL5 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL5 : entity is TRUE;

end PRBUFL5;

architecture BEHAV of PRBUFL5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL6 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL6 : entity is TRUE;

end PRBUFL6;

architecture BEHAV of PRBUFL6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL7 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL7 : entity is TRUE;

end PRBUFL7;

architecture BEHAV of PRBUFL7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFL8 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFL8 : entity is TRUE;

end PRBUFL8;

architecture BEHAV of PRBUFL8 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO1 : entity is TRUE;

end PRBUFO1;

architecture BEHAV of PRBUFO1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO10 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO10 : entity is TRUE;

end PRBUFO10;

architecture BEHAV of PRBUFO10 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO11 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO11 : entity is TRUE;

end PRBUFO11;

architecture BEHAV of PRBUFO11 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO12 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO12 : entity is TRUE;

end PRBUFO12;

architecture BEHAV of PRBUFO12 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO13 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO13 : entity is TRUE;

end PRBUFO13;

architecture BEHAV of PRBUFO13 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO14 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO14 : entity is TRUE;

end PRBUFO14;

architecture BEHAV of PRBUFO14 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO15 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO15 : entity is TRUE;

end PRBUFO15;

architecture BEHAV of PRBUFO15 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO16 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO16 : entity is TRUE;

end PRBUFO16;

architecture BEHAV of PRBUFO16 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO17 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO17 : entity is TRUE;

end PRBUFO17;

architecture BEHAV of PRBUFO17 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO18 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO18 : entity is TRUE;

end PRBUFO18;

architecture BEHAV of PRBUFO18 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO19 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO19 : entity is TRUE;

end PRBUFO19;

architecture BEHAV of PRBUFO19 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO2 : entity is TRUE;

end PRBUFO2;

architecture BEHAV of PRBUFO2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO20 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO20 : entity is TRUE;

end PRBUFO20;

architecture BEHAV of PRBUFO20 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO21 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO21 : entity is TRUE;

end PRBUFO21;

architecture BEHAV of PRBUFO21 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO22 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO22 : entity is TRUE;

end PRBUFO22;

architecture BEHAV of PRBUFO22 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO23 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO23 : entity is TRUE;

end PRBUFO23;

architecture BEHAV of PRBUFO23 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO24 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO24 : entity is TRUE;

end PRBUFO24;

architecture BEHAV of PRBUFO24 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO25 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO25 : entity is TRUE;

end PRBUFO25;

architecture BEHAV of PRBUFO25 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO26 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO26 : entity is TRUE;

end PRBUFO26;

architecture BEHAV of PRBUFO26 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO27 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO27 : entity is TRUE;

end PRBUFO27;

architecture BEHAV of PRBUFO27 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO28 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO28 : entity is TRUE;

end PRBUFO28;

architecture BEHAV of PRBUFO28 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO29 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO29 : entity is TRUE;

end PRBUFO29;

architecture BEHAV of PRBUFO29 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO3 : entity is TRUE;

end PRBUFO3;

architecture BEHAV of PRBUFO3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO30 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO30 : entity is TRUE;

end PRBUFO30;

architecture BEHAV of PRBUFO30 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO31 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO31 : entity is TRUE;

end PRBUFO31;

architecture BEHAV of PRBUFO31 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO32 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO32 : entity is TRUE;

end PRBUFO32;

architecture BEHAV of PRBUFO32 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO33 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO33 : entity is TRUE;

end PRBUFO33;

architecture BEHAV of PRBUFO33 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO34 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO34 : entity is TRUE;

end PRBUFO34;

architecture BEHAV of PRBUFO34 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO35 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO35 : entity is TRUE;

end PRBUFO35;

architecture BEHAV of PRBUFO35 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO36 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO36 : entity is TRUE;

end PRBUFO36;

architecture BEHAV of PRBUFO36 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO37 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO37 : entity is TRUE;

end PRBUFO37;

architecture BEHAV of PRBUFO37 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO38 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO38 : entity is TRUE;

end PRBUFO38;

architecture BEHAV of PRBUFO38 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO39 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO39 : entity is TRUE;

end PRBUFO39;

architecture BEHAV of PRBUFO39 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO4 : entity is TRUE;

end PRBUFO4;

architecture BEHAV of PRBUFO4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO40 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO40 : entity is TRUE;

end PRBUFO40;

architecture BEHAV of PRBUFO40 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO41 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO41 : entity is TRUE;

end PRBUFO41;

architecture BEHAV of PRBUFO41 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO42 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO42 : entity is TRUE;

end PRBUFO42;

architecture BEHAV of PRBUFO42 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO43 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO43 : entity is TRUE;

end PRBUFO43;

architecture BEHAV of PRBUFO43 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO44 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO44 : entity is TRUE;

end PRBUFO44;

architecture BEHAV of PRBUFO44 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO45 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO45 : entity is TRUE;

end PRBUFO45;

architecture BEHAV of PRBUFO45 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO46 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO46 : entity is TRUE;

end PRBUFO46;

architecture BEHAV of PRBUFO46 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO47 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO47 : entity is TRUE;

end PRBUFO47;

architecture BEHAV of PRBUFO47 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO48 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO48 : entity is TRUE;

end PRBUFO48;

architecture BEHAV of PRBUFO48 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO5 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO5 : entity is TRUE;

end PRBUFO5;

architecture BEHAV of PRBUFO5 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO6 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO6 : entity is TRUE;

end PRBUFO6;

architecture BEHAV of PRBUFO6 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO7 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO7 : entity is TRUE;

end PRBUFO7;

architecture BEHAV of PRBUFO7 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO8 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO8 : entity is TRUE;

end PRBUFO8;

architecture BEHAV of PRBUFO8 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFO9 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFO9 : entity is TRUE;

end PRBUFO9;

architecture BEHAV of PRBUFO9 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFQ is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFQ : entity is TRUE;

end PRBUFQ;

architecture BEHAV of PRBUFQ is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFT is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFT : entity is TRUE;

end PRBUFT;

architecture BEHAV of PRBUFT is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFX1 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFX1 : entity is TRUE;

end PRBUFX1;

architecture BEHAV of PRBUFX1 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFX2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFX2 : entity is TRUE;

end PRBUFX2;

architecture BEHAV of PRBUFX2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFX3 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFX3 : entity is TRUE;

end PRBUFX3;

architecture BEHAV of PRBUFX3 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PRBUFX4 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PRBUFX4 : entity is TRUE;

end PRBUFX4;

architecture BEHAV of PRBUFX4 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXAND2 is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXAND2 : entity is TRUE;

end PXAND2;

architecture BEHAV of PXAND2 is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd));

---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event,tpd_A0_Z0, TRUE),
			1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXBUFACO is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXBUFACO : entity is TRUE;

end PXBUFACO;

architecture BEHAV of PXBUFACO is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXBUFE is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXBUFE : entity is TRUE;

end PXBUFE;

architecture BEHAV of PXBUFE is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXBUFI is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXBUFI : entity is TRUE;

end PXBUFI;

architecture BEHAV of PXBUFI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXBUFK is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXBUFK : entity is TRUE;

end PXBUFK;

architecture BEHAV of PXBUFK is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXBUFO is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXBUFO : entity is TRUE;

end PXBUFO;

architecture BEHAV of PXBUFO is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXBUFQI is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXBUFQI : entity is TRUE;

end PXBUFQI;

architecture BEHAV of PXBUFQI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXBUFT is
	generic ( tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXBUFT : entity is TRUE;

end PXBUFT;

architecture BEHAV of PXBUFT is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PXDFF.				  --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity PXDFF is
	generic (tpd_CLK_Q0_posedge	 : VitalDelayType01 :=( 0 ps, 0 ps);-- LHCQ

			 tsetup_D0_CLK_noedge_posedge	: VitalDelayType := 15 ps; -- SUD(D0/D1)
			 thold_D0_CLK_noedge_posedge	: VitalDelayType := 0 ps; -- HOLD(D0/D1)

			 tpw_CLK_posedge		: VitalDelayType := 50 ps;
			 tpw_CLK_negedge		: VitalDelayType := 20 ps;
			
			 tipd_D0				: VitalDelayType01 := (0 ps, 0 ps);
			 tipd_CLK				: VitalDelayType01 := (0 ps, 0 ps);

			 InstancePath			: STRING := "*";
			 TimingChecksOn 			: Boolean 	:= TRUE);

	port (	D0, CLK : IN std_logic ;
		  	Q0 		: OUT std_logic);
	attribute VITAL_LEVEL0 of PXDFF : entity is TRUE;

end PXDFF;

---------------------------------------------
--		INPUT  WIRE DELAY 				----		
---------------------------------------------

architecture behav of PXDFF is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd   : STD_ULOGIC;
	 SIGNAL CLK_ipd  : STD_ULOGIC;


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0,tipd_D0);
		VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
	END BLOCK;

-----------------------------------------------
--		BEHAVIORAL DESCRIPTION				--	
--		contains TIMING CHECK,				--
--		FUNCTIONAL SECTION & PATH DELAYS	--
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, CLK_ipd)
	

	VARIABLE Timing_Viol_D0_CLK 	: std_ulogic := '0';
	VARIABLE Time_Data_D0_CLK 		: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Period_Viol_CLK		: std_ulogic := '0';
	VARIABLE Period_Info_CLK		: VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation 		: std_ulogic := '0';
	VARIABLE PrevData 		: Std_Logic_Vector(1 to 3);
	VARIABLE Results 		: Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd				: Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData 	: VitalGlitchDataType;

-- State Table for the D flip-flop--

--	-----------------------------------------------
--		Viol	D0		CLK		 IQ   	Q0 	---
--	-----------------------------------------------
	CONSTANT PXDFF_tab : VitalStateTableType := (
	(	'-',	'X',	'/',	 '-',	'X'		),
	(	'-',	'0',	'/',	 '-',	'0'		),
	(	'-',	'1',	'/',	 '-',	'1'		),
	(	'-',	'-',	'B',	 '-',	'S'		));
						

begin 

--	Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation			=> Timing_Viol_D0_CLK,
			TimingData			=> Time_Data_D0_CLK,
			TestSignal 			=> D0_ipd, 
			TestSignalName 		=> "D0",
			TestDelay			=> 0 ns,
			RefSignal 			=> CLK_ipd,
			RefSignalName		=> "CLK", 
			SetupHigh			=> tsetup_D0_CLK_noedge_posedge,
			SetupLow			=> tsetup_D0_CLK_noedge_posedge,
			HoldHigh			=> thold_D0_CLK_noedge_posedge,
			HoldLow				=> thold_D0_CLK_noedge_posedge,
		 	Checkenabled		=> TRUE,
			RefTransition		=> 'R',
			HeaderMsg			=> InstancePath & "/PXDFF",
		 	MsgOn				=> TRUE,
			XOn					=> TRUE,
			MsgSeverity			=> ERROR);


		VitalPeriodPulseCheck  (
			Violation			=> Period_Viol_CLK,
			PeriodData			=> Period_Info_CLK,
			TestSignal			=> CLK_ipd,
			TestSignalName		=> "CLK",
			TestDelay			=> 0 ns,
			Period				=> 0 ns,
			PulseWidthHigh		=> tpw_CLK_posedge, 
		  	PulseWidthLow		=> tpw_CLK_negedge,
			CheckEnabled		=> TRUE,
			HeaderMsg			=> InstancePath & "/PXDFF",
			XOn					=> TRUE,
			MsgOn				=> TRUE,
			MsgSeverity			=> ERROR);

	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_CLK or Period_Viol_CLK;


	VitalStateTable ( StateTable => PXDFF_tab,
					  DataIn	 => ( Violation, D0_ipd, CLK_ipd),
					  NumStates	 => 1, 
					  Result	 => Results,
					  PreviousDataIn => Prevdata );


--  Path Delay Section --

	VitalPathDelay01(
		OutSignal => Q0,
		OutSignalName => "Q0",
		OutTemp	=> Q0_zd,
		Paths =>(0 => (CLK_ipd'last_event,tpd_CLK_Q0_posedge, TRUE)),
		GlitchData => Q0_GlitchData,
		MsgOn => TRUE,
		XOn => TRUE,
		Mode => VitalTransport);

--					(CD_ipd = '0') AND (CLK_ipd = '1') AND (Q0_zd = '1'))),

--				1 => (CLK_ipd'last_event, tpd_CLK_Q0_posedge, TRUE )),
--					(CD_ipd = '0') AND (Q0_zd = '0') AND (CLK_ipd = '1'))),

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PXDFFR.				  --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity PXDFFR is
	generic(
		tpd_CLK_Q0_posedge	 	: VitalDelayType01 :=( 0 ps, 0 ps);-- LHCQ
		tpd_RNESET_Q0_negedge  	: VitalDelayType01 := (0 ps, 0 ps);-- HLRQ

		tsetup_D0_CLK_noedge_posedge	: VitalDelayType := 15 ps; -- SUD(D0/D1)
		thold_D0_CLK_noedge_posedge		: VitalDelayType := 0 ps; -- HOLD(D0/D1)

		trecovery_RNESET_CLK_posedge_posedge	: VitalDelayType := 0 ps; -- RECRC
		trecovery_CLK_RNESET_posedge_posedge 	: VitalDelayType := 0 ps; -- HOLDRC

		tpw_CLK_posedge		: VitalDelayType := 50 ps;
		tpw_CLK_negedge		: VitalDelayType := 20 ps;
			
		tipd_D0				: VitalDelayType01 := (0 ps, 0 ps);
		tipd_CLK				: VitalDelayType01 := (0 ps, 0 ps);
		tipd_RNESET			: VitalDelayType01 := (0 ps, 0 ps);

		InstancePath			: STRING := "*";
		TimingChecksOn 			: Boolean 	:= TRUE);

	port( D0, CLK, RNESET : IN std_logic ;
		  	Q0 			: OUT std_logic);
	attribute VITAL_LEVEL0 of PXDFFR : entity is TRUE;

end PXDFFR;

---------------------------------------------
--		INPUT  WIRE DELAY 				----		
---------------------------------------------

architecture behav of PXDFFR is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd   	: STD_ULOGIC;
	 SIGNAL CLK_ipd  	: STD_ULOGIC;
	 SIGNAL RNESET_ipd  : STD_ULOGIC; 


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0,tipd_D0);
		VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
		VitalWireDelay (RNESET_ipd, RNESET, tipd_RNESET);
	END BLOCK;

-----------------------------------------------
--		BEHAVIORAL DESCRIPTION				--	
--		contains TIMING CHECK,				--
--		FUNCTIONAL SECTION & PATH DELAYS	--
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, CLK_ipd, RNESET_ipd)
	

	VARIABLE Timing_Viol_D0_CLK 	: std_ulogic := '0';
	VARIABLE Time_Data_D0_CLK 		: VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Timing_Viol_RNESET_CLK	: std_ulogic := '0';
	VARIABLE Time_Data_RNESET_CLK	: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Period_Viol_CLK		: std_ulogic := '0';
	VARIABLE Period_Info_CLK		: VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation 		: std_ulogic := '0';
	VARIABLE PrevData 		: Std_Logic_Vector(1 to 4);
	VARIABLE Results 		: Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd				: Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData 	: VitalGlitchDataType;

-- State Table for the D flip-flop--

--  -------------------------------------------------------
--      Viol    D0      CLK          RNESET     IQ      Q0  ---
--  -------------------------------------------------------
	CONSTANT PXDFFR_tab : VitalStateTableType := (
	(   '-',    '-',    '-',        '0',    '-',    '0'     ),
	(   '-',    'X',    '/',        '1',    '-',    'X'     ),
	(   '-',    '0',    '/',        '1',    '-',    '0'     ),
	(   '-',    '1',    '/',        '1',    '-',    '1'     ),
	(   '-',    '-',    'B',        '1',    '-',    'S'     ));


begin 

--	Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation			=> Timing_Viol_D0_CLK,
			TimingData			=> Time_Data_D0_CLK,
			TestSignal 			=> D0_ipd, 
			TestSignalName 		=> "D0",
			TestDelay			=> 0 ns,
			RefSignal 			=> CLK_ipd,
			RefSignalName		=> "CLK", 
			SetupHigh			=> tsetup_D0_CLK_noedge_posedge,
			SetupLow			=> tsetup_D0_CLK_noedge_posedge,
			HoldHigh			=> thold_D0_CLK_noedge_posedge,
			HoldLow				=> thold_D0_CLK_noedge_posedge,
		 	Checkenabled		=> RNESET_ipd = '1',
			RefTransition		=> 'R',
			HeaderMsg			=> InstancePath & "/PXDFFR",
		 	MsgOn				=> TRUE,
			XOn					=> TRUE,
			MsgSeverity			=> ERROR);


		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_RNESET_CLK,
			TimingData          => Time_Data_RNESET_CLK,
			TestSignal          => RNESET_ipd,
			TestSignalName      => "RNESET",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay	        => 0 ns,
			Recovery           	=> trecovery_RNESET_CLK_posedge_posedge,
			Removal            	=> trecovery_CLK_RNESET_posedge_posedge,
			ActiveLow			=> TRUE,
			Checkenabled        => TRUE,
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PXDFFR",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);

		VitalPeriodPulseCheck(
			Violation			=> Period_Viol_CLK,
			PeriodData			=> Period_Info_CLK,
			TestSignal			=> CLK_ipd,
			TestSignalName		=> "CLK",
			TestDelay			=> 0 ns,
			Period				=> 0 ns,
			PulseWidthHigh		=> tpw_CLK_posedge, 
		  	PulseWidthLow		=> tpw_CLK_negedge,
			CheckEnabled		=> RNESET_ipd = '1',
			HeaderMsg			=> InstancePath & "/PXDFFR",
			XOn					=> TRUE,
			MsgOn				=> TRUE,
			MsgSeverity			=> ERROR);

	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_CLK or Timing_Viol_RNESET_CLK or  Period_Viol_CLK;

	VitalStateTable ( StateTable => PXDFFR_tab,
					  DataIn	 => ( Violation, D0_ipd, CLK_ipd, RNESET_ipd),
					  NumStates	 => 1, 
					  Result	 => Results,
					  PreviousDataIn => Prevdata );

-- PathDelay Section
-- CD (Clear) to Q0 path

	VitalPathDelay01(
		OutSignal => Q0,
		OutSignalName => "Q0",
		OutTemp	=> Q0_zd,
		Paths =>(0  => (CLK_ipd'last_event,tpd_CLK_Q0_posedge, TRUE),
--					(CD_ipd = '0') AND (CLK_ipd = '1') AND (Q0_zd = '1')),

				1 => (RNESET_ipd'last_event, tpd_RNESET_Q0_negedge, TRUE )),
--					(CD_ipd = '0') AND (Q0_zd = '0') AND (CLK_ipd = '1'))),

		GlitchData => Q0_GlitchData,
		MsgOn => TRUE,
		XOn => TRUE,
		Mode => VitalTransport);

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PXDL.				  --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Primitives.all;
use IEEE.VITAL_Timing.all;

entity PXDL is
	generic (tpd_G_Q0_posedge	 : VitalDelayType01 :=( 0 ps, 0 ps);-- LHCQ
			 tpd_D0_Q0			 : VitalDelayType01 := (0 ps, 0 ps);-- HLRQ

			 tsetup_D0_G_NOEDGE_posedge : VitalDelayType := 15 ps; -- SUD(D0/D1)
			 thold_D0_G_NOEDGE_posedge	: VitalDelayType  := 0 ps; -- HOLD(D0/D1)

			 tpw_G_posedge		: VitalDelayType := 50 ps;
			 tpw_G_negedge		: VitalDelayType := 20 ps;
			
			 tipd_D0			: VitalDelayType01 := (0 ps, 0 ps);
			 tipd_G				: VitalDelayType01 := (0 ps, 0 ps);

			 InstancePath			: STRING := "*";
			 TimingChecksOn 			: Boolean 	:= TRUE);

	port (	D0, G : IN std_logic ;
		  	Q0 			: OUT std_logic);
	attribute VITAL_LEVEL0 of PXDL : entity is TRUE;

end PXDL;

---------------------------------------------
--		INPUT  WIRE DELAY 				----		
---------------------------------------------

architecture behav of PXDL is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd   : STD_ULOGIC;
	 SIGNAL G_ipd  : STD_ULOGIC ;


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0, tipd_D0);
		VitalWireDelay (G_ipd, G, tipd_G);
	END BLOCK;

-----------------------------------------------
--		BEHAVIORAL DESCRIPTION				--	
--		contains TIMING CHECK,				--
--		FUNCTIONAL SECTION & PATH DELAYS	--
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, G_ipd)
	

	VARIABLE Timing_Viol_D0_G 	: std_ulogic := '0';
	VARIABLE Time_Data_D0_G 	: VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Period_Viol_G		: std_ulogic := '0';
	VARIABLE Period_Info_G		: VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation 		: std_ulogic := '0';
	VARIABLE PrevData 		: Std_Logic_Vector(1 to 3);
	VARIABLE Results 		: Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd				: Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData 	: VitalGlitchDataType;

-- State Table for the D-Latch--

--	-----------------------------------------------
--		Viol	D0		G	 IQ   	Q0 	---
--	-----------------------------------------------
	CONSTANT PXDL_tab : VitalStateTableType := (
	(	'-',	'X',	'1', '-',	'X'		),
	(	'-',	'0',	'1', '-',	'0'		),
	(	'-',	'1',	'1', '-',	'1'		),
	(	'-',	'-',	'0', '-',	'S'		));
						

begin 

--	Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation			=> Timing_Viol_D0_G,
			TimingData			=> Time_Data_D0_G,
			TestSignal			=> D0_ipd,
			TestSignalName		=> "D0",
			TestDelay			=> 0 ns,
			RefSignal			=> G_ipd,
			RefSignalName		=>  "G",
			RefDelay			=> 0 ns,
			SetupHigh			=> tsetup_D0_G_NOEDGE_posedge,
			SetupLow			=> tsetup_D0_G_NOEDGE_posedge,
			HoldHigh			=> thold_D0_G_NOEDGE_posedge,
			HoldLow				=> thold_D0_G_NOEDGE_posedge,
			Checkenabled		=> TRUE,
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PXDL",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);

		VitalPeriodPulseCheck (
			Violation			=> Period_Viol_G,
			PeriodData			=> Period_Info_G,
			TestSignal			=> G_ipd,
			TestSignalName		=> "G",
			TestDelay			=> 0 ps,
			Period				=> 0 ns,
			PulseWidthHigh		=> tpw_G_posedge, 
			PulseWidthLow		=> tpw_G_negedge, 
			Checkenabled		=> TRUE,
			HeaderMsg			=> InstancePath & "/PXDL",
			XOn					=> TRUE,
			MsgOn				=> TRUE,
			MsgSeverity			=> ERROR);

	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_G or Period_Viol_G;


	VitalStateTable ( StateTable => PXDL_tab,
					  DataIn	 => ( Violation, D0_ipd, G_ipd),
					  NumStates	 => 1, 
					  Result	 => Results,
					  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path

	VitalPathDelay01(
		OutSignal		=> Q0,
		OutSignalName	=> "Q0",
		OutTemp			=> Q0_zd,
		Paths =>(0  =>  (G_ipd'last_event, tpd_G_Q0_posedge,TRUE),
--							(G_ipd = '1') AND (Q0_zd = '0')),

				 1 => (D0_ipd'last_event, tpd_D0_Q0, TRUE)),
--						(D0_ipd = '1') AND (Q0_zd = '1') ),

		GlitchData => Q0_GlitchData,
		XOn 	=> TRUE,
		MsgOn	=> TRUE,
		Mode	=> VitalTransport);

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PXDLR.				  --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Primitives.all;
use IEEE.VITAL_Timing.all;

entity PXDLR is
	generic(
		tpd_G_Q0_posedge	 : VitalDelayType01 :=( 0 ps, 0 ps);-- LHCQ
		tpd_D0_Q0			 : VitalDelayType01 := (0 ps, 0 ps);-- HLRQ
		tpd_RNESET_Q0_negedge : VitalDelayType01 := (0 ps, 0 ps);

		tsetup_D0_G_NOEDGE_negedge 	: VitalDelayType := 15 ps; -- SUD(D0/D1)
		thold_D0_G_NOEDGE_negedge	: VitalDelayType  := 0 ps; -- HOLD(D0/D1)
			
		trecovery_G_RNESET_negedge_posedge :VitalDelayType := 0 ps;
		trecovery_RNESET_G_posedge_negedge :VitalDelayType := 0 ps;

		tpw_G_posedge		: VitalDelayType := 50 ps;
		tpw_G_negedge		: VitalDelayType := 20 ps;
			
		tipd_D0				: VitalDelayType01 := (0 ps, 0 ps);
		tipd_G				: VitalDelayType01 := (0 ps, 0 ps);
		tipd_RNESET        	: VitalDelayType01 := (0 ps, 0 ps);

		InstancePath			: STRING := "*";
		TimingChecksOn 			: Boolean 	:= TRUE);

	port (	D0, G, RNESET : IN std_logic ;
		  	Q0 			: OUT std_logic);
	attribute VITAL_LEVEL0 of PXDLR : entity is TRUE;

end PXDLR;

---------------------------------------------
--		INPUT  WIRE DELAY 				----		
---------------------------------------------

architecture behav of PXDLR is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd		: STD_ULOGIC;
	 SIGNAL G_ipd  		: STD_ULOGIC;
	 SIGNAL RNESET_ipd  : STD_ULOGIC;


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0, tipd_D0);
		VitalWireDelay (G_ipd, G, tipd_G);
		VitalWireDelay (RNESET_ipd, RNESET, tipd_RNESET);
	END BLOCK;

-----------------------------------------------
--		BEHAVIORAL DESCRIPTION				--	
--		contains TIMING CHECK,				--
--		FUNCTIONAL SECTION & PATH DELAYS	--
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, G_ipd, RNESET_ipd)
	

	VARIABLE Timing_Viol_D0_G 	: std_ulogic := '0';
	VARIABLE Time_Data_D0_G 	: VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Timing_Viol_RNESET_G 	: std_ulogic := '0';
	VARIABLE Time_Data_RNESEt_g 	: VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Period_Viol_G		: std_ulogic := '0';
	VARIABLE Period_Info_G		: VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation 		: std_ulogic := '0';
	VARIABLE PrevData 		: Std_Logic_Vector(1 to 4);
	VARIABLE Results 		: Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd				: Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData 	: VitalGlitchDataType;

-- State Table for the D-Latch--

--  ---------------------------------------------------
--      Viol    D0      G    RNESET     IQ      Q0  ---
--  ---------------------------------------------------
	CONSTANT PXDLR_tab : VitalStateTableType := (
	(   '-',    '-',    '-', '0',   '-',    '0'     ),
	(   '-',    'X',    '-', '1',   '-',    'X'     ),
	(   '-',    '0',    '1', '1',   '-',    '0'     ),
	(   '-',    '1',    '1', '1',   '-',    '1'     ),
	(   '-',    '-',    '0', '1',   '-',    'S'     ));

						

begin 

--	Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation			=> Timing_Viol_D0_G,
			TimingData			=> Time_Data_D0_G,
			TestSignal			=> D0_ipd,
			TestSignalName		=> "D0",
			TestDelay			=> 0 ns,
			RefSignal			=> G_ipd,
			RefSignalName		=>  "G",
			RefDelay			=> 0 ns,
			SetupHigh			=> tsetup_D0_G_NOEDGE_negedge,
			SetupLow			=> tsetup_D0_G_NOEDGE_negedge,
			HoldHigh			=> thold_D0_G_NOEDGE_negedge,
			HoldLow				=> thold_D0_G_NOEDGE_negedge,
			Checkenabled		=>  RNESET_ipd = '1',
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PXDLR",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);

		VitalRecoveryRemovalCheck(
			Violation			=> Timing_Viol_RNESET_G,
			TimingData			=> Time_Data_RNESET_G,
			TestSignal			=> RNESET_ipd,
			TestSignalName		=> "RNESET",
			TestDelay			=> 0 ns,
			RefSignal			=> G_ipd,
			RefSignalName		=> "G",
			RefDelay			=> 0 ns,
			Recovery			=> trecovery_G_RNESET_negedge_posedge,
			Removal				=> trecovery_RNESET_G_posedge_negedge,
			ActiveLow			=> TRUE,
			Checkenabled		=> TRUE,
			RefTransition		=> 'F',
			HeaderMsg			=> InstancePath & "/PXDLR",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);
			
		VitalPeriodPulseCheck (
			Violation			=> Period_Viol_G,
			PeriodData			=> Period_Info_G,
			TestSignal			=> G_ipd,
			TestSignalName		=> "G",
			TestDelay			=> 0 ps,
			Period				=> 0 ns,
			PulseWidthHigh		=> tpw_G_posedge, 
			PulseWidthLow		=> tpw_G_negedge, 
			Checkenabled		=> RNESET_ipd = '1',
			HeaderMsg			=> InstancePath & "/PXDLR",
			XOn					=> TRUE,
			MsgOn				=> TRUE,
			MsgSeverity			=> ERROR);

	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_G or Period_Viol_G;


	VitalStateTable ( StateTable => PXDLR_tab,
					  DataIn	 => ( Violation, D0_ipd, G_ipd, RNESET_ipd),
					  NumStates	 => 1, 
					  Result	 => Results,
					  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path

	VitalPathDelay01(
		OutSignal		=> Q0,
		OutSignalName	=> "Q0",
		OutTemp			=> Q0_zd,
		Paths =>(0  =>  (RNESET_ipd'last_event,tpd_RNESET_Q0_negedge, TRUE),
		
				 1	=>	(G_ipd'last_event, tpd_G_Q0_posedge,TRUE),
--							(G_ipd = '1') AND (Q0_zd = '0')),

				 2 => 	(D0_ipd'last_event, tpd_D0_Q0, TRUE)),
--						(D0_ipd = '1') AND (Q0_zd = '1') ),

		GlitchData => Q0_GlitchData,
		XOn 	=> TRUE,
		MsgOn	=> TRUE,
		Mode	=> VitalTransport);

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXIN is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXIN : entity is TRUE;

end PXIN;

architecture BEHAV of PXIN is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXIND is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXIND : entity is TRUE;

end PXIND;

architecture BEHAV of PXIND is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINE is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINE : entity is TRUE;

end PXINE;

architecture BEHAV of PXINE is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINK is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINK : entity is TRUE;

end PXINK;

architecture BEHAV of PXINK is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINR is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINR : entity is TRUE;

end PXINR;

architecture BEHAV of PXINR is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINRG is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINRG : entity is TRUE;

end PXINRG;

architecture BEHAV of PXINRG is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINRX is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINRX : entity is TRUE;

end PXINRX;

architecture BEHAV of PXINRX is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINT is
	generic ( tpd_XI0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_XI0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINT : entity is TRUE;

end PXINT;

architecture BEHAV of PXINT is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL XI0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (XI0_ipd, XI0, tipd_XI0);

END BLOCK;

	VitalBehavior : PROCESS(XI0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	Z0_zd := VitalBUF(XI0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths => (0 => (XI0_ipd'last_event, tpd_XI0_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINVE is
	generic ( tpd_A0_ZN0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINVE : entity is TRUE;

end PXINVE;

architecture BEHAV of PXINVE is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias ZN0_zd : std_logic is Results(1);
		variable ZN0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	ZN0_zd := VitalINV(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => ZN0,
	OutSignalName => "ZN0",
	OutTemp => ZN0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_ZN0, TRUE)),
	GlitchData => ZN0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINVK is
	generic ( tpd_A0_ZN0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINVK : entity is TRUE;

end PXINVK;

architecture BEHAV of PXINVK is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias ZN0_zd : std_logic is Results(1);
		variable ZN0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	ZN0_zd := VitalINV(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => ZN0,
	OutSignalName => "ZN0",
	OutTemp => ZN0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_ZN0, TRUE)),
	GlitchData => ZN0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXINVO is
	generic ( tpd_A0_ZN0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

 attribute VITAL_LEVEL0 of PXINVO : entity is TRUE;

end PXINVO;

architecture BEHAV of PXINVO is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias ZN0_zd : std_logic is Results(1);
		variable ZN0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	ZN0_zd := VitalINV(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => ZN0,
	OutSignalName => "ZN0",
	OutTemp => ZN0_zd,
	Paths => (0 => (A0_ipd'last_event, tpd_A0_ZN0, TRUE)),
	GlitchData => ZN0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXOUT is
	generic(tpd_A0_XO0	: VitalDelayType01 := (0 ns, 0 ns);
			tipd_A0		: VitalDelayType01 := (0 ns, 0 ns);
			TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 XO0 : OUT std_logic);

    attribute VITAL_LEVEL0 of PXOUT : entity is TRUE ;

end PXOUT;

architecture BEHAV of PXOUT is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin
	WIREDELAY : BLOCK
	BEGIN
        VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias XO0_zd : std_logic is Results(1);
		variable XO0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	XO0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => XO0,
	OutSignalName => "XO0",
	OutTemp => XO0_zd,
	Paths => ( 0 => (A0_ipd'last_event, tpd_A0_XO0, TRUE)),
	GlitchData => XO0_GlitchData,
	MsgOn   => TRUE,
	XOn     => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXOUTS is
	generic(tpd_A0_XO0	: VitalDelayType01 := (0 ns, 0 ns);
			tipd_A0		: VitalDelayType01 := (0 ns, 0 ns);
			TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 XO0 : OUT std_logic);

    attribute VITAL_LEVEL0 of PXOUTS : entity is TRUE ;

end PXOUTS;

architecture BEHAV of PXOUTS is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic;

begin
	WIREDELAY : BLOCK
	BEGIN
        VitalWireDelay (A0_ipd, A0, tipd_A0);

END BLOCK;

	VitalBehavior : PROCESS(A0_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias XO0_zd : std_logic is Results(1);
		variable XO0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	XO0_zd := VitalBUF(A0_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01(
	OutSignal => XO0,
	OutSignalName => "XO0",
	OutTemp => XO0_zd,
	Paths => ( 0 => (A0_ipd'last_event, tpd_A0_XO0, TRUE)),
	GlitchData => XO0_GlitchData,
	MsgOn   => TRUE,
	XOn     => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXTRI is
	generic(
		tpd_A0_XO0	:	VitalDelayType01 := (0 ns, 0 ns);
		tpd_OE_XO0 	:	VitalDelayType01Z := (0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
		tipd_A0		:	VitalDelayType01 := (0 ns, 0 ns);
		tipd_OE		:	VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 OE : IN std_logic;
		 XO0 : OUT std_logic);

	attribute VITAL_LEVEL0 of PXTRI : entity is TRUE;

end PXTRI;

architecture BEHAV of PXTRI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic ;
	SIGNAL OE_ipd : std_ulogic ;

begin
	WIREDELAY : BLOCK
	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (OE_ipd, OE, tipd_OE);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, OE_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias XO0_zd : std_logic is Results(1);
		variable XO0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	XO0_zd := VitalBUFIF1 (A0_ipd, OE_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01Z(
	OutSignal => XO0,
	OutSignalName => "XO0",
	OutTemp => XO0_zd,
	Paths	=>	(0 => (A0_ipd'last_event, VitalExtendtoFillDelay(tpd_A0_XO0), TRUE),
				 1 => (OE_ipd'last_event, tpd_OE_XO0, TRUE)),
	GlitchData => XO0_GlitchData,
	MsgOn	=> TRUE,
	XOn 	=> TRUE,
	Mode 	=> VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PXTRIS is
	generic(
		tpd_A0_XO0	:	VitalDelayType01 := (0 ns, 0 ns);
		tpd_OE_XO0 	:	VitalDelayType01Z := (0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
		tipd_A0		:	VitalDelayType01 := (0 ns, 0 ns);
		tipd_OE		:	VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
		 OE : IN std_logic;
		 XO0 : OUT std_logic);

	attribute VITAL_LEVEL0 of PXTRIS : entity is TRUE;

end PXTRIS;

architecture BEHAV of PXTRIS is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic ;
	SIGNAL OE_ipd : std_ulogic ;

begin
	WIREDELAY : BLOCK
	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (OE_ipd, OE, tipd_OE);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, OE_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias XO0_zd : std_logic is Results(1);
		variable XO0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--	 Functionality Section	--
---------------------------------------------

	XO0_zd := VitalBUFIF1 (A0_ipd, OE_ipd);
---------------------------------------------
----	Path Delay Section	--
---------------------------------------------

VitalPathDelay01Z(
	OutSignal => XO0,
	OutSignalName => "XO0",
	OutTemp => XO0_zd,
	Paths	=>	(0 => (A0_ipd'last_event,
					VitalExtendtoFillDelay(tpd_A0_XO0), TRUE),
				 1 => (OE_ipd'last_event, tpd_OE_XO0, TRUE)),
	GlitchData => XO0_GlitchData,
	MsgOn	=> TRUE,
	XOn 	=> TRUE,
	Mode 	=> VitalTransport);
end process;

end BEHAV;



-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND27 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND27 : entity is TRUE;

end PGAND27;

architecture BEHAV of PGAND27 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND28 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND28 : entity is TRUE;

end PGAND28;

architecture BEHAV of PGAND28 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND29 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND29 : entity is TRUE;

end PGAND29;

architecture BEHAV of PGAND29 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND30 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND30 : entity is TRUE;

end PGAND30;

architecture BEHAV of PGAND30 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND31 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND31 : entity is TRUE;

end PGAND31;

architecture BEHAV of PGAND31 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND32 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND32 : entity is TRUE;

end PGAND32;

architecture BEHAV of PGAND32 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND33 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND33 : entity is TRUE;

end PGAND33;

architecture BEHAV of PGAND33 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND34 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND34 : entity is TRUE;

end PGAND34;

architecture BEHAV of PGAND34 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND35 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND35 : entity is TRUE;

end PGAND35;

architecture BEHAV of PGAND35 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND36 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND36 : entity is TRUE;

end PGAND36;

architecture BEHAV of PGAND36 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND37 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND37 : entity is TRUE;

end PGAND37;

architecture BEHAV of PGAND37 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND38 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A37_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A37	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		A37	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND38 : entity is TRUE;

end PGAND38;

architecture BEHAV of PGAND38 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;
	SIGNAL A37_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
		VitalWireDelay (A37_ipd, A37, tipd_A37);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE),
		37 => (A37_ipd'last_event, tpd_A37_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND39 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A37_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A38_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A37	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A38	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		A37	: IN std_logic;
		A38	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND39 : entity is TRUE;

end PGAND39;

architecture BEHAV of PGAND39 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;
	SIGNAL A37_ipd : std_ulogic;
	SIGNAL A38_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
		VitalWireDelay (A37_ipd, A37, tipd_A37);
		VitalWireDelay (A38_ipd, A38, tipd_A38);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE),
		37 => (A37_ipd'last_event, tpd_A37_Z0, TRUE),
		38 => (A38_ipd'last_event, tpd_A38_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND40 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A37_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A38_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A39_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A37	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A38	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A39	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		A37	: IN std_logic;
		A38	: IN std_logic;
		A39	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND40 : entity is TRUE;

end PGAND40;

architecture BEHAV of PGAND40 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;
	SIGNAL A37_ipd : std_ulogic;
	SIGNAL A38_ipd : std_ulogic;
	SIGNAL A39_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
		VitalWireDelay (A37_ipd, A37, tipd_A37);
		VitalWireDelay (A38_ipd, A38, tipd_A38);
		VitalWireDelay (A39_ipd, A39, tipd_A39);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE),
		37 => (A37_ipd'last_event, tpd_A37_Z0, TRUE),
		38 => (A38_ipd'last_event, tpd_A38_Z0, TRUE),
		39 => (A39_ipd'last_event, tpd_A39_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND41 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A37_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A38_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A39_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A40_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A37	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A38	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A39	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A40	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		A37	: IN std_logic;
		A38	: IN std_logic;
		A39	: IN std_logic;
		A40	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND41 : entity is TRUE;

end PGAND41;

architecture BEHAV of PGAND41 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;
	SIGNAL A37_ipd : std_ulogic;
	SIGNAL A38_ipd : std_ulogic;
	SIGNAL A39_ipd : std_ulogic;
	SIGNAL A40_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
		VitalWireDelay (A37_ipd, A37, tipd_A37);
		VitalWireDelay (A38_ipd, A38, tipd_A38);
		VitalWireDelay (A39_ipd, A39, tipd_A39);
		VitalWireDelay (A40_ipd, A40, tipd_A40);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE),
		37 => (A37_ipd'last_event, tpd_A37_Z0, TRUE),
		38 => (A38_ipd'last_event, tpd_A38_Z0, TRUE),
		39 => (A39_ipd'last_event, tpd_A39_Z0, TRUE),
		40 => (A40_ipd'last_event, tpd_A40_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND42 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A37_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A38_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A39_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A40_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A41_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A37	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A38	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A39	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A40	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A41	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		A37	: IN std_logic;
		A38	: IN std_logic;
		A39	: IN std_logic;
		A40	: IN std_logic;
		A41	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND42 : entity is TRUE;

end PGAND42;

architecture BEHAV of PGAND42 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;
	SIGNAL A37_ipd : std_ulogic;
	SIGNAL A38_ipd : std_ulogic;
	SIGNAL A39_ipd : std_ulogic;
	SIGNAL A40_ipd : std_ulogic;
	SIGNAL A41_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
		VitalWireDelay (A37_ipd, A37, tipd_A37);
		VitalWireDelay (A38_ipd, A38, tipd_A38);
		VitalWireDelay (A39_ipd, A39, tipd_A39);
		VitalWireDelay (A40_ipd, A40, tipd_A40);
		VitalWireDelay (A41_ipd, A41, tipd_A41);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd, A41_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd, A41_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE),
		37 => (A37_ipd'last_event, tpd_A37_Z0, TRUE),
		38 => (A38_ipd'last_event, tpd_A38_Z0, TRUE),
		39 => (A39_ipd'last_event, tpd_A39_Z0, TRUE),
		40 => (A40_ipd'last_event, tpd_A40_Z0, TRUE),
		41 => (A41_ipd'last_event, tpd_A41_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND43 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A37_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A38_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A39_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A40_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A41_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A42_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A37	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A38	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A39	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A40	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A41	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A42	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		A37	: IN std_logic;
		A38	: IN std_logic;
		A39	: IN std_logic;
		A40	: IN std_logic;
		A41	: IN std_logic;
		A42	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND43 : entity is TRUE;

end PGAND43;

architecture BEHAV of PGAND43 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;
	SIGNAL A37_ipd : std_ulogic;
	SIGNAL A38_ipd : std_ulogic;
	SIGNAL A39_ipd : std_ulogic;
	SIGNAL A40_ipd : std_ulogic;
	SIGNAL A41_ipd : std_ulogic;
	SIGNAL A42_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
		VitalWireDelay (A37_ipd, A37, tipd_A37);
		VitalWireDelay (A38_ipd, A38, tipd_A38);
		VitalWireDelay (A39_ipd, A39, tipd_A39);
		VitalWireDelay (A40_ipd, A40, tipd_A40);
		VitalWireDelay (A41_ipd, A41, tipd_A41);
		VitalWireDelay (A42_ipd, A42, tipd_A42);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd, A41_ipd, A42_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd, A41_ipd, A42_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE),
		37 => (A37_ipd'last_event, tpd_A37_Z0, TRUE),
		38 => (A38_ipd'last_event, tpd_A38_Z0, TRUE),
		39 => (A39_ipd'last_event, tpd_A39_Z0, TRUE),
		40 => (A40_ipd'last_event, tpd_A40_Z0, TRUE),
		41 => (A41_ipd'last_event, tpd_A41_Z0, TRUE),
		42 => (A42_ipd'last_event, tpd_A42_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGAND44 is
	generic (
		tpd_A0_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A1_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A2_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A3_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A4_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A5_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A6_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A7_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A8_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A9_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A10_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A11_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A12_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A13_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A14_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A15_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A16_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A17_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A18_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A19_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A20_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A21_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A22_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A23_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A24_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A25_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A26_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A27_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A28_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A29_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A30_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A31_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A32_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A33_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A34_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A35_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A36_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A37_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A38_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A39_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A40_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A41_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A42_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tpd_A43_Z0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A0	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A1	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A2	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A3	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A4	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A5	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A6	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A7	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A8	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A9	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A10	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A11	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A12	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A13	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A14	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A15	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A16	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A17	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A18	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A19	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A20	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A21	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A22	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A23	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A24	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A25	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A26	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A27	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A28	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A29	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A30	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A31	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A32	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A33	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A34	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A35	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A36	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A37	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A38	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A39	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A40	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A41	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A42	: VitalDelayType01 := (0 ns, 0 ns);
		tipd_A43	: VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck	: Boolean := TRUE);
	port(
		A0	: IN std_logic;
		A1	: IN std_logic;
		A2	: IN std_logic;
		A3	: IN std_logic;
		A4	: IN std_logic;
		A5	: IN std_logic;
		A6	: IN std_logic;
		A7	: IN std_logic;
		A8	: IN std_logic;
		A9	: IN std_logic;
		A10	: IN std_logic;
		A11	: IN std_logic;
		A12	: IN std_logic;
		A13	: IN std_logic;
		A14	: IN std_logic;
		A15	: IN std_logic;
		A16	: IN std_logic;
		A17	: IN std_logic;
		A18	: IN std_logic;
		A19	: IN std_logic;
		A20	: IN std_logic;
		A21	: IN std_logic;
		A22	: IN std_logic;
		A23	: IN std_logic;
		A24	: IN std_logic;
		A25	: IN std_logic;
		A26	: IN std_logic;
		A27	: IN std_logic;
		A28	: IN std_logic;
		A29	: IN std_logic;
		A30	: IN std_logic;
		A31	: IN std_logic;
		A32	: IN std_logic;
		A33	: IN std_logic;
		A34	: IN std_logic;
		A35	: IN std_logic;
		A36	: IN std_logic;
		A37	: IN std_logic;
		A38	: IN std_logic;
		A39	: IN std_logic;
		A40	: IN std_logic;
		A41	: IN std_logic;
		A42	: IN std_logic;
		A43	: IN std_logic;
		Z0 : OUT std_logic);
attribute VITAL_LEVEL0 of PGAND44 : entity is TRUE;

end PGAND44;

architecture BEHAV of PGAND44 is
  attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE;
	SIGNAL A0_ipd : std_ulogic;
	SIGNAL A1_ipd : std_ulogic;
	SIGNAL A2_ipd : std_ulogic;
	SIGNAL A3_ipd : std_ulogic;
	SIGNAL A4_ipd : std_ulogic;
	SIGNAL A5_ipd : std_ulogic;
	SIGNAL A6_ipd : std_ulogic;
	SIGNAL A7_ipd : std_ulogic;
	SIGNAL A8_ipd : std_ulogic;
	SIGNAL A9_ipd : std_ulogic;
	SIGNAL A10_ipd : std_ulogic;
	SIGNAL A11_ipd : std_ulogic;
	SIGNAL A12_ipd : std_ulogic;
	SIGNAL A13_ipd : std_ulogic;
	SIGNAL A14_ipd : std_ulogic;
	SIGNAL A15_ipd : std_ulogic;
	SIGNAL A16_ipd : std_ulogic;
	SIGNAL A17_ipd : std_ulogic;
	SIGNAL A18_ipd : std_ulogic;
	SIGNAL A19_ipd : std_ulogic;
	SIGNAL A20_ipd : std_ulogic;
	SIGNAL A21_ipd : std_ulogic;
	SIGNAL A22_ipd : std_ulogic;
	SIGNAL A23_ipd : std_ulogic;
	SIGNAL A24_ipd : std_ulogic;
	SIGNAL A25_ipd : std_ulogic;
	SIGNAL A26_ipd : std_ulogic;
	SIGNAL A27_ipd : std_ulogic;
	SIGNAL A28_ipd : std_ulogic;
	SIGNAL A29_ipd : std_ulogic;
	SIGNAL A30_ipd : std_ulogic;
	SIGNAL A31_ipd : std_ulogic;
	SIGNAL A32_ipd : std_ulogic;
	SIGNAL A33_ipd : std_ulogic;
	SIGNAL A34_ipd : std_ulogic;
	SIGNAL A35_ipd : std_ulogic;
	SIGNAL A36_ipd : std_ulogic;
	SIGNAL A37_ipd : std_ulogic;
	SIGNAL A38_ipd : std_ulogic;
	SIGNAL A39_ipd : std_ulogic;
	SIGNAL A40_ipd : std_ulogic;
	SIGNAL A41_ipd : std_ulogic;
	SIGNAL A42_ipd : std_ulogic;
	SIGNAL A43_ipd : std_ulogic;

begin

	WIREDELAY : BLOCK

	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (A1_ipd, A1, tipd_A1);
		VitalWireDelay (A2_ipd, A2, tipd_A2);
		VitalWireDelay (A3_ipd, A3, tipd_A3);
		VitalWireDelay (A4_ipd, A4, tipd_A4);
		VitalWireDelay (A5_ipd, A5, tipd_A5);
		VitalWireDelay (A6_ipd, A6, tipd_A6);
		VitalWireDelay (A7_ipd, A7, tipd_A7);
		VitalWireDelay (A8_ipd, A8, tipd_A8);
		VitalWireDelay (A9_ipd, A9, tipd_A9);
		VitalWireDelay (A10_ipd, A10, tipd_A10);
		VitalWireDelay (A11_ipd, A11, tipd_A11);
		VitalWireDelay (A12_ipd, A12, tipd_A12);
		VitalWireDelay (A13_ipd, A13, tipd_A13);
		VitalWireDelay (A14_ipd, A14, tipd_A14);
		VitalWireDelay (A15_ipd, A15, tipd_A15);
		VitalWireDelay (A16_ipd, A16, tipd_A16);
		VitalWireDelay (A17_ipd, A17, tipd_A17);
		VitalWireDelay (A18_ipd, A18, tipd_A18);
		VitalWireDelay (A19_ipd, A19, tipd_A19);
		VitalWireDelay (A20_ipd, A20, tipd_A20);
		VitalWireDelay (A21_ipd, A21, tipd_A21);
		VitalWireDelay (A22_ipd, A22, tipd_A22);
		VitalWireDelay (A23_ipd, A23, tipd_A23);
		VitalWireDelay (A24_ipd, A24, tipd_A24);
		VitalWireDelay (A25_ipd, A25, tipd_A25);
		VitalWireDelay (A26_ipd, A26, tipd_A26);
		VitalWireDelay (A27_ipd, A27, tipd_A27);
		VitalWireDelay (A28_ipd, A28, tipd_A28);
		VitalWireDelay (A29_ipd, A29, tipd_A29);
		VitalWireDelay (A30_ipd, A30, tipd_A30);
		VitalWireDelay (A31_ipd, A31, tipd_A31);
		VitalWireDelay (A32_ipd, A32, tipd_A32);
		VitalWireDelay (A33_ipd, A33, tipd_A33);
		VitalWireDelay (A34_ipd, A34, tipd_A34);
		VitalWireDelay (A35_ipd, A35, tipd_A35);
		VitalWireDelay (A36_ipd, A36, tipd_A36);
		VitalWireDelay (A37_ipd, A37, tipd_A37);
		VitalWireDelay (A38_ipd, A38, tipd_A38);
		VitalWireDelay (A39_ipd, A39, tipd_A39);
		VitalWireDelay (A40_ipd, A40, tipd_A40);
		VitalWireDelay (A41_ipd, A41, tipd_A41);
		VitalWireDelay (A42_ipd, A42, tipd_A42);
		VitalWireDelay (A43_ipd, A43, tipd_A43);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd, A41_ipd, A42_ipd, A43_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias Z0_zd : std_logic is Results(1);
		variable Z0_GlitchData : VitalGlitchDataType;
BEGIN

------------------------------------------
--    Functionality Section             --
------------------------------------------

	Z0_zd := VitalAND(Data =>( A0_ipd, A1_ipd, A2_ipd, A3_ipd, A4_ipd, A5_ipd, A6_ipd, A7_ipd, A8_ipd, A9_ipd, A10_ipd, A11_ipd, A12_ipd, A13_ipd, A14_ipd, A15_ipd, A16_ipd, A17_ipd, A18_ipd, A19_ipd, A20_ipd, A21_ipd, A22_ipd, A23_ipd, A24_ipd, A25_ipd, A26_ipd, A27_ipd, A28_ipd, A29_ipd, A30_ipd, A31_ipd, A32_ipd, A33_ipd, A34_ipd, A35_ipd, A36_ipd, A37_ipd, A38_ipd, A39_ipd, A40_ipd, A41_ipd, A42_ipd, A43_ipd));

------------------------------------------
--    Path Delay Section                --
------------------------------------------

VitalPathDelay01 (
	OutSignal => Z0,
	OutSignalName => "Z0",
	OutTemp => Z0_zd,
	Paths =>(
		0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
		1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
		2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE),
		3 => (A3_ipd'last_event, tpd_A3_Z0, TRUE),
		4 => (A4_ipd'last_event, tpd_A4_Z0, TRUE),
		5 => (A5_ipd'last_event, tpd_A5_Z0, TRUE),
		6 => (A6_ipd'last_event, tpd_A6_Z0, TRUE),
		7 => (A7_ipd'last_event, tpd_A7_Z0, TRUE),
		8 => (A8_ipd'last_event, tpd_A8_Z0, TRUE),
		9 => (A9_ipd'last_event, tpd_A9_Z0, TRUE),
		10 => (A10_ipd'last_event, tpd_A10_Z0, TRUE),
		11 => (A11_ipd'last_event, tpd_A11_Z0, TRUE),
		12 => (A12_ipd'last_event, tpd_A12_Z0, TRUE),
		13 => (A13_ipd'last_event, tpd_A13_Z0, TRUE),
		14 => (A14_ipd'last_event, tpd_A14_Z0, TRUE),
		15 => (A15_ipd'last_event, tpd_A15_Z0, TRUE),
		16 => (A16_ipd'last_event, tpd_A16_Z0, TRUE),
		17 => (A17_ipd'last_event, tpd_A17_Z0, TRUE),
		18 => (A18_ipd'last_event, tpd_A18_Z0, TRUE),
		19 => (A19_ipd'last_event, tpd_A19_Z0, TRUE),
		20 => (A20_ipd'last_event, tpd_A20_Z0, TRUE),
		21 => (A21_ipd'last_event, tpd_A21_Z0, TRUE),
		22 => (A22_ipd'last_event, tpd_A22_Z0, TRUE),
		23 => (A23_ipd'last_event, tpd_A23_Z0, TRUE),
		24 => (A24_ipd'last_event, tpd_A24_Z0, TRUE),
		25 => (A25_ipd'last_event, tpd_A25_Z0, TRUE),
		26 => (A26_ipd'last_event, tpd_A26_Z0, TRUE),
		27 => (A27_ipd'last_event, tpd_A27_Z0, TRUE),
		28 => (A28_ipd'last_event, tpd_A28_Z0, TRUE),
		29 => (A29_ipd'last_event, tpd_A29_Z0, TRUE),
		30 => (A30_ipd'last_event, tpd_A30_Z0, TRUE),
		31 => (A31_ipd'last_event, tpd_A31_Z0, TRUE),
		32 => (A32_ipd'last_event, tpd_A32_Z0, TRUE),
		33 => (A33_ipd'last_event, tpd_A33_Z0, TRUE),
		34 => (A34_ipd'last_event, tpd_A34_Z0, TRUE),
		35 => (A35_ipd'last_event, tpd_A35_Z0, TRUE),
		36 => (A36_ipd'last_event, tpd_A36_Z0, TRUE),
		37 => (A37_ipd'last_event, tpd_A37_Z0, TRUE),
		38 => (A38_ipd'last_event, tpd_A38_Z0, TRUE),
		39 => (A39_ipd'last_event, tpd_A39_Z0, TRUE),
		40 => (A40_ipd'last_event, tpd_A40_Z0, TRUE),
		41 => (A41_ipd'last_event, tpd_A41_Z0, TRUE),
		42 => (A42_ipd'last_event, tpd_A42_Z0, TRUE),
		43 => (A43_ipd'last_event, tpd_A43_Z0, TRUE)),
	GlitchData => Z0_GlitchData,
	MsgOn => TRUE,
	XOn => TRUE,
	MsgSeverity => WARNING,
	Mode => VitalTransport);
end process;

end BEHAV;
-------------------------------------------
-------------------------------------------
-------------------------------------------


--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PGDFFRS.               --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity PGDFFRS is
	generic(
		tpd_CLK_Q0_posedge      : VitalDelayType01 := (0 ps, 0 ps);-- LHCQ & HLCQ
		tpd_CD_Q0_posedge       : VitalDelayType01 := (0 ps, 0 ps);-- HLRQ
		tpd_SD_Q0_posedge       : VitalDelayType01 := (0 ps, 0 ps);-- LHSQ 

		tsetup_D0_CLK_noedge_posedge          : VitalDelayType := 15 ps; -- SUD(D0/D1)
		thold_D0_CLK_noedge_posedge           : VitalDelayType := 0 ps;  -- HOLD(D0/D1)

		tsetup_EN_CLK_noedge_posedge         : VitalDelayType := 15 ps; -- SUEN
		thold_EN_CLK_noedge_posedge          : VitalDelayType := 0 ps;  -- HOLDEN

		trecovery_CD_CLK_negedge_posedge    : VitalDelayType := 0 ps; -- RECRC
		trecovery_CLK_CD_posedge_negedge    : VitalDelayType := 0 ps; -- HOLDRC

		trecovery_SD_CLK_negedge_posedge    : VitalDelayType := 0 ps; -- RECSC
		trecovery_CLK_SD_posedge_negedge    : VitalDelayType := 0 ps; -- HOLDSC

		tpw_CLK_posedge                 : VitalDelayType := 50 ps;
		tpw_CLK_negedge                 : VitalDelayType := 20 ps;

		tpw_CD_posedge                  : VitalDelayType := 0 ps; -- PULSER
		tpw_SD_posedge                  : VitalDelayType := 0 ps; -- PULSES
			
		tipd_D0                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_CLK                        : VitalDelayType01 := (0 ps, 0 ps);
		tipd_CD                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_EN                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_SD                         : VitalDelayType01 := (0 ps, 0 ps);

		InstancePath                    : STRING := "*";
		TimingChecksOn                  : Boolean := TRUE);

	port( D0, CLK, EN, CD, SD : IN std_logic ;
	      Q0                  : OUT std_logic);
	
	attribute VITAL_LEVEL0 of PGDFFRS        : entity is TRUE;

end PGDFFRS;

---------------------------------------------
--              INPUT  WIRE DELAY        ----            
---------------------------------------------

architecture behav of PGDFFRS is
	 attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd            : STD_ULOGIC;
	 SIGNAL CLK_ipd           : STD_ULOGIC;
	 SIGNAL EN_ipd            : STD_ULOGIC;
	 SIGNAL CD_ipd            : STD_ULOGIC; 
	 SIGNAL SD_ipd            : STD_ULOGIC;


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0,tipd_D0);
		VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
		VitalWireDelay (EN_ipd, EN, tipd_EN);
		VitalWireDelay (CD_ipd, CD, tipd_CD);
		VitalWireDelay (SD_ipd, SD, tipd_SD);
	END BLOCK;

-----------------------------------------------
--        BEHAVIORAL DESCRIPTION             --
--        contains TIMING CHECK,             --
--        FUNCTIONAL SECTION & PATH DELAYS   --
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, CLK_ipd, EN_ipd, CD_ipd, SD_ipd)
	

	VARIABLE Timing_Viol_D0_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_D0_CLK             : VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_EN_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_EN_CLK             : VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_CD_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_CD_CLK             : VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_SD_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_SD_CLK             : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Period_Viol_CLK              : std_ulogic := '0';
	VARIABLE Period_Info_CLK              : VitalPeriodDataType := VitalPeriodDataInit ;
	VARIABLE Period_Viol_CD               : std_ulogic := '0';
	VARIABLE Period_Info_CD               : VitalPeriodDataType := VitalPeriodDataInit ;
	VARIABLE Period_Viol_SD               : std_ulogic := '0';
	VARIABLE Period_Info_SD               : VitalPeriodDataType := VitalPeriodDataInit ;
	
	VARIABLE Violation                    : std_ulogic := '0';
	VARIABLE PrevData                     : Std_Logic_Vector(1 to 6);
	VARIABLE Results                      : Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd                           : Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData              : VitalGlitchDataType;

-- State Table for the D flip-flop--
--  ---------------------------------------------------------------------------------------
--         Viol      D0      CLK     EN      CD      SD      IQ      Q0    ---
--  ---------------------------------------------------------------------------------------
	CONSTANT PGDFFRS_tab : VitalStateTableType := (
	(   '-',    '-',    '-',    '-',    '1',    '-',    '-',    '0'     ),   
	(   '-',    '-',    '-',    '-',    '0',    '1',    '-',    '1'     ),
	(   '-',    '-',    '-',    '0',    '0',    '0',    '-',    'S'     ),
	(   '-',    '-',    '-',    'X',    '0',    '0',    '-',    'S'     ),
	(   '-',    '-',    '-',    'Z',    '0',    '0',    '-',    'S'     ),
	(   '-',    'X',    '/',    '1',    '0',    '0',    '-',    'X'     ),
	(   '-',    '0',    '/',    '1',    '0',    '0',    '-',    '0'     ),
	(   '-',    '1',    '/',    '1',    '0',    '0',    '-',    '1'     ),
	(   '-',    '-',    'B',    '1',    '0',    '0',    '-',    'S'     ));


begin 

--      Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation               => Timing_Viol_D0_CLK,
			TimingData              => Time_Data_D0_CLK,
			TestSignal              => D0_ipd, 
			TestSignalName          => "D0",
			TestDelay               => 0 ns,
			RefSignal               => CLK_ipd,
			RefSignalName           => "CLK", 
			SetupHigh               => tsetup_D0_CLK_noedge_posedge,
			SetupLow                => tsetup_D0_CLK_noedge_posedge,
			HoldHigh                => thold_D0_CLK_noedge_posedge,
			HoldLow                 => thold_D0_CLK_noedge_posedge,
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			RefTransition           => 'R',
			HeaderMsg               => InstancePath & "/PGDFFR",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalSetupHoldCheck(
			Violation               => Timing_Viol_EN_CLK,
			TimingData              => Time_Data_EN_CLK,
			TestSignal              => EN_ipd, 
			TestSignalName          => "EN",
			TestDelay               => 0 ns,
			RefSignal               => CLK_ipd,
			RefSignalName           => "CLK", 
			SetupHigh               => tsetup_EN_CLK_noedge_posedge,
			SetupLow                => tsetup_EN_CLK_noedge_posedge,
			HoldHigh                => thold_EN_CLK_noedge_posedge,
			HoldLow                 => thold_EN_CLK_noedge_posedge,
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			RefTransition           => 'R',
			HeaderMsg               => InstancePath & "/PGDFFRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);


		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_CD_CLK,
			TimingData          => Time_Data_CD_CLK,
			TestSignal          => CD_ipd,
			TestSignalName      => "CD",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay            => 0 ns,
			Recovery            => trecovery_CD_CLK_negedge_posedge,
			Removal             => trecovery_CLK_CD_posedge_negedge,
			ActiveLow           => FALSE,
			Checkenabled        => TRUE,
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PGDFFRS",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);

		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_SD_CLK,
			TimingData          => Time_Data_SD_CLK,
			TestSignal          => SD_ipd,
			TestSignalName      => "SD",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay            => 0 ns,
			Recovery            => trecovery_SD_CLK_negedge_posedge,
			Removal             => trecovery_CLK_SD_posedge_negedge,
			ActiveLow           => FALSE,
			Checkenabled        => CD_ipd = '0',
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PGDFFRS",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);


		VitalPeriodPulseCheck  (
			Violation               => Period_Viol_CLK,
			PeriodData              => Period_Info_CLK,
			TestSignal              => CLK_ipd,
			TestSignalName          => "CLK",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_CLK_posedge, 
			PulseWidthLow           => tpw_CLK_negedge,
			CheckEnabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			HeaderMsg               => InstancePath & "/PGDFFRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);

		VitalPeriodPulseCheck  (
			Violation               => Period_Viol_CD,
			PeriodData              => Period_Info_CD,
			TestSignal              => CD_ipd,
			TestSignalName          => "CD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_CD_posedge, 
			PulseWidthLow           => 0 ns,
			CheckEnabled            => TRUE,
			HeaderMsg               => InstancePath & "/PGDFFRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	
		VitalPeriodPulseCheck  (
			Violation               => Period_Viol_SD,
			PeriodData              => Period_Info_SD,
			TestSignal              => SD_ipd,
			TestSignalName          => "SD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_SD_posedge, 
			PulseWidthLow           => 0 ns,
			CheckEnabled            => CD_ipd = '0',
			HeaderMsg               => InstancePath & "/PGDFFRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	
	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_CLK or Timing_Viol_CD_CLK 
		       or Timing_Viol_SD_CLK or Period_Viol_CLK 
		       or Period_Viol_CD or Period_Viol_SD;


	VitalStateTable ( StateTable => PGDFFRS_tab,
			  DataIn     => ( Violation, D0_ipd, CLK_ipd, EN_ipd,CD_ipd, SD_ipd),
			  NumStates  => 1, 
			  Result     => Results,
			  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path
-- SD (Set)   to Q0 path
	VitalPathDelay01(
		OutSignal     => Q0,
		OutSignalName => "Q0",
		OutTemp   => Q0_zd,
		Paths     => ( 0 => (CD_ipd'last_event, tpd_CD_Q0_posedge,TRUE),
			       --   (CD_ipd = '1') ),
			       1 => (SD_ipd'last_event, tpd_SD_Q0_posedge,TRUE),
			       --   (SD_ipd = '1') ),
			       2 => (CLK_ipd'last_event,tpd_CLK_Q0_posedge, TRUE)),
			       --   (CD_ipd = '0') AND (CLK_ipd = '1') AND (Q0_zd = '1')),
		GlitchData => Q0_GlitchData,
		MsgOn => TRUE,
		XOn => TRUE,
		Mode => VitalTransport);

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PGDLRS.                            --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Primitives.all;
use IEEE.VITAL_Timing.all;

entity PGDLRS is
	generic(
		tpd_G_Q0_posedge               : VitalDelayType01 := (0 ps, 0 ps);-- LHCQ
		tpd_D0_Q0                        : VitalDelayType01 := (0 ps, 0 ps);-- HLDQ
		tpd_CD_Q0_posedge                : VitalDelayType01 := (0 ps, 0 ps);-- HLRQ
		tpd_SD_Q0_posedge                : VitalDelayType01 := (0 ps, 0 ps);-- PLHSQ
			
		tsetup_D0_G_noedge_negedge      : VitalDelayType := 15 ps; -- SUD(D0/D1)
		thold_D0_G_noedge_negedge       : VitalDelayType  := 0 ps; -- HOLD(D0/D1)
		
		trecovery_G_CD_negedge_negedge     :VitalDelayType := 0 ps;
		trecovery_CD_G_negedge_negedge     :VitalDelayType := 0 ps;

		trecovery_G_SD_negedge_negedge     :VitalDelayType := 0 ps;
		trecovery_SD_G_negedge_negedge     :VitalDelayType := 0 ps;

		tpw_G_posedge                   : VitalDelayType := 50 ps;
		tpw_G_negedge                   : VitalDelayType := 20 ps;

		tpw_CD_posedge                  : VitalDelayType := 0 ps;
		tpw_SD_posedge                  : VitalDelayType := 0 ps;
			
		tipd_D0                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_G                          : VitalDelayType01 := (0 ps, 0 ps);
		tipd_CD                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_SD                         : VitalDelayType01 := (0 ps, 0 ps);

		InstancePath                    : STRING := "*";
		TimingChecksOn                  : Boolean := TRUE);

	port (  D0, G, CD, SD  : IN std_logic ;
		Q0             : OUT std_logic);
	attribute VITAL_LEVEL0 of PGDLRS : entity is TRUE;

end PGDLRS;

---------------------------------------------
--              INPUT  WIRE DELAY        ----            
---------------------------------------------

architecture behav of PGDLRS is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	SIGNAL D0_ipd           : STD_ULOGIC;
	SIGNAL G_ipd            : STD_ULOGIC;
	SIGNAL CD_ipd           : STD_ULOGIC;
	SIGNAL SD_ipd           : STD_ULOGIC;


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0, tipd_D0);
		VitalWireDelay (G_ipd, G, tipd_G);
		VitalWireDelay (CD_ipd, CD, tipd_CD);
		VitalWireDelay (SD_ipd, SD, tipd_SD);
	END BLOCK;

-----------------------------------------------
--       BEHAVIORAL DESCRIPTION              --      
--       contains TIMING CHECK,              --
--       FUNCTIONAL SECTION & PATH DELAYS    --
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, G_ipd, CD_ipd, SD_ipd)
	

	VARIABLE Timing_Viol_D0_G       : std_ulogic := '0';
	VARIABLE Time_Data_D0_G         : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Timing_Viol_CD_G       : std_ulogic := '0';
	VARIABLE Time_Data_CD_G         : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Timing_Viol_SD_G       : std_ulogic := '0';
	VARIABLE Time_Data_SD_G         : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Period_Viol_G          : std_ulogic := '0';
	VARIABLE Period_Info_G          : VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Period_Viol_CD         : std_ulogic := '0';
	VARIABLE Period_Info_CD         : VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Period_Viol_SD         : std_ulogic := '0';
	VARIABLE Period_Info_SD         : VitalPeriodDataType := VitalPeriodDataInit ;
	
	VARIABLE Violation              : std_ulogic := '0';
	VARIABLE PrevData               : Std_Logic_Vector(1 to 5);
	VARIABLE Results                : Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd                     : Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData  : VitalGlitchDataType;

-- State Table for the D-Latch--

--  ----------------------------------------------------------------------
--          Viol    D0       G     CD     SD    IQ      Q0             ---
--  ----------------------------------------------------------------------
	CONSTANT PGDLRS_tab : VitalStateTableType := (
	(   '-',    '-',    '-',  '1',   '-',  '-',     '0'  ),
	(   '-',    '-',    '-',  '0',   '1',  '-',     '1'  ),
	(   '-',    'X',    '1',  '0',   '0',  '-',     'X'  ),
	(   '-',    '0',    '1',  '0',   '0',  '-',     '0'  ),
	(   '-',    '1',    '1',  '0',   '0',  '-',     '1'  ),
	(   '-',    '-',    '0',  '0',   '0',  '-',     'S'  ));
						

begin 

--      Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation               => Timing_Viol_D0_G,
			TimingData              => Time_Data_D0_G,
			TestSignal              => D0_ipd,
			TestSignalName          => "D0",
			TestDelay               => 0 ns,
			RefSignal               => G_ipd,
			RefSignalName           =>  "G",
			RefDelay                => 0 ns,
			SetupHigh               => tsetup_D0_G_NOEDGE_negedge,
			SetupLow                => tsetup_D0_G_NOEDGE_negedge,
			HoldHigh                => thold_D0_G_NOEDGE_negedge,
			HoldLow                 => thold_D0_G_NOEDGE_negedge,
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			RefTransition           => 'R',
			HeaderMsg               => InstancePath & "/PGDLRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalRecoveryRemovalCheck(
			Violation               => Timing_Viol_CD_G,
			TimingData              => Time_Data_CD_G,
			TestSignal              => CD_ipd,
			TestSignalName          => "CD",
			TestDelay               => 0 ns,
			RefSignal               => G_ipd,
			RefSignalName           => "G",
			RefDelay                => 0 ns,
			Recovery                => trecovery_G_CD_negedge_negedge,
			Removal                 => trecovery_CD_G_negedge_negedge,
			ActiveLow               => TRUE,
			Checkenabled            => TRUE,
			RefTransition           => 'F',
			HeaderMsg               => InstancePath & "/PGDLRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalRecoveryRemovalCheck(
			Violation               => Timing_Viol_SD_G,
			TimingData              => Time_Data_SD_G,
			TestSignal              => SD_ipd,
			TestSignalName          => "SD",
			TestDelay               => 0 ns,
			RefSignal               => G_ipd,
			RefSignalName           => "G",
			RefDelay                => 0 ns,
			Recovery                => trecovery_G_SD_negedge_negedge,
			Removal                 => trecovery_SD_G_negedge_negedge,
			ActiveLow               => TRUE,
			Checkenabled            => CD_ipd = '0',
			RefTransition           => 'F',
			HeaderMsg               => InstancePath & "/PGDLRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalPeriodPulseCheck (
			Violation               => Period_Viol_G,
			PeriodData              => Period_Info_G,
			TestSignal              => G_ipd,
			TestSignalName          => "G",
			TestDelay               => 0 ps,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_G_posedge, 
			PulseWidthLow           => tpw_G_negedge, 
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			HeaderMsg               => InstancePath & "/PGDLRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);

		VitalPeriodPulseCheck (
			Violation               => Period_Viol_CD,
			PeriodData              => Period_Info_CD,
			TestSignal              => CD_ipd,
			TestSignalName          => "CD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_CD_posedge, 
			PulseWidthLow           => 0 ns, 
			Checkenabled            => TRUE,
			HeaderMsg               => InstancePath & "/PGDLRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	
		VitalPeriodPulseCheck (
			Violation               => Period_Viol_SD,
			PeriodData              => Period_Info_SD,
			TestSignal              => SD_ipd,
			TestSignalName          => "SD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_SD_posedge, 
			PulseWidthLow           => 0 ns, 
			Checkenabled            => CD_ipd = '0',
			HeaderMsg               => InstancePath & "/PGDLRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_G or Period_Viol_G
		     or Period_Viol_CD or Period_Viol_SD;


	VitalStateTable ( StateTable => PGDLRS_tab,
			  DataIn     => ( Violation, D0_ipd, G_ipd, CD_ipd, SD_ipd),
			  NumStates  => 1, 
			  Result     => Results,
			  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path
-- SD (Set)   to Q0 path

	VitalPathDelay01(
		OutSignal       => Q0,
		OutSignalName   => "Q0",
		OutTemp         => Q0_zd,
		Paths =>(    
				 0  =>  (CD_ipd'last_event, tpd_CD_Q0_posedge, TRUE),

				 1  =>  (SD_ipd'last_event, tpd_SD_Q0_posedge, TRUE),

				 2  =>  (G_ipd'last_event, tpd_G_Q0_posedge,TRUE),
				--      (G_ipd = '1') AND (Q0_zd = '0')),

				 3  =>  (D0_ipd'last_event, tpd_D0_Q0, TRUE)),
				--      (D0_ipd = '1') AND (Q0_zd = '1') ),

		GlitchData => Q0_GlitchData,
		XOn     => TRUE,
		MsgOn   => TRUE,
		Mode    => VitalTransport);

END PROCESS;
	  
end behav;
-----------------------------------
-----------------------------------
-----------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;


entity PGTRI is
	generic(
		tpd_A0_XO0       :       VitalDelayType01 := (0 ns, 0 ns);
		tpd_OE_XO0       :       VitalDelayType01Z := (0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
		tipd_A0         :       VitalDelayType01 := (0 ns, 0 ns);
		tipd_OE         :       VitalDelayType01 := (0 ns, 0 ns);
		TimingCheck : Boolean := TRUE);

	port(A0 : IN std_logic;
	     OE : IN std_logic;
	     XO0 : OUT std_logic);

	attribute VITAL_LEVEL0 of PGTRI : entity is TRUE;

end PGTRI;

architecture BEHAV of PGTRI is
 attribute VITAL_LEVEL1 of BEHAV : architecture is TRUE ;
	SIGNAL A0_ipd : std_ulogic ;
	SIGNAL OE_ipd : std_ulogic ;

begin
	WIREDELAY : BLOCK
	BEGIN
		VitalWireDelay (A0_ipd, A0, tipd_A0);
		VitalWireDelay (OE_ipd, OE, tipd_OE);
END BLOCK;

	VitalBehavior : PROCESS(A0_ipd, OE_ipd)
		variable Results : std_logic_vector (1 to 1) := (OTHERS => 'X');
		alias XO0_zd : std_logic is Results(1);
		variable XO0_GlitchData : VitalGlitchDataType;

	BEGIN
---------------------------------------------
--       Functionality Section  --
---------------------------------------------

	XO0_zd := VitalBUFIF1 (A0_ipd, OE_ipd);
---------------------------------------------
----    Path Delay Section      --
---------------------------------------------

VitalPathDelay01Z(
	OutSignal => XO0,
	OutSignalName => "XO0",
	OutTemp => XO0_zd,
	Paths   =>      (0 => (A0_ipd'last_event, VitalExtendtoFillDelay(tpd_A0_XO0), TRUE),
			 1 => (OE_ipd'last_event, tpd_OE_XO0, TRUE)),
	GlitchData => XO0_GlitchData,
	MsgOn   => TRUE,
	XOn     => TRUE,
	Mode    => VitalTransport);
end process;

end BEHAV;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PXDFFRS.               --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity PXDFFRS is
	generic(
		tpd_CLK_Q0_posedge      : VitalDelayType01 := (0 ps, 0 ps);-- LHCQ & HLCQ
		tpd_CD_Q0_posedge       : VitalDelayType01 := (0 ps, 0 ps);-- HLRQ
		tpd_SD_Q0_posedge       : VitalDelayType01 := (0 ps, 0 ps);-- LHSQ 

		tsetup_D0_CLK_noedge_posedge          : VitalDelayType := 15 ps; -- SUD(D0/D1)
		thold_D0_CLK_noedge_posedge           : VitalDelayType := 0 ps;  -- HOLD(D0/D1)

		tsetup_EN_CLK_noedge_posedge         : VitalDelayType := 15 ps; -- SUEN
		thold_EN_CLK_noedge_posedge          : VitalDelayType := 0 ps;  -- HOLDEN

		trecovery_CD_CLK_negedge_posedge    : VitalDelayType := 0 ps; -- RECRC
		trecovery_CLK_CD_posedge_negedge    : VitalDelayType := 0 ps; -- HOLDRC

		trecovery_SD_CLK_negedge_posedge    : VitalDelayType := 0 ps; -- RECSC
		trecovery_CLK_SD_posedge_negedge    : VitalDelayType := 0 ps; -- HOLDSC

		tpw_CLK_posedge                 : VitalDelayType := 50 ps;
		tpw_CLK_negedge                 : VitalDelayType := 20 ps;

		tpw_CD_posedge                  : VitalDelayType := 0 ps;
		tpw_SD_posedge                  : VitalDelayType := 0 ps;
			
		tipd_D0                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_CLK                        : VitalDelayType01 := (0 ps, 0 ps);
		tipd_CD                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_EN                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_SD                         : VitalDelayType01 := (0 ps, 0 ps);

		InstancePath                    : STRING := "*";
		TimingChecksOn                  : Boolean := TRUE);

	port( D0, CLK, EN, CD, SD : IN std_logic ;
	      Q0                  : OUT std_logic);
	attribute VITAL_LEVEL0 of PXDFFRS        : entity is TRUE;

end PXDFFRS;

---------------------------------------------
--              INPUT  WIRE DELAY                               ----            
---------------------------------------------

architecture behav of PXDFFRS is
	 attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	 SIGNAL D0_ipd            : STD_ULOGIC;
	 SIGNAL CLK_ipd           : STD_ULOGIC;
	 SIGNAL EN_ipd            : STD_ULOGIC;
	 SIGNAL CD_ipd            : STD_ULOGIC; 
	 SIGNAL SD_ipd            : STD_ULOGIC;


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0,tipd_D0);
		VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
		VitalWireDelay (EN_ipd, EN, tipd_EN);
		VitalWireDelay (CD_ipd, CD, tipd_CD);
		VitalWireDelay (SD_ipd, SD, tipd_SD);
	END BLOCK;

-----------------------------------------------
--        BEHAVIORAL DESCRIPTION             --
--        contains TIMING CHECK,             --
--        FUNCTIONAL SECTION & PATH DELAYS   --
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, CLK_ipd, EN_ipd, CD_ipd, SD_ipd)
	

	VARIABLE Timing_Viol_D0_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_D0_CLK             : VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_EN_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_EN_CLK             : VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_CD_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_CD_CLK             : VitalTimingDataType := VitalTimingDataInit;
	VARIABLE Timing_Viol_SD_CLK           : std_ulogic := '0';
	VARIABLE Time_Data_SD_CLK             : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Period_Viol_CLK                : std_ulogic := '0';
	VARIABLE Period_Info_CLK                : VitalPeriodDataType := VitalPeriodDataInit ;
	VARIABLE Period_Viol_CD                 : std_ulogic := '0';
	VARIABLE Period_Info_CD                 : VitalPeriodDataType := VitalPeriodDataInit ;
	VARIABLE Period_Viol_SD                 : std_ulogic := '0';
	VARIABLE Period_Info_SD                 : VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation                    : std_ulogic := '0';
	VARIABLE PrevData                     : Std_Logic_Vector(1 to 6);
	VARIABLE Results                      : Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd                           : Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData              : VitalGlitchDataType;

-- State Table for the D flip-flop--
--  ---------------------------------------------------------------------------------------
--         Viol      D0      CLK     EN      CD      SD      IQ      Q0                 ---
--  ---------------------------------------------------------------------------------------
	CONSTANT PXDFFRS_tab : VitalStateTableType := (
	(   '-',    '-',    '-',    '-',    '1',    '-',    '-',    '0'     ),   
	(   '-',    '-',    '-',    '-',    '0',    '1',    '-',    '1'     ),
	(   '-',    '-',    '-',    '0',    '0',    '0',    '-',    'S'     ),
	(   '-',    '-',    '-',    'X',    '0',    '0',    '-',    'S'     ),
	(   '-',    '-',    '-',    'Z',    '0',    '0',    '-',    'S'     ),
	(   '-',    'X',    '/',    '1',    '0',    '0',    '-',    'X'     ),
	(   '-',    '0',    '/',    '1',    '0',    '0',    '-',    '0'     ),
	(   '-',    '1',    '/',    '1',    '0',    '0',    '-',    '1'     ),
	(   '-',    '-',    'B',    '1',    '0',    '0',    '-',    'S'     ));


begin 

--      Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation               => Timing_Viol_D0_CLK,
			TimingData              => Time_Data_D0_CLK,
			TestSignal              => D0_ipd, 
			TestSignalName          => "D0",
			TestDelay               => 0 ns,
			RefSignal               => CLK_ipd,
			RefSignalName           => "CLK", 
			SetupHigh               => tsetup_D0_CLK_noedge_posedge,
			SetupLow                => tsetup_D0_CLK_noedge_posedge,
			HoldHigh                => thold_D0_CLK_noedge_posedge,
			HoldLow                 => thold_D0_CLK_noedge_posedge,
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			RefTransition           => 'R',
			HeaderMsg               => InstancePath & "/PXDFFRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalSetupHoldCheck(
			Violation               => Timing_Viol_EN_CLK,
			TimingData              => Time_Data_EN_CLK,
			TestSignal              => EN_ipd, 
			TestSignalName          => "EN",
			TestDelay               => 0 ns,
			RefSignal               => CLK_ipd,
			RefSignalName           => "CLK", 
			SetupHigh               => tsetup_EN_CLK_noedge_posedge,
			SetupLow                => tsetup_EN_CLK_noedge_posedge,
			HoldHigh                => thold_EN_CLK_noedge_posedge,
			HoldLow                 => thold_EN_CLK_noedge_posedge,
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			RefTransition           => 'R',
			HeaderMsg               => InstancePath & "/PXDFFRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);


		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_CD_CLK,
			TimingData          => Time_Data_CD_CLK,
			TestSignal          => CD_ipd,
			TestSignalName      => "CD",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay            => 0 ns,
			Recovery            => trecovery_CD_CLK_negedge_posedge,
			Removal             => trecovery_CLK_CD_posedge_negedge,
			ActiveLow           => FALSE,
			Checkenabled        => TRUE,
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PXDFFRS",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);

		VitalRecoveryRemovalCheck(
			Violation           => Timing_Viol_SD_CLK,
			TimingData          => Time_Data_SD_CLK,
			TestSignal          => SD_ipd,
			TestSignalName      => "SD",
			TestDelay           => 0 ns,
			RefSignal           => CLK_ipd,
			RefSignalName       => "CLK",
			RefDelay            => 0 ns,
			Recovery            => trecovery_SD_CLK_negedge_posedge,
			Removal             => trecovery_CLK_SD_posedge_negedge,
			ActiveLow           => FALSE,
			Checkenabled        => (CD_ipd = '0'),
			RefTransition       => 'R',
			HeaderMsg           => InstancePath & "/PXDFFRS",
			MsgOn               => TRUE,
			XOn                 => TRUE,
			MsgSeverity         => ERROR);


		VitalPeriodPulseCheck  (
			Violation               => Period_Viol_CLK,
			PeriodData              => Period_Info_CLK,
			TestSignal              => CLK_ipd,
			TestSignalName          => "CLK",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_CLK_posedge, 
			PulseWidthLow           => tpw_CLK_negedge,
			CheckEnabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			HeaderMsg               => InstancePath & "/PXDFFRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);

		VitalPeriodPulseCheck  (
			Violation               => Period_Viol_CD,
			PeriodData              => Period_Info_CD,
			TestSignal              => CD_ipd,
			TestSignalName          => "CD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_CD_posedge, 
			PulseWidthLow           => 0 ns,
			CheckEnabled            => TRUE,
			HeaderMsg               => InstancePath & "/PXDFFRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	
		VitalPeriodPulseCheck  (
			Violation               => Period_Viol_SD,
			PeriodData              => Period_Info_SD,
			TestSignal              => SD_ipd,
			TestSignalName          => "SD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_SD_posedge, 
			PulseWidthLow           => 0 ns,
			CheckEnabled            => (CD_ipd = '0'),
			HeaderMsg               => InstancePath & "/PXDFFRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	
	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_CLK or Timing_Viol_CD_CLK 
		     or Timing_Viol_SD_CLK or Period_Viol_CLK
		     or Period_Viol_CD or Period_Viol_SD;


	VitalStateTable ( StateTable => PXDFFRS_tab,
			  DataIn     => ( Violation, D0_ipd, CLK_ipd, EN_ipd, CD_ipd, SD_ipd),
			  NumStates  => 1, 
			  Result     => Results,
			  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path
-- SD (Set)   to Q0 path
	VitalPathDelay01(
		OutSignal     => Q0,
		OutSignalName => "Q0",
		OutTemp   => Q0_zd,
		Paths     => ( 0 => (CD_ipd'last_event, tpd_CD_Q0_posedge,TRUE),
			    --      (CD_ipd = '1') ),
			       1 => (SD_ipd'last_event, tpd_SD_Q0_posedge,TRUE),
			    --      (SD_ipd = '1') ),
			       2 => (CLK_ipd'last_event,tpd_CLK_Q0_posedge, TRUE)),
			    --      (CD_ipd = '0') AND (CLK_ipd = '1') AND (Q0_zd = '1')),
		GlitchData => Q0_GlitchData,
		MsgOn => TRUE,
		XOn => TRUE,
		Mode => VitalTransport);

END PROCESS;

end behav;
-----------------------------------
-----------------------------------
-----------------------------------
--------------------------------------------------------
-- THIS FILE CONTAINS THE VITAL COMPLIANT (LEVEL 1)   --
-- PRIMITIVE BEHAVIOR MODEL OF PXDLRS.                --
--------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Primitives.all;
use IEEE.VITAL_Timing.all;

entity PXDLRS is
	generic(
		tpd_G_Q0_posedge                 : VitalDelayType01 := (0 ps, 0 ps);-- LHCQ
		tpd_D0_Q0                        : VitalDelayType01 := (0 ps, 0 ps);-- HLDQ
		tpd_CD_Q0_posedge                : VitalDelayType01 := (0 ps, 0 ps);-- HLRQ
		tpd_SD_Q0_posedge                : VitalDelayType01 := (0 ps, 0 ps);-- LHSQ
			
		tsetup_D0_G_NOEDGE_negedge      : VitalDelayType := 15 ps; -- SUD(D0/D1)
		thold_D0_G_NOEDGE_negedge       : VitalDelayType  := 0 ps; -- HOLD(D0/D1)
		
		trecovery_G_CD_negedge_negedge     :VitalDelayType := 0 ps;
		trecovery_CD_G_negedge_negedge     :VitalDelayType := 0 ps;

		trecovery_G_SD_negedge_negedge     :VitalDelayType := 0 ps;
		trecovery_SD_G_negedge_negedge     :VitalDelayType := 0 ps;

		tpw_G_posedge                   : VitalDelayType := 50 ps;
		tpw_G_negedge                   : VitalDelayType := 20 ps;
		tpw_CD_posedge                  : VitalDelayType := 0 ps;
		tpw_SD_posedge                  : VitalDelayType := 0 ps;
			
		tipd_D0                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_G                          : VitalDelayType01 := (0 ps, 0 ps);
		tipd_CD                         : VitalDelayType01 := (0 ps, 0 ps);
		tipd_SD                         : VitalDelayType01 := (0 ps, 0 ps);

		InstancePath                    : STRING := "*";
		TimingChecksOn                  : Boolean := TRUE);

	port (  D0, G, CD, SD  : IN std_logic ;
		Q0             : OUT std_logic);
	attribute VITAL_LEVEL0 of PXDLRS : entity is TRUE;

end PXDLRS;

---------------------------------------------
--          INPUT  WIRE DELAY            ----               
---------------------------------------------

architecture behav of PXDLRS is
	attribute VITAL_LEVEL1 of behav : architecture is TRUE;
	SIGNAL D0_ipd           : STD_ULOGIC;
	SIGNAL G_ipd            : STD_ULOGIC;
	SIGNAL CD_ipd           : STD_ULOGIC;
	SIGNAL SD_ipd           : STD_ULOGIC;


begin
	WIREDELAY : BLOCK
	BEGIN 
		VitalWireDelay (D0_ipd, D0, tipd_D0);
		VitalWireDelay (G_ipd, G, tipd_G);
		VitalWireDelay (CD_ipd, CD, tipd_CD);
		VitalWireDelay (SD_ipd, SD, tipd_SD);
	END BLOCK;

-----------------------------------------------
--              BEHAVIORAL DESCRIPTION           --     
--              contains TIMING CHECK,             --
--              FUNCTIONAL SECTION & PATH DELAYS --
-----------------------------------------------

VitalBehavior : PROCESS ( D0_ipd, G_ipd, CD_ipd, SD_ipd)
	

	VARIABLE Timing_Viol_D0_G       : std_ulogic := '0';
	VARIABLE Time_Data_D0_G         : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Timing_Viol_CD_G       : std_ulogic := '0';
	VARIABLE Time_Data_CD_G         : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Timing_Viol_SD_G     : std_ulogic := '0';
	VARIABLE Time_Data_SD_G       : VitalTimingDataType := VitalTimingDataInit;

	VARIABLE Period_Viol_G          : std_ulogic := '0';
	VARIABLE Period_Info_G          : VitalPeriodDataType := VitalPeriodDataInit ;
	VARIABLE Period_Viol_CD         : std_ulogic := '0';
	VARIABLE Period_Info_CD         : VitalPeriodDataType := VitalPeriodDataInit ;
	VARIABLE Period_Viol_SD         : std_ulogic := '0';
	VARIABLE Period_Info_SD         : VitalPeriodDataType := VitalPeriodDataInit ;

	VARIABLE Violation              : std_ulogic := '0';
	VARIABLE PrevData               : Std_Logic_Vector(1 to 5);
	VARIABLE Results                : Std_Logic_Vector(1 to 1) := (OTHERS => 'X');
	ALIAS Q0_zd                     : Std_Logic IS Results(1);

	VARIABLE Q0_GlitchData  : VitalGlitchDataType;

-- State Table for the D-Latch--

--  ----------------------------------------------------------------------
--          Viol    D0       G     CD     SD    IQ      Q0             ---
--  ----------------------------------------------------------------------
	CONSTANT PXDLRS_tab : VitalStateTableType := (
	(   '-',    '-',    '-',  '1',   '-',  '-',     '0'  ),
	(   '-',    '-',    '-',  '0',   '1',  '-',     '1'  ),
	(   '-',    'X',    '1',  '0',   '0',  '-',     'X'  ),
	(   '-',    '0',    '1',  '0',   '0',  '-',     '0'  ),
	(   '-',    '1',    '1',  '0',   '0',  '-',     '1'  ),
	(   '-',    '-',    '0',  '0',   '0',  '-',     'S'  ));
						

begin 

--      Timing Check Section --
	
	IF TimingChecksOn THEN
		
		VitalSetupHoldCheck(
			Violation               => Timing_Viol_D0_G,
			TimingData              => Time_Data_D0_G,
			TestSignal              => D0_ipd,
			TestSignalName          => "D0",
			TestDelay               => 0 ns,
			RefSignal               => G_ipd,
			RefSignalName           =>  "G",
			RefDelay                => 0 ns,
			SetupHigh               => tsetup_D0_G_noedge_negedge,
			SetupLow                => tsetup_D0_G_noedge_negedge,
			HoldHigh                => thold_D0_G_noedge_negedge,
			HoldLow                 => thold_D0_G_noedge_negedge,
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			RefTransition           => 'R',
			HeaderMsg               => InstancePath & "/PXDLRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalRecoveryRemovalCheck(
			Violation               => Timing_Viol_CD_G,
			TimingData              => Time_Data_CD_G,
			TestSignal              => CD_ipd,
			TestSignalName          => "CD",
			TestDelay               => 0 ns,
			RefSignal               => G_ipd,
			RefSignalName           => "G",
			RefDelay                => 0 ns,
			Recovery                => trecovery_G_CD_negedge_negedge,
			Removal                 => trecovery_CD_G_negedge_negedge,
			ActiveLow               => TRUE,
			Checkenabled            => TRUE,
			RefTransition           => 'F',
			HeaderMsg               => InstancePath & "/PXDLRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalRecoveryRemovalCheck(
			Violation               => Timing_Viol_SD_G,
			TimingData              => Time_Data_SD_G,
			TestSignal              => SD_ipd,
			TestSignalName          => "SD",
			TestDelay               => 0 ns,
			RefSignal               => G_ipd,
			RefSignalName           => "G",
			RefDelay                => 0 ns,
			Recovery                => trecovery_G_SD_negedge_negedge,
			Removal                 => trecovery_SD_G_negedge_negedge,
			ActiveLow               => TRUE,
			Checkenabled            => (CD_ipd = '0'),
			RefTransition           => 'F',
			HeaderMsg               => InstancePath & "/PXDLRS",
			MsgOn                   => TRUE,
			XOn                     => TRUE,
			MsgSeverity             => ERROR);

		VitalPeriodPulseCheck (
			Violation               => Period_Viol_G,
			PeriodData              => Period_Info_G,
			TestSignal              => G_ipd,
			TestSignalName          => "G",
			TestDelay               => 0 ps,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_G_posedge, 
			PulseWidthLow           => tpw_G_negedge, 
			Checkenabled            => (CD_ipd = '0') AND (SD_ipd = '0'),
			HeaderMsg               => InstancePath & "/PXDLRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);

		VitalPeriodPulseCheck (
			Violation               => Period_Viol_CD,
			PeriodData              => Period_Info_CD,
			TestSignal              => CD_ipd,
			TestSignalName          => "CD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_CD_posedge, 
			PulseWidthLow           => 0 ns, 
			Checkenabled            => TRUE,
			HeaderMsg               => InstancePath & "/PXDLRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	
		VitalPeriodPulseCheck (
			Violation               => Period_Viol_SD,
			PeriodData              => Period_Info_SD,
			TestSignal              => SD_ipd,
			TestSignalName          => "SD",
			TestDelay               => 0 ns,
			Period                  => 0 ns,
			PulseWidthHigh          => tpw_SD_posedge, 
			PulseWidthLow           => 0 ns, 
			Checkenabled            => (CD_ipd = '0'),
			HeaderMsg               => InstancePath & "/PXDLRS",
			XOn                     => TRUE,
			MsgOn                   => TRUE,
			MsgSeverity             => ERROR);
	
	END IF;

--  Functionality Section --

	Violation := Timing_Viol_D0_G or Period_Viol_G
		     or Period_Viol_CD or Period_Viol_SD;


	VitalStateTable ( StateTable => PXDLRS_tab,
			  DataIn     => ( Violation, D0_ipd, G_ipd, CD_ipd, SD_ipd),
			  NumStates  => 1, 
			  Result     => Results,
			  PreviousDataIn => Prevdata );


--  Path Delay Section --

-- CD (Clear) to Q0 path
-- SD (Set)   to Q0 path

	VitalPathDelay01(
		OutSignal       => Q0,
		OutSignalName   => "Q0",
		OutTemp         => Q0_zd,
		Paths           => ( 0  =>  (CD_ipd'last_event, tpd_CD_Q0_posedge, TRUE),
				     1  =>  (SD_ipd'last_event, tpd_SD_Q0_posedge, TRUE),
				     2  =>  (G_ipd'last_event, tpd_G_Q0_posedge,TRUE),
				--      (G_ipd = '1') AND (Q0_zd = '0')),
				     3  =>  (D0_ipd'last_event, tpd_D0_Q0, TRUE)),
				--      (D0_ipd = '1') AND (Q0_zd = '1') ),
		GlitchData => Q0_GlitchData,
		XOn     => TRUE,
		MsgOn   => TRUE,
		Mode    => VitalTransport);

END PROCESS;
	  
end behav;
------------------------------------------
------------------------------------------
------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.VITAL_Timing.ALL;
USE IEEE.VITAL_Primitives.ALL;

PACKAGE VIT_PKG IS

component PGAND1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND2
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND3
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND4
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND5
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND6
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND7
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND8
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND9
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND10
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND11
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND12
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND13
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND14
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND15
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND16
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND17
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND18
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND19
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND20
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND21
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND22
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND23
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND24
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND25
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGAND26
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 A25 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD2
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD3
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD4
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD5
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD6
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD7
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD8
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD9
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD10
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD11
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD12
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD13
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD14
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD15
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD16
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD17
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD18
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD19
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD20
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD21
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD22
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD23
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD24
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD25
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGANDD26
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 A7 : IN std_logic;
		 A8 : IN std_logic;
		 A9 : IN std_logic;
		 A10 : IN std_logic;
		 A11 : IN std_logic;
		 A12 : IN std_logic;
		 A13 : IN std_logic;
		 A14 : IN std_logic;
		 A15 : IN std_logic;
		 A16 : IN std_logic;
		 A17 : IN std_logic;
		 A18 : IN std_logic;
		 A19 : IN std_logic;
		 A20 : IN std_logic;
		 A21 : IN std_logic;
		 A22 : IN std_logic;
		 A23 : IN std_logic;
		 A24 : IN std_logic;
		 A25 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF71
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF72
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF73
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF74
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF75
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF76
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF77
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 A5 : IN std_logic;
		 A6 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF41
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF42
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF43
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF44
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF51
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF52
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF53
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF54
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORF55
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 A4 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFB1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFB2
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFB3
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFB4
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFBO1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFBO2
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFBO3
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORFBO4
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORG1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORG2
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORG3
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGORG4
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 A2 : IN std_logic;
		 A3 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXAND2
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGXOR2
	port(A0 : IN std_logic;
		 A1 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFE
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFF
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFI
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFK
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFKI
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFR
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFXA
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFXI
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGBUFXO
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXBUFACO
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXBUFE
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXBUFI
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXBUFK
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXBUFO
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXBUFQI
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXBUFT
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKBUFG1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKBUFG2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKBUFX0
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKBUFX1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFB
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD3
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD4
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD5
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD6
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD7
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFD8
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE3
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE4
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE5
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE6
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE7
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE8
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE9
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE10
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE11
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE12
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE13
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE14
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE15
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE16
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE17
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE18
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE19
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE20
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE21
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE22
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE23
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE24
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE25
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE26
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE27
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE28
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE29
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE30
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE31
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFE32
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFG1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFG2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFG3
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFG4
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFGE
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK3
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK4
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK5
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK6
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK7
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK8
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK9
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK10
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK11
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK12
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK13
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK14
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK15
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK16
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK17
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK18
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK19
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK20
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK21
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK22
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK23
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK24
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK25
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK26
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK27
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK28
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK29
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK30
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK31
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK32
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK33
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK34
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK35
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK36
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK37
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK38
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK39
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK40
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK41
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK42
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK43
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK44
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK45
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK46
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK47
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFK48
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL3
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL4
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL5
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL6
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL7
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFL8
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO3
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO4
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO5
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO6
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO7
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO8
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO9
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO10
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO11
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO12
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO13
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO14
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO15
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO16
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO17
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO18
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO19
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO20
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO21
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO22
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO23
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO24
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO25
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO26
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO27
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO28
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO29
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO30
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO31
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO32
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO33
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO34
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO35
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO36
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO37
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO38
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO39
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO40
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO41
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO42
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO43
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO44
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO45
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO46
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO47
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFO48
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFQ
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFT
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFX1
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFX2
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFX3
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PRBUFX4
	port(A0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGINVI
	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

end component;

component PGINVK
	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

end component;

component PGINVKI
	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

end component;

component PXINVK
	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

end component;

component PXINVE
	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

end component;

component PXINVO
	port(A0 : IN std_logic;
		 ZN0 : OUT std_logic);

end component;

component PXIN
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXIND
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXINE
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXINK
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXINR
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXINRG
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXINRX
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PXINT
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN0
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN1
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN2
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN3
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN4
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN5
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN6
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PKIN7
	port(XI0 : IN std_logic;
		 Z0 : OUT std_logic);

end component;

component PGDFF
	port(D0	: IN std_logic;
		 CLK : IN std_logic;
		 CD  : IN std_logic;
		 Q0  : OUT std_logic);

end component;

component PGDFFR
	port(D0	: IN std_logic;
		 CLK : IN std_logic;
		 CD  : IN std_logic;
		 RNESET : IN std_logic;
		 Q0  : OUT std_logic);

end component;

component PXDFF
	port(D0	: IN std_logic;
		 CLK : IN std_logic;
		 Q0  : OUT std_logic);

end component;

component PXDL
	port(D0	: IN std_logic;
		 G : IN std_logic;
		 Q0  : OUT std_logic);

end component;

component PXDLR
	port(D0	: IN std_logic;
		 G : IN std_logic;
		 RNESET : IN std_logic;
		 Q0  : OUT std_logic);
end component;


component PXDFFR
	port(D0	: IN std_logic;
		 CLK : IN std_logic;
		 RNESET : IN std_logic;
		 Q0  : OUT std_logic);

end component;

component PXOUT
	port(A0 : IN std_logic;
		 XO0 : OUT std_logic);
end component;

component PXOUTS
	port(A0 : IN std_logic;
		 XO0 : OUT std_logic);
end component;

component PXTRI
	port(A0 : IN std_logic;
		 OE : IN std_logic;
		 XO0 : OUT std_logic);
end component;

component PXTRIS
	port(A0 : IN std_logic;
		 OE : IN std_logic;
		 XO0 : OUT std_logic);
end component;



component PGAND27
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND28
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND29
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND30
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND31
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND32
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND33
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND34
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND35
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND36
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND37
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND38
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		A37 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND39
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		A37 : IN std_logic;
		A38 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND40
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		A37 : IN std_logic;
		A38 : IN std_logic;
		A39 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND41
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		A37 : IN std_logic;
		A38 : IN std_logic;
		A39 : IN std_logic;
		A40 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND42
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		A37 : IN std_logic;
		A38 : IN std_logic;
		A39 : IN std_logic;
		A40 : IN std_logic;
		A41 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND43
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		A37 : IN std_logic;
		A38 : IN std_logic;
		A39 : IN std_logic;
		A40 : IN std_logic;
		A41 : IN std_logic;
		A42 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGAND44
	port(
		A0 : IN std_logic;
		A1 : IN std_logic;
		A2 : IN std_logic;
		A3 : IN std_logic;
		A4 : IN std_logic;
		A5 : IN std_logic;
		A6 : IN std_logic;
		A7 : IN std_logic;
		A8 : IN std_logic;
		A9 : IN std_logic;
		A10 : IN std_logic;
		A11 : IN std_logic;
		A12 : IN std_logic;
		A13 : IN std_logic;
		A14 : IN std_logic;
		A15 : IN std_logic;
		A16 : IN std_logic;
		A17 : IN std_logic;
		A18 : IN std_logic;
		A19 : IN std_logic;
		A20 : IN std_logic;
		A21 : IN std_logic;
		A22 : IN std_logic;
		A23 : IN std_logic;
		A24 : IN std_logic;
		A25 : IN std_logic;
		A26 : IN std_logic;
		A27 : IN std_logic;
		A28 : IN std_logic;
		A29 : IN std_logic;
		A30 : IN std_logic;
		A31 : IN std_logic;
		A32 : IN std_logic;
		A33 : IN std_logic;
		A34 : IN std_logic;
		A35 : IN std_logic;
		A36 : IN std_logic;
		A37 : IN std_logic;
		A38 : IN std_logic;
		A39 : IN std_logic;
		A40 : IN std_logic;
		A41 : IN std_logic;
		A42 : IN std_logic;
		A43 : IN std_logic;
		Z0 : OUT std_logic);

end component;

component PGDFFRS
  port(D0 : IN std_logic; 
       CLK : IN std_logic; 
       EN : IN std_logic; 
       CD : IN std_logic; 
       SD : IN std_logic;
       Q0 : OUT std_logic);
end component;

component PGDLRS
  port(D0 : IN std_logic; 
       G : IN std_logic; 
       CD : IN std_logic; 
       SD : IN std_logic;
       Q0 : OUT std_logic);
end component;

component PXDFFRS
  port(D0 : IN std_logic; 
       CLK : IN std_logic; 
       EN : IN std_logic; 
       CD : IN std_logic; 
       SD : IN std_logic; 
       Q0 : OUT std_logic);
end component;

component PXDLRS 
  port(D0 : IN std_logic; 
       G : IN std_logic; 
       CD : IN std_logic; 
       SD : IN std_logic; 
       Q0 : OUT std_logic);
end component;

component PGTRI
  port(A0 : IN std_logic;
       OE : IN std_logic;
       XO0 : OUT std_logic);
end component;

END VIT_PKG;


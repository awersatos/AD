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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca2/src/RCS/ORCA_CMB.vhd,v 1.5 2005/05/19 20:04:09 pradeep Exp $ 
--

--
----- CELL AGEB4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AGEB4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AGEB4";
      tpd_A0_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_GE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0              :	in    STD_LOGIC;
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B0              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      B3              :	in    STD_LOGIC;
      CI              :	in    STD_LOGIC := '1';
      GE              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AGEB4 : entity is TRUE;

end AGEB4;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AGEB4 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A0_ipd	 : STD_LOGIC := 'X';
   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B0_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B3_ipd	 : STD_LOGIC := 'X';
   SIGNAL CI_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (CI_ipd, CI, tipd_CI);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, B1_ipd,
				B2_ipd, B3_ipd, CI_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS GE_zd      : STD_ULOGIC is Results(1);
   VARIABLE A, B    : STD_LOGIC_VECTOR(0 to 3) := (others => 'X');

   -- output glitch detection variables
   VARIABLE GE_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------

      A := STD_LOGIC_VECTOR'(A3_ipd, A2_ipd, A1_ipd, A0_ipd);
      B := STD_LOGIC_VECTOR'(B3_ipd, B2_ipd, B1_ipd, B0_ipd);

      -- If A = B, then pass on carry-in (GE from the lower stage)
      -- Note: carry-in on the first stage is tied HIGH
      IF (A > B) THEN
	GE_zd := '1'; 
      ELSIF (A = B) THEN
	GE_zd := CI_ipd;
      ELSE
	GE_zd := '0';
      END IF;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => GE,
       OutSignalName => "GE",
       OutTemp => GE_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_GE, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_GE, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_GE, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_GE, TRUE),
		 4 => (B0_ipd'last_event, tpd_B0_GE, TRUE),
		 5 => (B1_ipd'last_event, tpd_B1_GE, TRUE),
		 6 => (B2_ipd'last_event, tpd_B2_GE, TRUE),
		 7 => (B3_ipd'last_event, tpd_B3_GE, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_GE, TRUE)),
       GlitchData => GE_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL ANEB4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ANEB4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ANEB4";
      tpd_A0_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_NE       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0              :	in    STD_LOGIC;
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B0              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      B3              :	in    STD_LOGIC;
      CI              :	in    STD_LOGIC := '0';
      NE              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ANEB4 : entity is TRUE;

end ANEB4;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ANEB4 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A0_ipd	 : STD_LOGIC := 'X';
   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B0_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B3_ipd	 : STD_LOGIC := 'X';
   SIGNAL CI_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (CI_ipd, CI, tipd_CI);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, B1_ipd,
				B2_ipd, B3_ipd, CI_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS NE_zd      : STD_ULOGIC is Results(1);
   VARIABLE A, B    : STD_LOGIC_VECTOR(0 to 3) := (others => 'X');

   -- output glitch detection variables
   VARIABLE NE_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------

      A := STD_LOGIC_VECTOR'(A3_ipd, A2_ipd, A1_ipd, A0_ipd);
      B := STD_LOGIC_VECTOR'(B3_ipd, B2_ipd, B1_ipd, B0_ipd);

      -- If A = B, then pass on carry-in input (NE from the previous stage)
      -- Note: carry-in on the first stage is tied LOW
      IF (A = B) THEN
	NE_zd := CI_ipd; 
      ELSE
	NE_zd := '1';
      END IF;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => NE,
       OutSignalName => "NE",
       OutTemp => NE_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_NE, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_NE, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_NE, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_NE, TRUE),
		 4 => (B0_ipd'last_event, tpd_B0_NE, TRUE),
		 5 => (B1_ipd'last_event, tpd_B1_NE, TRUE),
		 6 => (B2_ipd'last_event, tpd_B2_NE, TRUE),
		 7 => (B3_ipd'last_event, tpd_B3_NE, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_NE, TRUE)),
       GlitchData => NE_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL AND2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND2 : entity is TRUE;

end AND2;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) AND (A_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL AND2B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND2B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND2B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND2B1 : entity is TRUE;

end AND2B1;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND2B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (NOT (B_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND2B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND2B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND2B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND2B2 : entity is TRUE;

end AND2B2;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND2B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (A_ipd)) AND (NOT (B_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND3 : entity is TRUE;

end AND3;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (C_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND3B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND3B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND3B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND3B1 : entity is TRUE;

end AND3B1;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND3B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (NOT (C_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND3B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND3B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND3B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND3B2 : entity is TRUE;

end AND3B2;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND3B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (NOT (B_ipd)) AND (NOT (C_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND3B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND3B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND3B3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND3B3 : entity is TRUE;

end AND3B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND3B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (A_ipd)) AND (NOT (B_ipd)) AND (NOT (C_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND4 : entity is TRUE;

end AND4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) AND (A_ipd) AND (C_ipd) AND (D_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND4B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND4B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND4B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND4B1 : entity is TRUE;

end AND4B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND4B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (C_ipd) AND (NOT (D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND4B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND4B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND4B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND4B2 : entity is TRUE;

end AND4B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND4B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (NOT (C_ipd)) AND (NOT (D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND4B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND4B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND4B3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND4B3 : entity is TRUE;

end AND4B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND4B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (NOT (B_ipd)) AND (NOT (C_ipd)) AND (NOT (D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND4B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND4B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND4B4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND4B4 : entity is TRUE;

end AND4B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND4B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (A_ipd)) AND (NOT (B_ipd)) AND (NOT (C_ipd)) AND (NOT (D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND5 : entity is TRUE;

end AND5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (C_ipd) AND (D_ipd) AND (E_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND5B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND5B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND5B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND5B1 : entity is TRUE;

end AND5B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND5B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (C_ipd) AND (D_ipd) AND (NOT (E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND5B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND5B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND5B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND5B2 : entity is TRUE;

end AND5B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND5B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (C_ipd) AND (NOT (D_ipd)) AND (NOT (E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND5B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND5B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND5B3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND5B3 : entity is TRUE;

end AND5B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND5B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (NOT (C_ipd)) AND (NOT (D_ipd)) AND (NOT (E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND5B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND5B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND5B4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND5B4 : entity is TRUE;

end AND5B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND5B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (NOT (B_ipd)) AND (NOT (C_ipd)) AND (NOT (D_ipd)) 
				AND (NOT (E_ipd));	

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND5B5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND5B5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND5B5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND5B5 : entity is TRUE;

end AND5B5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND5B5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (A_ipd)) AND (NOT (B_ipd)) AND (NOT (C_ipd)) 
			AND (NOT (D_ipd)) AND (NOT (E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AND6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AND6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AND6";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_F_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_F          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      F               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AND6 : entity is TRUE;

end AND6;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AND6 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';
   SIGNAL F_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (F_ipd, F, tipd_F);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (A_ipd) AND (B_ipd) AND (C_ipd) AND (D_ipd) AND (E_ipd) AND (F_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI21 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI21 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI21";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI21 : entity is TRUE;

end AOI21;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI21 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((A1_ipd AND A2_ipd) OR B_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI211 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI211 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI211";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI211 : entity is TRUE;

end AOI211;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI211 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((A2_ipd) AND (A1_ipd)) OR (B_ipd) OR (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 3 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI2111 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI2111 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI2111";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI2111 : entity is TRUE;

end AOI2111;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI2111 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A2_ipd) AND (A1_ipd)) OR (B_ipd) OR (C_ipd) OR (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 2 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 3 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 4 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI22 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI22 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI22";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI22 : entity is TRUE;

end AOI22;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI22 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((A1_ipd) AND (A2_ipd)) OR ((B1_ipd) AND (B2_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI221 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI221 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI221";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI221 : entity is TRUE;

end AOI221;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI221 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	         : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd)) OR ((B1_ipd) AND (B2_ipd)) OR (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 4 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL AOI2211 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI2211 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI2211";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI2211 : entity is TRUE;

end AOI2211;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI2211 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL B1_ipd : STD_LOGIC := 'X';
   SIGNAL B2_ipd : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd)) OR ((B1_ipd) AND (B2_ipd)) OR (C_ipd)
         OR (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 4 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 5 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI222 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI222 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI222";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C1              :	in    STD_LOGIC;
      C2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI222 : entity is TRUE;

end AOI222;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI222 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL C1_ipd	 : STD_LOGIC := 'X';
   SIGNAL C2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C1_ipd, C1, tipd_C1);
   VitalWireDelay (C2_ipd, C2, tipd_C2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd, C1_ipd, C2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd)) OR ((B1_ipd) AND (B2_ipd)) OR ((C1_ipd)
         AND (C2_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 4 => (C1_ipd'last_event, tpd_C1_Z, TRUE),
                 5 => (C2_ipd'last_event, tpd_C2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI31 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI31 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI31";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI31 : entity is TRUE;

end AOI31;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI31 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((A2_ipd AND A1_ipd AND A3_ipd) OR B_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL AOI311 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI311 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI311";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI311 : entity is TRUE;

end AOI311;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI311 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_B);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((A1_ipd AND A2_ipd AND A3_ipd) OR B_ipd OR C_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 4 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI3111 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI3111 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI3111";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in STD_LOGIC;
      A2              :	in STD_LOGIC;
      A3              :	in STD_LOGIC;
      B               :	in STD_LOGIC;
      C               :	in STD_LOGIC;
      D               :	in STD_LOGIC;
      Z               :	out STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI3111 : entity is TRUE;

end AOI3111;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI3111 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd) AND (A3_ipd)) OR (B_ipd) OR (C_ipd) OR
         (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 4 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 5 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI32 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI32 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI32";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI32 : entity is TRUE;

end AOI32;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI32 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL B1_ipd : STD_LOGIC := 'X';
   SIGNAL B2_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B1_ipd, B2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd) AND (A3_ipd)) OR ((B1_ipd) AND (B2_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 4 => (B2_ipd'last_event, tpd_B2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI321 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI321 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI321";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI321 : entity is TRUE;

end AOI321;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI321 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B1_ipd, B2_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) AND (B1_ipd)) OR ((A2_ipd) AND (A1_ipd) AND (A3_ipd))
         OR (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 4 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 5 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI33 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI33 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI33";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      B3              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI33 : entity is TRUE;

end AOI33;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI33 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL B1_ipd : STD_LOGIC := 'X';
   SIGNAL B2_ipd : STD_LOGIC := 'X';
   SIGNAL B3_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B1_ipd, B2_ipd, B3_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd) AND (A3_ipd)) OR ((B1_ipd) AND (B2_ipd)
         AND (B3_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 4 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 5 => (B3_ipd'last_event, tpd_B3_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI41 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI41 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI41";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A4_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A4         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1                             :	in    STD_LOGIC;
      A2                             :	in    STD_LOGIC;
      A3                             :	in    STD_LOGIC;
      A4                             :	in    STD_LOGIC;
      B                              :	in    STD_LOGIC;
      Z                              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI41 : entity is TRUE;

end AOI41;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI41 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL A4_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (A4_ipd, A4, tipd_A4);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, A4_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((A1_ipd AND A2_ipd AND A3_ipd AND A4_ipd) OR B_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (A4_ipd'last_event, tpd_A4_Z, TRUE),
                 4 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI411 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI411 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI411";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A4_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A4         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      A4              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI411 : entity is TRUE;

end AOI411;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI411 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL A4_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (A4_ipd, A4, tipd_A4);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, A4_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd) AND (A3_ipd) AND (A4_ipd)) OR (B_ipd) OR
         (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (A4_ipd'last_event, tpd_A4_Z, TRUE),
                 4 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 5 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL AOI42 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity AOI42 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "AOI42";
      tpd_A1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A4_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A4         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      A4              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of AOI42 : entity is TRUE;

end AOI42;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of AOI42 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL A4_ipd : STD_LOGIC := 'X';
   SIGNAL B1_ipd : STD_LOGIC := 'X';
   SIGNAL B2_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (A4_ipd, A4, tipd_A4);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, A4_ipd, B1_ipd, B2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((A1_ipd) AND (A2_ipd) AND (A3_ipd) AND (A4_ipd)) OR ((B1_ipd) 
         AND (B2_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (A4_ipd'last_event, tpd_A4_Z, TRUE),
                 4 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 5 => (B2_ipd'last_event, tpd_B2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL BNDSCAN -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity BNDSCAN is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BNDSCAN";
      tpd_BSO1_TDO    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BSO2_TDO    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_PTMS_TDO    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_PTDI_TDI    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_PTCK_TCK    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PTDI       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PTMS       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PTCK       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BSO1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BSO2       :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      PTDI            :	in    STD_LOGIC;
      PTMS            :	in    STD_LOGIC;
      PTCK            :	in    STD_LOGIC;
      BSO1            :	in    STD_LOGIC;
      BSO2            :	in    STD_LOGIC;
      TDI             :	out   STD_LOGIC;
      TCK             :	out   STD_LOGIC;
      BSEN1           :	out   STD_LOGIC;
      BSEN2           :	out   STD_LOGIC;
      TDO             :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of BNDSCAN : entity is TRUE;

end BNDSCAN;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of BNDSCAN is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL PTDI_ipd	 : STD_LOGIC := 'X';
   SIGNAL PTMS_ipd	 : STD_LOGIC := 'X';
   SIGNAL PTCK_ipd	 : STD_LOGIC := 'X';
   SIGNAL BSO1_ipd	 : STD_LOGIC := 'X';
   SIGNAL BSO2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (PTDI_ipd, PTDI, tipd_PTDI);
   VitalWireDelay (PTMS_ipd, PTMS, tipd_PTMS);
   VitalWireDelay (PTCK_ipd, PTCK, tipd_PTCK);
   VitalWireDelay (BSO1_ipd, BSO1, tipd_BSO1);
   VitalWireDelay (BSO2_ipd, BSO2, tipd_BSO2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (PTDI_ipd, PTMS_ipd, PTCK_ipd, BSO1_ipd, BSO2_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 5) := (others => 'X');
   ALIAS TDI_zd     : STD_ULOGIC is Results(1);
   ALIAS TCK_zd     : STD_ULOGIC is Results(2);
   ALIAS TDO_zd     : STD_ULOGIC is Results(5);

   -- output glitch detection variables
   VARIABLE TDI_GlitchData	: VitalGlitchDataType;
   VARIABLE TCK_GlitchData	: VitalGlitchDataType;
   VARIABLE TDO_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      TDO_zd := VitalMUX
                 (data => (BSO2_ipd, BSO1_ipd),
                  dselect => (0 => PTMS_ipd));
      TCK_zd := VitalBUF(PTCK_ipd);
      TDI_zd := VitalBUF(PTDI_ipd);
      BSEN1 <= '0'; 
      BSEN2 <= '0'; 

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => TDO,
       OutSignalName => "TDO",
       OutTemp => TDO_zd,
       Paths => (0 => (BSO1_ipd'last_event, tpd_BSO1_TDO, TRUE),
                 1 => (BSO2_ipd'last_event, tpd_BSO2_TDO, TRUE),
                 2 => (PTMS_ipd'last_event, tpd_PTMS_TDO, TRUE)),
       GlitchData => TDO_GlitchData,
       Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => TCK,
       OutSignalName => "TCK",
       OutTemp => TCK_zd,
       Paths => (0 => (InputChangeTime => PTCK_ipd'LAST_EVENT, 
                       PathDelay => tpd_PTCK_TCK, 
                       PathCondition => TRUE)),
       GlitchData => TCK_GlitchData,
       Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => TDI,
       OutSignalName => "TDI",
       OutTemp => TDI_zd,
       Paths => (0 => (InputChangeTime => PTDI_ipd'LAST_EVENT, 
                       PathDelay => tpd_PTDI_TDI, 
                       PathCondition => TRUE)),
       GlitchData => TDI_GlitchData,
       Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

end process;

end V;


--
----- CELL COMP -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity COMP is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "COMP";
      tpd_A0_EQ       :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_EQ       :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_EQ       :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_EQ       :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :  VitalDelayType01 := (0.1 ns, 0.1 ns));

    port(
      A0              :  in    STD_LOGIC;
      A1              :  in    STD_LOGIC;
      B0              :  in    STD_LOGIC;
      B1              :  in    STD_LOGIC;
      EQ              :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of COMP : entity is TRUE;

end COMP;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of COMP is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd      : STD_LOGIC := 'X';
   SIGNAL A1_ipd      : STD_LOGIC := 'X';
   SIGNAL B0_ipd      : STD_LOGIC := 'X';
   SIGNAL B1_ipd      : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, B0_ipd, B1_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS EQ_zd      : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE EQ_GlitchData        : VitalGlitchDataType;

   CONSTANT COMP_table : VitalTruthTableType := (
   --------------------------------------------
   --  A0   A1   B0   B1   |   EQ
   --------------------------------------------
    ( '0', '-', '1', '-',     '0'),
    ( '1', '-', '0', '-',     '0'),
    ( '-', '0', '-', '1',     '0'),
    ( '-', '1', '-', '0',     '0'),
    ( '0', '0', '0', '0',     '1'),
    ( '1', '0', '1', '0',     '1'),
    ( '0', '1', '0', '1',     '1'),
    ( '1', '1', '1', '1',     '1'));
 
   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Results := VitalTruthTable (
                TruthTable => COMP_table,
                DataIn => (A0_ipd, A1_ipd, B0_ipd, B1_ipd)
                );
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => EQ,
       OutSignalName => "EQ",
       OutTemp => EQ_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_EQ, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_EQ, TRUE),
                 2 => (B0_ipd'last_event, tpd_B0_EQ, TRUE),
                 3 => (B1_ipd'last_event, tpd_B1_EQ, TRUE)),
       GlitchData => EQ_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;
 
end V;
 

--
----- CELL COMP4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity COMP4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "COMP4";
      tpd_A0_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_EQ       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         : VitalDelayType01 := (0.1 ns, 0.1 ns));

    port(
      A0              :  in    STD_LOGIC;
      A1              :  in    STD_LOGIC;
      A2              :  in    STD_LOGIC;
      A3              :  in    STD_LOGIC;
      B0              :  in    STD_LOGIC;
      B1              :  in    STD_LOGIC;
      B2              :  in    STD_LOGIC;
      B3              :  in    STD_LOGIC;
      EQ              :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of COMP4 : entity is TRUE;

end COMP4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of COMP4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd         : STD_LOGIC := 'X';
   SIGNAL A1_ipd         : STD_LOGIC := 'X';
   SIGNAL A2_ipd         : STD_LOGIC := 'X';
   SIGNAL A3_ipd         : STD_LOGIC := 'X';
   SIGNAL B0_ipd         : STD_LOGIC := 'X';
   SIGNAL B1_ipd         : STD_LOGIC := 'X';
   SIGNAL B2_ipd         : STD_LOGIC := 'X';
   SIGNAL B3_ipd         : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, B1_ipd, B2_ipd, B3_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS EQ_zd      : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE EQ_GlitchData        : VitalGlitchDataType;

   CONSTANT COMP4_table : VitalTruthTableType := (
   ---------------------------------------------------
   --  A0   A1   A2   A3   B0   B1   B2   B3   |   EQ
   ---------------------------------------------------
    ( '0', '-', '-', '-', '1', '-', '-', '-',     '0'),
    ( '1', '-', '-', '-', '0', '-', '-', '-',     '0'),
    ( '-', '0', '-', '-', '-', '1', '-', '-',     '0'),
    ( '-', '1', '-', '-', '-', '0', '-', '-',     '0'),
    ( '-', '-', '0', '-', '-', '-', '1', '-',     '0'),
    ( '-', '-', '1', '-', '-', '-', '0', '-',     '0'),
    ( '-', '-', '-', '0', '-', '-', '-', '1',     '0'),
    ( '-', '-', '-', '1', '-', '-', '-', '0',     '0'),
    ( '0', '0', '0', '0', '0', '0', '0', '0',     '1'),
    ( '1', '0', '0', '0', '1', '0', '0', '0',     '1'),
    ( '0', '1', '0', '0', '0', '1', '0', '0',     '1'),
    ( '1', '1', '0', '0', '1', '1', '0', '0',     '1'),
    ( '0', '0', '1', '0', '0', '0', '1', '0',     '1'),
    ( '1', '0', '1', '0', '1', '0', '1', '0',     '1'),
    ( '0', '1', '1', '0', '0', '1', '1', '0',     '1'),
    ( '1', '1', '1', '0', '1', '1', '1', '0',     '1'),
    ( '0', '0', '0', '1', '0', '0', '0', '1',     '1'),
    ( '1', '0', '0', '1', '1', '0', '0', '1',     '1'),
    ( '0', '1', '0', '1', '0', '1', '0', '1',     '1'),
    ( '1', '1', '0', '1', '1', '1', '0', '1',     '1'),
    ( '0', '0', '1', '1', '0', '0', '1', '1',     '1'),
    ( '1', '0', '1', '1', '1', '0', '1', '1',     '1'),
    ( '0', '1', '1', '1', '0', '1', '1', '1',     '1'),
    ( '1', '1', '1', '1', '1', '1', '1', '1',     '1'));
 
   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Results := VitalTruthTable (
                TruthTable => COMP4_table,
                DataIn => (A0_ipd, A1_ipd, A2_ipd, A3_ipd, 
			   B0_ipd, B1_ipd, B2_ipd, B3_ipd)
                );
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => EQ,
       OutSignalName => "EQ",
       OutTemp => EQ_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_EQ, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_EQ, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_EQ, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_EQ, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_EQ, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_EQ, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_EQ, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_EQ, TRUE)),
       GlitchData => EQ_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;
 
end V;
 

--
----- CELL DMUX24 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DMUX24 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "DMUX24";
      tpd_A0_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

    port(
      A0              :  in    STD_LOGIC;
      A1              :  in    STD_LOGIC;
      Z0              :  out   STD_LOGIC;
      Z1              :  out   STD_LOGIC;
      Z2              :  out   STD_LOGIC;
      Z3              :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of DMUX24 : entity is TRUE;

end DMUX24;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of DMUX24 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd : STD_LOGIC := 'X';
   SIGNAL A1_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 4) := (others => 'X');
   ALIAS Z0_zd      : STD_ULOGIC is Results(1);
   ALIAS Z1_zd      : STD_ULOGIC is Results(2);
   ALIAS Z2_zd      : STD_ULOGIC is Results(3);
   ALIAS Z3_zd      : STD_ULOGIC is Results(4);

   -- output glitch detection variables
   VARIABLE Z0_GlitchData        : VitalGlitchDataType;
   VARIABLE Z1_GlitchData        : VitalGlitchDataType;
   VARIABLE Z2_GlitchData        : VitalGlitchDataType;
   VARIABLE Z3_GlitchData        : VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z0_zd := (NOT (A0_ipd)) AND (NOT (A1_ipd)); 
      Z1_zd := (A0_ipd) AND (NOT (A1_ipd)); 
      Z2_zd := (NOT (A0_ipd)) AND (A1_ipd); 
      Z3_zd := (A0_ipd) AND (A1_ipd); 

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z0,
       OutSignalName => "Z0",
       OutTemp => Z0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
       GlitchData => Z0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z1,
       OutSignalName => "Z1",
       OutTemp => Z1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z1, TRUE)),
       GlitchData => Z1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z2,
       OutSignalName => "Z2",
       OutTemp => Z2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z2, TRUE)),
       GlitchData => Z2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z3,
       OutSignalName => "Z3",
       OutTemp => Z3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z3, TRUE)),
       GlitchData => Z3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;
 
end V;
 

--
----- CELL DMUX24E -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DMUX24E is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "DMUX24E";
      tpd_A0_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z0        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z1        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z2        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z3        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

    port(
      A0                             :  in    STD_LOGIC;
      A1                             :  in    STD_LOGIC;
      E                              :  in    STD_LOGIC;
      Z0                             :  out   STD_LOGIC;
      Z1                             :  out   STD_LOGIC;
      Z2                             :  out   STD_LOGIC;
      Z3                             :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of DMUX24E : entity is TRUE;

end DMUX24E;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of DMUX24E is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd         : STD_LOGIC := 'X';
   SIGNAL A1_ipd         : STD_LOGIC := 'X';
   SIGNAL E_ipd          : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (E_ipd,  E,  tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, E_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 4) := (others => 'X');
   ALIAS Z0_zd      : STD_ULOGIC is Results(1);
   ALIAS Z1_zd      : STD_ULOGIC is Results(2);
   ALIAS Z2_zd      : STD_ULOGIC is Results(3);
   ALIAS Z3_zd      : STD_ULOGIC is Results(4);

   -- output glitch detection variables
   VARIABLE Z0_GlitchData        : VitalGlitchDataType;
   VARIABLE Z1_GlitchData        : VitalGlitchDataType;
   VARIABLE Z2_GlitchData        : VitalGlitchDataType;
   VARIABLE Z3_GlitchData        : VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z0_zd := E_ipd AND (NOT (A0_ipd)) AND (NOT (A1_ipd)); 
      Z1_zd := E_ipd AND A0_ipd AND (NOT (A1_ipd)); 
      Z2_zd := E_ipd AND (NOT (A0_ipd)) AND A1_ipd; 
      Z3_zd := E_ipd AND A0_ipd AND A1_ipd; 

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z0,
       OutSignalName => "Z0",
       OutTemp => Z0_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z0, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z0, TRUE)),
       GlitchData => Z0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z1,
       OutSignalName => "Z1",
       OutTemp => Z1_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z1, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z1, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z1, TRUE)),
       GlitchData => Z1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z2,
       OutSignalName => "Z2",
       OutTemp => Z2_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z2, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z2, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z2, TRUE)),
       GlitchData => Z2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z3,
       OutSignalName => "Z3",
       OutTemp => Z3_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z3, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z3, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z3, TRUE)),
       GlitchData => Z3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;
 
end V;
 

--
----- CELL DMUX38 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DMUX38 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "DMUX38";
      tpd_A0_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

    port(
      A0              :  in    STD_LOGIC;
      A1              :  in    STD_LOGIC;
      A2              :  in    STD_LOGIC;
      Z0              :  out   STD_LOGIC;
      Z1              :  out   STD_LOGIC;
      Z2              :  out   STD_LOGIC;
      Z3              :  out   STD_LOGIC;
      Z4              :  out   STD_LOGIC;
      Z5              :  out   STD_LOGIC;
      Z6              :  out   STD_LOGIC;
      Z7              :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of DMUX38 : entity is TRUE;

end DMUX38;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of DMUX38 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd : STD_LOGIC := 'X';
   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 8) := (others => 'X');
   ALIAS Z0_zd      : STD_ULOGIC is Results(1);
   ALIAS Z1_zd      : STD_ULOGIC is Results(2);
   ALIAS Z2_zd      : STD_ULOGIC is Results(3);
   ALIAS Z3_zd      : STD_ULOGIC is Results(4);
   ALIAS Z4_zd      : STD_ULOGIC is Results(5);
   ALIAS Z5_zd      : STD_ULOGIC is Results(6);
   ALIAS Z6_zd      : STD_ULOGIC is Results(7);
   ALIAS Z7_zd      : STD_ULOGIC is Results(8);

   -- output glitch detection variables
   VARIABLE Z0_GlitchData        : VitalGlitchDataType;
   VARIABLE Z1_GlitchData        : VitalGlitchDataType;
   VARIABLE Z2_GlitchData        : VitalGlitchDataType;
   VARIABLE Z3_GlitchData        : VitalGlitchDataType;
   VARIABLE Z4_GlitchData        : VitalGlitchDataType;
   VARIABLE Z5_GlitchData        : VitalGlitchDataType;
   VARIABLE Z6_GlitchData        : VitalGlitchDataType;
   VARIABLE Z7_GlitchData        : VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z0_zd := (NOT (A0_ipd)) AND (NOT (A1_ipd)) AND (NOT (A2_ipd)); 
      Z1_zd := (A0_ipd) AND (NOT (A1_ipd)) AND (NOT (A2_ipd)); 
      Z2_zd := (NOT (A0_ipd)) AND (A1_ipd) AND (NOT (A2_ipd));
      Z3_zd := (A0_ipd) AND (A1_ipd) AND (NOT (A2_ipd)); 
      Z4_zd := (NOT (A0_ipd)) AND (NOT (A1_ipd)) AND (A2_ipd); 
      Z5_zd := (A0_ipd) AND (NOT (A1_ipd)) AND (A2_ipd); 
      Z6_zd := (NOT (A0_ipd)) AND (A1_ipd) AND (A2_ipd); 
      Z7_zd := (A0_ipd) AND (A1_ipd) AND (A2_ipd); 

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z0,
       OutSignalName => "Z0",
       OutTemp => Z0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
       GlitchData => Z0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z1,
       OutSignalName => "Z1",
       OutTemp => Z1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z1, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z1, TRUE)),
       GlitchData => Z1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z2,
       OutSignalName => "Z2",
       OutTemp => Z2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z2, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z2, TRUE)),
       GlitchData => Z2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z3,
       OutSignalName => "Z3",
       OutTemp => Z3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z3, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z3, TRUE)),
       GlitchData => Z3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z4,
       OutSignalName => "Z4",
       OutTemp => Z4_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z4, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z4, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z4, TRUE)),
       GlitchData => Z4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z5,
       OutSignalName => "Z5",
       OutTemp => Z5_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z5, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z5, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z5, TRUE)),
       GlitchData => Z5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z6,
       OutSignalName => "Z6",
       OutTemp => Z6_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z6, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z6, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z6, TRUE)),
       GlitchData => Z6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z7,
       OutSignalName => "Z7",
       OutTemp => Z7_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_Z7, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_Z7, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_Z7, TRUE)),
       GlitchData => Z7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;
 
end V;
 

--
----- CELL DMUX38E -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity DMUX38E is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "DMUX38E";
      tpd_A0_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z0        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z1        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z2        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z3        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z4        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z5        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z6        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Z7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Z7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z7        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

    port(
      A0              :  in    STD_LOGIC;
      A1              :  in    STD_LOGIC;
      A2              :  in    STD_LOGIC;
      E               :  in    STD_LOGIC;
      Z0              :  out   STD_LOGIC;
      Z1              :  out   STD_LOGIC;
      Z2              :  out   STD_LOGIC;
      Z3              :  out   STD_LOGIC;
      Z4              :  out   STD_LOGIC;
      Z5              :  out   STD_LOGIC;
      Z6              :  out   STD_LOGIC;
      Z7              :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of DMUX38E : entity is TRUE;

end DMUX38E;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of DMUX38E is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd : STD_LOGIC := 'X';
   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL E_ipd  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, E_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 8) := (others => 'X');
   ALIAS Z0_zd      : STD_ULOGIC is Results(1);
   ALIAS Z1_zd      : STD_ULOGIC is Results(2);
   ALIAS Z2_zd      : STD_ULOGIC is Results(3);
   ALIAS Z3_zd      : STD_ULOGIC is Results(4);
   ALIAS Z4_zd      : STD_ULOGIC is Results(5);
   ALIAS Z5_zd      : STD_ULOGIC is Results(6);
   ALIAS Z6_zd      : STD_ULOGIC is Results(7);
   ALIAS Z7_zd      : STD_ULOGIC is Results(8);

   -- output glitch detection variables
   VARIABLE Z0_GlitchData        : VitalGlitchDataType;
   VARIABLE Z1_GlitchData        : VitalGlitchDataType;
   VARIABLE Z2_GlitchData        : VitalGlitchDataType;
   VARIABLE Z3_GlitchData        : VitalGlitchDataType;
   VARIABLE Z4_GlitchData        : VitalGlitchDataType;
   VARIABLE Z5_GlitchData        : VitalGlitchDataType;
   VARIABLE Z6_GlitchData        : VitalGlitchDataType;
   VARIABLE Z7_GlitchData        : VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z0_zd := (E_ipd) AND (NOT (A0_ipd)) AND (NOT (A1_ipd)) AND (NOT (A2_ipd)); 
      Z1_zd := (E_ipd) AND (A0_ipd) AND (NOT (A1_ipd)) AND (NOT (A2_ipd)); 
      Z2_zd := (E_ipd) AND (NOT (A0_ipd)) AND (A1_ipd) AND (NOT (A2_ipd));
      Z3_zd := (E_ipd) AND (A0_ipd) AND (A1_ipd) AND (NOT (A2_ipd)); 
      Z4_zd := (E_ipd) AND (NOT (A0_ipd)) AND (NOT (A1_ipd)) AND (A2_ipd); 
      Z5_zd := (E_ipd) AND (A0_ipd) AND (NOT (A1_ipd)) AND (A2_ipd); 
      Z6_zd := (E_ipd) AND (NOT (A0_ipd)) AND (A1_ipd) AND (A2_ipd); 
      Z7_zd := (E_ipd) AND (A0_ipd) AND (A1_ipd) AND (A2_ipd); 

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z0,
       OutSignalName => "Z0",
       OutTemp => Z0_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z0, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z0, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z0, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z0, TRUE)),
       GlitchData => Z0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z1,
       OutSignalName => "Z1",
       OutTemp => Z1_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z1, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z1, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z1, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z1, TRUE)),
       GlitchData => Z1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z2,
       OutSignalName => "Z2",
       OutTemp => Z2_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z2, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z2, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z2, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z2, TRUE)),
       GlitchData => Z2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z3,
       OutSignalName => "Z3",
       OutTemp => Z3_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z3, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z3, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z3, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z3, TRUE)),
       GlitchData => Z3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z4,
       OutSignalName => "Z4",
       OutTemp => Z4_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z4, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z4, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z4, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z4, TRUE)),
       GlitchData => Z4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z5,
       OutSignalName => "Z5",
       OutTemp => Z5_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z5, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z5, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z5, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z5, TRUE)),
       GlitchData => Z5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z6,
       OutSignalName => "Z6",
       OutTemp => Z6_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z6, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z6, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z6, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z6, TRUE)),
       GlitchData => Z6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => Z7,
       OutSignalName => "Z7",
       OutTemp => Z7_zd,
       Paths => (0 => (E_ipd'last_event, tpd_E_Z7, TRUE),
                 1 => (A0_ipd'last_event, tpd_A0_Z7, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z7, TRUE),
                 3 => (A2_ipd'last_event, tpd_A2_Z7, TRUE)),
       GlitchData => Z7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;
 
end V;
 

--
----- CELL ADD -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ADD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ADD";
      tpd_A_CO        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_CO        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A_S         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_S         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      CI              :	in    STD_LOGIC;
      CO              :	out   STD_LOGIC;
      S               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ADD : entity is TRUE;

end ADD;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ADD is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A_ipd  : STD_LOGIC := 'X';
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL CI_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (CI_ipd, CI, tipd_CI);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, CI_ipd)
 
   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS CO_zd      : STD_ULOGIC is Results(1);
   ALIAS S_zd       : STD_ULOGIC is Results(2);
 
   -- output glitch detection variables
   VARIABLE CO_GlitchData    : VitalGlitchDataType;
   VARIABLE S_GlitchData     : VitalGlitchDataType;
 
   CONSTANT ADD_table : VitalTruthTableType := (
   --------------------------------------------
   --  A    B    CI   |   CO   S
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A_ipd, B_ipd, CI_ipd)
                );
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => CO,
       OutSignalName => "CO",
       OutTemp => CO_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_CO, TRUE),
                 1 => (B_ipd'last_event, tpd_B_CO, TRUE),
		 2 => (CI_ipd'last_event, tpd_CI_CO, TRUE)),
       GlitchData => CO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S,
       OutSignalName => "S",
       OutTemp => S_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_S, TRUE),
                 1 => (B_ipd'last_event, tpd_B_S, TRUE),
                 2 => (CI_ipd'last_event, tpd_CI_S, TRUE)),
 
       GlitchData => S_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;

end V;


--
----- CELL FADD4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity FADD4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "FADD4";
      tpd_A0_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0              :	in    STD_LOGIC;
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B0              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      B3              :	in    STD_LOGIC;
      CI              :	in    STD_LOGIC;
      CO              :	out   STD_LOGIC;
      S0              :	out   STD_LOGIC;
      S1              :	out   STD_LOGIC;
      S2              :	out   STD_LOGIC;
      S3              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of FADD4 : entity is TRUE;

end FADD4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FADD4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd : STD_LOGIC := 'X';
   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL B0_ipd : STD_LOGIC := 'X';
   SIGNAL B1_ipd : STD_LOGIC := 'X';
   SIGNAL B2_ipd : STD_LOGIC := 'X';
   SIGNAL B3_ipd : STD_LOGIC := 'X';
   SIGNAL CI_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (CI_ipd, CI, tipd_CI);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, 
			    B1_ipd, B2_ipd, B3_ipd, CI_ipd)
 
   -- functionality results
   VARIABLE Results1 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results2 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results3 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results4 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS C0_zd      : STD_ULOGIC is Results1(1);
   ALIAS S0_zd      : STD_ULOGIC is Results1(2);
   ALIAS C1_zd      : STD_ULOGIC is Results2(1);
   ALIAS S1_zd      : STD_ULOGIC is Results2(2);
   ALIAS C2_zd      : STD_ULOGIC is Results3(1);
   ALIAS S2_zd      : STD_ULOGIC is Results3(2);
   ALIAS CO_zd      : STD_ULOGIC is Results4(1);
   ALIAS S3_zd      : STD_ULOGIC is Results4(2);
 
   -- output glitch detection variables
   VARIABLE CO_GlitchData    : VitalGlitchDataType;
   VARIABLE S0_GlitchData    : VitalGlitchDataType;
   VARIABLE S1_GlitchData    : VitalGlitchDataType;
   VARIABLE S2_GlitchData    : VitalGlitchDataType;
   VARIABLE S3_GlitchData    : VitalGlitchDataType;
 
   CONSTANT ADD_table : VitalTruthTableType := (
   --------------------------------------------
   --  A    B    CI   |   CO   S
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results1 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A0_ipd, B0_ipd, CI_ipd)
                );
      Results2 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A1_ipd, B1_ipd, C0_zd)
                );
      Results3 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A2_ipd, B2_ipd, C1_zd)
                );
      Results4 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A3_ipd, B3_ipd, C2_zd)
                );

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => CO,
       OutSignalName => "CO",
       OutTemp => CO_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_CO, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_CO, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_CO, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_CO, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_CO, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_CO, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_CO, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_CO, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_CO, TRUE)),
       GlitchData => CO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S0,
       OutSignalName => "S0",
       OutTemp => S0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S0, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S0, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S0, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S0, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S0, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S0, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S0, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S0, TRUE)),
       GlitchData => S0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S1,
       OutSignalName => "S1",
       OutTemp => S1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S1, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S1, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S1, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S1, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S1, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S1, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S1, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S1, TRUE)),
       GlitchData => S1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S2,
       OutSignalName => "S2",
       OutTemp => S2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S2, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S2, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S2, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S2, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S2, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S2, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S2, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S2, TRUE)),
       GlitchData => S2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S3,
       OutSignalName => "S3",
       OutTemp => S3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S3, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S3, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S3, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S3, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S3, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S3, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S3, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S3, TRUE)),
       GlitchData => S3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL FADD4O -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity FADD4O is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "FADD4O";
      tpd_A0_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_S3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0              :	in    STD_LOGIC;
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B0              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      B3              :	in    STD_LOGIC;
      CI              :	in    STD_LOGIC;
      OFL             :	out   STD_LOGIC;
      S0              :	out   STD_LOGIC;
      S1              :	out   STD_LOGIC;
      S2              :	out   STD_LOGIC;
      S3              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of FADD4O : entity is TRUE;

end FADD4O;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FADD4O is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd         : STD_LOGIC := 'X';
   SIGNAL A1_ipd         : STD_LOGIC := 'X';
   SIGNAL A2_ipd         : STD_LOGIC := 'X';
   SIGNAL A3_ipd         : STD_LOGIC := 'X';
   SIGNAL B0_ipd         : STD_LOGIC := 'X';
   SIGNAL B1_ipd         : STD_LOGIC := 'X';
   SIGNAL B2_ipd         : STD_LOGIC := 'X';
   SIGNAL B3_ipd         : STD_LOGIC := 'X';
   SIGNAL CI_ipd         : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (CI_ipd, CI, tipd_CI);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, 
		     	    B1_ipd, B2_ipd, B3_ipd, CI_ipd)
 
   -- functionality results
   VARIABLE Results1 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results2 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results3 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results4 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results5 : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS C0_zd      : STD_ULOGIC is Results1(1);
   ALIAS S0_zd      : STD_ULOGIC is Results1(2);
   ALIAS C1_zd      : STD_ULOGIC is Results2(1);
   ALIAS S1_zd      : STD_ULOGIC is Results2(2);
   ALIAS C2_zd      : STD_ULOGIC is Results3(1);
   ALIAS S2_zd      : STD_ULOGIC is Results3(2);
   ALIAS C3_zd      : STD_ULOGIC is Results4(1);
   ALIAS S3_zd      : STD_ULOGIC is Results4(2);
   ALIAS OFL_zd     : STD_ULOGIC is Results5(1);
 
   -- output glitch detection variables
   VARIABLE OFL_GlitchData   : VitalGlitchDataType;
   VARIABLE S0_GlitchData    : VitalGlitchDataType;
   VARIABLE S1_GlitchData    : VitalGlitchDataType;
   VARIABLE S2_GlitchData    : VitalGlitchDataType;
   VARIABLE S3_GlitchData    : VitalGlitchDataType;
 
   CONSTANT ADD_table : VitalTruthTableType := (
   --------------------------------------------
   --  A    B    CI   |   CO   S
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results1 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A0_ipd, B0_ipd, CI_ipd)
                );
      Results2 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A1_ipd, B1_ipd, C0_zd)
                );
      Results3 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A2_ipd, B2_ipd, C1_zd)
                );
      Results4 := VitalTruthTable (
                TruthTable => ADD_table,
                DataIn => (A3_ipd, B3_ipd, C2_zd)
                );
      OFL_zd  := C3_zd XOR C2_zd;
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFL,
       OutSignalName => "OFL",
       OutTemp => OFL_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_OFL, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_OFL, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_OFL, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_OFL, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_OFL, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_OFL, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_OFL, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_OFL, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_OFL, TRUE)),
       GlitchData => OFL_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S0,
       OutSignalName => "S0",
       OutTemp => S0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S0, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S0, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S0, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S0, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S0, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S0, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S0, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S0, TRUE)),
       GlitchData => S0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S1,
       OutSignalName => "S1",
       OutTemp => S1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S1, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S1, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S1, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S1, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S1, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S1, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S1, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S1, TRUE)),
       GlitchData => S1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S2,
       OutSignalName => "S2",
       OutTemp => S2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S2, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S2, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S2, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S2, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S2, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S2, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S2, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S2, TRUE)),
       GlitchData => S2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S3,
       OutSignalName => "S3",
       OutTemp => S3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S3, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S3, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S3, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S3, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S3, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S3, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S3, TRUE),
		 8 => (CI_ipd'last_event, tpd_CI_S3, TRUE)),
       GlitchData => S3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL ADSU -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ADSU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ADSU";
      tpd_A_BCO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_BCO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_BCO     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_BCO     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A_S         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_S         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BCI        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CON        :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      BCI             :	in    STD_LOGIC;
      CON             :	in    STD_LOGIC;
      BCO             :	out   STD_LOGIC;
      S               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ADSU : entity is TRUE;

end ADSU;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ADSU is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A_ipd         : STD_LOGIC := 'X';
   SIGNAL B_ipd         : STD_LOGIC := 'X';
   SIGNAL BCI_ipd       : STD_LOGIC := 'X';
   SIGNAL CON_ipd       : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (BCI_ipd, BCI, tipd_BCI);
   VitalWireDelay (CON_ipd, CON, tipd_CON);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, BCI_ipd, CON_ipd)
 
   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS BCO_zd     : STD_ULOGIC is Results(1);
   ALIAS S_zd       : STD_ULOGIC is Results(2);
 
   -- output glitch detection variables
   VARIABLE BCO_GlitchData    : VitalGlitchDataType;
   VARIABLE S_GlitchData     : VitalGlitchDataType;
 
   CONSTANT ADSU_table : VitalTruthTableType := (
   --------------------------------------------
   --   A    B   BCI  CON  |   BCO   S
   --------------------------------------------
      ('0', '0', '0', '1',     '0', '0'),
      ('1', '0', '0', '1',     '0', '1'),
      ('0', '1', '0', '1',     '0', '1'),
      ('1', '1', '0', '1',     '1', '0'),
      ('0', '0', '1', '1',     '0', '1'),
      ('1', '0', '1', '1',     '1', '0'),
      ('0', '1', '1', '1',     '1', '0'),
      ('1', '1', '1', '1',     '1', '1'),
      ('0', '0', '0', '0',     '0', '1'),
      ('1', '0', '0', '0',     '1', '0'),
      ('0', '1', '0', '0',     '0', '0'),
      ('1', '1', '0', '0',     '0', '1'),
      ('0', '0', '1', '0',     '1', '0'),
      ('1', '0', '1', '0',     '1', '1'),
      ('0', '1', '1', '0',     '0', '1'),
      ('1', '1', '1', '0',     '1', '0'));

   begin
 
      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  Functionality Section
      -------------------------
      Results := VitalTruthTable(
		TruthTable => ADSU_table,
        	DataIn => (A_ipd, B_ipd, BCI_ipd, CON_ipd)
		);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => BCO,
       OutSignalName => "BCO",
       OutTemp => BCO_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_BCO, TRUE),
                 1 => (B_ipd'last_event, tpd_B_BCO, TRUE),
		 2 => (BCI_ipd'last_event, tpd_BCI_BCO, TRUE)),
       GlitchData => BCO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S,
       OutSignalName => "S",
       OutTemp => S_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_S, TRUE),
                 1 => (B_ipd'last_event, tpd_B_S, TRUE),
                 2 => (BCI_ipd'last_event, tpd_BCI_S, TRUE)),
 
       GlitchData => S_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;

end V;


--
----- CELL FADSU4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity FADSU4 is
   generic(
      TimingChecksOn : Boolean := FALSE;
      XOn            : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath   : String := "FADSU4";
      tpd_A0_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_BCO     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_BCO    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_BCO    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BCI       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CON       : VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0             :	in    STD_LOGIC;
      A1             :	in    STD_LOGIC;
      A2             :	in    STD_LOGIC;
      A3             :	in    STD_LOGIC;
      B0             :	in    STD_LOGIC;
      B1             :	in    STD_LOGIC;
      B2             :	in    STD_LOGIC;
      B3             :	in    STD_LOGIC;
      BCI            :	in    STD_LOGIC;
      CON            :	in    STD_LOGIC;
      BCO            :	out   STD_LOGIC;
      S0             :	out   STD_LOGIC;
      S1             :	out   STD_LOGIC;
      S2             :	out   STD_LOGIC;
      S3             :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of FADSU4 : entity is TRUE;

end FADSU4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FADSU4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd  : STD_LOGIC := 'X';
   SIGNAL A1_ipd  : STD_LOGIC := 'X';
   SIGNAL A2_ipd  : STD_LOGIC := 'X';
   SIGNAL A3_ipd  : STD_LOGIC := 'X';
   SIGNAL B0_ipd  : STD_LOGIC := 'X';
   SIGNAL B1_ipd  : STD_LOGIC := 'X';
   SIGNAL B2_ipd  : STD_LOGIC := 'X';
   SIGNAL B3_ipd  : STD_LOGIC := 'X';
   SIGNAL BCI_ipd : STD_LOGIC := 'X';
   SIGNAL CON_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (BCI_ipd, BCI, tipd_BCI);
   VitalWireDelay (CON_ipd, CON, tipd_CON);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, 
			    B1_ipd, B2_ipd, B3_ipd, BCI_ipd, CON_ipd)
 
   -- functionality results
   VARIABLE Results1 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results2 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results3 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results4 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS BC0_zd     : STD_ULOGIC is Results1(1);
   ALIAS S0_zd      : STD_ULOGIC is Results1(2);
   ALIAS BC1_zd     : STD_ULOGIC is Results2(1);
   ALIAS S1_zd      : STD_ULOGIC is Results2(2);
   ALIAS BC2_zd     : STD_ULOGIC is Results3(1);
   ALIAS S2_zd      : STD_ULOGIC is Results3(2);
   ALIAS BCO_zd     : STD_ULOGIC is Results4(1);
   ALIAS S3_zd      : STD_ULOGIC is Results4(2);
 
   -- output glitch detection variables
   VARIABLE BCO_GlitchData   : VitalGlitchDataType;
   VARIABLE S0_GlitchData    : VitalGlitchDataType;
   VARIABLE S1_GlitchData    : VitalGlitchDataType;
   VARIABLE S2_GlitchData    : VitalGlitchDataType;
   VARIABLE S3_GlitchData    : VitalGlitchDataType;
 
   CONSTANT ADSU_table : VitalTruthTableType := (
   --------------------------------------------
   --   A    B   BCI  CON  |   BCO   S
   --------------------------------------------
      ('0', '0', '0', '1',     '0', '0'),
      ('1', '0', '0', '1',     '0', '1'),
      ('0', '1', '0', '1',     '0', '1'),
      ('1', '1', '0', '1',     '1', '0'),
      ('0', '0', '1', '1',     '0', '1'),
      ('1', '0', '1', '1',     '1', '0'),
      ('0', '1', '1', '1',     '1', '0'),
      ('1', '1', '1', '1',     '1', '1'),
      ('0', '0', '0', '0',     '0', '1'),
      ('1', '0', '0', '0',     '1', '0'),
      ('0', '1', '0', '0',     '0', '0'),
      ('1', '1', '0', '0',     '0', '1'),
      ('0', '0', '1', '0',     '1', '0'),
      ('1', '0', '1', '0',     '1', '1'),
      ('0', '1', '1', '0',     '0', '1'),
      ('1', '1', '1', '0',     '1', '0'));

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results1 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A0_ipd, B0_ipd, BCI_ipd, CON_ipd)
                );
      Results2 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A1_ipd, B1_ipd, BC0_zd, CON_ipd)
                );
      Results3 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A2_ipd, B2_ipd, BC1_zd, CON_ipd)
                );
      Results4 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A3_ipd, B3_ipd, BC2_zd, CON_ipd)
                );
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => BCO,
       OutSignalName => "BCO",
       OutTemp => BCO_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_BCO, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_BCO, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_BCO, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_BCO, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_BCO, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_BCO, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_BCO, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_BCO, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_BCO, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_BCO, TRUE)),
       GlitchData => BCO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S0,
       OutSignalName => "S0",
       OutTemp => S0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S0, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S0, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S0, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S0, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S0, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S0, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S0, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S0, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S0, TRUE)),
       GlitchData => S0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S1,
       OutSignalName => "S1",
       OutTemp => S1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S1, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S1, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S1, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S1, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S1, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S1, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S1, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S1, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S1, TRUE)),
       GlitchData => S1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S2,
       OutSignalName => "S2",
       OutTemp => S2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S2, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S2, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S2, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S2, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S2, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S2, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S2, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S2, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S2, TRUE)),
       GlitchData => S2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S3,
       OutSignalName => "S3",
       OutTemp => S3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S3, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S3, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S3, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S3, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S3, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S3, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S3, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S3, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S3, TRUE)),
       GlitchData => S3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL FADSU4O -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity FADSU4O is
   generic(
      TimingChecksOn : Boolean := FALSE;
      XOn            : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath   : String := "FADSU4O";
      tpd_A0_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_OFL     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_OFL    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_OFL    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S0     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S1     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S2     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BCI_S3     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S0     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S1     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S2     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CON_S3     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BCI       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CON       :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0             :	in    STD_LOGIC;
      A1             :	in    STD_LOGIC;
      A2             :	in    STD_LOGIC;
      A3             :	in    STD_LOGIC;
      B0             :	in    STD_LOGIC;
      B1             :	in    STD_LOGIC;
      B2             :	in    STD_LOGIC;
      B3             :	in    STD_LOGIC;
      BCI            :	in    STD_LOGIC;
      CON            :	in    STD_LOGIC;
      OFL            :	out   STD_LOGIC;
      S0             :	out   STD_LOGIC;
      S1             :	out   STD_LOGIC;
      S2             :	out   STD_LOGIC;
      S3             :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of FADSU4O : entity is TRUE;

end FADSU4O;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FADSU4O is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd         : STD_LOGIC := 'X';
   SIGNAL A1_ipd         : STD_LOGIC := 'X';
   SIGNAL A2_ipd         : STD_LOGIC := 'X';
   SIGNAL A3_ipd         : STD_LOGIC := 'X';
   SIGNAL B0_ipd         : STD_LOGIC := 'X';
   SIGNAL B1_ipd         : STD_LOGIC := 'X';
   SIGNAL B2_ipd         : STD_LOGIC := 'X';
   SIGNAL B3_ipd         : STD_LOGIC := 'X';
   SIGNAL BCI_ipd        : STD_LOGIC := 'X';
   SIGNAL CON_ipd        : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (BCI_ipd, BCI, tipd_BCI);
   VitalWireDelay (CON_ipd, CON, tipd_CON);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, 
			    B1_ipd, B2_ipd, B3_ipd, BCI_ipd, CON_ipd)
 
   -- functionality results
   VARIABLE Results1 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results2 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results3 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results4 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results5 : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS BC0_zd     : STD_ULOGIC is Results1(1);
   ALIAS S0_zd      : STD_ULOGIC is Results1(2);
   ALIAS BC1_zd     : STD_ULOGIC is Results2(1);
   ALIAS S1_zd      : STD_ULOGIC is Results2(2);
   ALIAS BC2_zd     : STD_ULOGIC is Results3(1);
   ALIAS S2_zd      : STD_ULOGIC is Results3(2);
   ALIAS BC3_zd     : STD_ULOGIC is Results4(1);
   ALIAS S3_zd      : STD_ULOGIC is Results4(2);
   ALIAS OFL_zd     : STD_ULOGIC is Results5(1);
 
   -- output glitch detection variables
   VARIABLE OFL_GlitchData   : VitalGlitchDataType;
   VARIABLE S0_GlitchData    : VitalGlitchDataType;
   VARIABLE S1_GlitchData    : VitalGlitchDataType;
   VARIABLE S2_GlitchData    : VitalGlitchDataType;
   VARIABLE S3_GlitchData    : VitalGlitchDataType;
 
   CONSTANT ADSU_table : VitalTruthTableType := (
   --------------------------------------------
   --   A    B   BCI  CON  |   BCO   S
   --------------------------------------------
      ('0', '0', '0', '1',     '0', '0'),
      ('1', '0', '0', '1',     '0', '1'),
      ('0', '1', '0', '1',     '0', '1'),
      ('1', '1', '0', '1',     '1', '0'),
      ('0', '0', '1', '1',     '0', '1'),
      ('1', '0', '1', '1',     '1', '0'),
      ('0', '1', '1', '1',     '1', '0'),
      ('1', '1', '1', '1',     '1', '1'),
      ('0', '0', '0', '0',     '0', '1'),
      ('1', '0', '0', '0',     '1', '0'),
      ('0', '1', '0', '0',     '0', '0'),
      ('1', '1', '0', '0',     '0', '1'),
      ('0', '0', '1', '0',     '1', '0'),
      ('1', '0', '1', '0',     '1', '1'),
      ('0', '1', '1', '0',     '0', '1'),
      ('1', '1', '1', '0',     '1', '0'));

   begin

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- No Timing Checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results1 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A0_ipd, B0_ipd, BCI_ipd, CON_ipd)
                );
      Results2 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A1_ipd, B1_ipd, BC0_zd, CON_ipd)
                );
      Results3 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A2_ipd, B2_ipd, BC1_zd, CON_ipd)
                );
      Results4 := VitalTruthTable (
                TruthTable => ADSU_table,
                DataIn => (A3_ipd, B3_ipd, BC2_zd, CON_ipd)
                );
      OFL_zd := BC3_zd XOR BC2_zd;
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFL,
       OutSignalName => "OFL",
       OutTemp => OFL_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_OFL, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_OFL, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_OFL, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_OFL, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_OFL, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_OFL, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_OFL, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_OFL, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_OFL, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_OFL, TRUE)),
       GlitchData => OFL_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S0,
       OutSignalName => "S0",
       OutTemp => S0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S0, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S0, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S0, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S0, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S0, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S0, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S0, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S0, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S0, TRUE)),
       GlitchData => S0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S1,
       OutSignalName => "S1",
       OutTemp => S1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S1, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S1, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S1, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S1, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S1, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S1, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S1, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S1, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S1, TRUE)),
       GlitchData => S1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S2,
       OutSignalName => "S2",
       OutTemp => S2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S2, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S2, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S2, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S2, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S2, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S2, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S2, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S2, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S2, TRUE)),
       GlitchData => S2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S3,
       OutSignalName => "S3",
       OutTemp => S3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S3, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S3, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S3, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S3, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S3, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S3, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S3, TRUE),
		 8 => (BCI_ipd'last_event, tpd_BCI_S3, TRUE),
		 9 => (CON_ipd'last_event, tpd_CON_S3, TRUE)),
       GlitchData => S3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL SUB -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity SUB is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "SUB";
      tpd_A_BO        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_BO        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A_S         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_S         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      BI              :	in    STD_LOGIC;
      BO              :	out   STD_LOGIC;
      S               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of SUB : entity is TRUE;

end SUB;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of SUB is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A_ipd         : STD_LOGIC := 'X';
   SIGNAL B_ipd         : STD_LOGIC := 'X';
   SIGNAL BI_ipd        : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (BI_ipd, BI, tipd_BI);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, BI_ipd)
 
   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS BO_zd      : STD_ULOGIC is Results(1);
   ALIAS S_zd       : STD_ULOGIC is Results(2);
 
   -- output glitch detection variables
   VARIABLE BO_GlitchData    : VitalGlitchDataType;
   VARIABLE S_GlitchData     : VitalGlitchDataType;
 
   CONSTANT SUB_table : VitalTruthTableType := (
   --------------------------------------------
   --  A    B    BI   |   BO   S
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A_ipd, B_ipd, BI_ipd)
                );
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => BO,
       OutSignalName => "BO",
       OutTemp => BO_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_BO, TRUE),
                 1 => (B_ipd'last_event, tpd_B_BO, TRUE),
		 2 => (BI_ipd'last_event, tpd_BI_BO, TRUE)),
       GlitchData => BO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S,
       OutSignalName => "S",
       OutTemp => S_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_S, TRUE),
                 1 => (B_ipd'last_event, tpd_B_S, TRUE),
                 2 => (BI_ipd'last_event, tpd_BI_S, TRUE)),
 
       GlitchData => S_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;

end V;


--
----- CELL FSUB4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity FSUB4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "FSUB4";
      tpd_A0_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_BO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0                     :	in    STD_LOGIC;
      A1                     :	in    STD_LOGIC;
      A2                     :	in    STD_LOGIC;
      A3                     :	in    STD_LOGIC;
      B0                     :	in    STD_LOGIC;
      B1                     :	in    STD_LOGIC;
      B2                     :	in    STD_LOGIC;
      B3                     :	in    STD_LOGIC;
      BI                     :	in    STD_LOGIC;
      BO                     :	out   STD_LOGIC;
      S0                     :	out   STD_LOGIC;
      S1                     :	out   STD_LOGIC;
      S2                     :	out   STD_LOGIC;
      S3                     :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of FSUB4 : entity is TRUE;

end FSUB4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FSUB4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd         : STD_LOGIC := 'X';
   SIGNAL A1_ipd         : STD_LOGIC := 'X';
   SIGNAL A2_ipd         : STD_LOGIC := 'X';
   SIGNAL A3_ipd         : STD_LOGIC := 'X';
   SIGNAL B0_ipd         : STD_LOGIC := 'X';
   SIGNAL B1_ipd         : STD_LOGIC := 'X';
   SIGNAL B2_ipd         : STD_LOGIC := 'X';
   SIGNAL B3_ipd         : STD_LOGIC := 'X';
   SIGNAL BI_ipd         : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (BI_ipd, BI, tipd_BI);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, 
			    B1_ipd, B2_ipd, B3_ipd, BI_ipd)
 
   -- functionality results
   VARIABLE Results1 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results2 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results3 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results4 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B0_zd      : STD_ULOGIC is Results1(1);
   ALIAS S0_zd      : STD_ULOGIC is Results1(2);
   ALIAS B1_zd      : STD_ULOGIC is Results2(1);
   ALIAS S1_zd      : STD_ULOGIC is Results2(2);
   ALIAS B2_zd      : STD_ULOGIC is Results3(1);
   ALIAS S2_zd      : STD_ULOGIC is Results3(2);
   ALIAS BO_zd      : STD_ULOGIC is Results4(1);
   ALIAS S3_zd      : STD_ULOGIC is Results4(2);
 
   -- output glitch detection variables
   VARIABLE BO_GlitchData    : VitalGlitchDataType;
   VARIABLE S0_GlitchData    : VitalGlitchDataType;
   VARIABLE S1_GlitchData    : VitalGlitchDataType;
   VARIABLE S2_GlitchData    : VitalGlitchDataType;
   VARIABLE S3_GlitchData    : VitalGlitchDataType;
 
   CONSTANT SUB_table : VitalTruthTableType := (
   --------------------------------------------
   --  A    B    BI   |   BO   S
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results1 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A0_ipd, B0_ipd, BI_ipd)
                );
      Results2 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A1_ipd, B1_ipd, B0_zd)
                );
      Results3 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A2_ipd, B2_ipd, B1_zd)
                );
      Results4 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A3_ipd, B3_ipd, B2_zd)
                );
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => BO,
       OutSignalName => "BO",
       OutTemp => BO_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_BO, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_BO, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_BO, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_BO, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_BO, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_BO, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_BO, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_BO, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_BO, TRUE)),
       GlitchData => BO_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S0,
       OutSignalName => "S0",
       OutTemp => S0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S0, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S0, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S0, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S0, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S0, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S0, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S0, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S0, TRUE)),
       GlitchData => S0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S1,
       OutSignalName => "S1",
       OutTemp => S1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S1, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S1, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S1, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S1, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S1, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S1, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S1, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S1, TRUE)),
       GlitchData => S1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S2,
       OutSignalName => "S2",
       OutTemp => S2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S2, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S2, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S2, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S2, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S2, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S2, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S2, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S2, TRUE)),
       GlitchData => S2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S3,
       OutSignalName => "S3",
       OutTemp => S3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S3, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S3, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S3, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S3, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S3, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S3, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S3, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S3, TRUE)),
       GlitchData => S3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL FSUB4O -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity FSUB4O is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "FSUB4O";
      tpd_A0_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_OFL      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_S3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BI_S3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BI         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0              :	in    STD_LOGIC;
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B0              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      B3              :	in    STD_LOGIC;
      BI              :	in    STD_LOGIC;
      OFL             :	out   STD_LOGIC;
      S0              :	out   STD_LOGIC;
      S1              :	out   STD_LOGIC;
      S2              :	out   STD_LOGIC;
      S3              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of FSUB4O : entity is TRUE;

end FSUB4O;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FSUB4O is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
   SIGNAL A0_ipd         : STD_LOGIC := 'X';
   SIGNAL A1_ipd         : STD_LOGIC := 'X';
   SIGNAL A2_ipd         : STD_LOGIC := 'X';
   SIGNAL A3_ipd         : STD_LOGIC := 'X';
   SIGNAL B0_ipd         : STD_LOGIC := 'X';
   SIGNAL B1_ipd         : STD_LOGIC := 'X';
   SIGNAL B2_ipd         : STD_LOGIC := 'X';
   SIGNAL B3_ipd         : STD_LOGIC := 'X';
   SIGNAL BI_ipd         : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   VitalWireDelay (BI_ipd, BI, tipd_BI);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, A2_ipd, A3_ipd, B0_ipd, 
			    B1_ipd, B2_ipd, B3_ipd, BI_ipd)
 
   -- functionality results
   VARIABLE Results1 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results2 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results3 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results4 : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   VARIABLE Results5 : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS B0_zd      : STD_ULOGIC is Results1(1);
   ALIAS S0_zd      : STD_ULOGIC is Results1(2);
   ALIAS B1_zd      : STD_ULOGIC is Results2(1);
   ALIAS S1_zd      : STD_ULOGIC is Results2(2);
   ALIAS B2_zd      : STD_ULOGIC is Results3(1);
   ALIAS S2_zd      : STD_ULOGIC is Results3(2);
   ALIAS B3_zd      : STD_ULOGIC is Results4(1);
   ALIAS S3_zd      : STD_ULOGIC is Results4(2);
   ALIAS OFL_zd     : STD_ULOGIC is Results5(1);
 
   -- output glitch detection variables
   VARIABLE OFL_GlitchData   : VitalGlitchDataType;
   VARIABLE S0_GlitchData    : VitalGlitchDataType;
   VARIABLE S1_GlitchData    : VitalGlitchDataType;
   VARIABLE S2_GlitchData    : VitalGlitchDataType;
   VARIABLE S3_GlitchData    : VitalGlitchDataType;
 
   CONSTANT SUB_table : VitalTruthTableType := (
   --------------------------------------------
   --  A    B    BI   |   BO   S
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      Results1 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A0_ipd, B0_ipd, BI_ipd)
                );
      Results2 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A1_ipd, B1_ipd, B0_zd)
                );
      Results3 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A2_ipd, B2_ipd, B1_zd)
                );
      Results4 := VitalTruthTable (
                TruthTable => SUB_table,
                DataIn => (A3_ipd, B3_ipd, B2_zd)
                );
      OFL_zd  := B3_zd XOR B2_zd;
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFL,
       OutSignalName => "OFL",
       OutTemp => OFL_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_OFL, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_OFL, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_OFL, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_OFL, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_OFL, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_OFL, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_OFL, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_OFL, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_OFL, TRUE)),
       GlitchData => OFL_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S0,
       OutSignalName => "S0",
       OutTemp => S0_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S0, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S0, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S0, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S0, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S0, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S0, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S0, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S0, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S0, TRUE)),
       GlitchData => S0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S1,
       OutSignalName => "S1",
       OutTemp => S1_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S1, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S1, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S1, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S1, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S1, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S1, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S1, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S1, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S1, TRUE)),
       GlitchData => S1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => S2,
       OutSignalName => "S2",
       OutTemp => S2_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S2, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S2, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S2, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S2, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S2, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S2, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S2, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S2, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S2, TRUE)),
       GlitchData => S2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => S3,
       OutSignalName => "S3",
       OutTemp => S3_zd,
       Paths => (0 => (A0_ipd'last_event, tpd_A0_S3, TRUE),
                 1 => (A1_ipd'last_event, tpd_A1_S3, TRUE),
                 2 => (A2_ipd'last_event, tpd_A2_S3, TRUE),
                 3 => (A3_ipd'last_event, tpd_A3_S3, TRUE),
                 4 => (B0_ipd'last_event, tpd_B0_S3, TRUE),
                 5 => (B1_ipd'last_event, tpd_B1_S3, TRUE),
                 6 => (B2_ipd'last_event, tpd_B2_S3, TRUE),
                 7 => (B3_ipd'last_event, tpd_B3_S3, TRUE),
		 8 => (BI_ipd'last_event, tpd_BI_S3, TRUE)),
       GlitchData => S3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL INRB -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity INRB is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "INRB";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          : VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of INRB : entity is TRUE;

end INRB;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of INRB is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT A_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL INV -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity INV is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "INV";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A                              :	in    STD_LOGIC;
      Z                              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of INV : entity is TRUE;

end INV;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of INV is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT A_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL LTGT -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity LTGT is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "LTGT";
      tpd_A0_GT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_LT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_GT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_LT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_GT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B0_LT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_GT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_LT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0              :	in    STD_LOGIC;
      A1              :	in    STD_LOGIC;
      B0              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      GT              :	out    STD_LOGIC;
      LT              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of LTGT : entity is TRUE;

end LTGT;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of LTGT is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A0_ipd	 : STD_LOGIC := 'X';
   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B0_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A0_ipd, A0, tipd_A0);
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (B0_ipd, B0, tipd_B0);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A0_ipd, A1_ipd, B0_ipd, B1_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS GT_zd      : STD_ULOGIC is Results(1);
   ALIAS LT_zd      : STD_ULOGIC is Results(2);

   -- output glitch detection variables
   VARIABLE GT_GlitchData	: VitalGlitchDataType;
   VARIABLE LT_GlitchData	: VitalGlitchDataType;

   CONSTANT LTGT_table : VitalTruthTableType := (
   --------------------------------------------
   --  A0   A1   B0   B1   |   GT   LT
   --------------------------------------------
     ('0', '0', '0', '0',     '0', '0'),
     ('1', '0', '0', '0',     '1', '0'),
     ('0', '1', '0', '0',     '1', '0'),
     ('1', '1', '0', '0',     '1', '0'),
     ('0', '0', '1', '0',     '0', '1'),
     ('1', '0', '1', '0',     '0', '0'),
     ('0', '1', '1', '0',     '1', '0'),
     ('1', '1', '1', '0',     '1', '0'),
     ('0', '0', '0', '1',     '0', '1'),
     ('1', '0', '0', '1',     '0', '1'),
     ('0', '1', '0', '1',     '0', '0'),
     ('1', '1', '0', '1',     '1', '0'),
     ('0', '0', '1', '1',     '0', '1'),
     ('1', '0', '1', '1',     '0', '1'),
     ('0', '1', '1', '1',     '0', '1'),
     ('1', '1', '1', '1',     '0', '0'));

   begin

    IF (TimingChecksOn) THEN
    -----------------------------------
    -- No Timing Checks for a comb gate
    -----------------------------------
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    Results := VitalTruthTable(TruthTable => LTGT_table,
        DataIn => ( A0_ipd, A1_ipd, B0_ipd, B1_ipd));

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01(
     OutSignal => GT, 
     OutSignalName => "GT", 
     OutTemp => GT_zd,
     Paths => (0 => (A0_ipd'last_event, tpd_A0_GT, TRUE),
               1 => (B1_ipd'last_event, tpd_B1_GT, TRUE),
               2 => (B0_ipd'last_event, tpd_B0_GT, TRUE),
               3 => (A1_ipd'last_event, tpd_A1_GT, TRUE)),
        GlitchData => GT_GlitchData,
        Mode => OnDetect,
        XOn => XOn,
        MsgOn => MsgOn);

    VitalPathDelay01(
     OutSignal => LT, 
     OutSignalName => "LT", 
     OutTemp => LT_zd,
     Paths => (0 => (A0_ipd'last_event, tpd_A0_GT, TRUE),
               1 => (B1_ipd'last_event, tpd_B1_GT, TRUE),
               2 => (B0_ipd'last_event, tpd_B0_GT, TRUE),
               3 => (A1_ipd'last_event, tpd_A1_GT, TRUE)),
        GlitchData => LT_GlitchData,
        Mode => OnDetect,
        XOn => XOn,
        MsgOn => MsgOn);

end process;

end V;


--
----- CELL MUX21 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MUX21 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "MUX21";
      tpd_D0_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D1_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      D0              :	in    STD_LOGIC;
      D1              :	in    STD_LOGIC;
      SD              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of MUX21 : entity is TRUE;

end MUX21;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MUX21 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL D0_ipd	 : STD_LOGIC := 'X';
   SIGNAL D1_ipd	 : STD_LOGIC := 'X';
   SIGNAL SD_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D0_ipd, D0, tipd_D0);
   VitalWireDelay (D1_ipd, D1, tipd_D1);
   VitalWireDelay (SD_ipd, SD, tipd_SD);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, SD_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => (D1_ipd, D0_ipd),
                  dselect => (0 => SD_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (D0_ipd'last_event, tpd_D0_Z, TRUE),
                 1 => (D1_ipd'last_event, tpd_D1_Z, TRUE),
                 2 => (SD_ipd'last_event, tpd_SD_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL MUX21E -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MUX21E is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "MUX21E";
      tpd_D0_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      D0              :	in    STD_LOGIC;
      D1              :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      SD              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of MUX21E : entity is TRUE;

end MUX21E;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MUX21E is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL D0_ipd	 : STD_LOGIC := 'X';
   SIGNAL D1_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd		 : STD_LOGIC := 'X';
   SIGNAL SD_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D0_ipd, D0, tipd_D0);
   VitalWireDelay (D1_ipd, D1, tipd_D1);
   VitalWireDelay (E_ipd,  E,  tipd_E);
   VitalWireDelay (SD_ipd, SD, tipd_SD);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, E_ipd, SD_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := 
       ((SD_ipd) AND (E_ipd) AND (D1_ipd)) OR (((NOT SD_ipd)) AND (E_ipd)
         AND (D0_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (D0_ipd'last_event, tpd_D0_Z, TRUE),
                 1 => (D1_ipd'last_event, tpd_D1_Z, TRUE),
                 2 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 3 => (SD_ipd'last_event, tpd_SD_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL MUX41 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MUX41 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "MUX41";
      tpd_D0_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD1_Z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD2_Z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD1        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD2        : VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      D0              :	in    STD_LOGIC;
      D1              :	in    STD_LOGIC;
      D2              :	in    STD_LOGIC;
      D3              :	in    STD_LOGIC;
      SD1             :	in    STD_LOGIC;
      SD2             :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of MUX41 : entity is TRUE;

end MUX41;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MUX41 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL D0_ipd	 : STD_LOGIC := 'X';
   SIGNAL D1_ipd	 : STD_LOGIC := 'X';
   SIGNAL D2_ipd	 : STD_LOGIC := 'X';
   SIGNAL D3_ipd	 : STD_LOGIC := 'X';
   SIGNAL SD1_ipd	 : STD_LOGIC := 'X';
   SIGNAL SD2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D0_ipd, D0, tipd_D0);
   VitalWireDelay (D1_ipd, D1, tipd_D1);
   VitalWireDelay (D2_ipd, D2, tipd_D2);
   VitalWireDelay (D3_ipd, D3, tipd_D3);
   VitalWireDelay (SD1_ipd, SD1, tipd_SD1);
   VitalWireDelay (SD2_ipd, SD2, tipd_SD2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, D2_ipd, D3_ipd, SD1_ipd, SD2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => (D3_ipd, D2_ipd, D1_ipd, D0_ipd),
                  dselect => (SD2_ipd, SD1_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
          Paths => (0 => (D0_ipd'last_event, tpd_D0_Z, TRUE),
                 1 => (D1_ipd'last_event, tpd_D1_Z, TRUE),
                 2 => (D2_ipd'last_event, tpd_D2_Z, TRUE),
                 3 => (D3_ipd'last_event, tpd_D3_Z, TRUE),
		 4 => (SD1_ipd'last_event, tpd_SD1_Z, TRUE),
                 5 => (SD2_ipd'last_event, tpd_SD2_Z, TRUE)),

       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL MUX41E -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MUX41E is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "MUX41E";
      tpd_D0_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD1_Z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD2_Z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD1        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD2        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          : VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      D0              :	in    STD_LOGIC;
      D1              :	in    STD_LOGIC;
      D2              :	in    STD_LOGIC;
      D3              :	in    STD_LOGIC;
      SD1             :	in    STD_LOGIC;
      SD2             :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of MUX41E : entity is TRUE;

end MUX41E;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MUX41E is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL D0_ipd  : STD_LOGIC := 'X';
   SIGNAL D1_ipd  : STD_LOGIC := 'X';
   SIGNAL D2_ipd  : STD_LOGIC := 'X';
   SIGNAL D3_ipd  : STD_LOGIC := 'X';
   SIGNAL SD1_ipd : STD_LOGIC := 'X';
   SIGNAL SD2_ipd : STD_LOGIC := 'X';
   SIGNAL E_ipd   : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D0_ipd, D0, tipd_D0);
   VitalWireDelay (D1_ipd, D1, tipd_D1);
   VitalWireDelay (D2_ipd, D2, tipd_D2);
   VitalWireDelay (D3_ipd, D3, tipd_D3);
   VitalWireDelay (SD1_ipd, SD1, tipd_SD1);
   VitalWireDelay (SD2_ipd, SD2, tipd_SD2);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, D2_ipd, D3_ipd, SD1_ipd, SD2_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := 

       ((SD1_ipd) AND (E_ipd) AND ((NOT SD2_ipd)) AND (D1_ipd)) OR (((NOT
         SD1_ipd)) AND (E_ipd) AND ((NOT SD2_ipd)) AND (D0_ipd)) OR (((NOT
         SD1_ipd)) AND (E_ipd) AND (SD2_ipd) AND (D2_ipd)) OR ((SD1_ipd) AND
         (E_ipd) AND (SD2_ipd) AND (D3_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (D0_ipd'last_event, tpd_D0_Z, TRUE),
                 1 => (D1_ipd'last_event, tpd_D1_Z, TRUE),
                 2 => (D2_ipd'last_event, tpd_D2_Z, TRUE),
                 3 => (D3_ipd'last_event, tpd_D3_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (SD1_ipd'last_event, tpd_SD1_Z, TRUE),
                 6 => (SD2_ipd'last_event, tpd_SD2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL MUX81 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MUX81 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "MUX81";
      tpd_D0_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D1_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D2_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D3_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D4_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D5_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D6_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D7_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD1_Z       :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD2_Z       :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD3_Z       :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D0         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D1         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D2         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D3         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D4         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D5         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D6         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D7         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD1        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD2        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD3        :  VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      D0              :  in    STD_LOGIC;
      D1              :  in    STD_LOGIC;
      D2              :  in    STD_LOGIC;
      D3              :  in    STD_LOGIC;
      D4              :  in    STD_LOGIC;
      D5              :  in    STD_LOGIC;
      D6              :  in    STD_LOGIC;
      D7              :  in    STD_LOGIC;
      SD1             :  in    STD_LOGIC;
      SD2             :  in    STD_LOGIC;
      SD3             :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of MUX81 : entity is TRUE;

end MUX81;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MUX81 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL D0_ipd  : STD_LOGIC := 'X';
   SIGNAL D1_ipd  : STD_LOGIC := 'X';
   SIGNAL D2_ipd  : STD_LOGIC := 'X';
   SIGNAL D3_ipd  : STD_LOGIC := 'X';
   SIGNAL D4_ipd  : STD_LOGIC := 'X';
   SIGNAL D5_ipd  : STD_LOGIC := 'X';
   SIGNAL D6_ipd  : STD_LOGIC := 'X';
   SIGNAL D7_ipd  : STD_LOGIC := 'X';
   SIGNAL SD1_ipd : STD_LOGIC := 'X';
   SIGNAL SD2_ipd : STD_LOGIC := 'X';
   SIGNAL SD3_ipd : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D0_ipd, D0, tipd_D0);
   VitalWireDelay (D1_ipd, D1, tipd_D1);
   VitalWireDelay (D2_ipd, D2, tipd_D2);
   VitalWireDelay (D3_ipd, D3, tipd_D3);
   VitalWireDelay (D4_ipd, D4, tipd_D4);
   VitalWireDelay (D5_ipd, D5, tipd_D5);
   VitalWireDelay (D6_ipd, D6, tipd_D6);
   VitalWireDelay (D7_ipd, D7, tipd_D7);
   VitalWireDelay (SD1_ipd, SD1, tipd_SD1);
   VitalWireDelay (SD2_ipd, SD2, tipd_SD2);
   VitalWireDelay (SD3_ipd, SD3, tipd_SD3);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, D2_ipd, D3_ipd, D4_ipd, D5_ipd, D6_ipd, D7_ipd, SD1_ipd, SD2_ipd, SD3_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => (D7_ipd, D6_ipd, D5_ipd, D4_ipd, D3_ipd, D2_ipd, D1_ipd, D0_ipd),
                  dselect => (SD3_ipd, SD2_ipd, SD1_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (D0_ipd'last_event, tpd_D0_Z, TRUE),
                 1 => (D1_ipd'last_event, tpd_D1_Z, TRUE),
                 2 => (D2_ipd'last_event, tpd_D2_Z, TRUE),
                 3 => (D3_ipd'last_event, tpd_D3_Z, TRUE),
                 4 => (D4_ipd'last_event, tpd_D4_Z, TRUE),
                 5 => (D5_ipd'last_event, tpd_D5_Z, TRUE),
                 6 => (D6_ipd'last_event, tpd_D6_Z, TRUE),
                 7 => (D7_ipd'last_event, tpd_D7_Z, TRUE),
                 8 => (SD1_ipd'last_event, tpd_SD1_Z, TRUE),
                 9 => (SD2_ipd'last_event, tpd_SD2_Z, TRUE),
		 10 => (SD3_ipd'last_event, tpd_SD3_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL MUX81E -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity MUX81E is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "MUX81E";
      tpd_D0_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D4_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D5_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D6_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D7_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD1_Z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD2_Z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SD3_Z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D4         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D5         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D6         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D7         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD1        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD2        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD3        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          : VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      D0              :  in    STD_LOGIC;
      D1              :  in    STD_LOGIC;
      D2              :  in    STD_LOGIC;
      D3              :  in    STD_LOGIC;
      D4              :  in    STD_LOGIC;
      D5              :  in    STD_LOGIC;
      D6              :  in    STD_LOGIC;
      D7              :  in    STD_LOGIC;
      SD1             :  in    STD_LOGIC;
      SD2             :  in    STD_LOGIC;
      SD3             :  in    STD_LOGIC;
      E               :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);

   attribute VITAL_LEVEL0 of MUX81E : entity is TRUE;

end MUX81E;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of MUX81E is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL D0_ipd  : STD_LOGIC := 'X';
   SIGNAL D1_ipd  : STD_LOGIC := 'X';
   SIGNAL D2_ipd  : STD_LOGIC := 'X';
   SIGNAL D3_ipd  : STD_LOGIC := 'X';
   SIGNAL D4_ipd  : STD_LOGIC := 'X';
   SIGNAL D5_ipd  : STD_LOGIC := 'X';
   SIGNAL D6_ipd  : STD_LOGIC := 'X';
   SIGNAL D7_ipd  : STD_LOGIC := 'X';
   SIGNAL SD1_ipd : STD_LOGIC := 'X';
   SIGNAL SD2_ipd : STD_LOGIC := 'X';
   SIGNAL SD3_ipd : STD_LOGIC := 'X';
   SIGNAL E_ipd	  : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D0_ipd, D0, tipd_D0);
   VitalWireDelay (D1_ipd, D1, tipd_D1);
   VitalWireDelay (D2_ipd, D2, tipd_D2);
   VitalWireDelay (D3_ipd, D3, tipd_D3);
   VitalWireDelay (D4_ipd, D4, tipd_D4);
   VitalWireDelay (D5_ipd, D5, tipd_D5);
   VitalWireDelay (D6_ipd, D6, tipd_D6);
   VitalWireDelay (D7_ipd, D7, tipd_D7);
   VitalWireDelay (SD1_ipd, SD1, tipd_SD1);
   VitalWireDelay (SD2_ipd, SD2, tipd_SD2);
   VitalWireDelay (SD3_ipd, SD3, tipd_SD3);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D0_ipd, D1_ipd, D2_ipd, D3_ipd, D4_ipd, D5_ipd, D6_ipd, D7_ipd, SD1_ipd, SD2_ipd, SD3_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := 
       ((SD1_ipd) AND (E_ipd) AND ((NOT SD2_ipd)) AND ((NOT SD3_ipd)) AND
         (D1_ipd)) OR (((NOT SD1_ipd)) AND (E_ipd) AND ((NOT SD2_ipd)) AND
         ((NOT SD3_ipd)) AND (D0_ipd)) OR (((NOT SD1_ipd)) AND (E_ipd) AND
         (SD2_ipd) AND ((NOT SD3_ipd)) AND (D2_ipd)) OR ((SD1_ipd) AND
         (E_ipd) AND (SD2_ipd) AND ((NOT SD3_ipd)) AND (D3_ipd)) OR (((NOT
         SD1_ipd)) AND (E_ipd) AND ((NOT SD2_ipd)) AND (SD3_ipd) AND
         (D4_ipd)) OR ((SD1_ipd) AND (E_ipd) AND ((NOT SD2_ipd)) AND
         (SD3_ipd) AND (D5_ipd)) OR (((NOT SD1_ipd)) AND (E_ipd) AND
         (SD2_ipd) AND (SD3_ipd) AND (D6_ipd)) OR ((SD1_ipd) AND (E_ipd) AND
         (SD2_ipd) AND (SD3_ipd) AND (D7_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (D0_ipd'last_event, tpd_D0_Z, TRUE),
                 1 => (D1_ipd'last_event, tpd_D1_Z, TRUE),
                 2 => (D2_ipd'last_event, tpd_D2_Z, TRUE),
                 3 => (D3_ipd'last_event, tpd_D3_Z, TRUE),
                 4 => (D4_ipd'last_event, tpd_D4_Z, TRUE),
                 5 => (D5_ipd'last_event, tpd_D5_Z, TRUE),
                 6 => (D6_ipd'last_event, tpd_D6_Z, TRUE),
                 7 => (D7_ipd'last_event, tpd_D7_Z, TRUE),
                 8 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 9 => (SD1_ipd'last_event, tpd_SD1_Z, TRUE),
                 10 => (SD2_ipd'last_event, tpd_SD2_Z, TRUE),
		 11 => (SD3_ipd'last_event, tpd_SD3_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND2 : entity is TRUE;

end ND2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND (A_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND2B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND2B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND2B1";
      tpd_A_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND2B1 : entity is TRUE;

end ND2B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND2B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) AND (A_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND2B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND2B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND2B2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND2B2 : entity is TRUE;

end ND2B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND2B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	: STD_LOGIC := 'X';
   SIGNAL B_ipd	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) AND ((NOT A_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND3 : entity is TRUE;

end ND3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	: STD_LOGIC := 'X';
   SIGNAL B_ipd	: STD_LOGIC := 'X';
   SIGNAL C_ipd	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND (A_ipd) AND (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND3B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND3B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND3B1";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND3B1 : entity is TRUE;

end ND3B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND3B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	: STD_LOGIC := 'X';
   SIGNAL B_ipd	: STD_LOGIC := 'X';
   SIGNAL C_ipd	: STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND (A_ipd) AND (( NOT C_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND3B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND3B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND3B2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND3B2 : entity is TRUE;

end ND3B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND3B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) AND (A_ipd) AND ((NOT C_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND3B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND3B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND3B3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND3B3 : entity is TRUE;

end ND3B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND3B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) AND ((NOT A_ipd)) AND ((NOT C_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND4";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND4 : entity is TRUE;

end ND4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND (A_ipd) AND (C_ipd) AND (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND4B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND4B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND4B1";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND4B1 : entity is TRUE;

end ND4B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND4B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND (A_ipd) AND (C_ipd) AND ((NOT D_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND4B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND4B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND4B2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND4B2 : entity is TRUE;

end ND4B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND4B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := 
	(NOT ((B_ipd) AND (A_ipd) AND ((NOT C_ipd)) AND ((NOT D_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND4B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND4B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND4B3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND4B3 : entity is TRUE;

end ND4B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND4B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := 
       (NOT (((NOT B_ipd)) AND (A_ipd) AND ((NOT C_ipd)) AND ((NOT D_ipd))));


      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND4B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND4B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND4B4";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND4B4 : entity is TRUE;

end ND4B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND4B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := 
       (NOT (((NOT B_ipd)) AND ((NOT A_ipd)) AND ((NOT C_ipd)) AND ((NOT
         D_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND5 : entity is TRUE;

end ND5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND (A_ipd) AND (C_ipd) AND (D_ipd) AND (E_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND5B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND5B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND5B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND5B1 : entity is TRUE;

end ND5B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND5B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND (A_ipd) AND (C_ipd) AND (D_ipd) AND ((NOT E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND5B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND5B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND5B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND5B2 : entity is TRUE;

end ND5B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND5B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND (A_ipd) AND (C_ipd) AND ((NOT D_ipd)) AND ((NOT
         E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND5B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND5B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND5B3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND5B3 : entity is TRUE;

end ND5B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND5B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND (A_ipd) AND ((NOT C_ipd)) AND ((NOT D_ipd)) AND
         ((NOT E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND5B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND5B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND5B4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND5B4 : entity is TRUE;

end ND5B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND5B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((NOT B_ipd)) AND (A_ipd) AND ((NOT C_ipd)) AND ((NOT D_ipd))
         AND ((NOT E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


----- CELL ND5B5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND5B5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND5B5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND5B5 : entity is TRUE;

end ND5B5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND5B5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((NOT B_ipd)) AND ((NOT A_ipd)) AND ((NOT C_ipd)) AND ((NOT
         D_ipd)) AND ((NOT E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL ND6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ND6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "ND6";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_F_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_F          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      F               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of ND6 : entity is TRUE;

end ND6;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ND6 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';
   SIGNAL F_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (F_ipd, F, tipd_F);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND (A_ipd) AND (C_ipd) AND (D_ipd) AND (E_ipd) AND
         (F_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR2 : entity is TRUE;

end NR2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) OR (A_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR2B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR2B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR2B1";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR2B1 : entity is TRUE;

end NR2B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR2B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) OR (A_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR2B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR2B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR2B2";
      tpd_A_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR2B2 : entity is TRUE;

end NR2B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR2B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) OR ((NOT A_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR3 : entity is TRUE;

end NR3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) OR (A_ipd) OR (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR3B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR3B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR3B1";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR3B1 : entity is TRUE;

end NR3B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR3B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) OR (A_ipd) OR ((NOT C_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR3B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR3B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR3B2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR3B2 : entity is TRUE;

end NR3B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR3B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) OR (A_ipd) OR ((NOT C_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR3B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR3B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR3B3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR3B3 : entity is TRUE;

end NR3B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR3B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((NOT B_ipd)) OR ((NOT A_ipd)) OR ((NOT C_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR4";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR4 : entity is TRUE;

end NR4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR4B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR4B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR4B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR4B1 : entity is TRUE;

end NR4B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR4B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) OR (A_ipd) OR (C_ipd) OR ((NOT D_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR4B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR4B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR4B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR4B2 : entity is TRUE;

end NR4B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR4B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR4B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR4B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR4B3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR4B3 : entity is TRUE;

end NR4B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR4B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((NOT B_ipd)) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR4B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR4B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR4B4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR4B4 : entity is TRUE;

end NR4B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR4B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((NOT B_ipd)) OR ((NOT A_ipd)) OR ((NOT C_ipd)) OR ((NOT
         D_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR5 : entity is TRUE;

end NR5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd) OR (E_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


----- CELL NR5B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR5B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR5B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR5B1 : entity is TRUE;

end NR5B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR5B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd) OR ((NOT E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR5B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR5B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR5B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR5B2 : entity is TRUE;

end NR5B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR5B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) OR (A_ipd) OR (C_ipd) OR ((NOT D_ipd)) OR ((NOT
         E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL NR5B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR5B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR5B3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR5B3 : entity is TRUE;

end NR5B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR5B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd)) OR ((NOT
         E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


----- CELL NR5B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR5B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR5B4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR5B4 : entity is TRUE;

end NR5B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR5B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((NOT B_ipd)) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd)) OR
         ((NOT E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


----- CELL NR5B5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR5B5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR5B5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR5B5 : entity is TRUE;

end NR5B5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR5B5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((NOT B_ipd)) OR ((NOT A_ipd)) OR ((NOT C_ipd)) OR ((NOT
         D_ipd)) OR ((NOT E_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;

--
----- CELL NR6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity NR6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "NR6";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_F_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_F          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      F               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of NR6 : entity is TRUE;

end NR6;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of NR6 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';
   SIGNAL F_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (F_ipd, F, tipd_F);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd) OR (E_ipd) OR
         (F_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI21 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI21 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI21";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI21 : entity is TRUE;

end OAI21;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI21 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (A1_ipd'last_event, tpd_A1_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI211 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI211 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI211";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI211 : entity is TRUE;

end OAI211;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI211 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd)) AND (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 3 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI2111 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI2111 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI2111";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI2111 : entity is TRUE;

end OAI2111;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI2111 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd)) AND (C_ipd) AND (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 3 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 4 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI22 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI22 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI22";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI22 : entity is TRUE;

end OAI22;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI22 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT (((B2_ipd) OR (B1_ipd)) AND ((A2_ipd) OR (A1_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A1_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI221 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI221 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI221";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI221 : entity is TRUE;

end OAI221;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI221 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) OR (B1_ipd)) AND ((A2_ipd) OR (A1_ipd)) AND (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 4 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI2211 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI2211 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI2211";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI2211 : entity is TRUE;

end OAI2211;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI2211 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) OR (B1_ipd)) AND ((A2_ipd) OR (A1_ipd)) AND (C_ipd)
         AND (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 4 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 5 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI222 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI222 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI222";
      tpd_A1_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C1_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C2_Z        :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C1              :	in    STD_LOGIC;
      C2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI222 : entity is TRUE;

end OAI222;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI222 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL C1_ipd	 : STD_LOGIC := 'X';
   SIGNAL C2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C1_ipd, C1, tipd_C1);
   VitalWireDelay (C2_ipd, C2, tipd_C2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, B1_ipd, B2_ipd, C1_ipd, C2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) OR (B1_ipd)) AND ((A2_ipd) OR (A1_ipd)) AND ((C2_ipd)
         OR (C1_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 3 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 4 => (C1_ipd'last_event, tpd_C1_Z, TRUE),
                 5 => (C2_ipd'last_event, tpd_C2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI31 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI31 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI31";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI31 : entity is TRUE;

end OAI31;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI31 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI311 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI311 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI311";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI311 : entity is TRUE;

end OAI311;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI311 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd)) AND (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 4 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI3111 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI3111 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI3111";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI3111 : entity is TRUE;

end OAI3111;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI3111 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd)) AND (C_ipd) AND
         (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 4 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 5 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI32 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI32 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI32";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI32 : entity is TRUE;

end OAI32;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI32 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B1_ipd, B2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) OR (B1_ipd)) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A3_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 4 => (B2_ipd'last_event, tpd_B2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI321 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI321 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI321";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI321 : entity is TRUE;

end OAI321;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI321 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL B1_ipd : STD_LOGIC := 'X';
   SIGNAL B2_ipd : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B1_ipd, B2_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) OR (B1_ipd)) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd))
         AND (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 4 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 5 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI33 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI33 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI33";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B3         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      B3              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI33 : entity is TRUE;

end OAI33;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI33 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';
   SIGNAL B3_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   VitalWireDelay (B3_ipd, B3, tipd_B3);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, B1_ipd, B2_ipd, B3_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) OR (B1_ipd) OR (B3_ipd)) AND ((A2_ipd) OR (A1_ipd) OR
         (A3_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 4 => (B2_ipd'last_event, tpd_B2_Z, TRUE),
                 5 => (B3_ipd'last_event, tpd_B3_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI41 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI41 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI41";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A4_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A4         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      A4              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI41 : entity is TRUE;

end OAI41;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI41 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd : STD_LOGIC := 'X';
   SIGNAL A2_ipd : STD_LOGIC := 'X';
   SIGNAL A3_ipd : STD_LOGIC := 'X';
   SIGNAL A4_ipd : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (A4_ipd, A4, tipd_A4);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, A4_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd) OR (A4_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (A4_ipd'last_event, tpd_A4_Z, TRUE),
                 4 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI411 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI411 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI411";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A4_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A4         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      A4              :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI411 : entity is TRUE;

end OAI411;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI411 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL A4_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (A4_ipd, A4, tipd_A4);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, A4_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd) OR (A4_ipd)) AND
         (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (A4_ipd'last_event, tpd_A4_Z, TRUE),
                 4 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 5 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OAI42 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OAI42 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OAI42";
      tpd_A1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A4_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B1_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B2_Z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A4         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B2         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      A4              :	in    STD_LOGIC;
      B1              :	in    STD_LOGIC;
      B2              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OAI42 : entity is TRUE;

end OAI42;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OAI42 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A1_ipd	 : STD_LOGIC := 'X';
   SIGNAL A2_ipd	 : STD_LOGIC := 'X';
   SIGNAL A3_ipd	 : STD_LOGIC := 'X';
   SIGNAL A4_ipd	 : STD_LOGIC := 'X';
   SIGNAL B1_ipd	 : STD_LOGIC := 'X';
   SIGNAL B2_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A1_ipd, A1, tipd_A1);
   VitalWireDelay (A2_ipd, A2, tipd_A2);
   VitalWireDelay (A3_ipd, A3, tipd_A3);
   VitalWireDelay (A4_ipd, A4, tipd_A4);
   VitalWireDelay (B1_ipd, B1, tipd_B1);
   VitalWireDelay (B2_ipd, B2, tipd_B2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A1_ipd, A2_ipd, A3_ipd, A4_ipd, B1_ipd, B2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT (((B2_ipd) OR (B1_ipd)) AND ((A2_ipd) OR (A1_ipd) OR (A3_ipd) OR
         (A4_ipd))));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A1_ipd'last_event, tpd_A1_Z, TRUE),
                 1 => (A2_ipd'last_event, tpd_A2_Z, TRUE),
                 2 => (A3_ipd'last_event, tpd_A3_Z, TRUE),
                 3 => (A4_ipd'last_event, tpd_A4_Z, TRUE),
                 4 => (B1_ipd'last_event, tpd_B1_Z, TRUE),
                 5 => (B2_ipd'last_event, tpd_B2_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR2 : entity is TRUE;

end OR2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR2B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR2B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR2B1";
      tpd_A_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR2B1 : entity is TRUE;

end OR2B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR2B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := ((NOT B_ipd)) OR (A_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR2B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR2B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR2B2";
      tpd_A_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR2B2 : entity is TRUE;

end OR2B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR2B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := ((NOT B_ipd) OR (NOT A_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR3 : entity is TRUE;

end OR3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd) OR (C_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR3B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR3B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR3B1";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR3B1 : entity is TRUE;

end OR3B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR3B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd) OR ((NOT C_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR3B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR3B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR3B2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR3B2 : entity is TRUE;

end OR3B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR3B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := ((NOT B_ipd)) OR (A_ipd) OR ((NOT C_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR3B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR3B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR3B3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR3B3 : entity is TRUE;

end OR3B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR3B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := ((NOT B_ipd)) OR ((NOT A_ipd)) OR ((NOT C_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR4";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR4 : entity is TRUE;

end OR4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR4B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR4B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR4B1";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR4B1 : entity is TRUE;

end OR4B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR4B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd) OR (C_ipd) OR ((NOT D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR4B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR4B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR4B2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR4B2 : entity is TRUE;

end OR4B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR4B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR4B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR4B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR4B3";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR4B3 : entity is TRUE;

end OR4B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR4B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := ((NOT B_ipd)) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR4B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR4B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR4B4";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR4B4 : entity is TRUE;

end OR4B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR4B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := ((NOT B_ipd)) OR (NOT (A_ipd)) OR ((NOT C_ipd)) OR ((NOT D_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR5 : entity is TRUE;

end OR5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd) OR (E_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR5B1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR5B1 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR5B1";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR5B1 : entity is TRUE;

end OR5B1;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR5B1 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd) OR ((NOT E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR5B2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR5B2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR5B2";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR5B2 : entity is TRUE;

end OR5B2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR5B2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (B_ipd) OR (A_ipd) OR (C_ipd) OR ((NOT D_ipd)) OR ((NOT E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR5B3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR5B3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR5B3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR5B3 : entity is TRUE;

end OR5B3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR5B3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (B_ipd) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd)) OR ((NOT E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR5B4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR5B4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR5B4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR5B4 : entity is TRUE;

end OR5B4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR5B4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       ((NOT B_ipd)) OR (A_ipd) OR ((NOT C_ipd)) OR ((NOT D_ipd)) OR ((NOT
         E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR5B5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR5B5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR5B5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR5B5 : entity is TRUE;

end OR5B5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR5B5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       ((NOT B_ipd)) OR ((NOT A_ipd)) OR ((NOT C_ipd)) OR ((NOT D_ipd)) OR
         ((NOT E_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OR6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity OR6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OR6";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_F_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_F          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      F               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of OR6 : entity is TRUE;

end OR6;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of OR6 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';
   SIGNAL F_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (F_ipd, F, tipd_F);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (B_ipd) OR (A_ipd) OR (C_ipd) OR (D_ipd) OR (E_ipd) OR (F_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL OSCIL -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
 
-- entity declaration --
entity OSCIL is
    generic (
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
        MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "OSCIL";
        tpd_TEST_OSC    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_TEST       : VitalDelayType01 := (0.1 ns, 0.1 ns)) ;
 
    port (
        TEST : in STD_LOGIC;
        OSC  : out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of OSCIL : entity is TRUE;
 
end OSCIL ;
 
-- architecture body --
architecture V of OSCIL is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
    signal TEST_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WIREDELAY : block
   begin
   VitalWireDelay(TEST_ipd, TEST, tipd_TEST);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (TEST_ipd)
 
   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS OSC_zd     : STD_ULOGIC is Results(1);
 
   -- output glitch detection variables
   VARIABLE OSC_GlitchData     : VitalGlitchDataType;
 
   begin
 
   IF (TimingChecksOn) THEN
    -----------------------------------
    -- No Timing Checks for a comb gate
    -----------------------------------
   END IF;
 
   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   OSC_zd := VitalBUF(TEST_ipd);
 
   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => OSC,
     OutSignalName => "OSC",
     OutTemp => OSC_zd,
     Paths => (0 => (InputChangeTime => TEST_ipd'LAST_EVENT, 
                     PathDelay => tpd_TEST_OSC, 
                     PathCondition => TRUE)),
     GlitchData => OSC_GlitchData,
     Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
   end process;
 
end V;
 
 

--
----- CELL PFUMX -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity PFUMX is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "PFUMX";
      tpd_C0_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ALUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BLUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ALUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BLUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C0         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      ALUT            :	in    STD_LOGIC;
      BLUT            :	in    STD_LOGIC;
      C0              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of PFUMX : entity is TRUE;

end PFUMX;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of PFUMX is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL ALUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL BLUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL C0_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (ALUT_ipd, ALUT, tipd_ALUT);
   VitalWireDelay (BLUT_ipd, BLUT, tipd_BLUT);
   VitalWireDelay (C0_ipd, C0, tipd_C0);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (ALUT_ipd, BLUT_ipd, C0_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => (ALUT_ipd, BLUT_ipd),
                  dselect => (0 => C0_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (C0_ipd'last_event, tpd_C0_Z, TRUE),
                 1 => (ALUT_ipd'last_event, tpd_ALUT_Z, TRUE),
                 2 => (BLUT_ipd'last_event, tpd_BLUT_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL PFUND -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity PFUND is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "PFUND";
      tpd_ALUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BLUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C0_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ALUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BLUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C0         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      ALUT            :	in    STD_LOGIC;
      BLUT            :	in    STD_LOGIC;
      C0              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of PFUND : entity is TRUE;

end PFUND;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of PFUND is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL ALUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL BLUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL C0_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (ALUT_ipd, ALUT, tipd_ALUT);
   VitalWireDelay (BLUT_ipd, BLUT, tipd_BLUT);
   VitalWireDelay (C0_ipd, C0, tipd_C0);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (ALUT_ipd, BLUT_ipd, C0_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((BLUT_ipd) AND (ALUT_ipd) AND (C0_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (ALUT_ipd'last_event, tpd_ALUT_Z, TRUE),
                 1 => (BLUT_ipd'last_event, tpd_BLUT_Z, TRUE),
                 2 => (C0_ipd'last_event, tpd_C0_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


----- CELL PFUND0 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity PFUND0 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "PFUND0";
      tpd_ALUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BLUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ALUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BLUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      ALUT            :	in    STD_LOGIC;
      BLUT            :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of PFUND0 : entity is TRUE;

end PFUND0;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of PFUND0 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL ALUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL BLUT_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (ALUT_ipd, ALUT, tipd_ALUT);
   VitalWireDelay (BLUT_ipd, BLUT, tipd_BLUT);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (ALUT_ipd, BLUT_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((BLUT_ipd) AND (ALUT_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (ALUT_ipd'last_event, tpd_ALUT_Z, TRUE),
                 1 => (BLUT_ipd'last_event, tpd_BLUT_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


----- CELL PFUXR -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity PFUXR is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "PFUXR";
      tpd_ALUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BLUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C0_Z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ALUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BLUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C0         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      ALUT            :	in    STD_LOGIC;
      BLUT            :	in    STD_LOGIC;
      C0              :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of PFUXR : entity is TRUE;

end PFUXR;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of PFUXR is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL ALUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL BLUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL C0_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (ALUT_ipd, ALUT, tipd_ALUT);
   VitalWireDelay (BLUT_ipd, BLUT, tipd_BLUT);
   VitalWireDelay (C0_ipd, C0, tipd_C0);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (ALUT_ipd, BLUT_ipd, C0_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (BLUT_ipd) XOR (ALUT_ipd) XOR (C0_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (ALUT_ipd'last_event, tpd_ALUT_Z, TRUE),
                 1 => (BLUT_ipd'last_event, tpd_BLUT_Z, TRUE),
                 2 => (C0_ipd'last_event, tpd_C0_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL PFUXR0 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity PFUXR0 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "PFUXR0";
      tpd_ALUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_BLUT_Z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ALUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_BLUT       :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      ALUT            :	in    STD_LOGIC;
      BLUT            :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of PFUXR0 : entity is TRUE;

end PFUXR0;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of PFUXR0 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL ALUT_ipd	 : STD_LOGIC := 'X';
   SIGNAL BLUT_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (ALUT_ipd, ALUT, tipd_ALUT);
   VitalWireDelay (BLUT_ipd, BLUT, tipd_BLUT);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (ALUT_ipd, BLUT_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (BLUT_ipd) XOR (ALUT_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (ALUT_ipd'last_event, tpd_ALUT_Z, TRUE),
                 1 => (BLUT_ipd'last_event, tpd_BLUT_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL READBK -----
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.VITAL_TIMING.all;
USE IEEE.VITAL_PRIMITIVES.all;
 
 
-- entity declaration --
entity READBK IS
   generic (
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := FALSE;
      InstancePath       : String  := "READBK");
 
   port(
      rdcfgn             : in STD_LOGIC;
      capt               : in STD_LOGIC;
      prddata            : out STD_LOGIC;
      rdbo               : out STD_LOGIC);
 
    attribute Vital_Level0 of READBK : entity IS TRUE;
 
end READBK ;
 
-- architecture body --
architecture V of READBK IS
    attribute Vital_Level0 of V : architecture IS TRUE;
 
begin
 
end V;


--
----- CELL STRTUP -----
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.VITAL_TIMING.all;
USE IEEE.VITAL_PRIMITIVES.all;
 
 
-- entity declaration --
entity STRTUP IS
   generic (
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := FALSE;
      InstancePath       : String  := "STRTUP");
 
   port(
      uclk               : in STD_LOGIC);
 
    attribute Vital_Level0 of STRTUP : entity IS TRUE;
 
end STRTUP ;
 
-- architecture body --
architecture V of STRTUP IS
    attribute Vital_Level0 of V : architecture IS TRUE;
 
begin
 
end V;


--
----- CELL VHI -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity VHI is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "VHI");

   port(
      Z               :	out   STD_LOGIC := '1');

   attribute VITAL_LEVEL0 of VHI : entity is TRUE;

end VHI;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of VHI is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

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
   Z <= '1';



end V;


--
----- CELL VLO -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity VLO is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "VLO");

   port(
      Z               :	out   STD_LOGIC := '0');

   attribute VITAL_LEVEL0 of VLO : entity is TRUE;

end VLO;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of VLO is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

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
   Z <= '0';



end V;


--
----- CELL XNOR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XNOR2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XNOR2";
      tpd_A_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XNOR2 : entity is TRUE;

end XNOR2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XNOR2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) XOR (A_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL XNOR3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XNOR3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XNOR3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XNOR3 : entity is TRUE;

end XNOR3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XNOR3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) XOR (A_ipd) XOR (C_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL XNOR4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XNOR4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XNOR4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XNOR4 : entity is TRUE;

end XNOR4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XNOR4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (NOT ((B_ipd) XOR (A_ipd) XOR (C_ipd) XOR (D_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;

--
----- CELL XNOR5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XNOR5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XNOR5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XNOR5 : entity is TRUE;

end XNOR5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XNOR5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) XOR (A_ipd) XOR (C_ipd) XOR (D_ipd) XOR (E_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL XNOR6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XNOR6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XNOR6";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_F_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_F          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      F               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XNOR6 : entity is TRUE;

end XNOR6;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XNOR6 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';
   SIGNAL F_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (F_ipd, F, tipd_F);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (NOT ((B_ipd) XOR (A_ipd) XOR (C_ipd) XOR (D_ipd) XOR (E_ipd) XOR
         (F_ipd)));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;

--
----- CELL XOR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XOR2 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XOR2";
      tpd_A_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XOR2 : entity is TRUE;

end XOR2;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XOR2 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) XOR (A_ipd);
       
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL XOR3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XOR3 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XOR3";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XOR3 : entity is TRUE;

end XOR3;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XOR3 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) XOR (A_ipd) XOR (C_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL XOR4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XOR4 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XOR4";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XOR4 : entity is TRUE;

end XOR4;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XOR4 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) XOR (A_ipd) XOR (C_ipd) XOR (D_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL XOR5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XOR5 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XOR5";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XOR5 : entity is TRUE;

end XOR5;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XOR5 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := (B_ipd) XOR (A_ipd) XOR (C_ipd) XOR (D_ipd) XOR (E_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL XOR6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;


-- entity declaration --
entity XOR6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "XOR6";
      tpd_A_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_B_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_C_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_D_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_E_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_F_Z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_C          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_E          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_F          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A               :	in    STD_LOGIC;
      B               :	in    STD_LOGIC;
      C               :	in    STD_LOGIC;
      D               :	in    STD_LOGIC;
      E               :	in    STD_LOGIC;
      F               :	in    STD_LOGIC;
      Z               :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of XOR6 : entity is TRUE;

end XOR6;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of XOR6 is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_LOGIC := 'X';
   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL C_ipd	 : STD_LOGIC := 'X';
   SIGNAL D_ipd	 : STD_LOGIC := 'X';
   SIGNAL E_ipd	 : STD_LOGIC := 'X';
   SIGNAL F_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (A_ipd, A, tipd_A);
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (C_ipd, C, tipd_C);
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (E_ipd, E, tipd_E);
   VitalWireDelay (F_ipd, F, tipd_F);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd :=
       (B_ipd) XOR (A_ipd) XOR (C_ipd) XOR (D_ipd) XOR (E_ipd) XOR (F_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE)),
       GlitchData => Z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;

end V;


--
----- CELL FAC4P3D -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library ORCA2;
use ORCA2.ORCACOMP.all;

-- entity declaration --
entity FAC4P3D is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "FAC4P3D";
      tpd_A0_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A0_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A1_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A2_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_A3_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CI_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CK_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CK_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CK_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CK_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CK_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_CO       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A0         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A1         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A2         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_A3         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CI         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD         :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      A0              :	in    STD_LOGIC;
      A1              :	in    STD_LOGIC;
      A2              :	in    STD_LOGIC;
      A3              :	in    STD_LOGIC;
      CI              :	in    STD_LOGIC;
      SP              :	in    STD_LOGIC;
      CK              :	in    STD_LOGIC;
      CD              :	in    STD_LOGIC;
      CO              :	out   STD_LOGIC;
      Q0              :	out   STD_LOGIC;
      Q1              :	out   STD_LOGIC;
      Q2              :	out   STD_LOGIC;
      Q3              :	out   STD_LOGIC);

   attribute VITAL_LEVEL0 of FAC4P3D : entity is TRUE;

end FAC4P3D;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FAC4P3D is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   component AND2
     port(
      A               :  in    STD_LOGIC;
      B               :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);
   end component;

   component OR3
     port(
      A               :  in    STD_LOGIC;
      B               :  in    STD_LOGIC;
      C               :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);
   end component;

   component FD1P3DX
     port(
        D             : in STD_LOGIC;
        SP            : in STD_LOGIC;
        CD            : in STD_LOGIC;
        CK            : in STD_LOGIC;
        Q             : out STD_LOGIC;
        QN            : out STD_LOGIC);
   end component;

   component XOR3
     port(
      A               :  in    STD_LOGIC;
      B               :  in    STD_LOGIC;
      C               :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);
   end component;
 
   SIGNAL Q0_1, Q1_1, Q2_1, Q3_1, I3, I4, I5, I6, I7, I15, I16, I17, 
      I18, I19, I28, I29, I30, I31, I32, I41, I42, 
      I43, I45: STD_LOGIC := 'X';

begin

   INST10: AND2 port map (A=>CI, B=>Q0_1, Z=>I3);
   INST11: AND2 port map (A=>A0, B=>CI, Z=>I4);
   INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
   INST13: XOR3 port map (A=>A0, B=>Q0_1, C=>CI, Z=>I7);
   INST2: AND2 port map (A=>Q0_1, B=>A0, Z=>I5);
   INST22: AND2 port map (A=>Q1_1, B=>A1, Z=>I17);
   INST23: AND2 port map (A=>I6, B=>Q1_1, Z=>I15);
   INST24: AND2 port map (A=>A1, B=>I6, Z=>I16);
   INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
   INST26: XOR3 port map (A=>A1, B=>Q1_1, C=>I6, Z=>I19);
   INST35: AND2 port map (A=>Q2_1, B=>A2, Z=>I30);
   INST36: AND2 port map (A=>I18, B=>Q2_1, Z=>I28);
   INST37: AND2 port map (A=>A2, B=>I18, Z=>I29);
   INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
   INST39: XOR3 port map (A=>A2, B=>Q2_1, C=>I18, Z=>I32);
   INST48: AND2 port map (A=>Q3_1, B=>A3, Z=>I43);
   INST49: AND2 port map (A=>I31, B=>Q3_1, Z=>I41);
   INST50: AND2 port map (A=>A3, B=>I31, Z=>I42);
   INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
   INST52: XOR3 port map (A=>A3, B=>Q3_1, C=>I31, Z=>I45);
   INST68: FD1P3DX port map (D=>I45, SP=>SP, CK=>CK, CD=>CD, 
				Q=>Q3_1, QN=>open);
   INST69: FD1P3DX port map (D=>I32, SP=>SP, CK=>CK, CD=>CD, 
				Q=>Q2_1, QN=>open);
   INST70: FD1P3DX port map (D=>I19, SP=>SP, CK=>CK, CD=>CD, 
				Q=>Q1_1, QN=>open);
   INST71: FD1P3DX port map (D=>I7, SP=>SP, CK=>CK, CD=>CD, 
				Q=>Q0_1, QN=>open);
   Q0 <= Q0_1;
   Q1 <= Q1_1;
   Q2 <= Q2_1;
   Q3 <= Q3_1;

end V;

library ORCA2;
configuration FAC4P3DC of FAC4P3D is
   for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: FD1P3DX use entity ORCA2.FD1P3DX(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
   end for;
end FAC4P3DC;


--
----- CELL FMULT4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_timing.all;
library ORCA2;
use ORCA2.ORCACOMP.all;


-- entity declaration --
entity FMULT4 is
   generic (
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      InstancePath    : String := "FMULT4";
      tipd_A0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_A3         :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B1         :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B2         :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B3         :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_A2         :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_A1         :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S1	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S2	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S3	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S4	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S5	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S6       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_S7       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S1       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S2       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S3       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S4       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S5       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S6       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_S7       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S0       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S1       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S2	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S3       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S4	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S5	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S6	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_S7	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S1       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S2	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S3	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S4	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S5	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S6       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_S7	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S1       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S2	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S3	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S4	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S5	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S6	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_S7	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S1	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S2	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S3	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S4	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S5       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S6       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_S7       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S0       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S1	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S2       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S3       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S4       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S5       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S6       :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_S7	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S0	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S1	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S2	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S3	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S4	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S5	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S6	      :  VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_S7	      :  VitalDelayType01 := (0.1 ns, 0.1 ns)) ;

    port (
        A0	      :  in STD_LOGIC;
        A1	      :  in STD_LOGIC;
        A2	      :  in STD_LOGIC;
        A3	      :  in STD_LOGIC;
        B0	      :  in STD_LOGIC;
        B1	      :  in STD_LOGIC;
        B2	      :  in STD_LOGIC;
        B3	      :  in STD_LOGIC;
        S0            :  out STD_LOGIC;
        S1            :  out STD_LOGIC;
        S2            :  out STD_LOGIC;
        S3            :  out STD_LOGIC;
        S4            :  out STD_LOGIC;
        S5            :  out STD_LOGIC;
        S6            :  out STD_LOGIC;
        S7            :  out STD_LOGIC);

   attribute VITAL_LEVEL0 of FMULT4 : entity is TRUE;

end FMULT4 ;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FMULT4 is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component AND2
    port (
      A, B : in STD_LOGIC;
      Z : out STD_LOGIC);
  end component;

  component FADD4
    port (
      A0, A1, A2, A3, B0, B1, B2, B3, CI: in STD_LOGIC;
      CO, S0, S1, S2, S3: out STD_LOGIC);
  end component;

  component VLO
    port (
      Z: out STD_LOGIC);
  end component;

  SIGNAL I149, I147, I145, I143, I157, I155, I153, I151, I166, I164,
     I162, I159, I192, I196, I137, I139, I141, I175, I169, I171, I173,
     I183, I177, I179, I181: STD_LOGIC := 'X';

begin

  INST114: AND2 port map (A=>A1, B=>B3, Z=>I149);
  INST115: AND2 port map (A=>A1, B=>B2, Z=>I147);
  INST116: AND2 port map (A=>A1, B=>B1, Z=>I145);
  INST117: AND2 port map (A=>A1, B=>B0, Z=>I143);
  INST123: AND2 port map (A=>A2, B=>B3, Z=>I157);
  INST124: AND2 port map (A=>A2, B=>B2, Z=>I155);
  INST125: AND2 port map (A=>A2, B=>B1, Z=>I153);
  INST126: AND2 port map (A=>A2, B=>B0, Z=>I151);
  INST132: AND2 port map (A=>A3, B=>B3, Z=>I166);
  INST133: AND2 port map (A=>A3, B=>B2, Z=>I164);
  INST134: AND2 port map (A=>A3, B=>B1, Z=>I162);
  INST135: AND2 port map (A=>A3, B=>B0, Z=>I159);
  INST191: VLO port map (Z=>I192);
  INST195: VLO port map (Z=>I196);
  INST68: FADD4 port map (A0=>I137, A1=>I139, A2=>I141, A3=>I192, B0=>
    I143, B1=>I145, B2=>I147, B3=>I149, CI=>I192, CO=>I175, S0=>S1, S1=>
    I169, S2=>I171, S3=>I173);
  INST69: FADD4 port map (A0=>I169, A1=>I171, A2=>I173, A3=>I175, B0=>
    I151, B1=>I153, B2=>I155, B3=>I157, CI=>I196, CO=>I183, S0=>S2, S1=>
    I177, S2=>I179, S3=>I181);
  INST70: FADD4 port map (A0=>I177, A1=>I179, A2=>I181, A3=>I183, B0=>
    I159, B1=>I162, B2=>I164, B3=>I166, CI=>I196, CO=>S7, S0=>S3, S1=>
    S4, S2=>S5, S3=>S6);
  INST71: AND2 port map (A=>A0, B=>B3, Z=>I141);
  INST72: AND2 port map (A=>A0, B=>B2, Z=>I139);
  INST73: AND2 port map (A=>A0, B=>B1, Z=>I137);
  INST74: AND2 port map (A=>A0, B=>B0, Z=>S0);

end V;

library ORCA2;
configuration FMULT4C of FMULT4 is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: FADD4 use entity ORCA2.FADD4(v); end for;
    for all: VLO use entity ORCA2.VLO(v); end for;
  end for;
end FMULT4C;


--
----- CELL FMULT41 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_timing.all;
library ORCA2;
use ORCA2.ORCACOMP.all;


-- entity declaration --
entity FMULT41 is
   generic (
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "FMULT41";
      tipd_A0  	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_A1 	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_A2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_A3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_B3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_MULT	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_CI	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_CO	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_P0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_P1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_P2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A0_P3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_CO	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_P0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_P1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_P2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B0_P3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_CO       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_P0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_P1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_P2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A3_P3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_CO	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_P0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_P1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_P2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B1_P3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_CO	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_P0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_P1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_P2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B2_P3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_CO	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_P0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_P1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_P2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_B3_P3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_CO       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_P0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_P1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_P2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A2_P3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_CO	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_P0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_P1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_P2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_A1_P3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_MULT_CO     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_MULT_P0     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_MULT_P1     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_MULT_P2     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_MULT_P3     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_CI_CO	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_CI_P0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_CI_P1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_CI_P2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_CI_P3	      : VitalDelayType01 := (0.1 ns, 0.1 ns)) ;

    port (
        A0            :  in STD_LOGIC;
        A1            :  in STD_LOGIC;
        A2            :  in STD_LOGIC;
        A3            :  in STD_LOGIC;
        B0            :  in STD_LOGIC;
        B1            :  in STD_LOGIC;
        B2            :  in STD_LOGIC;
        B3            :  in STD_LOGIC;
        MULT	      :  in STD_LOGIC;
        CI	      :  in STD_LOGIC;
        CO            :  out STD_LOGIC;
        P0            :  out STD_LOGIC;
        P1            :  out STD_LOGIC;
        P2            :  out STD_LOGIC;
        P3            :  out STD_LOGIC);

   attribute VITAL_LEVEL0 of FMULT41 : entity is TRUE;

end FMULT41 ;

-- architecture body --

library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of FMULT41 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   component AND2
     port(
      A               :  in    STD_LOGIC;
      B               :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);
   end component;

   component OR3
     port(
      A               :  in    STD_LOGIC;
      B               :  in    STD_LOGIC;
      C               :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);
   end component;

   component XOR3
     port(
      A               :  in    STD_LOGIC;
      B               :  in    STD_LOGIC;
      C               :  in    STD_LOGIC;
      Z               :  out   STD_LOGIC);
   end component;

    SIGNAL PP0, INST2_pe_I3_1, INST2_pe_I4_1, INST2_pe_I5_1, 
       CO0, PP1, INST4_pe_I3_1, INST4_pe_I4_1, INST4_pe_I5_1, CO1, 
       PP2, INST6_pe_I3_1, INST6_pe_I4_1, INST6_pe_I5_1, CO2, PP3,
       INST8_pe_I3_1, INST8_pe_I4_1, INST8_pe_I5_1: STD_LOGIC := 'X';

begin

  INST1: AND2 port map (A=>MULT, B=>B0, Z=>PP0);
  INST2_pe_INST10_1: AND2 port map (A=>CI, B=>A0, Z=>INST2_pe_I3_1);
  INST2_pe_INST11_1: AND2 port map (A=>PP0, B=>CI, Z=>INST2_pe_I4_1);
  INST2_pe_INST12_1: OR3 port map (A=>INST2_pe_I3_1, B=>INST2_pe_I4_1,
    C=>INST2_pe_I5_1, Z=>CO0);
  INST2_pe_INST13_1: XOR3 port map (A=>PP0, B=>A0, C=>CI, Z=>P0);
  INST2_pe_INST2_1: AND2 port map (A=>A0, B=>PP0, Z=>INST2_pe_I5_1);
  INST3: AND2 port map (A=>MULT, B=>B1, Z=>PP1);
  INST4_pe_INST10_1: AND2 port map (A=>CO0, B=>A1, Z=>INST4_pe_I3_1);
  INST4_pe_INST11_1: AND2 port map (A=>PP1, B=>CO0, Z=>INST4_pe_I4_1);
  INST4_pe_INST12_1: OR3 port map (A=>INST4_pe_I3_1, B=>INST4_pe_I4_1,
    C=>INST4_pe_I5_1, Z=>CO1);
  INST4_pe_INST13_1: XOR3 port map (A=>PP1, B=>A1, C=>CO0, Z=>P1);
  INST4_pe_INST2_1: AND2 port map (A=>A1, B=>PP1, Z=>INST4_pe_I5_1);
  INST5: AND2 port map (A=>MULT, B=>B2, Z=>PP2);
  INST6_pe_INST10_1: AND2 port map (A=>CO1, B=>A2, Z=>INST6_pe_I3_1);
  INST6_pe_INST11_1: AND2 port map (A=>PP2, B=>CO1, Z=>INST6_pe_I4_1);
  INST6_pe_INST12_1: OR3 port map (A=>INST6_pe_I3_1, B=>INST6_pe_I4_1,
    C=>INST6_pe_I5_1, Z=>CO2);
  INST6_pe_INST13_1: XOR3 port map (A=>PP2, B=>A2, C=>CO1, Z=>P2);
  INST6_pe_INST2_1: AND2 port map (A=>A2, B=>PP2, Z=>INST6_pe_I5_1);
  INST7: AND2 port map (A=>MULT, B=>B3, Z=>PP3);
  INST8_pe_INST10_1: AND2 port map (A=>CO2, B=>A3, Z=>INST8_pe_I3_1);
  INST8_pe_INST11_1: AND2 port map (A=>PP3, B=>CO2, Z=>INST8_pe_I4_1);
  INST8_pe_INST12_1: OR3 port map (A=>INST8_pe_I3_1, B=>INST8_pe_I4_1,
    C=>INST8_pe_I5_1, Z=>CO);
  INST8_pe_INST13_1: XOR3 port map (A=>PP3, B=>A3, C=>CO2, Z=>P3);
  INST8_pe_INST2_1: AND2 port map (A=>A3, B=>PP3, Z=>INST8_pe_I5_1);

end V;

library ORCA2;
configuration FMULT41C of FMULT41 is
   for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
   end for;
end FMULT41C;




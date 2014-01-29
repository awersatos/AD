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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCA_CMB.vhd,v 1.16 2005/05/19 20:04:53 pradeep Exp $ 
--

--
----- cell ageb4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY ageb4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ageb4";
      tpd_a0_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      b3              :	IN    std_logic;
      ci              :	IN    std_logic := '1';
      ge              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF ageb4 : ENTITY IS TRUE;

END ageb4;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF ageb4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL a2_ipd	 : std_logic := 'X';
   SIGNAL a3_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL b2_ipd	 : std_logic := 'X';
   SIGNAL b3_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, b1_ipd,
				b2_ipd, b3_ipd, ci_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS ge_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 3) := (others => 'X');

   -- output glitch detection VARIABLEs
   VARIABLE ge_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a3_ipd, a2_ipd, a1_ipd, a0_ipd);
      b := std_logic_vector'(b3_ipd, b2_ipd, b1_ipd, b0_ipd);

      -- if a = b, then output carry-in (ge from the lower stage)
      -- note: carry-in on the first stage is tied high
      IF (a > b) THEN
	ge_zd := '1'; 
      ELSIF (a = b) THEN
	ge_zd := ci_ipd;
      ELSE
	ge_zd := '0';
      END IF;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => ge,
       OutSignalName => "ge",
       OutTemp => ge_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_ge, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_ge, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_ge, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_ge, TRUE),
		 4 => (b0_ipd'last_event, tpd_b0_ge, TRUE),
		 5 => (b1_ipd'last_event, tpd_b1_ge, TRUE),
		 6 => (b2_ipd'last_event, tpd_b2_ge, TRUE),
		 7 => (b3_ipd'last_event, tpd_b3_ge, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_ge, TRUE)),
       GlitchData => ge_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ageb8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY ageb8 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ageb8";
      tpd_a0_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_ge       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic;
      ci                             : IN std_logic := '1';
      ge                             : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF ageb8 : ENTITY IS TRUE;

END ageb8;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF ageb8 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL a2_ipd	 : std_logic := 'X';
   SIGNAL a3_ipd	 : std_logic := 'X';
   SIGNAL a4_ipd	 : std_logic := 'X';
   SIGNAL a5_ipd	 : std_logic := 'X';
   SIGNAL a6_ipd	 : std_logic := 'X';
   SIGNAL a7_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL b2_ipd	 : std_logic := 'X';
   SIGNAL b3_ipd	 : std_logic := 'X';
   SIGNAL b4_ipd	 : std_logic := 'X';
   SIGNAL b5_ipd	 : std_logic := 'X';
   SIGNAL b6_ipd	 : std_logic := 'X';
   SIGNAL b7_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd, 
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, ci_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS ge_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 7) := (others => 'X');

   -- output glitch detection VARIABLEs
   VARIABLE ge_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a7_ipd, a6_ipd, a5_ipd, a4_ipd, a3_ipd, a2_ipd, 
				a1_ipd, a0_ipd);
      b := std_logic_vector'(b7_ipd, b6_ipd, b5_ipd, b4_ipd, b3_ipd, b2_ipd, 
				b1_ipd, b0_ipd);

      -- if a = b, then output carry-in (ge from the lower stage)
      -- note: carry-in on the first stage is tied high
      IF (a > b) THEN
	ge_zd := '1'; 
      ELSIF (a = b) THEN
	ge_zd := ci_ipd;
      ELSE
	ge_zd := '0';
      END IF;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => ge,
       OutSignalName => "ge",
       OutTemp => ge_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_ge, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_ge, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_ge, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_ge, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_ge, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_ge, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_ge, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_ge, TRUE),
		 8 => (b0_ipd'last_event, tpd_b0_ge, TRUE),
		 9 => (b1_ipd'last_event, tpd_b1_ge, TRUE),
		10 => (b2_ipd'last_event, tpd_b2_ge, TRUE),
		11 => (b3_ipd'last_event, tpd_b3_ge, TRUE),
		12 => (b4_ipd'last_event, tpd_b4_ge, TRUE),
		13 => (b5_ipd'last_event, tpd_b5_ge, TRUE),
		14 => (b6_ipd'last_event, tpd_b6_ge, TRUE),
		15 => (b7_ipd'last_event, tpd_b7_ge, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_ge, TRUE)),
       GlitchData => ge_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell aleb4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aleb4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "aleb4";
      tpd_a0_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3  : IN std_logic;
      b0, b1, b2, b3  : IN std_logic;
      ci              : IN std_logic := '1';
      le              : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF aleb4 : ENTITY IS TRUE;

END aleb4;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aleb4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL a2_ipd	 : std_logic := 'X';
   SIGNAL a3_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL b2_ipd	 : std_logic := 'X';
   SIGNAL b3_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, b1_ipd, 
		b2_ipd, b3_ipd, ci_ipd)
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS le_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 3) := (others => 'X');

   -- output glitch detection VARIABLEs
   VARIABLE le_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a3_ipd, a2_ipd, a1_ipd, a0_ipd);
      b := std_logic_vector'(b3_ipd, b2_ipd, b1_ipd, b0_ipd);

      -- if a = b, then output carry-in (le from the lower stage)
      -- note: carry-in on the first stage is tied high
      IF (a < b) THEN
	le_zd := '1'; 
      ELSIF (a = b) THEN
	le_zd := ci_ipd;
      ELSE
	le_zd := '0';
      END IF;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => le,
       OutSignalName => "le",
       OutTemp => le_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_le, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_le, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_le, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_le, TRUE),
		 4 => (b0_ipd'last_event, tpd_b0_le, TRUE),
		 5 => (b1_ipd'last_event, tpd_b1_le, TRUE),
		 6 => (b2_ipd'last_event, tpd_b2_le, TRUE),
		 7 => (b3_ipd'last_event, tpd_b3_le, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_le, TRUE)),
       GlitchData => le_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell aleb8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aleb8 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "aleb8";
      tpd_a0_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_le       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic;
      ci                             : IN std_logic := '1';
      le                             : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF aleb8 : ENTITY IS TRUE;

END aleb8;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aleb8 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL a2_ipd	 : std_logic := 'X';
   SIGNAL a3_ipd	 : std_logic := 'X';
   SIGNAL a4_ipd	 : std_logic := 'X';
   SIGNAL a5_ipd	 : std_logic := 'X';
   SIGNAL a6_ipd	 : std_logic := 'X';
   SIGNAL a7_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL b2_ipd	 : std_logic := 'X';
   SIGNAL b3_ipd	 : std_logic := 'X';
   SIGNAL b4_ipd	 : std_logic := 'X';
   SIGNAL b5_ipd	 : std_logic := 'X';
   SIGNAL b6_ipd	 : std_logic := 'X';
   SIGNAL b7_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd, 
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, ci_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS le_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 7) := (others => 'X');

   -- output glitch detection VARIABLEs
   VARIABLE le_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a7_ipd, a6_ipd, a5_ipd, a4_ipd, a3_ipd, a2_ipd, 
				a1_ipd, a0_ipd);
      b := std_logic_vector'(b7_ipd, b6_ipd, b5_ipd, b4_ipd, b3_ipd, b2_ipd, 
				b1_ipd, b0_ipd);

      -- if a = b, then output carry-in (le from the lower stage)
      -- note: carry-in on the first stage is tied high
      IF (a < b) THEN
	le_zd := '1'; 
      ELSIF (a = b) THEN
	le_zd := ci_ipd;
      ELSE
	le_zd := '0';
      END IF;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => le,
       OutSignalName => "le",
       OutTemp => le_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_le, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_le, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_le, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_le, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_le, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_le, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_le, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_le, TRUE),
		 8 => (b0_ipd'last_event, tpd_b0_le, TRUE),
		 9 => (b1_ipd'last_event, tpd_b1_le, TRUE),
		10 => (b2_ipd'last_event, tpd_b2_le, TRUE),
		11 => (b3_ipd'last_event, tpd_b3_le, TRUE),
		12 => (b4_ipd'last_event, tpd_b4_le, TRUE),
		13 => (b5_ipd'last_event, tpd_b5_le, TRUE),
		14 => (b6_ipd'last_event, tpd_b6_le, TRUE),
		15 => (b7_ipd'last_event, tpd_b7_le, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_le, TRUE)),
       GlitchData => le_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell aneb4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aneb4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "aneb4";
      tpd_a0_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      b3              :	IN    std_logic;
      ci              :	IN    std_logic := '0';
      ne              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF aneb4 : ENTITY IS TRUE;

END aneb4;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aneb4 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL a2_ipd	 : std_logic := 'X';
   SIGNAL a3_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL b2_ipd	 : std_logic := 'X';
   SIGNAL b3_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, b1_ipd,
				b2_ipd, b3_ipd, ci_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS ne_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 3) := (others => 'X');

   -- output glitch detection VARIABLEs
   VARIABLE ne_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a3_ipd, a2_ipd, a1_ipd, a0_ipd);
      b := std_logic_vector'(b3_ipd, b2_ipd, b1_ipd, b0_ipd);

      -- IF a = b, THEN pass on carry-in input (ne from the previous stage)
      -- note: carry-in on the first stage is tied low
      IF (a = b) THEN
	ne_zd := ci_ipd; 
      ELSE
	ne_zd := '1';
      END IF;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => ne,
       OutSignalName => "ne",
       OutTemp => ne_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_ne, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_ne, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_ne, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_ne, TRUE),
		 4 => (b0_ipd'last_event, tpd_b0_ne, TRUE),
		 5 => (b1_ipd'last_event, tpd_b1_ne, TRUE),
		 6 => (b2_ipd'last_event, tpd_b2_ne, TRUE),
		 7 => (b3_ipd'last_event, tpd_b3_ne, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_ne, TRUE)),
       GlitchData => ne_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell aneb8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aneb8 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "aneb8";
      tpd_a0_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_ne       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic;
      ci                             : IN std_logic := '0';
      ne                             : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF aneb8 : ENTITY IS TRUE;

END aneb8;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aneb8 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL a2_ipd	 : std_logic := 'X';
   SIGNAL a3_ipd	 : std_logic := 'X';
   SIGNAL a4_ipd	 : std_logic := 'X';
   SIGNAL a5_ipd	 : std_logic := 'X';
   SIGNAL a6_ipd	 : std_logic := 'X';
   SIGNAL a7_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL b2_ipd	 : std_logic := 'X';
   SIGNAL b3_ipd	 : std_logic := 'X';
   SIGNAL b4_ipd	 : std_logic := 'X';
   SIGNAL b5_ipd	 : std_logic := 'X';
   SIGNAL b6_ipd	 : std_logic := 'X';
   SIGNAL b7_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd, 
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, ci_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS ne_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 7) := (others => 'X');

   -- output glitch detection VARIABLEs
   VARIABLE ne_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------

      a := std_logic_vector'(a7_ipd, a6_ipd, a5_ipd, a4_ipd, a3_ipd, a2_ipd, 
				a1_ipd, a0_ipd);
      b := std_logic_vector'(b7_ipd, b6_ipd, b5_ipd, b4_ipd, b3_ipd, b2_ipd, 
				b1_ipd, b0_ipd);

      -- IF a = b, THEN pass on carry-in input (ne from the previous stage)
      -- note: carry-in on the first stage is tied low
      IF (a = b) THEN
	ne_zd := ci_ipd; 
      ELSE
	ne_zd := '1';
      END IF;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => ne,
       OutSignalName => "ne",
       OutTemp => ne_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_ne, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_ne, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_ne, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_ne, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_ne, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_ne, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_ne, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_ne, TRUE),
		 8 => (b0_ipd'last_event, tpd_b0_ne, TRUE),
		 9 => (b1_ipd'last_event, tpd_b1_ne, TRUE),
		10 => (b2_ipd'last_event, tpd_b2_ne, TRUE),
		11 => (b3_ipd'last_event, tpd_b3_ne, TRUE),
		12 => (b4_ipd'last_event, tpd_b4_ne, TRUE),
		13 => (b5_ipd'last_event, tpd_b5_ne, TRUE),
		14 => (b6_ipd'last_event, tpd_b6_ne, TRUE),
		15 => (b7_ipd'last_event, tpd_b7_ne, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_ne, TRUE)),
       GlitchData => ne_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell and2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "and2";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF and2 : ENTITY IS TRUE;

END and2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell and3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and3 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "and3";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT   std_logic); 

   ATTRIBUTE Vital_Level0 OF and3 : ENTITY IS TRUE;

END and3;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and3 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd AND c_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell and4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "and4";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF and4 : ENTITY IS TRUE;

END and4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd AND c_ipd AND d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell and5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY and5 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "and5";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF and5 : ENTITY IS TRUE;

END and5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF and5 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd AND c_ipd AND d_ipd AND e_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sand10 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sand10 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sand10";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_g_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_h_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_i_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_j_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_g          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_h          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_j          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      f               :	IN    std_logic;
      g               :	IN    std_logic;
      h               :	IN    std_logic;
      i               :	IN    std_logic;
      j               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF sand10 : ENTITY IS TRUE;

END sand10;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sand10 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';
   SIGNAL g_ipd	 : std_logic := 'X';
   SIGNAL h_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL j_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   VitalWireDelay (g_ipd, g, tipd_g);
   VitalWireDelay (h_ipd, h, tipd_h);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (j_ipd, j, tipd_j);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd, 
			g_ipd, h_ipd, i_ipd, j_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd AND c_ipd AND d_ipd AND e_ipd AND f_ipd 
		and g_ipd AND h_ipd AND i_ipd AND j_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE),
                 6 => (g_ipd'last_event, tpd_g_z, TRUE),
                 7 => (h_ipd'last_event, tpd_h_z, TRUE),
                 8 => (i_ipd'last_event, tpd_i_z, TRUE),
                 9 => (j_ipd'last_event, tpd_j_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sand2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sand2 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sand2";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sand2 : ENTITY IS TRUE;

END sand2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sand2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell sand4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sand4 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sand4";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sand4 : ENTITY IS TRUE;

END sand4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sand4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd AND c_ipd AND d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sand6 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sand6 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sand6";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      f               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sand6 : ENTITY IS TRUE;

END sand6;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sand6 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd AND c_ipd AND d_ipd AND e_ipd AND f_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sand8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sand8 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sand8";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_g_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_h_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_g          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_h          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      f               :	IN    std_logic;
      g               :	IN    std_logic;
      h               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sand8 : ENTITY IS TRUE;

END sand8;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sand8 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';
   SIGNAL g_ipd	 : std_logic := 'X';
   SIGNAL h_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   VitalWireDelay (g_ipd, g, tipd_g);
   VitalWireDelay (h_ipd, h, tipd_h);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd, 
			g_ipd, h_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd AND b_ipd AND c_ipd AND d_ipd AND e_ipd AND f_ipd 
		and g_ipd AND h_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE),
                 6 => (g_ipd'last_event, tpd_g_z, TRUE),
                 7 => (h_ipd'last_event, tpd_h_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell saoi42 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY saoi42 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "saoi42";
      tpd_a1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      a4              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF saoi42 : ENTITY IS TRUE;

END saoi42;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF saoi42 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a1_ipd : std_logic := 'X';
   SIGNAL a2_ipd : std_logic := 'X';
   SIGNAL a3_ipd : std_logic := 'X';
   SIGNAL a4_ipd : std_logic := 'X';
   SIGNAL b1_ipd : std_logic := 'X';
   SIGNAL b2_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a1_ipd, a2_ipd, a3_ipd, a4_ipd, b1_ipd, b2_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (NOT ((a1_ipd AND a2_ipd AND a3_ipd AND a4_ipd) OR (b1_ipd 
         AND b2_ipd)));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a1_ipd'last_event, tpd_a1_z, TRUE),
                 1 => (a2_ipd'last_event, tpd_a2_z, TRUE),
                 2 => (a3_ipd'last_event, tpd_a3_z, TRUE),
                 3 => (a4_ipd'last_event, tpd_a4_z, TRUE),
                 4 => (b1_ipd'last_event, tpd_b1_z, TRUE),
                 5 => (b2_ipd'last_event, tpd_b2_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell saoi44 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY saoi44 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "saoi44";
      tpd_a1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      a4              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      b3              :	IN    std_logic;
      b4              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF saoi44 : ENTITY IS TRUE;

END saoi44;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF saoi44 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a1_ipd : std_logic := 'X';
   SIGNAL a2_ipd : std_logic := 'X';
   SIGNAL a3_ipd : std_logic := 'X';
   SIGNAL a4_ipd : std_logic := 'X';
   SIGNAL b1_ipd : std_logic := 'X';
   SIGNAL b2_ipd : std_logic := 'X';
   SIGNAL b3_ipd : std_logic := 'X';
   SIGNAL b4_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a1_ipd, a2_ipd, a3_ipd, a4_ipd, b1_ipd, b2_ipd,
				b3_ipd, b4_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (NOT ((a1_ipd AND a2_ipd AND a3_ipd AND a4_ipd) OR (b1_ipd 
         AND b2_ipd AND b3_ipd AND b4_ipd)));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a1_ipd'last_event, tpd_a1_z, TRUE),
                 1 => (a2_ipd'last_event, tpd_a2_z, TRUE),
                 2 => (a3_ipd'last_event, tpd_a3_z, TRUE),
                 3 => (a4_ipd'last_event, tpd_a4_z, TRUE),
                 4 => (b1_ipd'last_event, tpd_b1_z, TRUE),
                 5 => (b2_ipd'last_event, tpd_b2_z, TRUE),
                 6 => (b3_ipd'last_event, tpd_b3_z, TRUE),
                 7 => (b4_ipd'last_event, tpd_b4_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell saoi442 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY saoi442 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "saoi442";
      tpd_a1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c2_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c2         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      a4              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      b3              :	IN    std_logic;
      b4              :	IN    std_logic;
      c1              :	IN    std_logic;
      c2              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF saoi442 : ENTITY IS TRUE;

END saoi442;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF saoi442 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a1_ipd : std_logic := 'X';
   SIGNAL a2_ipd : std_logic := 'X';
   SIGNAL a3_ipd : std_logic := 'X';
   SIGNAL a4_ipd : std_logic := 'X';
   SIGNAL b1_ipd : std_logic := 'X';
   SIGNAL b2_ipd : std_logic := 'X';
   SIGNAL b3_ipd : std_logic := 'X';
   SIGNAL b4_ipd : std_logic := 'X';
   SIGNAL c1_ipd : std_logic := 'X';
   SIGNAL c2_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (c1_ipd, c1, tipd_c1);
   VitalWireDelay (c2_ipd, c2, tipd_c2);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a1_ipd, a2_ipd, a3_ipd, a4_ipd, b1_ipd, b2_ipd,
				b3_ipd, b4_ipd, c1_ipd, c2_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (NOT ((a1_ipd AND a2_ipd AND a3_ipd AND a4_ipd) OR (b1_ipd 
         AND b2_ipd AND b3_ipd AND b4_ipd) OR (c1_ipd AND c2_ipd)));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a1_ipd'last_event, tpd_a1_z, TRUE),
                 1 => (a2_ipd'last_event, tpd_a2_z, TRUE),
                 2 => (a3_ipd'last_event, tpd_a3_z, TRUE),
                 3 => (a4_ipd'last_event, tpd_a4_z, TRUE),
                 4 => (b1_ipd'last_event, tpd_b1_z, TRUE),
                 5 => (b2_ipd'last_event, tpd_b2_z, TRUE),
                 6 => (b3_ipd'last_event, tpd_b3_z, TRUE),
                 7 => (b4_ipd'last_event, tpd_b4_z, TRUE),
                 8 => (c1_ipd'last_event, tpd_c1_z, TRUE),
                 9 => (c2_ipd'last_event, tpd_c2_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell bndscan -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY bndscan IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "bndscan";
      tpd_bso1_tdo    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bso2_tdo    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ptms_tdo    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ptdi_tdi    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ptck_tck    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ptdi       :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ptms       :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ptck       :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bso1       :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bso2       :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      ptdi            :	IN    std_logic;
      ptms            :	IN    std_logic;
      ptck            :	IN    std_logic;
      bso1            :	IN    std_logic;
      bso2            :	IN    std_logic;
      tdi             :	OUT  std_logic;
      tck             :	OUT  std_logic;
      bsen1           :	OUT  std_logic;
      bsen2           :	OUT  std_logic;
      tdo             :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF bndscan : ENTITY IS TRUE;

END bndscan;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF bndscan IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL ptdi_ipd	 : std_logic := 'X';
   SIGNAL ptms_ipd	 : std_logic := 'X';
   SIGNAL ptck_ipd	 : std_logic := 'X';
   SIGNAL bso1_ipd	 : std_logic := 'X';
   SIGNAL bso2_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (ptdi_ipd, ptdi, tipd_ptdi);
   VitalWireDelay (ptms_ipd, ptms, tipd_ptms);
   VitalWireDelay (ptck_ipd, ptck, tipd_ptck);
   VitalWireDelay (bso1_ipd, bso1, tipd_bso1);
   VitalWireDelay (bso2_ipd, bso2, tipd_bso2);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ptdi_ipd, ptms_ipd, ptck_ipd, bso1_ipd, bso2_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 5) := (others => 'X');
   ALIAS tdi_zd     : std_ulogic IS results(1);
   ALIAS tck_zd     : std_ulogic IS results(2);
   ALIAS tdo_zd     : std_ulogic IS results(5);

   -- output glitch detection VARIABLEs
   VARIABLE tdi_GlitchData	: VitalGlitchDataType;
   VARIABLE tck_GlitchData	: VitalGlitchDataType;
   VARIABLE tdo_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tdo_zd := vitalmux
                 (data => (bso2_ipd, bso1_ipd),
                  dselect => (0 => ptms_ipd));
      tck_zd := vitalbuf(ptck_ipd);
      tdi_zd := vitalbuf(ptdi_ipd);
      bsen1 <= '0'; 
      bsen2 <= '0'; 

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => tdo,
       OutSignalName => "tdo",
       OutTemp => tdo_zd,
       Paths => (0 => (bso1_ipd'last_event, tpd_bso1_tdo, TRUE),
                 1 => (bso2_ipd'last_event, tpd_bso2_tdo, TRUE),
                 2 => (ptms_ipd'last_event, tpd_ptms_tdo, TRUE)),
       GlitchData => tdo_GlitchData,
       Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => tck,
       OutSignalName => "tck",
       OutTemp => tck_zd,
       Paths => (0 => (inputchangetime => ptck_ipd'last_event, 
                       pathdelay => tpd_ptck_tck, 
                       pathcondition => TRUE)),
       GlitchData => tck_GlitchData,
       Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => tdi,
       OutSignalName => "tdi",
       OutTemp => tdi_zd,
       Paths => (0 => (inputchangetime => ptdi_ipd'last_event, 
                       pathdelay => tpd_ptdi_tdi, 
                       pathcondition => TRUE)),
       GlitchData => tdi_GlitchData,
       Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell sor10 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sor10 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sor10";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_g_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_h_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_i_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_j_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_g          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_h          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_j          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      f               :	IN    std_logic;
      g               :	IN    std_logic;
      h               :	IN    std_logic;
      i               :	IN    std_logic;
      j               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sor10 : ENTITY IS TRUE;

END sor10;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sor10 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';
   SIGNAL g_ipd	 : std_logic := 'X';
   SIGNAL h_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL j_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   VitalWireDelay (g_ipd, g, tipd_g);
   VitalWireDelay (h_ipd, h, tipd_h);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (j_ipd, j, tipd_j);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd, g_ipd, 
				h_ipd, i_ipd, j_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd OR c_ipd OR d_ipd OR e_ipd OR f_ipd OR g_ipd 
		or h_ipd OR i_ipd OR j_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE),
                 6 => (g_ipd'last_event, tpd_g_z, TRUE),
                 7 => (h_ipd'last_event, tpd_h_z, TRUE),
                 8 => (i_ipd'last_event, tpd_i_z, TRUE),
                 9 => (j_ipd'last_event, tpd_j_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sor2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sor2 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sor2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sor2 : ENTITY IS TRUE;

END sor2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sor4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sor4 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sor4";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sor4 : ENTITY IS TRUE;

END sor4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sor4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd OR c_ipd OR d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sor6 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sor6 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sor6";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      f               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sor6 : ENTITY IS TRUE;

END sor6;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sor6 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd OR c_ipd OR d_ipd OR e_ipd OR f_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell sor8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY sor8 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "sor8";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_g_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_h_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_g          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_h          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      f               :	IN    std_logic;
      g               :	IN    std_logic;
      h               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF sor8 : ENTITY IS TRUE;

END sor8;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF sor8 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';
   SIGNAL g_ipd	 : std_logic := 'X';
   SIGNAL h_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   VitalWireDelay (g_ipd, g, tipd_g);
   VitalWireDelay (h_ipd, h, tipd_h);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd, g_ipd, 
				h_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd OR c_ipd OR d_ipd OR e_ipd OR f_ipd OR g_ipd 
		or h_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE),
                 6 => (g_ipd'last_event, tpd_g_z, TRUE),
                 7 => (h_ipd'last_event, tpd_h_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell fadd4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadd4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fadd4";
      tpd_a0_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      b3              :	IN    std_logic;
      ci              :	IN    std_logic;
      co              :	OUT   std_logic;
      s0              :	OUT   std_logic;
      s1              :	OUT   std_logic;
      s2              :	OUT   std_logic;
      s3              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadd4 : ENTITY IS TRUE;

END fadd4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadd4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd : std_logic := 'X';
   SIGNAL a1_ipd : std_logic := 'X';
   SIGNAL a2_ipd : std_logic := 'X';
   SIGNAL a3_ipd : std_logic := 'X';
   SIGNAL b0_ipd : std_logic := 'X';
   SIGNAL b1_ipd : std_logic := 'X';
   SIGNAL b2_ipd : std_logic := 'X';
   SIGNAL b3_ipd : std_logic := 'X';
   SIGNAL ci_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, 
			    b1_ipd, b2_ipd, b3_ipd, ci_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS c0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS c1_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
   ALIAS c2_zd      : std_ulogic IS results3(1);
   ALIAS s2_zd      : std_ulogic IS results3(2);
   ALIAS co_zd      : std_ulogic IS results4(1);
   ALIAS s3_zd      : std_ulogic IS results4(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData    : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    ci   |   co   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (a0_ipd, b0_ipd, ci_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (a1_ipd, b1_ipd, c0_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (a2_ipd, b2_ipd, c1_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (a3_ipd, b3_ipd, c2_zd)
                );

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_co, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_co, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_co, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_co, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_co, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_co, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_co, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_co, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fadd4o -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadd4o IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fadd4o";
      tpd_a0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      b3              :	IN    std_logic;
      ci              :	IN    std_logic;
      OFl             :	OUT   std_logic;
      s0              :	OUT   std_logic;
      s1              :	OUT   std_logic;
      s2              :	OUT   std_logic;
      s3              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadd4o : ENTITY IS TRUE;

END fadd4o;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadd4o IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd         : std_logic := 'X';
   SIGNAL a1_ipd         : std_logic := 'X';
   SIGNAL a2_ipd         : std_logic := 'X';
   SIGNAL a3_ipd         : std_logic := 'X';
   SIGNAL b0_ipd         : std_logic := 'X';
   SIGNAL b1_ipd         : std_logic := 'X';
   SIGNAL b2_ipd         : std_logic := 'X';
   SIGNAL b3_ipd         : std_logic := 'X';
   SIGNAL ci_ipd         : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, 
		     	    b1_ipd, b2_ipd, b3_ipd, ci_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS c0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS c1_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
   ALIAS c2_zd      : std_ulogic IS results3(1);
   ALIAS s2_zd      : std_ulogic IS results3(2);
   ALIAS c3_zd      : std_ulogic IS results4(1);
   ALIAS s3_zd      : std_ulogic IS results4(2);
   ALIAS OFl_zd     : std_ulogic IS results5(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE OFl_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    ci   |   co   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (a0_ipd, b0_ipd, ci_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (a1_ipd, b1_ipd, c0_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (a2_ipd, b2_ipd, c1_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (a3_ipd, b3_ipd, c2_zd)
                );
      OFl_zd  := c3_zd XOR c2_zd;
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFl,
       OutSignalName => "OFl",
       OutTemp => OFl_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_OFl, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_OFl, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_OFl, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_OFl, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_OFl, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_OFl, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_OFl, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_OFl, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_OFl, TRUE)),
       GlitchData => OFl_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
		 8 => (ci_ipd'last_event, tpd_ci_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fadd8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadd8 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fadd8";
      tpd_a0_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_co       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN   std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN   std_logic;
      ci                             : IN   std_logic;
      co                             : OUT  std_logic;
      s0, s1, s2, s3, s4, s5, s6, s7 : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF fadd8 : ENTITY IS TRUE;

END fadd8;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadd8 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd : std_logic := 'X';
   SIGNAL a1_ipd : std_logic := 'X';
   SIGNAL a2_ipd : std_logic := 'X';
   SIGNAL a3_ipd : std_logic := 'X';
   SIGNAL a4_ipd : std_logic := 'X';
   SIGNAL a5_ipd : std_logic := 'X';
   SIGNAL a6_ipd : std_logic := 'X';
   SIGNAL a7_ipd : std_logic := 'X';
   SIGNAL b0_ipd : std_logic := 'X';
   SIGNAL b1_ipd : std_logic := 'X';
   SIGNAL b2_ipd : std_logic := 'X';
   SIGNAL b3_ipd : std_logic := 'X';
   SIGNAL b4_ipd : std_logic := 'X';
   SIGNAL b5_ipd : std_logic := 'X';
   SIGNAL b6_ipd : std_logic := 'X';
   SIGNAL b7_ipd : std_logic := 'X';
   SIGNAL ci_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd,
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, ci_ipd)
 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results6 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results7 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS c0_zd       : std_ulogic IS results0(1);
   ALIAS s0_zd       : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS s1_zd       : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS s2_zd       : std_ulogic IS results2(2);
   ALIAS c3_zd       : std_ulogic IS results3(1);
   ALIAS s3_zd       : std_ulogic IS results3(2);
   ALIAS c4_zd       : std_ulogic IS results4(1);
   ALIAS s4_zd       : std_ulogic IS results4(2);
   ALIAS c5_zd       : std_ulogic IS results5(1);
   ALIAS s5_zd       : std_ulogic IS results5(2);
   ALIAS c6_zd       : std_ulogic IS results6(1);
   ALIAS s6_zd       : std_ulogic IS results6(2);
   ALIAS co_zd       : std_ulogic IS results7(1);
   ALIAS s7_zd       : std_ulogic IS results7(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData    : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
   VARIABLE s4_GlitchData    : VitalGlitchDataType;
   VARIABLE s5_GlitchData    : VitalGlitchDataType;
   VARIABLE s6_GlitchData    : VitalGlitchDataType;
   VARIABLE s7_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    ci   |   co   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (a0_ipd, b0_ipd, ci_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (a1_ipd, b1_ipd, c0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (a2_ipd, b2_ipd, c1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (a3_ipd, b3_ipd, c2_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (a4_ipd, b4_ipd, c3_zd)
                );
      results5 := vitaltruthtable (
                truthtable => add_table,
                datain => (a5_ipd, b5_ipd, c4_zd)
                );
      results6 := vitaltruthtable (
                truthtable => add_table,
                datain => (a6_ipd, b6_ipd, c5_zd)
                );
      results7 := vitaltruthtable (
                truthtable => add_table,
                datain => (a7_ipd, b7_ipd, c6_zd)
                );

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_co, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_co, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_co, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_co, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_co, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_co, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_co, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_co, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_co, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_co, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_co, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_co, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_co, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_co, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_co, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_co, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s0, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s0, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s0, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s0, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s0, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s0, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s0, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s0, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s1, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s1, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s1, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s1, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s1, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s1, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s1, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s1, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s2, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s2, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s2, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s2, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s2, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s2, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s2, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s2, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s3, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s3, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s3, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s3, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s3, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s3, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s3, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s3, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s4,
       OutSignalName => "s4",
       OutTemp => s4_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s4, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s4, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s4, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s4, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s4, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s4, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s4, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s4, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s4, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s4, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s4, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s4, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s4, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s4, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s4, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s4, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s4, TRUE)),
       GlitchData => s4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s5,
       OutSignalName => "s5",
       OutTemp => s5_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s5, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s5, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s5, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s5, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s5, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s5, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s5, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s5, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s5, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s5, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s5, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s5, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s5, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s5, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s5, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s5, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s5, TRUE)),
       GlitchData => s5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s6,
       OutSignalName => "s6",
       OutTemp => s6_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s6, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s6, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s6, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s6, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s6, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s6, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s6, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s6, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s6, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s6, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s6, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s6, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s6, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s6, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s6, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s6, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s6, TRUE)),
       GlitchData => s6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s7,
       OutSignalName => "s7",
       OutTemp => s7_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s7, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s7, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s7, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s7, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s7, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s7, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s7, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s7, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s7, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s7, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s7, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s7, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s7, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s7, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s7, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s7, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s7, TRUE)),
       GlitchData => s7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fadd8o -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadd8o IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fadd8o";
      tpd_a0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN    std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN    std_logic;
      ci                             : IN    std_logic;
      OFl                            : OUT   std_logic;
      s0, s1, s2, s3, s4, s5, s6, s7 : OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadd8o : ENTITY IS TRUE;

END fadd8o;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadd8o IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd : std_logic := 'X';
   SIGNAL a1_ipd : std_logic := 'X';
   SIGNAL a2_ipd : std_logic := 'X';
   SIGNAL a3_ipd : std_logic := 'X';
   SIGNAL a4_ipd : std_logic := 'X';
   SIGNAL a5_ipd : std_logic := 'X';
   SIGNAL a6_ipd : std_logic := 'X';
   SIGNAL a7_ipd : std_logic := 'X';
   SIGNAL b0_ipd : std_logic := 'X';
   SIGNAL b1_ipd : std_logic := 'X';
   SIGNAL b2_ipd : std_logic := 'X';
   SIGNAL b3_ipd : std_logic := 'X';
   SIGNAL b4_ipd : std_logic := 'X';
   SIGNAL b5_ipd : std_logic := 'X';
   SIGNAL b6_ipd : std_logic := 'X';
   SIGNAL b7_ipd : std_logic := 'X';
   SIGNAL ci_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd,
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, ci_ipd)
 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results6 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results7 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results8 : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS c0_zd       : std_ulogic IS results0(1);
   ALIAS s0_zd       : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS s1_zd       : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS s2_zd       : std_ulogic IS results2(2);
   ALIAS c3_zd       : std_ulogic IS results3(1);
   ALIAS s3_zd       : std_ulogic IS results3(2);
   ALIAS c4_zd       : std_ulogic IS results4(1);
   ALIAS s4_zd       : std_ulogic IS results4(2);
   ALIAS c5_zd       : std_ulogic IS results5(1);
   ALIAS s5_zd       : std_ulogic IS results5(2);
   ALIAS c6_zd       : std_ulogic IS results6(1);
   ALIAS s6_zd       : std_ulogic IS results6(2);
   ALIAS c7_zd       : std_ulogic IS results7(1);
   ALIAS s7_zd       : std_ulogic IS results7(2);
   ALIAS OFl_zd      : std_ulogic IS results8(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE OFl_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
   VARIABLE s4_GlitchData    : VitalGlitchDataType;
   VARIABLE s5_GlitchData    : VitalGlitchDataType;
   VARIABLE s6_GlitchData    : VitalGlitchDataType;
   VARIABLE s7_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    ci   |   co   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '0'),
    ( '1', '0', '0',     '0', '1'),
    ( '0', '1', '0',     '0', '1'),
    ( '1', '1', '0',     '1', '0'),
    ( '0', '0', '1',     '0', '1'),
    ( '1', '0', '1',     '1', '0'),
    ( '0', '1', '1',     '1', '0'),
    ( '1', '1', '1',     '1', '1'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (a0_ipd, b0_ipd, ci_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (a1_ipd, b1_ipd, c0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (a2_ipd, b2_ipd, c1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (a3_ipd, b3_ipd, c2_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (a4_ipd, b4_ipd, c3_zd)
                );
      results5 := vitaltruthtable (
                truthtable => add_table,
                datain => (a5_ipd, b5_ipd, c4_zd)
                );
      results6 := vitaltruthtable (
                truthtable => add_table,
                datain => (a6_ipd, b6_ipd, c5_zd)
                );
      results7 := vitaltruthtable (
                truthtable => add_table,
                datain => (a7_ipd, b7_ipd, c6_zd)
                );
      OFl_zd := c7_zd XOR c6_zd;

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFl,
       OutSignalName => "OFl",
       OutTemp => OFl_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_OFl, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_OFl, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_OFl, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_OFl, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_OFl, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_OFl, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_OFl, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_OFl, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_OFl, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_OFl, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_OFl, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_OFl, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_OFl, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_OFl, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_OFl, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_OFl, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_OFl, TRUE)),
       GlitchData => OFl_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s0, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s0, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s0, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s0, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s0, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s0, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s0, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s0, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s1, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s1, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s1, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s1, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s1, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s1, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s1, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s1, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s2, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s2, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s2, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s2, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s2, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s2, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s2, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s2, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s3, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s3, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s3, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s3, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s3, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s3, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s3, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s3, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s4,
       OutSignalName => "s4",
       OutTemp => s4_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s4, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s4, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s4, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s4, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s4, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s4, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s4, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s4, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s4, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s4, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s4, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s4, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s4, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s4, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s4, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s4, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s4, TRUE)),
       GlitchData => s4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s5,
       OutSignalName => "s5",
       OutTemp => s5_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s5, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s5, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s5, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s5, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s5, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s5, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s5, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s5, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s5, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s5, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s5, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s5, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s5, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s5, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s5, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s5, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s5, TRUE)),
       GlitchData => s5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s6,
       OutSignalName => "s6",
       OutTemp => s6_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s6, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s6, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s6, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s6, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s6, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s6, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s6, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s6, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s6, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s6, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s6, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s6, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s6, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s6, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s6, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s6, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s6, TRUE)),
       GlitchData => s6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s7,
       OutSignalName => "s7",
       OutTemp => s7_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s7, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s7, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s7, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s7, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s7, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s7, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s7, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s7, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s7, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s7, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s7, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s7, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s7, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s7, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s7, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s7, TRUE),
		16 => (ci_ipd'last_event, tpd_ci_s7, TRUE)),
       GlitchData => s7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fadsu4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadsu4 IS
   GENERIC(
      TimingChecksOn : boolean := TRUE;
      XOn            : boolean := FALSE;
      MsgOn          : boolean := TRUE;
      InstancePath   : string := "fadsu4";
      tpd_a0_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_bco    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_bco    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bci       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_con       : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0             :	IN    std_logic;
      a1             :	IN    std_logic;
      a2             :	IN    std_logic;
      a3             :	IN    std_logic;
      b0             :	IN    std_logic;
      b1             :	IN    std_logic;
      b2             :	IN    std_logic;
      b3             :	IN    std_logic;
      bci            :	IN    std_logic;
      con            :	IN    std_logic;
      bco            :	OUT   std_logic;
      s0             :	OUT   std_logic;
      s1             :	OUT   std_logic;
      s2             :	OUT   std_logic;
      s3             :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadsu4 : ENTITY IS TRUE;

END fadsu4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadsu4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd  : std_logic := 'X';
   SIGNAL a1_ipd  : std_logic := 'X';
   SIGNAL a2_ipd  : std_logic := 'X';
   SIGNAL a3_ipd  : std_logic := 'X';
   SIGNAL b0_ipd  : std_logic := 'X';
   SIGNAL b1_ipd  : std_logic := 'X';
   SIGNAL b2_ipd  : std_logic := 'X';
   SIGNAL b3_ipd  : std_logic := 'X';
   SIGNAL bci_ipd : std_logic := 'X';
   SIGNAL con_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (bci_ipd, bci, tipd_bci);
   VitalWireDelay (con_ipd, con, tipd_con);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, 
			    b1_ipd, b2_ipd, b3_ipd, bci_ipd, con_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS bc0_zd     : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS bc1_zd     : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
   ALIAS bc2_zd     : std_ulogic IS results3(1);
   ALIAS s2_zd      : std_ulogic IS results3(2);
   ALIAS bco_zd     : std_ulogic IS results4(1);
   ALIAS s3_zd      : std_ulogic IS results4(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE bco_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
 
   constant adsu_table : vitaltruthtabletype := (
   --------------------------------------------
   --   a    b   bci  con  |   bco   s
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

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a0_ipd, b0_ipd, bci_ipd, con_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a1_ipd, b1_ipd, bc0_zd, con_ipd)
                );
      results3 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a2_ipd, b2_ipd, bc1_zd, con_ipd)
                );
      results4 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a3_ipd, b3_ipd, bc2_zd, con_ipd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => bco,
       OutSignalName => "bco",
       OutTemp => bco_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_bco, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_bco, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_bco, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_bco, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_bco, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_bco, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_bco, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_bco, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_bco, TRUE),
		 9 => (con_ipd'last_event, tpd_con_bco, TRUE)),
       GlitchData => bco_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s0, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s1, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s2, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s3, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fadsu4o -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadsu4o IS
   GENERIC(
      TimingChecksOn : boolean := TRUE;
      XOn            : boolean := FALSE;
      MsgOn          : boolean := TRUE;
      InstancePath   : string := "fadsu4o";
      tpd_a0_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_OFl     :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_OFl    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_OFl    :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s0     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s1     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s2     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s3     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s0     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s1     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s2     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s3     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3        :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bci       :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_con       :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0             :	IN    std_logic;
      a1             :	IN    std_logic;
      a2             :	IN    std_logic;
      a3             :	IN    std_logic;
      b0             :	IN    std_logic;
      b1             :	IN    std_logic;
      b2             :	IN    std_logic;
      b3             :	IN    std_logic;
      bci            :	IN    std_logic;
      con            :	IN    std_logic;
      OFl            :	OUT   std_logic;
      s0             :	OUT   std_logic;
      s1             :	OUT   std_logic;
      s2             :	OUT   std_logic;
      s3             :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadsu4o : ENTITY IS TRUE;

END fadsu4o;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadsu4o IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd         : std_logic := 'X';
   SIGNAL a1_ipd         : std_logic := 'X';
   SIGNAL a2_ipd         : std_logic := 'X';
   SIGNAL a3_ipd         : std_logic := 'X';
   SIGNAL b0_ipd         : std_logic := 'X';
   SIGNAL b1_ipd         : std_logic := 'X';
   SIGNAL b2_ipd         : std_logic := 'X';
   SIGNAL b3_ipd         : std_logic := 'X';
   SIGNAL bci_ipd        : std_logic := 'X';
   SIGNAL con_ipd        : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (bci_ipd, bci, tipd_bci);
   VitalWireDelay (con_ipd, con, tipd_con);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, 
			    b1_ipd, b2_ipd, b3_ipd, bci_ipd, con_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS bc0_zd     : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS bc1_zd     : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
   ALIAS bc2_zd     : std_ulogic IS results3(1);
   ALIAS s2_zd      : std_ulogic IS results3(2);
   ALIAS bc3_zd     : std_ulogic IS results4(1);
   ALIAS s3_zd      : std_ulogic IS results4(2);
   ALIAS OFl_zd     : std_ulogic IS results5(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE OFl_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
 
   constant adsu_table : vitaltruthtabletype := (
   --------------------------------------------
   --   a    b   bci  con  |   bco   s
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

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a0_ipd, b0_ipd, bci_ipd, con_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a1_ipd, b1_ipd, bc0_zd, con_ipd)
                );
      results3 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a2_ipd, b2_ipd, bc1_zd, con_ipd)
                );
      results4 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a3_ipd, b3_ipd, bc2_zd, con_ipd)
                );
      OFl_zd := bc3_zd XOR bc2_zd;
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFl,
       OutSignalName => "OFl",
       OutTemp => OFl_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_OFl, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_OFl, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_OFl, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_OFl, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_OFl, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_OFl, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_OFl, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_OFl, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_OFl, TRUE),
		 9 => (con_ipd'last_event, tpd_con_OFl, TRUE)),
       GlitchData => OFl_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s0, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s1, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s2, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
		 8 => (bci_ipd'last_event, tpd_bci_s3, TRUE),
		 9 => (con_ipd'last_event, tpd_con_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fadsu8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadsu8 IS
   GENERIC(
      TimingChecksOn : boolean := TRUE;
      XOn            : boolean := FALSE;
      MsgOn          : boolean := TRUE;
      InstancePath   : string := "fadsu8";
      tpd_a0_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_bco     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_bco    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_bco    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bci       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_con       : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic;
      bci                            : IN std_logic;
      con                            : IN std_logic;
      bco                            : OUT std_logic;
      s0, s1, s2, s3, s4, s5, s6, s7 : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF fadsu8 : ENTITY IS TRUE;

END fadsu8;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadsu8 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd  : std_logic := 'X';
   SIGNAL a1_ipd  : std_logic := 'X';
   SIGNAL a2_ipd  : std_logic := 'X';
   SIGNAL a3_ipd  : std_logic := 'X';
   SIGNAL a4_ipd  : std_logic := 'X';
   SIGNAL a5_ipd  : std_logic := 'X';
   SIGNAL a6_ipd  : std_logic := 'X';
   SIGNAL a7_ipd  : std_logic := 'X';
   SIGNAL b0_ipd  : std_logic := 'X';
   SIGNAL b1_ipd  : std_logic := 'X';
   SIGNAL b2_ipd  : std_logic := 'X';
   SIGNAL b3_ipd  : std_logic := 'X';
   SIGNAL b4_ipd  : std_logic := 'X';
   SIGNAL b5_ipd  : std_logic := 'X';
   SIGNAL b6_ipd  : std_logic := 'X';
   SIGNAL b7_ipd  : std_logic := 'X';
   SIGNAL bci_ipd : std_logic := 'X';
   SIGNAL con_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (bci_ipd, bci, tipd_bci);
   VitalWireDelay (con_ipd, con, tipd_con);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd,
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, bci_ipd, con_ipd)
 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results6 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results7 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS bc0_zd     : std_ulogic IS results0(1);
   ALIAS s0_zd      : std_ulogic IS results0(2);
   ALIAS bc1_zd     : std_ulogic IS results1(1);
   ALIAS s1_zd      : std_ulogic IS results1(2);
   ALIAS bc2_zd     : std_ulogic IS results2(1);
   ALIAS s2_zd      : std_ulogic IS results2(2);
   ALIAS bc3_zd     : std_ulogic IS results3(1);
   ALIAS s3_zd      : std_ulogic IS results3(2);
   ALIAS bc4_zd     : std_ulogic IS results4(1);
   ALIAS s4_zd      : std_ulogic IS results4(2);
   ALIAS bc5_zd     : std_ulogic IS results5(1);
   ALIAS s5_zd      : std_ulogic IS results5(2);
   ALIAS bc6_zd     : std_ulogic IS results6(1);
   ALIAS s6_zd      : std_ulogic IS results6(2);
   ALIAS bco_zd     : std_ulogic IS results7(1);
   ALIAS s7_zd      : std_ulogic IS results7(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE bco_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
   VARIABLE s4_GlitchData    : VitalGlitchDataType;
   VARIABLE s5_GlitchData    : VitalGlitchDataType;
   VARIABLE s6_GlitchData    : VitalGlitchDataType;
   VARIABLE s7_GlitchData    : VitalGlitchDataType;
 
   constant adsu_table : vitaltruthtabletype := (
   --------------------------------------------
   --   a    b   bci  con  |   bco   s
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

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a0_ipd, b0_ipd, bci_ipd, con_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a1_ipd, b1_ipd, bc0_zd, con_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a2_ipd, b2_ipd, bc1_zd, con_ipd)
                );
      results3 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a3_ipd, b3_ipd, bc2_zd, con_ipd)
                );
      results4 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a4_ipd, b4_ipd, bc3_zd, con_ipd)
                );
      results5 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a5_ipd, b5_ipd, bc4_zd, con_ipd)
                );
      results6 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a6_ipd, b6_ipd, bc5_zd, con_ipd)
                );
      results7 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a7_ipd, b7_ipd, bc6_zd, con_ipd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => bco,
       OutSignalName => "bco",
       OutTemp => bco_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_bco, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_bco, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_bco, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_bco, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_bco, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_bco, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_bco, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_bco, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_bco, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_bco, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_bco, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_bco, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_bco, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_bco, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_bco, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_bco, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_bco, TRUE),
		17 => (con_ipd'last_event, tpd_con_bco, TRUE)),
       GlitchData => bco_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s0, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s0, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s0, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s0, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s0, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s0, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s0, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s0, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s0, TRUE),
		17 => (con_ipd'last_event, tpd_con_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s1, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s1, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s1, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s1, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s1, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s1, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s1, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s1, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s1, TRUE),
		17 => (con_ipd'last_event, tpd_con_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s2, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s2, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s2, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s2, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s2, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s2, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s2, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s2, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s2, TRUE),
		17 => (con_ipd'last_event, tpd_con_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s3, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s3, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s3, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s3, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s3, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s3, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s3, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s3, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s3, TRUE),
		17 => (con_ipd'last_event, tpd_con_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s4,
       OutSignalName => "s4",
       OutTemp => s4_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s4, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s4, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s4, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s4, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s4, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s4, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s4, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s4, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s4, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s4, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s4, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s4, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s4, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s4, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s4, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s4, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s4, TRUE),
		17 => (con_ipd'last_event, tpd_con_s4, TRUE)),
       GlitchData => s4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s5,
       OutSignalName => "s5",
       OutTemp => s5_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s5, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s5, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s5, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s5, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s5, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s5, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s5, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s5, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s5, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s5, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s5, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s5, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s5, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s5, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s5, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s5, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s5, TRUE),
		17 => (con_ipd'last_event, tpd_con_s5, TRUE)),
       GlitchData => s5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s6,
       OutSignalName => "s6",
       OutTemp => s6_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s6, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s6, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s6, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s6, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s6, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s6, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s6, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s6, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s6, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s6, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s6, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s6, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s6, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s6, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s6, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s6, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s6, TRUE),
		17 => (con_ipd'last_event, tpd_con_s6, TRUE)),
       GlitchData => s6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s7,
       OutSignalName => "s7",
       OutTemp => s7_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s7, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s7, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s7, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s7, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s7, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s7, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s7, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s7, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s7, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s7, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s7, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s7, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s7, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s7, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s7, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s7, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s7, TRUE),
		17 => (con_ipd'last_event, tpd_con_s7, TRUE)),
       GlitchData => s7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fadsu8o -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadsu8o IS
   GENERIC(
      TimingChecksOn : boolean := TRUE;
      XOn            : boolean := FALSE;
      MsgOn          : boolean := TRUE;
      InstancePath   : string := "fadsu8o";
      tpd_a0_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_OFl     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_OFl    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bci_s7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_OFl    : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_s7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bci       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_con       : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN   std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN   std_logic;
      bci                            : IN   std_logic;
      con                            : IN   std_logic;
      OFl                            : OUT  std_logic;
      s0, s1, s2, s3, s4, s5, s6, s7 : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF fadsu8o : ENTITY IS TRUE;

END fadsu8o;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadsu8o IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd  : std_logic := 'X';
   SIGNAL a1_ipd  : std_logic := 'X';
   SIGNAL a2_ipd  : std_logic := 'X';
   SIGNAL a3_ipd  : std_logic := 'X';
   SIGNAL a4_ipd  : std_logic := 'X';
   SIGNAL a5_ipd  : std_logic := 'X';
   SIGNAL a6_ipd  : std_logic := 'X';
   SIGNAL a7_ipd  : std_logic := 'X';
   SIGNAL b0_ipd  : std_logic := 'X';
   SIGNAL b1_ipd  : std_logic := 'X';
   SIGNAL b2_ipd  : std_logic := 'X';
   SIGNAL b3_ipd  : std_logic := 'X';
   SIGNAL b4_ipd  : std_logic := 'X';
   SIGNAL b5_ipd  : std_logic := 'X';
   SIGNAL b6_ipd  : std_logic := 'X';
   SIGNAL b7_ipd  : std_logic := 'X';
   SIGNAL bci_ipd : std_logic := 'X';
   SIGNAL con_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (bci_ipd, bci, tipd_bci);
   VitalWireDelay (con_ipd, con, tipd_con);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd,
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, bci_ipd, con_ipd)
 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results6 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results7 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results8 : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS bc0_zd     : std_ulogic IS results0(1);
   ALIAS s0_zd      : std_ulogic IS results0(2);
   ALIAS bc1_zd     : std_ulogic IS results1(1);
   ALIAS s1_zd      : std_ulogic IS results1(2);
   ALIAS bc2_zd     : std_ulogic IS results2(1);
   ALIAS s2_zd      : std_ulogic IS results2(2);
   ALIAS bc3_zd     : std_ulogic IS results3(1);
   ALIAS s3_zd      : std_ulogic IS results3(2);
   ALIAS bc4_zd     : std_ulogic IS results4(1);
   ALIAS s4_zd      : std_ulogic IS results4(2);
   ALIAS bc5_zd     : std_ulogic IS results5(1);
   ALIAS s5_zd      : std_ulogic IS results5(2);
   ALIAS bc6_zd     : std_ulogic IS results6(1);
   ALIAS s6_zd      : std_ulogic IS results6(2);
   ALIAS bc7_zd     : std_ulogic IS results7(1);
   ALIAS s7_zd      : std_ulogic IS results7(2);
   ALIAS OFl_zd     : std_ulogic IS results8(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE OFl_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
   VARIABLE s4_GlitchData    : VitalGlitchDataType;
   VARIABLE s5_GlitchData    : VitalGlitchDataType;
   VARIABLE s6_GlitchData    : VitalGlitchDataType;
   VARIABLE s7_GlitchData    : VitalGlitchDataType;
 
   constant adsu_table : vitaltruthtabletype := (
   --------------------------------------------
   --   a    b   bci  con  |   bco   s
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

   BEGIN

      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a0_ipd, b0_ipd, bci_ipd, con_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a1_ipd, b1_ipd, bc0_zd, con_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a2_ipd, b2_ipd, bc1_zd, con_ipd)
                );
      results3 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a3_ipd, b3_ipd, bc2_zd, con_ipd)
                );
      results4 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a4_ipd, b4_ipd, bc3_zd, con_ipd)
                );
      results5 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a5_ipd, b5_ipd, bc4_zd, con_ipd)
                );
      results6 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a6_ipd, b6_ipd, bc5_zd, con_ipd)
                );
      results7 := vitaltruthtable (
                truthtable => adsu_table,
                datain => (a7_ipd, b7_ipd, bc6_zd, con_ipd)
                );
      OFl_zd := bc7_zd XOR bc6_zd;
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFl,
       OutSignalName => "OFl",
       OutTemp => OFl_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_OFl, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_OFl, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_OFl, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_OFl, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_OFl, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_OFl, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_OFl, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_OFl, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_OFl, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_OFl, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_OFl, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_OFl, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_OFl, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_OFl, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_OFl, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_OFl, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_OFl, TRUE),
		17 => (con_ipd'last_event, tpd_con_OFl, TRUE)),
       GlitchData => OFl_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s0, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s0, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s0, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s0, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s0, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s0, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s0, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s0, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s0, TRUE),
		17 => (con_ipd'last_event, tpd_con_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s1, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s1, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s1, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s1, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s1, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s1, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s1, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s1, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s1, TRUE),
		17 => (con_ipd'last_event, tpd_con_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s2, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s2, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s2, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s2, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s2, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s2, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s2, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s2, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s2, TRUE),
		17 => (con_ipd'last_event, tpd_con_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s3, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s3, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s3, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s3, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s3, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s3, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s3, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s3, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s3, TRUE),
		17 => (con_ipd'last_event, tpd_con_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s4,
       OutSignalName => "s4",
       OutTemp => s4_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s4, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s4, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s4, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s4, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s4, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s4, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s4, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s4, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s4, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s4, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s4, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s4, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s4, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s4, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s4, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s4, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s4, TRUE),
		17 => (con_ipd'last_event, tpd_con_s4, TRUE)),
       GlitchData => s4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s5,
       OutSignalName => "s5",
       OutTemp => s5_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s5, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s5, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s5, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s5, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s5, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s5, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s5, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s5, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s5, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s5, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s5, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s5, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s5, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s5, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s5, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s5, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s5, TRUE),
		17 => (con_ipd'last_event, tpd_con_s5, TRUE)),
       GlitchData => s5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s6,
       OutSignalName => "s6",
       OutTemp => s6_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s6, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s6, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s6, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s6, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s6, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s6, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s6, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s6, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s6, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s6, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s6, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s6, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s6, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s6, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s6, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s6, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s6, TRUE),
		17 => (con_ipd'last_event, tpd_con_s6, TRUE)),
       GlitchData => s6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s7,
       OutSignalName => "s7",
       OutTemp => s7_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s7, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s7, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s7, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s7, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s7, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s7, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s7, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s7, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s7, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s7, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s7, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s7, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s7, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s7, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s7, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s7, TRUE),
		16 => (bci_ipd'last_event, tpd_bci_s7, TRUE),
		17 => (con_ipd'last_event, tpd_con_s7, TRUE)),
       GlitchData => s7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fsub4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fsub4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fsub4";
      tpd_a0_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bi         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0                     :	IN    std_logic;
      a1                     :	IN    std_logic;
      a2                     :	IN    std_logic;
      a3                     :	IN    std_logic;
      b0                     :	IN    std_logic;
      b1                     :	IN    std_logic;
      b2                     :	IN    std_logic;
      b3                     :	IN    std_logic;
      bi                     :	IN    std_logic;
      bo                     :	OUT   std_logic;
      s0                     :	OUT   std_logic;
      s1                     :	OUT   std_logic;
      s2                     :	OUT   std_logic;
      s3                     :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fsub4 : ENTITY IS TRUE;

END fsub4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fsub4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd         : std_logic := 'X';
   SIGNAL a1_ipd         : std_logic := 'X';
   SIGNAL a2_ipd         : std_logic := 'X';
   SIGNAL a3_ipd         : std_logic := 'X';
   SIGNAL b0_ipd         : std_logic := 'X';
   SIGNAL b1_ipd         : std_logic := 'X';
   SIGNAL b2_ipd         : std_logic := 'X';
   SIGNAL b3_ipd         : std_logic := 'X';
   SIGNAL bi_ipd         : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (bi_ipd, bi, tipd_bi);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, 
			    b1_ipd, b2_ipd, b3_ipd, bi_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS b1_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
   ALIAS b2_zd      : std_ulogic IS results3(1);
   ALIAS s2_zd      : std_ulogic IS results3(2);
   ALIAS bo_zd      : std_ulogic IS results4(1);
   ALIAS s3_zd      : std_ulogic IS results4(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE bo_GlitchData    : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
 
   constant sub_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    bi   |   bo   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a0_ipd, b0_ipd, bi_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a1_ipd, b1_ipd, b0_zd)
                );
      results3 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a2_ipd, b2_ipd, b1_zd)
                );
      results4 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a3_ipd, b3_ipd, b2_zd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => bo,
       OutSignalName => "bo",
       OutTemp => bo_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_bo, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_bo, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_bo, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_bo, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_bo, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_bo, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_bo, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_bo, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_bo, TRUE)),
       GlitchData => bo_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fsub4o -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fsub4o IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fsub4o";
      tpd_a0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bi         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      a2              :	IN    std_logic;
      a3              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      b2              :	IN    std_logic;
      b3              :	IN    std_logic;
      bi              :	IN    std_logic;
      OFl             :	OUT   std_logic;
      s0              :	OUT   std_logic;
      s1              :	OUT   std_logic;
      s2              :	OUT   std_logic;
      s3              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fsub4o : ENTITY IS TRUE;

END fsub4o;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fsub4o IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd         : std_logic := 'X';
   SIGNAL a1_ipd         : std_logic := 'X';
   SIGNAL a2_ipd         : std_logic := 'X';
   SIGNAL a3_ipd         : std_logic := 'X';
   SIGNAL b0_ipd         : std_logic := 'X';
   SIGNAL b1_ipd         : std_logic := 'X';
   SIGNAL b2_ipd         : std_logic := 'X';
   SIGNAL b3_ipd         : std_logic := 'X';
   SIGNAL bi_ipd         : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (bi_ipd, bi, tipd_bi);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd, 
			    b1_ipd, b2_ipd, b3_ipd, bi_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS b0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS b1_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
   ALIAS b2_zd      : std_ulogic IS results3(1);
   ALIAS s2_zd      : std_ulogic IS results3(2);
   ALIAS b3_zd      : std_ulogic IS results4(1);
   ALIAS s3_zd      : std_ulogic IS results4(2);
   ALIAS OFl_zd     : std_ulogic IS results5(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE OFl_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
 
   constant sub_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    bi   |   bo   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a0_ipd, b0_ipd, bi_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a1_ipd, b1_ipd, b0_zd)
                );
      results3 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a2_ipd, b2_ipd, b1_zd)
                );
      results4 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a3_ipd, b3_ipd, b2_zd)
                );
      OFl_zd  := b3_zd XOR b2_zd;
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFl,
       OutSignalName => "OFl",
       OutTemp => OFl_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_OFl, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_OFl, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_OFl, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_OFl, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_OFl, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_OFl, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_OFl, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_OFl, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_OFl, TRUE)),
       GlitchData => OFl_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
		 8 => (bi_ipd'last_event, tpd_bi_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fsub8 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fsub8 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fsub8";
      tpd_a0_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_bo       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bi         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN   std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN   std_logic;
      bi                             : IN   std_logic;
      bo                             : OUT  std_logic;
      s0, s1, s2, s3, s4, s5, s6, s7 : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF fsub8 : ENTITY IS TRUE;

END fsub8;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fsub8 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd         : std_logic := 'X';
   SIGNAL a1_ipd         : std_logic := 'X';
   SIGNAL a2_ipd         : std_logic := 'X';
   SIGNAL a3_ipd         : std_logic := 'X';
   SIGNAL a4_ipd         : std_logic := 'X';
   SIGNAL a5_ipd         : std_logic := 'X';
   SIGNAL a6_ipd         : std_logic := 'X';
   SIGNAL a7_ipd         : std_logic := 'X';
   SIGNAL b0_ipd         : std_logic := 'X';
   SIGNAL b1_ipd         : std_logic := 'X';
   SIGNAL b2_ipd         : std_logic := 'X';
   SIGNAL b3_ipd         : std_logic := 'X';
   SIGNAL b4_ipd         : std_logic := 'X';
   SIGNAL b5_ipd         : std_logic := 'X';
   SIGNAL b6_ipd         : std_logic := 'X';
   SIGNAL b7_ipd         : std_logic := 'X';
   SIGNAL bi_ipd         : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (bi_ipd, bi, tipd_bi);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd,
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, bi_ipd)
 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results6 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results7 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b0_zd      : std_ulogic IS results0(1);
   ALIAS s0_zd      : std_ulogic IS results0(2);
   ALIAS b1_zd      : std_ulogic IS results1(1);
   ALIAS s1_zd      : std_ulogic IS results1(2);
   ALIAS b2_zd      : std_ulogic IS results2(1);
   ALIAS s2_zd      : std_ulogic IS results2(2);
   ALIAS b3_zd      : std_ulogic IS results3(1);
   ALIAS s3_zd      : std_ulogic IS results3(2);
   ALIAS b4_zd      : std_ulogic IS results4(1);
   ALIAS s4_zd      : std_ulogic IS results4(2);
   ALIAS b5_zd      : std_ulogic IS results5(1);
   ALIAS s5_zd      : std_ulogic IS results5(2);
   ALIAS b6_zd      : std_ulogic IS results6(1);
   ALIAS s6_zd      : std_ulogic IS results6(2);
   ALIAS bo_zd      : std_ulogic IS results7(1);
   ALIAS s7_zd      : std_ulogic IS results7(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE bo_GlitchData    : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
   VARIABLE s4_GlitchData    : VitalGlitchDataType;
   VARIABLE s5_GlitchData    : VitalGlitchDataType;
   VARIABLE s6_GlitchData    : VitalGlitchDataType;
   VARIABLE s7_GlitchData    : VitalGlitchDataType;
 
   constant sub_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    bi   |   bo   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a0_ipd, b0_ipd, bi_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a1_ipd, b1_ipd, b0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a2_ipd, b2_ipd, b1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a3_ipd, b3_ipd, b2_zd)
                );
      results4 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a4_ipd, b4_ipd, b3_zd)
                );
      results5 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a5_ipd, b5_ipd, b4_zd)
                );
      results6 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a6_ipd, b6_ipd, b5_zd)
                );
      results7 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a7_ipd, b7_ipd, b6_zd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => bo,
       OutSignalName => "bo",
       OutTemp => bo_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_bo, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_bo, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_bo, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_bo, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_bo, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_bo, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_bo, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_bo, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_bo, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_bo, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_bo, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_bo, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_bo, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_bo, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_bo, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_bo, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_bo, TRUE)),
       GlitchData => bo_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s0, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s0, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s0, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s0, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s0, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s0, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s0, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s0, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s1, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s1, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s1, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s1, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s1, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s1, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s1, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s1, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s2, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s2, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s2, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s2, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s2, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s2, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s2, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s2, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s3, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s3, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s3, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s3, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s3, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s3, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s3, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s3, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s4,
       OutSignalName => "s4",
       OutTemp => s4_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s4, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s4, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s4, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s4, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s4, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s4, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s4, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s4, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s4, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s4, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s4, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s4, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s4, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s4, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s4, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s4, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s4, TRUE)),
       GlitchData => s4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s5,
       OutSignalName => "s5",
       OutTemp => s5_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s5, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s5, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s5, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s5, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s5, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s5, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s5, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s5, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s5, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s5, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s5, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s5, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s5, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s5, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s5, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s5, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s5, TRUE)),
       GlitchData => s5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s6,
       OutSignalName => "s6",
       OutTemp => s6_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s6, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s6, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s6, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s6, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s6, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s6, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s6, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s6, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s6, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s6, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s6, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s6, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s6, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s6, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s6, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s6, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s6, TRUE)),
       GlitchData => s6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s7,
       OutSignalName => "s7",
       OutTemp => s7_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s7, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s7, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s7, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s7, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s7, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s7, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s7, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s7, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s7, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s7, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s7, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s7, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s7, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s7, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s7, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s7, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s7, TRUE)),
       GlitchData => s7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fsub8o -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fsub8o IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fsub8o";
      tpd_a0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a4_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a5_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a6_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_a7_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b0_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b1_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b2_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s0       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s1       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s2       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s3       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s4       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s5       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s6       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b3_s7       :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b4_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b5_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b6_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_OFl      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b7_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_OFl      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s4       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s5       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s6       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_bi_s7       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b2         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b3         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b4         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b5         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b6         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b7         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bi         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1, a2, a3, a4, a5, a6, a7 : IN   std_logic;
      b0, b1, b2, b3, b4, b5, b6, b7 : IN   std_logic;
      bi                             : IN   std_logic;
      OFl                            : OUT  std_logic;
      s0, s1, s2, s3, s4, s5, s6, s7 : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF fsub8o : ENTITY IS TRUE;

END fsub8o;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fsub8o IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd         : std_logic := 'X';
   SIGNAL a1_ipd         : std_logic := 'X';
   SIGNAL a2_ipd         : std_logic := 'X';
   SIGNAL a3_ipd         : std_logic := 'X';
   SIGNAL a4_ipd         : std_logic := 'X';
   SIGNAL a5_ipd         : std_logic := 'X';
   SIGNAL a6_ipd         : std_logic := 'X';
   SIGNAL a7_ipd         : std_logic := 'X';
   SIGNAL b0_ipd         : std_logic := 'X';
   SIGNAL b1_ipd         : std_logic := 'X';
   SIGNAL b2_ipd         : std_logic := 'X';
   SIGNAL b3_ipd         : std_logic := 'X';
   SIGNAL b4_ipd         : std_logic := 'X';
   SIGNAL b5_ipd         : std_logic := 'X';
   SIGNAL b6_ipd         : std_logic := 'X';
   SIGNAL b7_ipd         : std_logic := 'X';
   SIGNAL bi_ipd         : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (bi_ipd, bi, tipd_bi);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd, a5_ipd,
	a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd, b5_ipd, 
	b6_ipd, b7_ipd, bi_ipd)
 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results6 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results7 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results8 : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS b0_zd      : std_ulogic IS results0(1);
   ALIAS s0_zd      : std_ulogic IS results0(2);
   ALIAS b1_zd      : std_ulogic IS results1(1);
   ALIAS s1_zd      : std_ulogic IS results1(2);
   ALIAS b2_zd      : std_ulogic IS results2(1);
   ALIAS s2_zd      : std_ulogic IS results2(2);
   ALIAS b3_zd      : std_ulogic IS results3(1);
   ALIAS s3_zd      : std_ulogic IS results3(2);
   ALIAS b4_zd      : std_ulogic IS results4(1);
   ALIAS s4_zd      : std_ulogic IS results4(2);
   ALIAS b5_zd      : std_ulogic IS results5(1);
   ALIAS s5_zd      : std_ulogic IS results5(2);
   ALIAS b6_zd      : std_ulogic IS results6(1);
   ALIAS s6_zd      : std_ulogic IS results6(2);
   ALIAS b7_zd      : std_ulogic IS results7(1);
   ALIAS s7_zd      : std_ulogic IS results7(2);
   ALIAS OFl_zd     : std_ulogic IS results8(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE OFl_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
   VARIABLE s2_GlitchData    : VitalGlitchDataType;
   VARIABLE s3_GlitchData    : VitalGlitchDataType;
   VARIABLE s4_GlitchData    : VitalGlitchDataType;
   VARIABLE s5_GlitchData    : VitalGlitchDataType;
   VARIABLE s6_GlitchData    : VitalGlitchDataType;
   VARIABLE s7_GlitchData    : VitalGlitchDataType;
 
   constant sub_table : vitaltruthtabletype := (
   --------------------------------------------
   --  a    b    bi   |   bo   s
   --------------------------------------------
    ( '0', '0', '0',     '0', '1'),
    ( '1', '0', '0',     '1', '0'),
    ( '0', '1', '0',     '0', '0'),
    ( '1', '1', '0',     '0', '1'),
    ( '0', '0', '1',     '1', '0'),
    ( '1', '0', '1',     '1', '1'),
    ( '0', '1', '1',     '0', '1'),
    ( '1', '1', '1',     '1', '0'));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a0_ipd, b0_ipd, bi_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a1_ipd, b1_ipd, b0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a2_ipd, b2_ipd, b1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a3_ipd, b3_ipd, b2_zd)
                );
      results4 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a4_ipd, b4_ipd, b3_zd)
                );
      results5 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a5_ipd, b5_ipd, b4_zd)
                );
      results6 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a6_ipd, b6_ipd, b5_zd)
                );
      results7 := vitaltruthtable (
                truthtable => sub_table,
                datain => (a7_ipd, b7_ipd, b6_zd)
                );
      OFl_zd := b7_zd XOR b6_zd;
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => OFl,
       OutSignalName => "OFl",
       OutTemp => OFl_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_OFl, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_OFl, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_OFl, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_OFl, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_OFl, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_OFl, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_OFl, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_OFl, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_OFl, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_OFl, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_OFl, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_OFl, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_OFl, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_OFl, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_OFl, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_OFl, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_OFl, TRUE)),
       GlitchData => OFl_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s0, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s0, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s0, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s0, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s0, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s0, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s0, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s0, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s0, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s0, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s0, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s0, TRUE)),
       GlitchData => s0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s1,
       OutSignalName => "s1",
       OutTemp => s1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s1, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s1, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s1, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s1, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s1, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s1, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s1, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s1, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s1, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s1, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s1, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s2,
       OutSignalName => "s2",
       OutTemp => s2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s2, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s2, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s2, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s2, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s2, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s2, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s2, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s2, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s2, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s2, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s2, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s2, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s2, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s2, TRUE)),
       GlitchData => s2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s3,
       OutSignalName => "s3",
       OutTemp => s3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s3, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s3, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s3, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s3, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s3, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s3, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s3, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s3, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s3, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s3, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s3, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s3, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s3, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s3, TRUE)),
       GlitchData => s3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s4,
       OutSignalName => "s4",
       OutTemp => s4_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s4, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s4, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s4, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s4, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s4, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s4, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s4, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s4, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s4, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s4, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s4, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s4, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s4, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s4, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s4, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s4, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s4, TRUE)),
       GlitchData => s4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s5,
       OutSignalName => "s5",
       OutTemp => s5_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s5, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s5, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s5, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s5, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s5, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s5, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s5, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s5, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s5, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s5, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s5, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s5, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s5, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s5, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s5, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s5, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s5, TRUE)),
       GlitchData => s5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s6,
       OutSignalName => "s6",
       OutTemp => s6_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s6, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s6, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s6, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s6, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s6, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s6, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s6, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s6, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s6, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s6, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s6, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s6, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s6, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s6, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s6, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s6, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s6, TRUE)),
       GlitchData => s6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => s7,
       OutSignalName => "s7",
       OutTemp => s7_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s7, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s7, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_s7, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_s7, TRUE),
                 4 => (a4_ipd'last_event, tpd_a4_s7, TRUE),
                 5 => (a5_ipd'last_event, tpd_a5_s7, TRUE),
                 6 => (a6_ipd'last_event, tpd_a6_s7, TRUE),
                 7 => (a7_ipd'last_event, tpd_a7_s7, TRUE),
                 8 => (b0_ipd'last_event, tpd_b0_s7, TRUE),
                 9 => (b1_ipd'last_event, tpd_b1_s7, TRUE),
                10 => (b2_ipd'last_event, tpd_b2_s7, TRUE),
                11 => (b3_ipd'last_event, tpd_b3_s7, TRUE),
                12 => (b4_ipd'last_event, tpd_b4_s7, TRUE),
                13 => (b5_ipd'last_event, tpd_b5_s7, TRUE),
                14 => (b6_ipd'last_event, tpd_b6_s7, TRUE),
                15 => (b7_ipd'last_event, tpd_b7_s7, TRUE),
		16 => (bi_ipd'last_event, tpd_bi_s7, TRUE)),
       GlitchData => s7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell inv -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY inv IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "inv";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a                              :	IN    std_logic;
      z                              :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF inv : ENTITY IS TRUE;

END inv;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF inv IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (NOT a_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell mux21 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux21 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "mux21";
      tpd_d0_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d1_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sd_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_d0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      sd              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux21 : ENTITY IS TRUE;

END mux21;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux21 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL d0_ipd	 : std_logic := 'X';
   SIGNAL d1_ipd	 : std_logic := 'X';
   SIGNAL sd_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (d0_ipd, d0, tipd_d0);
   VitalWireDelay (d1_ipd, d1, tipd_d1);
   VitalWireDelay (sd_ipd, sd, tipd_sd);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sd_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := vitalmux
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sd_ipd));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (d0_ipd'last_event, tpd_d0_z, TRUE),
                 1 => (d1_ipd'last_event, tpd_d1_z, TRUE),
                 2 => (sd_ipd'last_event, tpd_sd_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell mux21e -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux21e IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "mux21e";
      tpd_d0_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d1_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sd_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_d0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      e               :	IN    std_logic;
      sd              :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF mux21e : ENTITY IS TRUE;

END mux21e;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux21e IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL d0_ipd	 : std_logic := 'X';
   SIGNAL d1_ipd	 : std_logic := 'X';
   SIGNAL e_ipd		 : std_logic := 'X';
   SIGNAL sd_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (d0_ipd, d0, tipd_d0);
   VitalWireDelay (d1_ipd, d1, tipd_d1);
   VitalWireDelay (e_ipd,  e,  tipd_e);
   VitalWireDelay (sd_ipd, sd, tipd_sd);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, e_ipd, sd_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := 
       ((sd_ipd) AND (e_ipd) AND (d1_ipd)) OR (((NOT sd_ipd)) AND (e_ipd)
         AND (d0_ipd));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (d0_ipd'last_event, tpd_d0_z, TRUE),
                 1 => (d1_ipd'last_event, tpd_d1_z, TRUE),
                 2 => (e_ipd'last_event, tpd_e_z, TRUE),
                 3 => (sd_ipd'last_event, tpd_sd_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell mux41 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux41 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "mux41";
      tpd_d0_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d1_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d2_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d3_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sd1_z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sd2_z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_d0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d2         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d3         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd2        : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      d2              :	IN    std_logic;
      d3              :	IN    std_logic;
      sd1             :	IN    std_logic;
      sd2             :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux41 : ENTITY IS TRUE;

END mux41;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux41 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL d0_ipd	 : std_logic := 'X';
   SIGNAL d1_ipd	 : std_logic := 'X';
   SIGNAL d2_ipd	 : std_logic := 'X';
   SIGNAL d3_ipd	 : std_logic := 'X';
   SIGNAL sd1_ipd	 : std_logic := 'X';
   SIGNAL sd2_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (d0_ipd, d0, tipd_d0);
   VitalWireDelay (d1_ipd, d1, tipd_d1);
   VitalWireDelay (d2_ipd, d2, tipd_d2);
   VitalWireDelay (d3_ipd, d3, tipd_d3);
   VitalWireDelay (sd1_ipd, sd1, tipd_sd1);
   VitalWireDelay (sd2_ipd, sd2, tipd_sd2);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, d2_ipd, d3_ipd, sd1_ipd, sd2_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := vitalmux
                 (data => (d3_ipd, d2_ipd, d1_ipd, d0_ipd),
                  dselect => (sd2_ipd, sd1_ipd));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
          Paths => (0 => (d0_ipd'last_event, tpd_d0_z, TRUE),
                 1 => (d1_ipd'last_event, tpd_d1_z, TRUE),
                 2 => (d2_ipd'last_event, tpd_d2_z, TRUE),
                 3 => (d3_ipd'last_event, tpd_d3_z, TRUE),
		 4 => (sd1_ipd'last_event, tpd_sd1_z, TRUE),
                 5 => (sd2_ipd'last_event, tpd_sd2_z, TRUE)),

       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell mux41e -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux41e IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "mux41e";
      tpd_d0_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d1_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d2_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d3_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sd1_z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sd2_z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_d0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d2         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d3         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      d2              :	IN    std_logic;
      d3              :	IN    std_logic;
      sd1             :	IN    std_logic;
      sd2             :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux41e : ENTITY IS TRUE;

END mux41e;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux41e IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL d0_ipd  : std_logic := 'X';
   SIGNAL d1_ipd  : std_logic := 'X';
   SIGNAL d2_ipd  : std_logic := 'X';
   SIGNAL d3_ipd  : std_logic := 'X';
   SIGNAL sd1_ipd : std_logic := 'X';
   SIGNAL sd2_ipd : std_logic := 'X';
   SIGNAL e_ipd   : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (d0_ipd, d0, tipd_d0);
   VitalWireDelay (d1_ipd, d1, tipd_d1);
   VitalWireDelay (d2_ipd, d2, tipd_d2);
   VitalWireDelay (d3_ipd, d3, tipd_d3);
   VitalWireDelay (sd1_ipd, sd1, tipd_sd1);
   VitalWireDelay (sd2_ipd, sd2, tipd_sd2);
   VitalWireDelay (e_ipd, e, tipd_e);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, d2_ipd, d3_ipd, sd1_ipd, sd2_ipd, e_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := 

       ((sd1_ipd) AND (e_ipd) AND ((NOT sd2_ipd)) AND (d1_ipd)) OR (((not
         sd1_ipd)) AND (e_ipd) AND ((NOT sd2_ipd)) AND (d0_ipd)) OR (((not
         sd1_ipd)) AND (e_ipd) AND (sd2_ipd) AND (d2_ipd)) OR ((sd1_ipd) AND
         (e_ipd) AND (sd2_ipd) AND (d3_ipd));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (d0_ipd'last_event, tpd_d0_z, TRUE),
                 1 => (d1_ipd'last_event, tpd_d1_z, TRUE),
                 2 => (d2_ipd'last_event, tpd_d2_z, TRUE),
                 3 => (d3_ipd'last_event, tpd_d3_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (sd1_ipd'last_event, tpd_sd1_z, TRUE),
                 6 => (sd2_ipd'last_event, tpd_sd2_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nd2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd2 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nd2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd2 : ENTITY IS TRUE;

END nd2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd AND b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nd3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd3 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nd3";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd3 : ENTITY IS TRUE;

END nd3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd3 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	: std_logic := 'X';
   SIGNAL b_ipd	: std_logic := 'X';
   SIGNAL c_ipd	: std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd AND b_ipd AND c_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nd4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd4 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nd4";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd4 : ENTITY IS TRUE;

END nd4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd AND b_ipd AND c_ipd AND d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nd5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nd5 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nd5";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nd5 : ENTITY IS TRUE;

END nd5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nd5 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd AND b_ipd AND c_ipd AND d_ipd AND e_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nr2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr2 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nr2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr2 : ENTITY IS TRUE;

END nr2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd OR b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nr3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr3 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nr3";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr3 : ENTITY IS TRUE;

END nr3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr3 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd OR b_ipd OR c_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nr4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr4 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nr4";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr4 : ENTITY IS TRUE;

END nr4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd OR b_ipd OR c_ipd OR d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell nr5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY nr5 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "nr5";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF nr5 : ENTITY IS TRUE;

END nr5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF nr5 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd OR b_ipd OR c_ipd OR d_ipd OR e_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell or2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "or2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF or2 : ENTITY IS TRUE;

END or2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell or3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or3 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "or3";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF or3 : ENTITY IS TRUE;

END or3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or3 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd OR c_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell or4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "or4";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF or4 : ENTITY IS TRUE;

END or4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd OR c_ipd OR d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell or5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY or5 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "or5";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF or5 : ENTITY IS TRUE;

END or5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF or5 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd OR b_ipd OR c_ipd OR d_ipd OR e_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell oscil -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
-- entity declaration --
ENTITY oscil IS
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "oscil";
        tpd_test_osc    : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_test       : VitalDelayType01 := (0.0 ns, 0.0 ns)) ;
 
    PORT (
        test : IN std_logic;
        osc  : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF oscil : ENTITY IS TRUE;
 
END oscil ;
 
-- architecture body --
ARCHITECTURE v OF oscil IS
    ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL test_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(test_ipd, test, tipd_test);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (test_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS osc_zd     : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE osc_GlitchData     : VitalGlitchDataType;
 
   BEGIN
 
   IF (TimingChecksOn) THEN
    -----------------------------------
    -- no timing checks for a comb gate
    -----------------------------------
   END IF;
 
   -----------------------------------
   -- functionality section.
   -----------------------------------
   osc_zd := vitalbuf(test_ipd);
 
   -----------------------------------
   -- path delay section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => osc,
     OutSignalName => "osc",
     OutTemp => osc_zd,
     Paths => (0 => (inputchangetime => test_ipd'last_event, 
                     pathdelay => tpd_test_osc, 
                     pathcondition => TRUE)),
     GlitchData => osc_GlitchData,
     Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
   END PROCESS;
 
END v;
 
 
--
----- cell pfumx -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY pfumx IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "pfumx";
      tpd_c0_z        :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_alut_z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_blut_z      :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_alut       :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_blut       :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c0         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      alut            :	IN    std_logic;
      blut            :	IN    std_logic;
      c0              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF pfumx : ENTITY IS TRUE;

END pfumx;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF pfumx IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL alut_ipd	 : std_logic := 'X';
   SIGNAL blut_ipd	 : std_logic := 'X';
   SIGNAL c0_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (alut_ipd, alut, tipd_alut);
   VitalWireDelay (blut_ipd, blut, tipd_blut);
   VitalWireDelay (c0_ipd, c0, tipd_c0);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (alut_ipd, blut_ipd, c0_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := vitalmux
                 (data => (alut_ipd, blut_ipd),
                  dselect => (0 => c0_ipd));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (c0_ipd'last_event, tpd_c0_z, TRUE),
                 1 => (alut_ipd'last_event, tpd_alut_z, TRUE),
                 2 => (blut_ipd'last_event, tpd_blut_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell readbk -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY readbk IS
   GENERIC (
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := FALSE;
      InstancePath	 : String  := "readbk");

   PORT(
      rdcfgn		 : in std_logic;
      capt		 : in std_logic;
      prddata		 : out std_logic;
      rdbo		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF readbk : ENTITY IS TRUE;
 
END readbk ;

-- ARCHITECTURE body --
ARCHITECTURE V OF readbk IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

END V;


--
----- cell strtup -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY strtup IS
   GENERIC (
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := FALSE;
      InstancePath	 : String  := "strtup");

   PORT(
      uclk		 : in std_logic);

    ATTRIBUTE Vital_Level0 OF strtup : ENTITY IS TRUE;
 
END strtup ;

-- ARCHITECTURE body --
ARCHITECTURE V OF strtup IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

BEGIN

END V;


--
----- cell vhi -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY vhi IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "vhi");

   PORT(
      z               :	OUT  std_logic := '1');

   ATTRIBUTE Vital_Level0 OF vhi : ENTITY IS TRUE;

END vhi;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF vhi IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   --  empty
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   z <= '1';



END v;


--
----- cell vlo -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY vlo IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "vlo");

   PORT(
      z               :	OUT  std_logic := '0');

   ATTRIBUTE Vital_Level0 OF vlo : ENTITY IS TRUE;

END vlo;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF vlo IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   --  empty
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   z <= '0';



END v;


--
----- cell xnor2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor2 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "xnor2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor2 : ENTITY IS TRUE;

END xnor2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd XOR b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xnor3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor3 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "xnor3";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor3 : ENTITY IS TRUE;

END xnor3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor3 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd XOR b_ipd XOR c_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xnor4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor4 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "xnor4";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor4 : ENTITY IS TRUE;

END xnor4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd XOR b_ipd XOR c_ipd XOR d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;

--
----- cell xnor5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xnor5 IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "xnor5";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xnor5 : ENTITY IS TRUE;

END xnor5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xnor5 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd XOR b_ipd XOR c_ipd XOR d_ipd XOR e_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xor2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "xor2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      z               :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF xor2 : ENTITY IS TRUE;

END xor2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd XOR b_ipd);
       
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xor3 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor3 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "xor3";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xor3 : ENTITY IS TRUE;

END xor3;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor3 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd XOR b_ipd XOR c_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xor4 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor4 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "xor4";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xor4 : ENTITY IS TRUE;

END xor4;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor4 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd XOR b_ipd XOR c_ipd XOR d_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xor5 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor5 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "xor5";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a               :	IN    std_logic;
      b               :	IN    std_logic;
      c               :	IN    std_logic;
      d               :	IN    std_logic;
      e               :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF xor5 : ENTITY IS TRUE;

END xor5;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor5 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd XOR b_ipd XOR c_ipd XOR d_ipd XOR e_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xor11 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor11 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "xor11";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_g_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_h_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_i_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_j_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_k_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_g          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_h          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_j          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_k          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a, b, c, d, e, f, g, h, i, j, k : IN std_logic;
      z                               : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF xor11 : ENTITY IS TRUE;

END xor11;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor11 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';
   SIGNAL g_ipd	 : std_logic := 'X';
   SIGNAL h_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL j_ipd	 : std_logic := 'X';
   SIGNAL k_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   VitalWireDelay (g_ipd, g, tipd_g);
   VitalWireDelay (h_ipd, h, tipd_h);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (j_ipd, j, tipd_j);
   VitalWireDelay (k_ipd, k, tipd_k);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd, 
		g_ipd, h_ipd, i_ipd, j_ipd, k_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd XOR b_ipd XOR c_ipd XOR d_ipd XOR e_ipd xor
		f_ipd XOR g_ipd XOR h_ipd XOR i_ipd XOR j_ipd XOR 
		k_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE),
                 6 => (g_ipd'last_event, tpd_g_z, TRUE),
                 7 => (h_ipd'last_event, tpd_h_z, TRUE),
                 8 => (i_ipd'last_event, tpd_i_z, TRUE),
                 9 => (j_ipd'last_event, tpd_j_z, TRUE),
                10 => (k_ipd'last_event, tpd_k_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell xor21 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY xor21 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "xor21";
      tpd_a_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_b_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_c_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_e_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_f_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_g_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_h_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_i_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_j_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_k_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_l_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_m_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_n_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_o_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_p_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_q_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_r_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_s_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_t_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_u_z         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_c          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_e          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_f          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_g          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_h          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_j          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_k          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_l          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_m          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_n          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_o          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_p          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_q          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_r          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_s          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_u          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a, b, c, d, e, f, g, h, i, j, k : IN std_logic;
      l, m, n, o, p, q, r, s, t, u    : IN std_logic;
      z				      :	OUT std_logic);

   ATTRIBUTE Vital_Level0 OF xor21 : ENTITY IS TRUE;

END xor21;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF xor21 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a_ipd	 : std_logic := 'X';
   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL c_ipd	 : std_logic := 'X';
   SIGNAL d_ipd	 : std_logic := 'X';
   SIGNAL e_ipd	 : std_logic := 'X';
   SIGNAL f_ipd	 : std_logic := 'X';
   SIGNAL g_ipd	 : std_logic := 'X';
   SIGNAL h_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL j_ipd	 : std_logic := 'X';
   SIGNAL k_ipd	 : std_logic := 'X';
   SIGNAL l_ipd	 : std_logic := 'X';
   SIGNAL m_ipd	 : std_logic := 'X';
   SIGNAL n_ipd	 : std_logic := 'X';
   SIGNAL o_ipd	 : std_logic := 'X';
   SIGNAL p_ipd	 : std_logic := 'X';
   SIGNAL q_ipd	 : std_logic := 'X';
   SIGNAL r_ipd	 : std_logic := 'X';
   SIGNAL s_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';
   SIGNAL u_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (c_ipd, c, tipd_c);
   VitalWireDelay (d_ipd, d, tipd_d);
   VitalWireDelay (e_ipd, e, tipd_e);
   VitalWireDelay (f_ipd, f, tipd_f);
   VitalWireDelay (g_ipd, g, tipd_g);
   VitalWireDelay (h_ipd, h, tipd_h);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (j_ipd, j, tipd_j);
   VitalWireDelay (k_ipd, k, tipd_k);
   VitalWireDelay (l_ipd, l, tipd_l);
   VitalWireDelay (m_ipd, m, tipd_m);
   VitalWireDelay (n_ipd, n, tipd_n);
   VitalWireDelay (o_ipd, o, tipd_o);
   VitalWireDelay (p_ipd, p, tipd_p);
   VitalWireDelay (q_ipd, q, tipd_q);
   VitalWireDelay (r_ipd, r, tipd_r);
   VitalWireDelay (s_ipd, s, tipd_s);
   VitalWireDelay (t_ipd, t, tipd_t);
   VitalWireDelay (u_ipd, u, tipd_u);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, b_ipd, c_ipd, d_ipd, e_ipd, f_ipd, 
		g_ipd, h_ipd, i_ipd, j_ipd, k_ipd, l_ipd, m_ipd, n_ipd,
		o_ipd, p_ipd, q_ipd, r_ipd, s_ipd, t_ipd, u_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd XOR b_ipd XOR c_ipd XOR d_ipd XOR e_ipd xor
		f_ipd XOR g_ipd XOR h_ipd XOR i_ipd XOR j_ipd XOR 
		k_ipd XOR l_ipd XOR m_ipd XOR n_ipd XOR o_ipd xor
		p_ipd) XOR (q_ipd XOR r_ipd XOR s_ipd XOR t_ipd XOR 
		u_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (b_ipd'last_event, tpd_b_z, TRUE),
                 2 => (c_ipd'last_event, tpd_c_z, TRUE),
                 3 => (d_ipd'last_event, tpd_d_z, TRUE),
                 4 => (e_ipd'last_event, tpd_e_z, TRUE),
                 5 => (f_ipd'last_event, tpd_f_z, TRUE),
                 6 => (g_ipd'last_event, tpd_g_z, TRUE),
                 7 => (h_ipd'last_event, tpd_h_z, TRUE),
                 8 => (i_ipd'last_event, tpd_i_z, TRUE),
                 9 => (j_ipd'last_event, tpd_j_z, TRUE),
                10 => (k_ipd'last_event, tpd_k_z, TRUE),
                11 => (l_ipd'last_event, tpd_l_z, TRUE),
                12 => (m_ipd'last_event, tpd_m_z, TRUE),
                13 => (n_ipd'last_event, tpd_n_z, TRUE),
                14 => (o_ipd'last_event, tpd_o_z, TRUE),
                15 => (p_ipd'last_event, tpd_p_z, TRUE),
                16 => (q_ipd'last_event, tpd_q_z, TRUE),
                17 => (r_ipd'last_event, tpd_r_z, TRUE),
                18 => (s_ipd'last_event, tpd_s_z, TRUE),
                19 => (t_ipd'last_event, tpd_t_z, TRUE),
                20 => (u_ipd'last_event, tpd_u_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell fmult41 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY fmult41 IS
   GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fmult41";
      tipd_a0  	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a1 	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a2	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a3	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b0	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b1	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b2	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b3	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_mult	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_ci	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tpd_a0_co	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_co	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_co	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_co	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_co	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p3	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_co     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p0     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p1     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p2     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p3     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_co	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p0	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p1	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p2	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p3	      : VitalDelayType01 := (0.1 ns, 0.1 ns)) ;

    PORT (
        a0            :  IN    std_logic;
        a1            :  IN    std_logic;
        a2            :  IN    std_logic;
        a3            :  IN    std_logic;
        b0            :  IN    std_logic;
        b1            :  IN    std_logic;
        b2            :  IN    std_logic;
        b3            :  IN    std_logic;
        mult	      :  IN    std_logic;
        ci	      :  IN    std_logic;
        co            :  OUT   std_logic;
        p0            :  OUT   std_logic;
        p1            :  OUT   std_logic;
        p2            :  OUT   std_logic;
        p3            :  OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fmult41 : ENTITY IS TRUE;

END fmult41 ;

-- architecture body --

ARCHITECTURE v OF fmult41 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd  : std_logic := 'X';
   SIGNAL a1_ipd  : std_logic := 'X';
   SIGNAL a2_ipd  : std_logic := 'X';
   SIGNAL a3_ipd  : std_logic := 'X';
   SIGNAL b0_ipd  : std_logic := 'X';
   SIGNAL b1_ipd  : std_logic := 'X';
   SIGNAL b2_ipd  : std_logic := 'X';
   SIGNAL b3_ipd  : std_logic := 'X';
   SIGNAL mult_ipd  : std_logic := 'X';
   SIGNAL ci_ipd  : std_logic := 'X';

BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (mult_ipd, mult, tipd_mult);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, mult_ipd, a0_ipd, a1_ipd, a2_ipd, a3_ipd, b0_ipd,
                   b1_ipd, b2_ipd, b3_ipd)

   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS c0_zd       : std_ulogic IS results0(1);
   ALIAS p0_zd       : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS p1_zd       : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS p2_zd       : std_ulogic IS results2(2);
   ALIAS co_zd       : std_ulogic IS results3(1);
   ALIAS p3_zd       : std_ulogic IS results3(2);

   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData    : VitalGlitchDataType;
   VARIABLE p0_GlitchData    : VitalGlitchDataType;
   VARIABLE p1_GlitchData    : VitalGlitchDataType;
   VARIABLE p2_GlitchData    : VitalGlitchDataType;
   VARIABLE p3_GlitchData    : VitalGlitchDataType;

   constant add_table : vitaltruthtabletype := (
   ---------------------------------------------------
   -- a     b    mult     ci   |    co     p      
   ---------------------------------------------------
   ( '0',  '0',  '0',    '0',      '0',   '0' ),
   ( '0',  '0',  '0',    '1',      '0',   '1' ),
   ( '0',  '0',  '1',    '0',      '0',   '0' ),
   ( '0',  '0',  '1',    '1',      '0',   '1' ),
   ( '0',  '1',  '0',    '0',      '0',   '0' ),
   ( '0',  '1',  '0',    '1',      '0',   '1' ),
   ( '0',  '1',  '1',    '0',      '0',   '1' ),
   ( '0',  '1',  '1',    '1',      '1',   '0' ),
   ( '1',  '0',  '0',    '0',      '0',   '1' ),
   ( '1',  '0',  '0',    '1',      '1',   '0' ),
   ( '1',  '0',  '1',    '0',      '0',   '1' ),
   ( '1',  '0',  '1',    '1',      '1',   '0' ),
   ( '1',  '1',  '0',    '0',      '0',   '1' ),
   ( '1',  '1',  '0',    '1',      '1',   '0' ),
   ( '1',  '1',  '1',    '0',      '1',   '0' ),
   ( '1',  '1',  '1',    '1',      '1',   '1' ));

   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (a0_ipd, b0_ipd, mult_ipd, ci_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (a1_ipd, b1_ipd, mult_ipd, c0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (a2_ipd, b2_ipd, mult_ipd, c1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (a3_ipd, b3_ipd, mult_ipd, c2_zd)
                );

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_co, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_co, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_co, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_co, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_co, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_co, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_co, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_co, TRUE),
                 8 => (mult_ipd'last_event, tpd_mult_co, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p0,
       OutSignalName => "p0",
       OutTemp => p0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_p0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_p0, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_p0, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_p0, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_p0, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_p0, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_p0, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_p0, TRUE),
                 8 => (mult_ipd'last_event, tpd_mult_p0, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_p0, TRUE)),
       GlitchData => p0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p1,
       OutSignalName => "p1",
       OutTemp => p1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_p1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_p1, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_p1, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_p1, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_p1, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_p1, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_p1, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_p1, TRUE),
                 8 => (mult_ipd'last_event, tpd_mult_p1, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_p1, TRUE)),
       GlitchData => p1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p2,
       OutSignalName => "p2",
       OutTemp => p2_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_p2, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_p2, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_p2, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_p2, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_p2, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_p2, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_p2, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_p2, TRUE),
                 8 => (mult_ipd'last_event, tpd_mult_p2, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_p2, TRUE)),
       GlitchData => p2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p3,
       OutSignalName => "p3",
       OutTemp => p3_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_p3, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_p3, TRUE),
                 2 => (a2_ipd'last_event, tpd_a2_p3, TRUE),
                 3 => (a3_ipd'last_event, tpd_a3_p3, TRUE),
                 4 => (b0_ipd'last_event, tpd_b0_p3, TRUE),
                 5 => (b1_ipd'last_event, tpd_b1_p3, TRUE),
                 6 => (b2_ipd'last_event, tpd_b2_p3, TRUE),
                 7 => (b3_ipd'last_event, tpd_b3_p3, TRUE),
                 8 => (mult_ipd'last_event, tpd_mult_p3, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_p3, TRUE)),
       GlitchData => p3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell fmult81 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY fmult81 IS
  GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string  := "fmult81";
      tipd_a0         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a1         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a2         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a3         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a4         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a5         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a6         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_a7         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b0         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b1         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b2         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b3         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b4         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b5         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b6         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_b7         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_mult       : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_ci         : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tpd_a0_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a0_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a1_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a2_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a3_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a4_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a5_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a6_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_a7_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b0_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b1_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b2_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b3_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b4_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b5_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b6_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_b7_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_co     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p0     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p1     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p2     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p3     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p4     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p5     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p6     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_mult_p7     : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_co       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p0       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p1       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p2       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p3       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p4       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p5       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p6       : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tpd_ci_p7       : VitalDelayType01 := (0.1 ns, 0.1 ns)) ;

  PORT (
    a0, a1, a2, a3, a4, a5, a6, a7, b0, b1, b2, b3, b4, b5, b6, b7,
      mult, ci: IN std_logic;
    co, p0, p1, p2, p3, p4, p5, p6, p7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF fmult81 : ENTITY IS TRUE;

END fmult81;

ARCHITECTURE v OF fmult81 IS
  ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd  : std_logic := 'X';
   SIGNAL a1_ipd  : std_logic := 'X';
   SIGNAL a2_ipd  : std_logic := 'X';
   SIGNAL a3_ipd  : std_logic := 'X';
   SIGNAL a4_ipd  : std_logic := 'X';
   SIGNAL a5_ipd  : std_logic := 'X';
   SIGNAL a6_ipd  : std_logic := 'X';
   SIGNAL a7_ipd  : std_logic := 'X';
   SIGNAL b0_ipd  : std_logic := 'X';
   SIGNAL b1_ipd  : std_logic := 'X';
   SIGNAL b2_ipd  : std_logic := 'X';
   SIGNAL b3_ipd  : std_logic := 'X';
   SIGNAL b4_ipd  : std_logic := 'X';
   SIGNAL b5_ipd  : std_logic := 'X';
   SIGNAL b6_ipd  : std_logic := 'X';
   SIGNAL b7_ipd  : std_logic := 'X';
   SIGNAL mult_ipd  : std_logic := 'X';
   SIGNAL ci_ipd  : std_logic := 'X';

BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (a2_ipd, a2, tipd_a2);
   VitalWireDelay (a3_ipd, a3, tipd_a3);
   VitalWireDelay (a4_ipd, a4, tipd_a4);
   VitalWireDelay (a5_ipd, a5, tipd_a5);
   VitalWireDelay (a6_ipd, a6, tipd_a6);
   VitalWireDelay (a7_ipd, a7, tipd_a7);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (b2_ipd, b2, tipd_b2);
   VitalWireDelay (b3_ipd, b3, tipd_b3);
   VitalWireDelay (b4_ipd, b4, tipd_b4);
   VitalWireDelay (b5_ipd, b5, tipd_b5);
   VitalWireDelay (b6_ipd, b6, tipd_b6);
   VitalWireDelay (b7_ipd, b7, tipd_b7);
   VitalWireDelay (mult_ipd, mult, tipd_mult);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, mult_ipd, a0_ipd, a1_ipd, a2_ipd, a3_ipd, a4_ipd,
                   a5_ipd, a6_ipd, a7_ipd, b0_ipd, b1_ipd, b2_ipd, b3_ipd, b4_ipd,
                   b5_ipd, b6_ipd, b7_ipd)
                   
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results5 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results6 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results7 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS c0_zd       : std_ulogic IS results0(1);
   ALIAS p0_zd       : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS p1_zd       : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS p2_zd       : std_ulogic IS results2(2);
   ALIAS c3_zd       : std_ulogic IS results3(1);
   ALIAS p3_zd       : std_ulogic IS results3(2);
   ALIAS c4_zd       : std_ulogic IS results4(1);
   ALIAS p4_zd       : std_ulogic IS results4(2);
   ALIAS c5_zd       : std_ulogic IS results5(1);
   ALIAS p5_zd       : std_ulogic IS results5(2);
   ALIAS c6_zd       : std_ulogic IS results6(1);
   ALIAS p6_zd       : std_ulogic IS results6(2);
   ALIAS co_zd       : std_ulogic IS results7(1);
   ALIAS p7_zd       : std_ulogic IS results7(2);

   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData    : VitalGlitchDataType;
   VARIABLE p0_GlitchData    : VitalGlitchDataType;
   VARIABLE p1_GlitchData    : VitalGlitchDataType;
   VARIABLE p2_GlitchData    : VitalGlitchDataType;
   VARIABLE p3_GlitchData    : VitalGlitchDataType;
   VARIABLE p4_GlitchData    : VitalGlitchDataType;
   VARIABLE p5_GlitchData    : VitalGlitchDataType;
   VARIABLE p6_GlitchData    : VitalGlitchDataType;
   VARIABLE p7_GlitchData    : VitalGlitchDataType;

   constant add_table : vitaltruthtabletype := (
   ---------------------------------------------------
   -- a     b    mult     ci   |    co     p
   ---------------------------------------------------
   ( '0',  '0',  '0',    '0',      '0',   '0' ),
   ( '0',  '0',  '0',    '1',      '0',   '1' ),
   ( '0',  '0',  '1',    '0',      '0',   '0' ),
   ( '0',  '0',  '1',    '1',      '0',   '1' ),
   ( '0',  '1',  '0',    '0',      '0',   '0' ),
   ( '0',  '1',  '0',    '1',      '0',   '1' ),
   ( '0',  '1',  '1',    '0',      '0',   '1' ),
   ( '0',  '1',  '1',    '1',      '1',   '0' ),
   ( '1',  '0',  '0',    '0',      '0',   '1' ),
   ( '1',  '0',  '0',    '1',      '1',   '0' ),
   ( '1',  '0',  '1',    '0',      '0',   '1' ),
   ( '1',  '0',  '1',    '1',      '1',   '0' ),
   ( '1',  '1',  '0',    '0',      '0',   '1' ),
   ( '1',  '1',  '0',    '1',      '1',   '0' ),
   ( '1',  '1',  '1',    '0',      '1',   '0' ),
   ( '1',  '1',  '1',    '1',      '1',   '1' ));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (a0_ipd, b0_ipd, mult_ipd, ci_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (a1_ipd, b1_ipd, mult_ipd, c0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (a2_ipd, b2_ipd, mult_ipd, c1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (a3_ipd, b3_ipd, mult_ipd, c2_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (a4_ipd, b4_ipd, mult_ipd, c3_zd)
                );
      results5 := vitaltruthtable (
                truthtable => add_table,
                datain => (a5_ipd, b5_ipd, mult_ipd, c4_zd)
                );
      results6 := vitaltruthtable (
                truthtable => add_table,
                datain => (a6_ipd, b6_ipd, mult_ipd, c5_zd)
                );
      results7 := vitaltruthtable (
                truthtable => add_table,
                datain => (a7_ipd, b7_ipd, mult_ipd, c6_zd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_co, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_co, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_co, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_co, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_co, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_co, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_co, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_co, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_co, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_co, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_co, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_co, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_co, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_co, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_co, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_co, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_co, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p0,
       OutSignalName => "p0",
       OutTemp => p0_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p0, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p0, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p0, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p0, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p0, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p0, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p0, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p0, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p0, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p0, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p0, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p0, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p0, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p0, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p0, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p0, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p0, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p0, TRUE)),
       GlitchData => p0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p1,
       OutSignalName => "p1",
       OutTemp => p1_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p1, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p1, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p1, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p1, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p1, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p1, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p1, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p1, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p1, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p1, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p1, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p1, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p1, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p1, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p1, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p1, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p1, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p1, TRUE)),
       GlitchData => p1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p2,
       OutSignalName => "p2",
       OutTemp => p2_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p2, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p2, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p2, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p2, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p2, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p2, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p2, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p2, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p2, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p2, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p2, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p2, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p2, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p2, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p2, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p2, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p2, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p2, TRUE)),
       GlitchData => p2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p3,
       OutSignalName => "p3",
       OutTemp => p3_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p3, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p3, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p3, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p3, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p3, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p3, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p3, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p3, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p3, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p3, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p3, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p3, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p3, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p3, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p3, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p3, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p3, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p3, TRUE)),
       GlitchData => p3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p4,
       OutSignalName => "p4",
       OutTemp => p4_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p4, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p4, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p4, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p4, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p4, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p4, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p4, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p4, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p4, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p4, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p4, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p4, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p4, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p4, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p4, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p4, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p4, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p4, TRUE)),
       GlitchData => p4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p5,
       OutSignalName => "p5",
       OutTemp => p5_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p5, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p5, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p5, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p5, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p5, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p5, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p5, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p5, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p5, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p5, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p5, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p5, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p5, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p5, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p5, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p5, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p5, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p5, TRUE)),
       GlitchData => p5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p6,
       OutSignalName => "p6",
       OutTemp => p6_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p6, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p6, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p6, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p6, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p6, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p6, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p6, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p6, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p6, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p6, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p6, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p6, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p6, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p6, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p6, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p6, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p6, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p6, TRUE)),
       GlitchData => p6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => p7,
       OutSignalName => "p7",
       OutTemp => p7_zd,
       Paths => (0  => (a0_ipd'last_event, tpd_a0_p7, TRUE),
                 1  => (a1_ipd'last_event, tpd_a1_p7, TRUE),
                 2  => (a2_ipd'last_event, tpd_a2_p7, TRUE),
                 3  => (a3_ipd'last_event, tpd_a3_p7, TRUE),
                 4  => (a4_ipd'last_event, tpd_a4_p7, TRUE),
                 5  => (a5_ipd'last_event, tpd_a5_p7, TRUE),
                 6  => (a6_ipd'last_event, tpd_a6_p7, TRUE),
                 7  => (a7_ipd'last_event, tpd_a7_p7, TRUE),
                 8  => (b0_ipd'last_event, tpd_b0_p7, TRUE),
                 9  => (b1_ipd'last_event, tpd_b1_p7, TRUE),
                 10 => (b2_ipd'last_event, tpd_b2_p7, TRUE),
                 11 => (b3_ipd'last_event, tpd_b3_p7, TRUE),
                 12 => (b4_ipd'last_event, tpd_b4_p7, TRUE),
                 13 => (b5_ipd'last_event, tpd_b5_p7, TRUE),
                 14 => (b6_ipd'last_event, tpd_b6_p7, TRUE),
                 15 => (b7_ipd'last_event, tpd_b7_p7, TRUE),
                 16 => (mult_ipd'last_event, tpd_mult_p7, TRUE),
                 17 => (ci_ipd'last_event, tpd_ci_p7, TRUE)),
       GlitchData => p7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;
 
END v;
 
--
----- cell bufba -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
 
-- entity declaration --
ENTITY bufba IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bufba";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN   std_logic;
      z               : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF bufba : ENTITY IS TRUE;
 
END bufba;
 
-- architecture body --
ARCHITECTURE v OF bufba IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := VitalBUF(a_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, (tpd_a_z), TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 


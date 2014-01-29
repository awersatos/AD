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
-- Simulation Library File for XO
--
-- $Header: /home/rel01/env5_1a.34/vhdl/pkg/vhdsclibs/data/orca5mj/src/RCS/MACHXO_CMB.vhd,v 1.4 2005/05/19 20:37:52 pradeep Exp $ 
--

--
----- cell ageb2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY ageb2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ageb4";
      tpd_a0_ge       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_ge       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_ge       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_ge       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_ci_ge       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      ci              :	IN    std_logic := '1';
      ge              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF ageb2 : ENTITY IS TRUE;

END ageb2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF ageb2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, b0_ipd, b1_ipd, ci_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS ge_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 1) := (others => 'X');

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

      a := std_logic_vector'(a1_ipd, a0_ipd);
      b := std_logic_vector'(b1_ipd, b0_ipd);

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
		 2 => (b0_ipd'last_event, tpd_b0_ge, TRUE),
		 3 => (b1_ipd'last_event, tpd_b1_ge, TRUE),
		 4 => (ci_ipd'last_event, tpd_ci_ge, TRUE)),
       GlitchData => ge_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;



--
----- cell aleb2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aleb2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "aleb4";
      tpd_a0_le       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_le       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_le       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_le       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_ci_le       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0, a1   : IN std_logic;
      b0, b1   : IN std_logic;
      ci       : IN std_logic := '1';
      le       : OUT std_logic);

   ATTRIBUTE Vital_Level0 OF aleb2 : ENTITY IS TRUE;

END aleb2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aleb2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, b0_ipd, b1_ipd, ci_ipd) 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS le_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 1) := (others => 'X');

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

      a := std_logic_vector'(a1_ipd, a0_ipd);
      b := std_logic_vector'(b1_ipd, b0_ipd);

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
		 2 => (b0_ipd'last_event, tpd_b0_le, TRUE),
		 3 => (b1_ipd'last_event, tpd_b1_le, TRUE),
		 4 => (ci_ipd'last_event, tpd_ci_le, TRUE)),
       GlitchData => le_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell aneb2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY aneb2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "aneb4";
      tpd_a0_ne       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_ne       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_ne       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_ne       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_ci_ne       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      ci              :	IN    std_logic := '0';
      ne              :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF aneb2 : ENTITY IS TRUE;

END aneb2;

-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF aneb2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd	 : std_logic := 'X';
   SIGNAL a1_ipd	 : std_logic := 'X';
   SIGNAL b0_ipd	 : std_logic := 'X';
   SIGNAL b1_ipd	 : std_logic := 'X';
   SIGNAL ci_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, b0_ipd, b1_ipd, ci_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS ne_zd      : std_ulogic IS results(1);
   VARIABLE a, b    : std_logic_vector(0 to 1) := (others => 'X');

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

      a := std_logic_vector'(a1_ipd, a0_ipd);
      b := std_logic_vector'(b1_ipd, b0_ipd);

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
		 2 => (b0_ipd'last_event, tpd_b0_ne, TRUE),
		 3 => (b1_ipd'last_event, tpd_b1_ne, TRUE),
		 4 => (ci_ipd'last_event, tpd_ci_ne, TRUE)),
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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
----- cell fadd2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadd2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fadd2";
      tpd_a0_cout0    :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_cout0    :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_cout0    :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_cout0    :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_ci_cout0    :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a0_cout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_cout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_cout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_cout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_ci_cout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a0_s0       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a0_s1       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_s0       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_s1       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_s0       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_s1       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_s0       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_s1       :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_ci_s0       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_ci_s1       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_ci         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0              :	IN    std_logic;
      a1              :	IN    std_logic;
      b0              :	IN    std_logic;
      b1              :	IN    std_logic;
      ci              :	IN    std_logic;
      s0              :	OUT   std_logic;
      s1              :	OUT   std_logic;
      cout0           :	OUT   std_logic;
      cout1           :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadd2 : ENTITY IS TRUE;

END fadd2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadd2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd : std_logic := 'X';
   SIGNAL a1_ipd : std_logic := 'X';
   SIGNAL b0_ipd : std_logic := 'X';
   SIGNAL b1_ipd : std_logic := 'X';
   SIGNAL ci_ipd : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, b0_ipd, 
			    b1_ipd, ci_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS cout0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS cout1_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE cout0_GlitchData    : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE cout1_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
 
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
                datain => (a1_ipd, b1_ipd, cout0_zd)
                );

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => cout0,
       OutSignalName => "cout0",
       OutTemp => cout0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_cout0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_cout0, TRUE),
                 2 => (b0_ipd'last_event, tpd_b0_cout0, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_cout0, TRUE),
		 4 => (ci_ipd'last_event, tpd_ci_cout0, TRUE)),
       GlitchData => cout0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
		 4 => (ci_ipd'last_event, tpd_ci_s0, TRUE)),
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
                 2 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
		 4 => (ci_ipd'last_event, tpd_ci_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => cout1,
       OutSignalName => "cout1",
       OutTemp => cout1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_cout1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_cout1, TRUE),
                 2 => (b0_ipd'last_event, tpd_b0_cout1, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_cout1, TRUE),
		 4 => (ci_ipd'last_event, tpd_ci_cout1, TRUE)),
       GlitchData => cout1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell fsub2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fsub2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "fsub2";
      tpd_a0_bout0    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_bout0    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_bout0    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_bout0    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_bi_bout0    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a0_bout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_bout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_bout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_bout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_bi_bout1    : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a0_s0       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_s0       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_s0       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_s0       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_bi_s0       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a0_s1       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_a1_s1       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b0_s1       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b1_s1       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_bi_s1       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bi         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0                     :	IN    std_logic;
      a1                     :	IN    std_logic;
      b0                     :	IN    std_logic;
      b1                     :	IN    std_logic;
      bi                     :	IN    std_logic;
      bout0                  :	OUT   std_logic;
      bout1                  :	OUT   std_logic;
      s0                     :	OUT   std_logic;
      s1                     :	OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fsub2 : ENTITY IS TRUE;

END fsub2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fsub2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a0_ipd         : std_logic := 'X';
   SIGNAL a1_ipd         : std_logic := 'X';
   SIGNAL b0_ipd         : std_logic := 'X';
   SIGNAL b1_ipd         : std_logic := 'X';
   SIGNAL bi_ipd         : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a0_ipd, a0, tipd_a0);
   VitalWireDelay (a1_ipd, a1, tipd_a1);
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (bi_ipd, bi, tipd_bi);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, b0_ipd, 
			    b1_ipd, bi_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS bout0_zd      : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS bout1_zd      : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE bout0_GlitchData    : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE bout1_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;

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
                datain => (a1_ipd, b1_ipd, bout0_zd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => bout0,
       OutSignalName => "bout0",
       OutTemp => bout0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_bout0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_bout0, TRUE),
                 2 => (b0_ipd'last_event, tpd_b0_bout0, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_bout0, TRUE),
		 4 => (bi_ipd'last_event, tpd_bi_bout0, TRUE)),
       GlitchData => bout0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => s0,
       OutSignalName => "s0",
       OutTemp => s0_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_s0, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_s0, TRUE),
                 2 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
		 4 => (bi_ipd'last_event, tpd_bi_s0, TRUE)),
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
                 2 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
		 4 => (bi_ipd'last_event, tpd_bi_s1, TRUE)),
       GlitchData => s1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => bout1,
       OutSignalName => "bout1",
       OutTemp => bout1_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_bout1, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_bout1, TRUE),
                 2 => (b0_ipd'last_event, tpd_b0_bout1, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_bout1, TRUE),
                 4 => (bi_ipd'last_event, tpd_bi_bout1, TRUE)),
       GlitchData => bout1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;

END v;


----- cell fadsu2 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY fadsu2 IS
   GENERIC(
      TimingChecksOn : boolean := TRUE;
      XOn            : boolean := FALSE;
      MsgOn          : boolean := TRUE;
      InstancePath   : string := "fadsu2";
      tpd_a0_bco     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_a1_bco     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_b0_bco     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_b1_bco     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_bci_bco    : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_con_bco    : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_a0_s0      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_a0_s1      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_a1_s0      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_a1_s1      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_b0_s0      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_b0_s1      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_b1_s0      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_b1_s1      : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_bci_s0     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_bci_s1     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_con_s0     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tpd_con_s1     : VitalDelayType01 := (0.001 ns, 0.001 ns);
      tipd_a0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_a1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_b1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_bci       : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_con       : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      a0             :  IN    std_logic;
      a1             :  IN    std_logic;
      b0             :  IN    std_logic;
      b1             :  IN    std_logic;
      bci            :  IN    std_logic;
      con            :  IN    std_logic;
      bco            :  OUT   std_logic;
      s0             :  OUT   std_logic;
      s1             :  OUT   std_logic);

   ATTRIBUTE Vital_Level0 OF fadsu2 : ENTITY IS TRUE;

END fadsu2;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF fadsu2 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL a0_ipd  : std_logic := 'X';
   SIGNAL a1_ipd  : std_logic := 'X';
   SIGNAL b0_ipd  : std_logic := 'X';
   SIGNAL b1_ipd  : std_logic := 'X';
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
   VitalWireDelay (b0_ipd, b0, tipd_b0);
   VitalWireDelay (b1_ipd, b1, tipd_b1);
   VitalWireDelay (bci_ipd, bci, tipd_bci);
   VitalWireDelay (con_ipd, con, tipd_con);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a0_ipd, a1_ipd, b0_ipd, b1_ipd, bci_ipd, con_ipd)

   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS bc0_zd     : std_ulogic IS results1(1);
   ALIAS s0_zd      : std_ulogic IS results1(2);
   ALIAS bco_zd     : std_ulogic IS results2(1);
   ALIAS s1_zd      : std_ulogic IS results2(2);


   -- output glitch detection VARIABLEs
   VARIABLE bco_GlitchData   : VitalGlitchDataType;
   VARIABLE s0_GlitchData    : VitalGlitchDataType;
   VARIABLE s1_GlitchData    : VitalGlitchDataType;
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

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => bco,
       OutSignalName => "bco",
       OutTemp => bco_zd,
       Paths => (0 => (a0_ipd'last_event, tpd_a0_bco, TRUE),
                 1 => (a1_ipd'last_event, tpd_a1_bco, TRUE),
                 2 => (b0_ipd'last_event, tpd_b0_bco, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_bco, TRUE),
                 4 => (bci_ipd'last_event, tpd_bci_bco, TRUE),
                 5 => (con_ipd'last_event, tpd_con_bco, TRUE)),
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
                 2 => (b0_ipd'last_event, tpd_b0_s0, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_s0, TRUE),
                 4 => (bci_ipd'last_event, tpd_bci_s0, TRUE),
                 5 => (con_ipd'last_event, tpd_con_s0, TRUE)),
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
                 2 => (b0_ipd'last_event, tpd_b0_s1, TRUE),
                 3 => (b1_ipd'last_event, tpd_b1_s1, TRUE),
                 4 => (bci_ipd'last_event, tpd_bci_s1, TRUE),
                 5 => (con_ipd'last_event, tpd_con_s1, TRUE)),
       GlitchData => s1_GlitchData,
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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_d0_z        :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d1_z        :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd_z        :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
----- cell l6mux21 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY l6mux21 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "l6mux21";
      tpd_d0_z        :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d1_z        :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd_z        :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_d0         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd         :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              :	IN    std_logic;
      d1              :	IN    std_logic;
      sd              :	IN    std_logic;
      z               :	OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF l6mux21 : ENTITY IS TRUE;

END l6mux21;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF l6mux21 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
----- cell mux41 -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;

ENTITY mux41 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "mux41";
      tpd_d0_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d1_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d2_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d3_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd1_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd2_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
----- cell mux81 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux81 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "mux81";
      tpd_d0_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d1_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d2_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d3_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d4_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d5_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d6_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d7_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd1_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd2_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd3_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_d0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d2         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d3         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d4         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d5         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d6         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d7         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd3        : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux81 : ENTITY IS TRUE;

END mux81;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux81 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL d0_ipd         : std_logic := 'X';
   SIGNAL d1_ipd         : std_logic := 'X';
   SIGNAL d2_ipd         : std_logic := 'X';
   SIGNAL d3_ipd         : std_logic := 'X';
   SIGNAL d4_ipd         : std_logic := 'X';
   SIGNAL d5_ipd         : std_logic := 'X';
   SIGNAL d6_ipd         : std_logic := 'X';
   SIGNAL d7_ipd         : std_logic := 'X';
   SIGNAL sd1_ipd        : std_logic := 'X';
   SIGNAL sd2_ipd        : std_logic := 'X';
   SIGNAL sd3_ipd        : std_logic := 'X';

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
   VitalWireDelay (d4_ipd, d4, tipd_d4);
   VitalWireDelay (d5_ipd, d5, tipd_d5);
   VitalWireDelay (d6_ipd, d6, tipd_d6);
   VitalWireDelay (d7_ipd, d7, tipd_d7);
   VitalWireDelay (sd1_ipd, sd1, tipd_sd1);
   VitalWireDelay (sd2_ipd, sd2, tipd_sd2);
   VitalWireDelay (sd3_ipd, sd3, tipd_sd3);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, d2_ipd, d3_ipd, d4_ipd, d5_ipd, d6_ipd, d7_ipd, sd1_ipd, sd2_ipd, sd3_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := vitalmux
                 (data => (d7_ipd, d6_ipd, d5_ipd, d4_ipd, d3_ipd, d2_ipd, d1_ipd, d0_ipd),
                  dselect => (sd3_ipd, sd2_ipd, sd1_ipd));

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
                 4 => (d4_ipd'last_event, tpd_d4_z, TRUE),
                 5 => (d5_ipd'last_event, tpd_d5_z, TRUE),
                 6 => (d6_ipd'last_event, tpd_d6_z, TRUE),
                 7 => (d7_ipd'last_event, tpd_d7_z, TRUE),
                 8 => (sd1_ipd'last_event, tpd_sd1_z, TRUE),
                 9 => (sd2_ipd'last_event, tpd_sd2_z, TRUE),
                10 => (sd3_ipd'last_event, tpd_sd3_z, TRUE)),

       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;

--
----- cell mux161 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux161 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "mux81";
      tpd_d0_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d1_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d2_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d3_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d4_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d5_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d6_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d7_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d8_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d9_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d10_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d11_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d12_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d13_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d14_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d15_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd1_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd2_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd3_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd4_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_d0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d2         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d3         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d4         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d5         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d6         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d7         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d8         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d9         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d10        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d11        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d12        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d13        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d14        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d15        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd4        : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      d8              : IN    std_logic;
      d9              : IN    std_logic;
      d10             : IN    std_logic;
      d11             : IN    std_logic;
      d12             : IN    std_logic;
      d13             : IN    std_logic;
      d14             : IN    std_logic;
      d15             : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      sd4             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux161 : ENTITY IS TRUE;

END mux161;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux161 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL d0_ipd         : std_logic := 'X';
   SIGNAL d1_ipd         : std_logic := 'X';
   SIGNAL d2_ipd         : std_logic := 'X';
   SIGNAL d3_ipd         : std_logic := 'X';
   SIGNAL d4_ipd         : std_logic := 'X';
   SIGNAL d5_ipd         : std_logic := 'X';
   SIGNAL d6_ipd         : std_logic := 'X';
   SIGNAL d7_ipd         : std_logic := 'X';
   SIGNAL d8_ipd         : std_logic := 'X';
   SIGNAL d9_ipd         : std_logic := 'X';
   SIGNAL d10_ipd         : std_logic := 'X';
   SIGNAL d11_ipd         : std_logic := 'X';
   SIGNAL d12_ipd         : std_logic := 'X';
   SIGNAL d13_ipd         : std_logic := 'X';
   SIGNAL d14_ipd         : std_logic := 'X';
   SIGNAL d15_ipd         : std_logic := 'X';
   SIGNAL sd1_ipd        : std_logic := 'X';
   SIGNAL sd2_ipd        : std_logic := 'X';
   SIGNAL sd3_ipd        : std_logic := 'X';
   SIGNAL sd4_ipd        : std_logic := 'X';

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
   VitalWireDelay (d4_ipd, d4, tipd_d4);
   VitalWireDelay (d5_ipd, d5, tipd_d5);
   VitalWireDelay (d6_ipd, d6, tipd_d6);
   VitalWireDelay (d7_ipd, d7, tipd_d7);
   VitalWireDelay (d8_ipd, d8, tipd_d8);
   VitalWireDelay (d9_ipd, d9, tipd_d9);
   VitalWireDelay (d10_ipd, d10, tipd_d10);
   VitalWireDelay (d11_ipd, d11, tipd_d11);
   VitalWireDelay (d12_ipd, d12, tipd_d12);
   VitalWireDelay (d13_ipd, d13, tipd_d13);
   VitalWireDelay (d14_ipd, d14, tipd_d14);
   VitalWireDelay (d15_ipd, d15, tipd_d15);
   VitalWireDelay (sd1_ipd, sd1, tipd_sd1);
   VitalWireDelay (sd2_ipd, sd2, tipd_sd2);
   VitalWireDelay (sd3_ipd, sd3, tipd_sd3);
   VitalWireDelay (sd4_ipd, sd4, tipd_sd4);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, d2_ipd, d3_ipd, d4_ipd, d5_ipd, d6_ipd, d7_ipd, d8_ipd, d9_ipd, d10_ipd, d11_ipd, d12_ipd, d13_ipd, d14_ipd, d15_ipd, sd1_ipd, sd2_ipd, sd3_ipd, sd4_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := vitalmux
                 (data => (d15_ipd, d14_ipd, d13_ipd, d12_ipd, d11_ipd, d10_ipd, d9_ipd, d8_ipd, d7_ipd, d6_ipd, d5_ipd, d4_ipd, d3_ipd, d2_ipd, d1_ipd, d0_ipd),
                  dselect => (sd4_ipd, sd3_ipd, sd2_ipd, sd1_ipd));

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
                 4 => (d4_ipd'last_event, tpd_d4_z, TRUE),
                 5 => (d5_ipd'last_event, tpd_d5_z, TRUE),
                 6 => (d6_ipd'last_event, tpd_d6_z, TRUE),
                 7 => (d7_ipd'last_event, tpd_d7_z, TRUE),
                 8 => (d8_ipd'last_event, tpd_d8_z, TRUE),
                 9 => (d9_ipd'last_event, tpd_d9_z, TRUE),
                 10 => (d10_ipd'last_event, tpd_d10_z, TRUE),
                 11 => (d11_ipd'last_event, tpd_d11_z, TRUE),
                 12 => (d12_ipd'last_event, tpd_d12_z, TRUE),
                 13 => (d13_ipd'last_event, tpd_d13_z, TRUE),
                 14 => (d14_ipd'last_event, tpd_d14_z, TRUE),
                 15 => (d15_ipd'last_event, tpd_d15_z, TRUE),
                 16 => (sd1_ipd'last_event, tpd_sd1_z, TRUE),
                 17 => (sd2_ipd'last_event, tpd_sd2_z, TRUE),
                 18 => (sd3_ipd'last_event, tpd_sd3_z, TRUE),
                19 => (sd4_ipd'last_event, tpd_sd4_z, TRUE)),

       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


END PROCESS;

END v;


--
----- cell mux321 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux321 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "mux81";
      tpd_d0_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d1_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d2_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d3_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d4_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d5_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d6_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d7_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d8_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d9_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d10_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d11_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d12_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d13_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d14_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d15_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d16_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d17_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d18_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d19_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d20_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d21_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d22_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d23_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d24_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d25_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d26_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d27_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d28_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d29_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d30_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d31_z        : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd1_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd2_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd3_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd4_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_sd5_z       : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_d0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d2         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d3         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d4         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d5         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d6         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d7         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d8         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d9         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d10        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d11        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d12        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d13        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d14        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d15        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d16        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d17        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d18        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d19        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d20        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d21        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d22        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d23        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d24        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d25        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d26        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d27        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d28        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d29        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d30        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d31        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sd5        : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      d8              : IN    std_logic;
      d9              : IN    std_logic;
      d10             : IN    std_logic;
      d11             : IN    std_logic;
      d12             : IN    std_logic;
      d13             : IN    std_logic;
      d14             : IN    std_logic;
      d15             : IN    std_logic;
      d16             : IN    std_logic;
      d17             : IN    std_logic;
      d18             : IN    std_logic;
      d19             : IN    std_logic;
      d20             : IN    std_logic;
      d21             : IN    std_logic;
      d22             : IN    std_logic;
      d23             : IN    std_logic;
      d24             : IN    std_logic;
      d25             : IN    std_logic;
      d26             : IN    std_logic;
      d27             : IN    std_logic;
      d28             : IN    std_logic;
      d29             : IN    std_logic;
      d30             : IN    std_logic;
      d31             : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      sd4             : IN    std_logic;
      sd5             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux321 : ENTITY IS TRUE;

END mux321;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux321 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL d0_ipd         : std_logic := 'X';
   SIGNAL d1_ipd         : std_logic := 'X';
   SIGNAL d2_ipd         : std_logic := 'X';
   SIGNAL d3_ipd         : std_logic := 'X';
   SIGNAL d4_ipd         : std_logic := 'X';
   SIGNAL d5_ipd         : std_logic := 'X';
   SIGNAL d6_ipd         : std_logic := 'X';
   SIGNAL d7_ipd         : std_logic := 'X';
   SIGNAL d8_ipd         : std_logic := 'X';
   SIGNAL d9_ipd         : std_logic := 'X';
   SIGNAL d10_ipd         : std_logic := 'X';
   SIGNAL d11_ipd         : std_logic := 'X';
   SIGNAL d12_ipd         : std_logic := 'X';
   SIGNAL d13_ipd         : std_logic := 'X';
   SIGNAL d14_ipd         : std_logic := 'X';
   SIGNAL d15_ipd         : std_logic := 'X';
   SIGNAL d16_ipd         : std_logic := 'X';
   SIGNAL d17_ipd         : std_logic := 'X';
   SIGNAL d18_ipd         : std_logic := 'X';
   SIGNAL d19_ipd         : std_logic := 'X';
   SIGNAL d20_ipd         : std_logic := 'X';
   SIGNAL d21_ipd         : std_logic := 'X';
   SIGNAL d22_ipd         : std_logic := 'X';
   SIGNAL d23_ipd         : std_logic := 'X';
   SIGNAL d24_ipd         : std_logic := 'X';
   SIGNAL d25_ipd         : std_logic := 'X';
   SIGNAL d26_ipd         : std_logic := 'X';
   SIGNAL d27_ipd         : std_logic := 'X';
   SIGNAL d28_ipd         : std_logic := 'X';
   SIGNAL d29_ipd         : std_logic := 'X';
   SIGNAL d30_ipd         : std_logic := 'X';
   SIGNAL d31_ipd         : std_logic := 'X';
   SIGNAL sd1_ipd        : std_logic := 'X';
   SIGNAL sd2_ipd        : std_logic := 'X';
   SIGNAL sd3_ipd        : std_logic := 'X';
   SIGNAL sd4_ipd        : std_logic := 'X';
   SIGNAL sd5_ipd        : std_logic := 'X';

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
   VitalWireDelay (d4_ipd, d4, tipd_d4);
   VitalWireDelay (d5_ipd, d5, tipd_d5);
   VitalWireDelay (d6_ipd, d6, tipd_d6);
   VitalWireDelay (d7_ipd, d7, tipd_d7);
   VitalWireDelay (d8_ipd, d8, tipd_d8);
   VitalWireDelay (d9_ipd, d9, tipd_d9);
   VitalWireDelay (d10_ipd, d10, tipd_d10);
   VitalWireDelay (d11_ipd, d11, tipd_d11);
   VitalWireDelay (d12_ipd, d12, tipd_d12);
   VitalWireDelay (d13_ipd, d13, tipd_d13);
   VitalWireDelay (d14_ipd, d14, tipd_d14);
   VitalWireDelay (d15_ipd, d15, tipd_d15);
   VitalWireDelay (d16_ipd, d16, tipd_d16);
   VitalWireDelay (d17_ipd, d17, tipd_d17);
   VitalWireDelay (d18_ipd, d18, tipd_d18);
   VitalWireDelay (d19_ipd, d19, tipd_d19);
   VitalWireDelay (d20_ipd, d20, tipd_d20);
   VitalWireDelay (d21_ipd, d21, tipd_d21);
   VitalWireDelay (d22_ipd, d22, tipd_d22);
   VitalWireDelay (d23_ipd, d23, tipd_d23);
   VitalWireDelay (d24_ipd, d24, tipd_d24);
   VitalWireDelay (d25_ipd, d25, tipd_d25);
   VitalWireDelay (d26_ipd, d26, tipd_d26);
   VitalWireDelay (d27_ipd, d27, tipd_d27);
   VitalWireDelay (d28_ipd, d28, tipd_d28);
   VitalWireDelay (d29_ipd, d29, tipd_d29);
   VitalWireDelay (d30_ipd, d30, tipd_d30);
   VitalWireDelay (d31_ipd, d31, tipd_d31);
   VitalWireDelay (sd1_ipd, sd1, tipd_sd1);
   VitalWireDelay (sd2_ipd, sd2, tipd_sd2);
   VitalWireDelay (sd3_ipd, sd3, tipd_sd3);
   VitalWireDelay (sd4_ipd, sd4, tipd_sd4);
   VitalWireDelay (sd5_ipd, sd5, tipd_sd5);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, d2_ipd, d3_ipd, d4_ipd, d5_ipd, d6_ipd, d7_ipd, d8_ipd, d9_ipd, d10_ipd, d11_ipd, d12_ipd, d13_ipd, d14_ipd, d15_ipd, d16_ipd, d17_ipd, d18_ipd, d19_ipd, d20_ipd, d21_ipd, d22_ipd, d23_ipd, d24_ipd, d25_ipd, d26_ipd, d27_ipd, d28_ipd, d29_ipd, d30_ipd, d31_ipd, sd1_ipd, sd2_ipd, sd3_ipd, sd4_ipd, sd5_ipd)


   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z_zd := vitalmux
                 (data => (d31_ipd, d30_ipd, d29_ipd, d28_ipd, d27_ipd, d26_ipd, d25_ipd, d24_ipd, d23_ipd, d22_ipd, d21_ipd, d20_ipd, d19_ipd, d18_ipd, d17_ipd, d16_ipd, d15_ipd, d14_ipd, d13_ipd, d12_ipd, d11_ipd, d10_ipd, d9_ipd, d8_ipd, d7_ipd, d6_ipd, d5_ipd, d4_ipd, d3_ipd, d2_ipd, d1_ipd, d0_ipd),
                  dselect => (sd5_ipd, sd4_ipd, sd3_ipd, sd2_ipd, sd1_ipd));

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
                 4 => (d4_ipd'last_event, tpd_d4_z, TRUE),
                 5 => (d5_ipd'last_event, tpd_d5_z, TRUE),
                 6 => (d6_ipd'last_event, tpd_d6_z, TRUE),
                 7 => (d7_ipd'last_event, tpd_d7_z, TRUE),
                 8 => (d8_ipd'last_event, tpd_d8_z, TRUE),
                 9 => (d9_ipd'last_event, tpd_d9_z, TRUE),
                 10 => (d10_ipd'last_event, tpd_d10_z, TRUE),
                 11 => (d11_ipd'last_event, tpd_d11_z, TRUE),
                 12 => (d12_ipd'last_event, tpd_d12_z, TRUE),
                 13 => (d13_ipd'last_event, tpd_d13_z, TRUE),
                 14 => (d14_ipd'last_event, tpd_d14_z, TRUE),
                 15 => (d15_ipd'last_event, tpd_d15_z, TRUE),
                 16 => (d16_ipd'last_event, tpd_d16_z, TRUE),
                 17 => (d17_ipd'last_event, tpd_d17_z, TRUE),
                 18 => (d18_ipd'last_event, tpd_d18_z, TRUE),
                 19 => (d19_ipd'last_event, tpd_d19_z, TRUE),
                 20 => (d20_ipd'last_event, tpd_d20_z, TRUE),
                 21 => (d21_ipd'last_event, tpd_d21_z, TRUE),
                 22 => (d22_ipd'last_event, tpd_d22_z, TRUE),
                 23 => (d23_ipd'last_event, tpd_d23_z, TRUE),
                 24 => (d24_ipd'last_event, tpd_d24_z, TRUE),
                 25 => (d25_ipd'last_event, tpd_d25_z, TRUE),
                 26 => (d26_ipd'last_event, tpd_d26_z, TRUE),
                 27 => (d27_ipd'last_event, tpd_d27_z, TRUE),
                 28 => (d28_ipd'last_event, tpd_d28_z, TRUE),
                 29 => (d29_ipd'last_event, tpd_d29_z, TRUE),
                 30 => (d30_ipd'last_event, tpd_d30_z, TRUE),
                 31 => (d31_ipd'last_event, tpd_d31_z, TRUE),
                 32 => (sd1_ipd'last_event, tpd_sd1_z, TRUE),
                 33 => (sd2_ipd'last_event, tpd_sd2_z, TRUE),
                 34 => (sd3_ipd'last_event, tpd_sd3_z, TRUE),
                 35 => (sd4_ipd'last_event, tpd_sd4_z, TRUE),
                36 => (sd5_ipd'last_event, tpd_sd5_z, TRUE)),

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
----- cell oscc -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY oscc IS
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string  := "oscc");

    PORT (
        osc  : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF oscc : ENTITY IS TRUE;

END oscc ;

-- architecture body --
ARCHITECTURE v OF oscc IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL test_ipd  : std_logic := '0';

BEGIN

   --------------------
   --  behavior section
   --------------------

   test_ipd <= not test_ipd after 25 ns;

   P2 : PROCESS (test_ipd)
   BEGIN
      osc <= test_ipd;
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
      tpd_c0_z        :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_alut_z      :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_blut_z      :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_f_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_g_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_h_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_i_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_j_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_k_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_b_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_c_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_d_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_e_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_f_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_g_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_h_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_i_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_j_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_k_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_l_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_m_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_n_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_o_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_p_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_q_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_r_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_s_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_t_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
      tpd_u_z         :	VitalDelayType01 := (0.01 ns, 0.01 ns);
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
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

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
      tpd_a_z         : VitalDelayType01 := (0.01 ns, 0.01 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN   std_logic;
      z               : OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF bufba : ENTITY IS TRUE;
 
END bufba;
 
-- architecture body --
ARCHITECTURE v OF bufba IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
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
 
 
--
----- cell jtagd -----
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY jtagd IS
   GENERIC(
      TimingChecksOn   : boolean := FALSE;
      XOn              : boolean := FALSE;
      MsgOn            : boolean := FALSE;
      ER1              : string := "ENABLED";
      ER2              : string := "ENABLED";
      InstancePath     : string := "jtagd");

   PORT(
      tck                :      IN    std_logic;
      tms                :      IN    std_logic;
      tdi                :      IN    std_logic;
      jtdo1              :      IN    std_logic;
      jtdo2              :      IN    std_logic;
      tdo                :      OUT  std_logic;
      jtck               :      OUT  std_logic;
      jtdi               :      OUT  std_logic;
      jshift             :      OUT  std_logic;
      jupdate            :      OUT  std_logic;
      jrst               :      OUT  std_logic;
      jce1               :      OUT  std_logic;
      jce2               :      OUT  std_logic;
      jrti1              :      OUT  std_logic;
      jrti2              :      OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF jtagd : ENTITY IS TRUE;

END jtagd;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF jtagd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN
      assert FALSE
         report "Empty model is being used for block ""JTAGD"", for the full functional model please use either the encrypted or the pre-compiled models."
         severity WARNING;

      tdo <= '0';
      jtck <= '0';
      jtdi <= '0';
      jshift <= '0';
      jupdate <= '0';
      jrst <= '0';
      jce1 <= '0';
      jce2 <= '0';
      jrti1 <= '0';
      jrti2 <= '0';


END v;


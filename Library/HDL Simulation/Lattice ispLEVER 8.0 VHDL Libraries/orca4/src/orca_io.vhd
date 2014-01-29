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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCA_IO.vhd,v 1.24 2005/05/19 20:04:54 pradeep Exp $ 
--

 
 
--
----- cell tsall -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;
 
 
-- entity declaration --
ENTITY tsall IS
   GENERIC(
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := FALSE;
      InstancePath    : string := "tsall");
 
   PORT(
      tsall           : IN std_logic := 'Z');

END tsall;
 
-- architecture body --
ARCHITECTURE v OF tsall IS
 
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
   tsallnet <= tsall;
 
END v;


--
----- cell bms6 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bms6 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bms6";
      tpd_i_b         :  VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :  VitalDelayType01z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :  VitalDelayType01 := (0.0 ns, 0.0 ns));
--        -- pulse width constraints
--        tperiod_i              : VitalDelayType := 0.1 ns;
--        tpw_i_posedge          : VitalDelayType := 0.1 ns;
--        tpw_i_negedge          : VitalDelayType := 0.1 ns;
--        tperiod_t              : VitalDelayType := 0.1 ns;
--        tpw_t_posedge          : VitalDelayType := 0.1 ns;
--        tpw_t_negedge          : VitalDelayType := 0.1 ns);

   PORT(
      b               :  INOUT std_logic;
      i               :  IN std_logic;
      t               :  IN std_logic;
      o               :  OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bms6 : ENTITY IS TRUE;
 
END bms6;

-- architecture body --
ARCHITECTURE v OF bms6 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd  : std_logic := 'X';
   SIGNAL i_ipd  : std_logic := 'X';
   SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData        : VitalGlitchDataType;
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bms12 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bms12 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bms12";
      tpd_i_b         :  VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :  VitalDelayType01z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :  VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :  INOUT std_logic;
      i               :  IN std_logic;
      t               :  IN std_logic;
      o               :  OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bms12 : ENTITY IS TRUE;
 
END bms12;

-- architecture body --
ARCHITECTURE v OF bms12 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd  : std_logic := 'X';
   SIGNAL i_ipd  : std_logic := 'X';
   SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData        : VitalGlitchDataType;
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bms12f -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bms12f IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bms12f";
      tpd_i_b         :  VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :  VitalDelayType01z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :  VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :  INOUT std_logic;
      i               :  IN std_logic;
      t               :  IN std_logic;
      o               :  OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bms12f : ENTITY IS TRUE;
 
END bms12f;

-- architecture body --
ARCHITECTURE v OF bms12f IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd  : std_logic := 'X';
   SIGNAL i_ipd  : std_logic := 'X';
   SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData        : VitalGlitchDataType;
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
-----CELL BMS6PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BMS6PD is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BMS6PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns)); 
 
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BMS6PD : entity is TRUE;
 
end BMS6PD;
 
-- architecture body --
architecture V of BMS6PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
 
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
 
      --  Functionality Section
      -------------------------
 
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','L'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
 
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
 
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
--
----- CELL BMS6PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BMS6PU is
   generic(
 
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BMS6PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BMS6PU : entity is TRUE;
 
end BMS6PU;
 
-- architecture body --
architecture V of BMS6PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
 
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
 
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
 
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
 
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','H'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
 
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
 

--
----- CELL BMS12FPD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BMS12FPD is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BMS12FPD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BMS12FPD : entity is TRUE;
 
end BMS12FPD;
 
-- architecture body --
architecture V of BMS12FPD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
 
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','L'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
 
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
--
----- CELL BMS12FPU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BMS12FPU is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BMS12FPU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
 
    attribute VITAL_LEVEL0 of BMS12FPU : entity is TRUE;
 
end BMS12FPU;
 
-- architecture body --
architecture V of BMS12FPU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','H'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(B_ipd2);
 
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
 
end V;
 
 
--
----- CELL BMS12PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BMS12PD is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BMS12PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BMS12PD : entity is TRUE;
 
end BMS12PD;
 
-- architecture body --
architecture V of BMS12PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','L'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
--
----- CELL BMS12PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BMS12PU is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath: String := "BMS12PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BMS12PU : entity is TRUE;
 
end BMS12PU;
 
-- architecture body --
architecture V of BMS12PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','H'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
 
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);


end process;
 
end V;
 
--
-----CELL BTS6PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BTS6PD is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BTS6PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
 
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BTS6PD : entity is TRUE;
 
end BTS6PD;
 
-- architecture body --
architecture V of BTS6PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
 
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','L'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
 
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
--
----- CELL BTS6PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BTS6PU is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BTS6PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BTS6PU : entity is TRUE;
 
end BTS6PU;
 
-- architecture body --
architecture V of BTS6PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
 
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
 
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','H'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
 
--
----- CELL BTS12FPD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BTS12FPD is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BTS12FPD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
 
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BTS12FPD : entity is TRUE;
 
end BTS12FPD;
 
-- architecture body --
architecture V of BTS12FPD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
 
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','L'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
--
----- CELL BTS12FPU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BTS12FPU is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BTS12FPU";
 
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BTS12FPU : entity is TRUE;
 
end BTS12FPU;
 
-- architecture body --
architecture V of BTS12FPU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
 
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
 
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','H'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
 
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
--
----- CELL BTS12PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BTS12PD is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BTS12PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BTS12PD : entity is TRUE;
 
 
end BTS12PD;
 
-- architecture body --
architecture V of BTS12PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','L'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
 
--
----- CELL BTS12PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity BTS12PU is
   generic(
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := TRUE;
      InstancePath    : String := "BTS12PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_I          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_T          : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
 
 
   port(
      B               : inout STD_LOGIC;
      I               : in    STD_LOGIC;
      T               : in    STD_LOGIC;
      O               : out   STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BTS12PU : entity is TRUE;
 
end BTS12PU;
 
-- architecture body --
architecture V of BTS12PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;
 
   SIGNAL B_ipd  : STD_LOGIC := 'X';
   SIGNAL I_ipd  : STD_LOGIC := 'X';
   SIGNAL T_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (B_ipd, B, tipd_B);
 
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (B_ipd, I_ipd, T_ipd, TSALLNET)
 
   -- functionality results
   VARIABLE B_ipd2  : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
 
   -- output glitch detection variables
   VARIABLE B_GlitchData        : VitalGlitchDataType;
   VARIABLE O_GlitchData        : VitalGlitchDataType;
 
   begin
 
      -------------------------
      --  Functionality Section
      -------------------------
 
      B_ipd2 := VitalIdent (data => B_ipd,
                           ResultMap => ('U','X','0','1','H'));
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(B_ipd2);
 
      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => B,
       OutSignalName => "B",
       OutTemp => B_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_B, TRUE),
                 1 => (T_ipd'last_event, tpd_T_B, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => B_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (B_ipd'last_event, tpd_B_O, TRUE)),
 
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
end process;
 
end V;
 
--
----- cell bmz6 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz6 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz6";
      tpd_i_b         :  VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :  VitalDelayType01z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :  VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :  INOUT std_logic;
      i               :  IN std_logic;
      t               :  IN std_logic;
      o               :  OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz6 : ENTITY IS TRUE;
 
END bmz6;

-- architecture body --
ARCHITECTURE v OF bmz6 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd  : std_logic := 'X';
   SIGNAL i_ipd  : std_logic := 'X';
   SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData        : VitalGlitchDataType;
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz6pd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz6pd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz6pd";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz6pd : ENTITY IS TRUE;
 
END bmz6pd;

-- architecture body --
ARCHITECTURE v OF bmz6pd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri, 
                          resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz6pu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz6pu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz6pu";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz6pu : ENTITY IS TRUE;
 
END bmz6pu;

-- architecture body --
ARCHITECTURE v OF bmz6pu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz12 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz12 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz12";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz12 : ENTITY IS TRUE;
 
END bmz12;

-- architecture body --
ARCHITECTURE v OF bmz12 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz12f -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz12f IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz12f";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz12f : ENTITY IS TRUE;
 
END bmz12f;

-- architecture body --
ARCHITECTURE v OF bmz12f IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz12fpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz12fpd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz12fpd";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz12fpd : ENTITY IS TRUE;
 
END bmz12fpd;

-- architecture body --
ARCHITECTURE v OF bmz12fpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz12fpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz12fpu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz12fpu";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz12fpu : ENTITY IS TRUE;
 
END bmz12fpu;

-- architecture body --
ARCHITECTURE v OF bmz12fpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz12pd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz12pd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz12pd";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz12pd : ENTITY IS TRUE;
 
END bmz12pd;

-- architecture body --
ARCHITECTURE v OF bmz12pd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bmz12pu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bmz12pu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bmz12pu";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bmz12pu : ENTITY IS TRUE;
 
END bmz12pu;

-- architecture body --
ARCHITECTURE v OF bmz12pu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bts6 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bts6 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bts6";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bts6 : ENTITY IS TRUE;
 
END bts6;

-- architecture body --
ARCHITECTURE v OF bts6 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bts12 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bts12 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bts12";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bts12 : ENTITY IS TRUE;
 
END bts12;

-- architecture body --
ARCHITECTURE v OF bts12 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell bts12f -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY bts12f IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "bts12f";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF bts12f : ENTITY IS TRUE;
 
END bts12f;

-- architecture body --
ARCHITECTURE v OF bts12f IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz6 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz6 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz6";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz6 : ENTITY IS TRUE;
 
END btz6;

-- architecture body --
ARCHITECTURE v OF btz6 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz6pd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz6pd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz6pd";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz6pd : ENTITY IS TRUE;
 
END btz6pd;

-- architecture body --
ARCHITECTURE v OF btz6pd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz6pu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz6pu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz6pu";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz6pu : ENTITY IS TRUE;
 
END btz6pu;

-- architecture body --
ARCHITECTURE v OF btz6pu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz12 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz12 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz12";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz12 : ENTITY IS TRUE;
 
END btz12;

-- architecture body --
ARCHITECTURE v OF btz12 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz12f -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz12f IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz12f";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz12f : ENTITY IS TRUE;
 
END btz12f;

-- architecture body --
ARCHITECTURE v OF btz12f IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri);
      o_zd := VitalBUF(b_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz12fpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz12fpd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz12fpd";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz12fpd : ENTITY IS TRUE;
 
END btz12fpd;

-- architecture body --
ARCHITECTURE v OF btz12fpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz12fpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz12fpu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz12fpu";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz12fpu : ENTITY IS TRUE;
 
END btz12fpu;

-- architecture body --
ARCHITECTURE v OF btz12fpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz12pd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz12pd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz12pd";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz12pd : ENTITY IS TRUE;
 
END btz12pd;

-- architecture body --
ARCHITECTURE v OF btz12pd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','L'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell btz12pu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY btz12pu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "btz12pu";
      tpd_i_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_b         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_b_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_b          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      b               :	INOUT std_logic;
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF btz12pu : ENTITY IS TRUE;
 
END btz12pu;

-- architecture body --
ARCHITECTURE v OF btz12pu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL b_ipd	 : std_logic := 'X';
   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (b_ipd, b, tipd_b);
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (b_ipd, i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE b_ipd2  : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS b_zd       : std_ulogic IS results(1);
   ALIAS o_zd       : std_ulogic IS results(2);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE b_GlitchData	: VitalGlitchDataType;
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      b_ipd2 := VitalIDENT (data => b_ipd,
                           resultmap => ('U','X','0','1','H'));
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      b_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(b_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => b,
       OutSignalName => "b",
       OutTemp => b_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_b, TRUE),
                 1 => (t_ipd'last_event, tpd_t_b, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => b_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (b_ipd'last_event, tpd_b_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell clkcntlb -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;

-- entity declaration --
ENTITY clkcntlb IS
   GENERIC (
      freeze		 : String := "low";
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "clkcntlb";
      tpd_clkin_clkout	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      shutoff		 : in std_logic;
      clkout		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF clkcntlb : ENTITY IS TRUE;
 
END clkcntlb ;

-- ARCHITECTURE body --
ARCHITECTURE V OF clkcntlb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);

   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '0') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;

    IF (shutoff_reg = '1') THEN
          clkout_zd :='0';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


--
----- cell clkcntll -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;

-- entity declaration --
ENTITY clkcntll IS
   GENERIC (
      freeze		 : String := "low";
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "clkcntll";
      tpd_clkin_clkout	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      shutoff		 : in std_logic;
      clkout		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF clkcntll : ENTITY IS TRUE;
 
END clkcntll ;

-- ARCHITECTURE body --
ARCHITECTURE V OF clkcntll IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';   
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);

   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '0') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;
 
    IF (shutoff_reg = '1') THEN
          clkout_zd :='0';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


--
----- cell clkcntlr -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;

-- entity declaration --
ENTITY clkcntlr IS
   GENERIC (
      freeze		 : String := "low";
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "clkcntlr";
      tpd_clkin_clkout	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      shutoff		 : in std_logic;
      clkout		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF clkcntlr : ENTITY IS TRUE;
 
END clkcntlr ;

-- ARCHITECTURE body --
ARCHITECTURE V OF clkcntlr IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);

   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '0') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;
 
    IF (shutoff_reg = '1') THEN
          clkout_zd :='0';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;


--
----- cell clkcntlt -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;


-- entity declaration --
ENTITY clkcntlt IS
   GENERIC (
      freeze		 : String := "low";
      TimingChecksOn	 : Boolean := TRUE;
      XOn		 : Boolean := FALSE;        
      MsgOn		 : Boolean := TRUE;
      InstancePath	 : String  := "clkcntlt";
      tpd_clkin_clkout	 : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin	 : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff	 : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clkin		 : in std_logic;
      shutoff		 : in std_logic;
      clkout		 : out std_logic);

    ATTRIBUTE Vital_Level0 OF clkcntlt : ENTITY IS TRUE;
 
END clkcntlt ;

-- ARCHITECTURE body --
ARCHITECTURE V OF clkcntlt IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);

   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '0') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;
 
    IF (shutoff_reg = '1') THEN
          clkout_zd :='0';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END V;

--
----- cell clkcnthb -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;
 
-- entity declaration --
ENTITY clkcnthb IS
   GENERIC (
      freeze             : String := "high";
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "clkcnthb";
      tpd_clkin_clkout   : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      clkin              : in std_logic;
      shutoff            : in std_logic;
      clkout             : out std_logic);
 
    ATTRIBUTE Vital_Level0 OF clkcnthb : ENTITY IS TRUE;
 
END clkcnthb ;
 
-- ARCHITECTURE body --
ARCHITECTURE V OF clkcnthb IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
 
    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);
 
   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;
 
   BEGIN
 
    IF (TimingChecksOn) THEN
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '1') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;
 
    IF (shutoff_reg = '1') THEN
          clkout_zd :='1';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
 
END PROCESS;
 
END V;
 
 
--
----- cell clkcnthl -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;
 
-- entity declaration --
ENTITY clkcnthl IS
   GENERIC (
      freeze             : String := "high";
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "clkcnthl";
      tpd_clkin_clkout   : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      clkin              : in std_logic;
      shutoff            : in std_logic;
      clkout             : out std_logic);
 
    ATTRIBUTE Vital_Level0 OF clkcnthl : ENTITY IS TRUE;
 
END clkcnthl ;
 
-- ARCHITECTURE body --
ARCHITECTURE V OF clkcnthl IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
 
    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);
 
   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;
 
   BEGIN
 
    IF (TimingChecksOn) THEN
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '1') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;
 
    IF (shutoff_reg = '1') THEN
          clkout_zd :='1';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
 
END PROCESS;
 
END V;
 
 
--
----- cell clkcnthr -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;
 
-- entity declaration --
ENTITY clkcnthr IS
   GENERIC (
      freeze             : String := "high";
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "clkcnthr";
      tpd_clkin_clkout   : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      clkin              : in std_logic;
      shutoff            : in std_logic;
      clkout             : out std_logic);
 
    ATTRIBUTE Vital_Level0 OF clkcnthr : ENTITY IS TRUE;
 
END clkcnthr ;
 
-- ARCHITECTURE body --
ARCHITECTURE V OF clkcnthr IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
 
    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);
 
   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;
 
   BEGIN
 
    IF (TimingChecksOn) THEN
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '1') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;
 
    IF (shutoff_reg = '1') THEN
          clkout_zd :='1';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;
 
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
 
END PROCESS;
 
END V;
 
 
--
----- cell clkcntht -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.purnet;
 
 
-- entity declaration --
ENTITY clkcntht IS
   GENERIC (
      freeze             : String := "high";
      TimingChecksOn     : Boolean := TRUE;
      XOn                : Boolean := FALSE;
      MsgOn              : Boolean := TRUE;
      InstancePath       : String  := "clkcntht";
      tpd_clkin_clkout   : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_shutoff_clkout : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_shutoff       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      clkin              : in std_logic;
      shutoff            : in std_logic;
      clkout             : out std_logic);
 
    ATTRIBUTE Vital_Level0 OF clkcntht : ENTITY IS TRUE;
 
END clkcntht ;
 
-- ARCHITECTURE body --
ARCHITECTURE V OF clkcntht IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
 
    signal shutoff_ipd  : std_logic := 'X';
    signal clkin_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(shutoff_ipd, shutoff, tipd_shutoff);
   VitalWireDelay(clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : PROCESS (shutoff_ipd, clkin_ipd, purnet)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   VARIABLE shut_reg : std_logic := '0';
   VARIABLE shutoff_reg : std_logic := '0';
   ALIAS clkout_zd : std_ulogic is results(1);
 
   -- output glitch detection variables
   VARIABLE clkout_GlitchData : VitalGlitchDataType;
 
   BEGIN
 
    IF (TimingChecksOn) THEN
    END IF;
 
    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    IF (purnet = '0') THEN
       shutoff_reg := '0';
       shut_reg := '0';
    END IF;
 
    IF (purnet = '1') THEN
       IF (clkin_ipd'event and clkin_ipd = '1') THEN
          shutoff_reg := shut_reg;
          shut_reg := shutoff_ipd;
       END IF;
    END IF;
 
    IF (shutoff_reg = '1') THEN
          clkout_zd :='1';
       ELSIF (shutoff_reg = '0') THEN
          clkout_zd := VITALBUF(clkin_ipd);
       ELSE
          clkout_zd := 'X';
    END IF;
 
    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01 (
     OutSignal => clkout,
     OutSignalName => "clkout",
     OutTemp => clkout_zd,
     Paths => (0 => (clkin_ipd'last_event, tpd_clkin_clkout, TRUE),
               1 => (shutoff_ipd'last_event, tpd_shutoff_clkout, TRUE)),
     GlitchData => clkout_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);
 
END PROCESS;
 
END V;
 
 

--
----- cell ibm -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibm IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibm";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibm : ENTITY IS TRUE;
 
END ibm;

-- architecture body --
ARCHITECTURE v OF ibm IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUF(i_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibmpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibmpd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibmpd";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibmpd : ENTITY IS TRUE;
 
END ibmpd;

-- architecture body --
ARCHITECTURE v OF ibmpd IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibmpds -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibmpds IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibmpds";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibmpds : ENTITY IS TRUE;
 
END ibmpds;

-- architecture body --
ARCHITECTURE v OF ibmpds IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibmpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibmpu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibmpu";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibmpu : ENTITY IS TRUE;
 
END ibmpu;

-- architecture body --
ARCHITECTURE v OF ibmpu IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibmpus -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibmpus IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibmpus";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibmpus : ENTITY IS TRUE;
 
END ibmpus;

-- architecture body --
ARCHITECTURE v OF ibmpus IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibms -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibms IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibms";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibms : ENTITY IS TRUE;
 
END ibms;

-- architecture body --
ARCHITECTURE v OF ibms IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUF(i_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibt -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibt IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibt";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibt : ENTITY IS TRUE;
 
END ibt;

-- architecture body --
ARCHITECTURE v OF ibt IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUF(i_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibtpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibtpd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibtpd";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibtpd : ENTITY IS TRUE;
 
END ibtpd;

-- architecture body --
ARCHITECTURE v OF ibtpd IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibtpds -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibtpds IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibtpds";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibtpds : ENTITY IS TRUE;
 
END ibtpds;

-- architecture body --
ARCHITECTURE v OF ibtpds IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','L'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibtpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibtpu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibtpu";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibtpu : ENTITY IS TRUE;
 
END ibtpu;

-- architecture body --
ARCHITECTURE v OF ibtpu IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibtpus -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibtpus IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibtpus";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibtpus : ENTITY IS TRUE;
 
END ibtpus;

-- architecture body --
ARCHITECTURE v OF ibtpus IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE i_ipd2 : std_ulogic := 'X';
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      i_ipd2 := VitalIDENT (data => i_ipd,
                           resultmap => ('U','X','0','1','H'));
      o_zd := VitalBUF(i_ipd2);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ibts -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY ibts IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ibts";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ibts : ENTITY IS TRUE;
 
END ibts;

-- architecture body --
ARCHITECTURE v OF ibts IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUF(i_ipd);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, (tpd_i_o), TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ifs1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1p3bx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1p3bx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk	        : VitalDelayType := 0.01 ns;
        tpw_sclk_posedge	: VitalDelayType := 0.01 ns;
        tpw_sclk_negedge	: VitalDelayType := 0.01 ns;
        tperiod_pd	        : VitalDelayType := 0.01 ns;
        tpw_pd_posedge		: VitalDelayType := 0.01 ns;
        tpw_pd_negedge		: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3bx : ENTITY IS TRUE;

END ifs1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF ifs1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd: std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_posedge, 
            SetupLow => tsetup_d_sclk_noedge_posedge,
            HoldHigh => thold_d_sclk_noedge_posedge, 
            HoldLow => thold_d_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk_noedge_posedge, 
            SetupLow => tsetup_sp_sclk_noedge_posedge,
            HoldHigh => thold_sp_sclk_noedge_posedge, 
            HoldLow => thold_sp_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge,
            PulseWidthLow => tpw_pd_negedge,
            PeriodData => periodcheckinfo_pd, Violation => tviol_pd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);

    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => NOT(set_reset), b => pd_ipd);  

    vitalstatetable (statetable => ff_table,
	    datain => (violation, preset, sp_ipd, sclk_ipd, d_ipd),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1p3dx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1p3dx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk    	: VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_cd              : VitalDelayType := 0.01 ns;
        tpw_cd_posedge          : VitalDelayType := 0.01 ns;
        tpw_cd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3dx : ENTITY IS TRUE;

END ifs1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF ifs1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE clear	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_posedge, 
            SetupLow => tsetup_d_sclk_noedge_posedge,
            HoldHigh => thold_d_sclk_noedge_posedge, 
            HoldLow => thold_d_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk_noedge_posedge, 
            SetupLow => tsetup_sp_sclk_noedge_posedge,
            HoldHigh => thold_sp_sclk_noedge_posedge, 
            HoldLow => thold_sp_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge,
            PulseWidthLow => tpw_cd_negedge,
            PeriodData => periodcheckinfo_cd, Violation => tviol_cd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => NOT(set_reset), b => cd_ipd);  

    vitalstatetable (statetable => ff_table,
	    datain => (violation, clear, sp_ipd, sclk_ipd, d_ipd),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1p3ix IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1p3ix";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_cd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk            : VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_cd              : VitalDelayType := 0.01 ns;
        tpw_cd_posedge          : VitalDelayType := 0.01 ns;
        tpw_cd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk              : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3ix : ENTITY IS TRUE;

END ifs1p3ix ;
 
-- architecture body --
ARCHITECTURE v OF ifs1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  clr  scl  ce   sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- sync. clear 
	( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tsviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_posedge, 
            SetupLow => tsetup_d_sclk_noedge_posedge,
            HoldHigh => thold_d_sclk_noedge_posedge, 
            HoldLow => thold_d_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk_noedge_posedge, 
            SetupLow => tsetup_cd_sclk_noedge_posedge,
            HoldHigh => thold_cd_sclk_noedge_posedge, 
            HoldLow => thold_cd_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tsviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk_noedge_posedge, 
            SetupLow => tsetup_sp_sclk_noedge_posedge,
            HoldHigh => thold_sp_sclk_noedge_posedge, 
            HoldLow => thold_sp_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge,
            PulseWidthLow => tpw_cd_negedge,
            PeriodData => periodcheckinfo_cd, Violation => tviol_cd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, cd_ipd, sp_ipd, sclk_ipd, d_ipd),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1p3iz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1p3iz";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_cd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk    	: VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_cd              : VitalDelayType := 0.01 ns;
        tpw_cd_posedge          : VitalDelayType := 0.01 ns;
        tpw_cd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3iz : ENTITY IS TRUE;

END ifs1p3iz ;
 
-- architecture body --
ARCHITECTURE v OF ifs1p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tsviol_cd   : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_posedge, 
            SetupLow => tsetup_d_sclk_noedge_posedge,
            HoldHigh => thold_d_sclk_noedge_posedge, 
            HoldLow => thold_d_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk_noedge_posedge, 
            SetupLow => tsetup_cd_sclk_noedge_posedge,
            HoldHigh => thold_cd_sclk_noedge_posedge, 
            HoldLow => thold_cd_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tsviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk_noedge_posedge, 
            SetupLow => tsetup_sp_sclk_noedge_posedge,
            HoldHigh => thold_sp_sclk_noedge_posedge, 
            HoldLow => thold_sp_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge,
            PulseWidthLow => tpw_cd_negedge,
            PeriodData => periodcheckinfo_cd, Violation => tviol_cd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => NOT(cd_ipd));  

    vitalstatetable (statetable => ff_table,
	    datain => (violation, VitalBUF(set_reset), sp_ipd, sclk_ipd, synclr),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1p3jx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1p3jx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_pd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk    	: VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_pd              : VitalDelayType := 0.01 ns;
        tpw_pd_posedge          : VitalDelayType := 0.01 ns;
        tpw_pd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk              : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3jx : ENTITY IS TRUE;

END ifs1p3jx ;
 
-- architecture body --
ARCHITECTURE v OF ifs1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  pre  spr  ce   sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- sync. preset
	( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_posedge, 
            SetupLow => tsetup_d_sclk_noedge_posedge,
            HoldHigh => thold_d_sclk_noedge_posedge, 
            HoldLow => thold_d_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk_noedge_posedge, 
            SetupLow => tsetup_pd_sclk_noedge_posedge,
            HoldHigh => thold_pd_sclk_noedge_posedge, 
            HoldLow => thold_pd_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tsviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk_noedge_posedge, 
            SetupLow => tsetup_sp_sclk_noedge_posedge,
            HoldHigh => thold_sp_sclk_noedge_posedge, 
            HoldLow => thold_sp_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge,
            PulseWidthLow => tpw_pd_negedge,
            PeriodData => periodcheckinfo_pd, Violation => tviol_pd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, pd_ipd, sp_ipd, sclk_ipd, d_ipd),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1p3jz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1p3jz";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_pd_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        thold_sp_sclk_noedge_posedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk     	: VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_pd              : VitalDelayType := 0.01 ns;
        tpw_pd_posedge          : VitalDelayType := 0.01 ns;
        tpw_pd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1p3jz : ENTITY IS TRUE;

END ifs1p3jz ;
 
-- architecture body --
ARCHITECTURE v OF ifs1p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre	: std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_posedge, 
            SetupLow => tsetup_d_sclk_noedge_posedge,
            HoldHigh => thold_d_sclk_noedge_posedge, 
            HoldLow => thold_d_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk_noedge_posedge, 
            SetupLow => tsetup_pd_sclk_noedge_posedge,
            HoldHigh => thold_pd_sclk_noedge_posedge, 
            HoldLow => thold_pd_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tsviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk_noedge_posedge, 
            SetupLow => tsetup_sp_sclk_noedge_posedge,
            HoldHigh => thold_sp_sclk_noedge_posedge, 
            HoldLow => thold_sp_sclk_noedge_posedge,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge,
            PulseWidthLow => tpw_pd_negedge,
            PeriodData => periodcheckinfo_pd, Violation => tviol_pd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);  

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, sp_ipd, sclk_ipd, synpre),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1s1b -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1s1b IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1s1b";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk            : VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_pd              : VitalDelayType := 0.01 ns;
        tpw_pd_posedge          : VitalDelayType := 0.01 ns;
        tpw_pd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1b : ENTITY IS TRUE;

END ifs1s1b ;
 
-- architecture body --
ARCHITECTURE v OF ifs1s1b IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  pre  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '1' ),  -- async. preset 
	( '-', '0', '0', '-', '-', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '0', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '0', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_negedge, 
            SetupLow => tsetup_d_sclk_noedge_negedge,
            HoldHigh => thold_d_sclk_noedge_negedge, 
            HoldLow => thold_d_sclk_noedge_negedge,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge,
            PulseWidthLow => tpw_pd_negedge,
            PeriodData => periodcheckinfo_pd, Violation => tviol_pd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => NOT(set_reset), b => pd_ipd);  

    vitalstatetable (statetable => latch_table,
	    datain => (violation, preset, sclk_ipd, d_ipd),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1s1d -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1s1d IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1s1d";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q	        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk            : VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_cd              : VitalDelayType := 0.01 ns;
        tpw_cd_posedge          : VitalDelayType := 0.01 ns;
        tpw_cd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1d : ENTITY IS TRUE;

END ifs1s1d ;
 
-- architecture body --
ARCHITECTURE v OF ifs1s1d IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  clr  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '0' ),  -- async. clear 
	( '-', '0', '0', '-', '-', 'S' ),  -- clock low
	( '-', '0', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '0', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '0', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE clear	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_negedge, 
            SetupLow => tsetup_d_sclk_noedge_negedge,
            HoldHigh => thold_d_sclk_noedge_negedge, 
            HoldLow => thold_d_sclk_noedge_negedge,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge,
            PulseWidthLow => tpw_cd_negedge,
            PeriodData => periodcheckinfo_cd, Violation => tviol_cd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => NOT(set_reset), b => cd_ipd);  

    vitalstatetable (statetable => latch_table,
	    datain => (violation, clear, sclk_ipd, d_ipd),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1s1i -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1s1i IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1s1i";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q 	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_cd_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_cd_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk            : VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_cd              : VitalDelayType := 0.01 ns;
        tpw_cd_posedge          : VitalDelayType := 0.01 ns;
        tpw_cd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1i : ENTITY IS TRUE;

END ifs1s1i ;
 
-- architecture body --
ARCHITECTURE v OF ifs1s1i IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL cd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, cd_ipd, sclk_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  clr  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '0' ),  -- async. clear (active low)
        ( '-', '1', '0', '-', '-', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_sclk   : X01 := '0';
   VARIABLE tviol_d      : X01 := '0';
   VARIABLE tviol_cd     : X01 := '0';
   VARIABLE tsviol_cd    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_cd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr 	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_negedge, 
            SetupLow => tsetup_d_sclk_noedge_negedge,
            HoldHigh => thold_d_sclk_noedge_negedge, 
            HoldLow => thold_d_sclk_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk_noedge_negedge, 
            SetupLow => tsetup_cd_sclk_noedge_negedge,
            HoldHigh => thold_cd_sclk_noedge_negedge, 
            HoldLow => thold_cd_sclk_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tsviol_cd, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            Period => tperiod_cd,
            PulseWidthHigh => tpw_cd_posedge,
            PulseWidthLow => tpw_cd_negedge,
            PeriodData => periodcheckinfo_cd, Violation => tviol_cd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => NOT(cd_ipd));  

    vitalstatetable (statetable => latch_table,
	    datain => (violation, set_reset, sclk_ipd, synclr),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- cell ifs1s1j -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ifs1s1j IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn	: boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath	: string := "ifs1s1j";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_d_q	        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_d_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        tsetup_pd_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        thold_pd_sclk_noedge_negedge	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk            : VitalDelayType := 0.01 ns;
        tpw_sclk_posedge        : VitalDelayType := 0.01 ns;
        tpw_sclk_negedge        : VitalDelayType := 0.01 ns;
        tperiod_pd              : VitalDelayType := 0.01 ns;
        tpw_pd_posedge          : VitalDelayType := 0.01 ns;
        tpw_pd_negedge          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ifs1s1j : ENTITY IS TRUE;

END ifs1s1j ;
 
-- architecture body --
ARCHITECTURE v OF ifs1s1j IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd   : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL pd_ipd  : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, pd_ipd, sclk_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 6, 1 to 6) := (
      -- viol  pre  sclk    d    q  qnew 
	( 'X', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '1' ),  -- async. preset (active low)
        ( '-', '1', '0', '-', '-', 'S' ),  -- clock low
	( '-', '1', '1', '0', '-', '0' ),  -- low d->q on rising edge sclk
	( '-', '1', '1', '1', '-', '1' ),  -- high d->q on rising edge sclk
	( '-', '1', '1', 'X', '-', 'X' ) );  -- clock an x if d is x
	
   -- timing check results 
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tsviol_pd   : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_pd   : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre 	: std_logic := 'X';
   VARIABLE tpd_gsr_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_d_sclk_noedge_negedge, 
            SetupLow => tsetup_d_sclk_noedge_negedge,
            HoldHigh => thold_d_sclk_noedge_negedge, 
            HoldLow => thold_d_sclk_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk_noedge_negedge, 
            SetupLow => tsetup_pd_sclk_noedge_negedge,
            HoldHigh => thold_pd_sclk_noedge_negedge, 
            HoldLow => thold_pd_sclk_noedge_negedge,
            CheckEnabled => (set_reset='1'), RefTransition => '\',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tsviol_pd, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk_posedge, 
	    PulseWidthLow => tpw_sclk_negedge, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            Period => tperiod_pd,
            PulseWidthHigh => tpw_pd_posedge,
            PulseWidthLow => tpw_pd_negedge,
            PeriodData => periodcheckinfo_pd, Violation => tviol_pd,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);  

    vitalstatetable (statetable => latch_table,
	    datain => (violation, set_reset, sclk_ipd, synpre),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (d_ipd'last_event, tpd_d_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- ilf2p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3bx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3bx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.01 ns;
        thold_eclk_d	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.01 ns;
        thold_sclk_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.01 ns;
        tpw_eclk	: VitalDelayType := 0.01 ns;
        tperiod_sclk	: VitalDelayType := 0.01 ns;
        tpw_sclk	: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic; 
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3bx : ENTITY IS TRUE;

END ilf2p3bx ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL pd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock low
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on rising edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on rising edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   clk    d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck

	( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_eclk or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => NOT(set_reset), b => pd_ipd);  

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, preset, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- ilf2p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3dx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3dx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.01 ns;
        thold_eclk_d	: VitalDelayType := 0.01 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.01 ns;
        thold_sclk_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.01 ns;
        tpw_eclk	: VitalDelayType := 0.01 ns;
        tperiod_sclk	: VitalDelayType := 0.01 ns;
        tpw_sclk	: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3dx : ENTITY IS TRUE;

END ilf2p3dx ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL cd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear 
	( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE clear       : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'), 
            RefTransition => '\', MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_eclk or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => NOT(set_reset), b => cd_ipd);  

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, clear, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
		3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- ilf2p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3ix IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3ix";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.01 ns;
        thold_eclk_d	: VitalDelayType := 0.01 ns;
        tsetup_cd_sclk  : VitalDelayType := 0.01 ns;
        thold_sclk_cd   : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.01 ns;
        thold_sclk_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.01 ns;
        tpw_eclk	: VitalDelayType := 0.01 ns;
        tperiod_sclk	: VitalDelayType := 0.01 ns;
        tpw_sclk	: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3ix : ENTITY IS TRUE;

END ilf2p3ix ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL cd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  clr  scl  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- sync. clear
	( '-', '1', '-', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '-', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '-', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk, SetupLow => tsetup_cd_sclk,
            HoldHigh => thold_sclk_cd, HoldLow => thold_sclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation, eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, cd_ipd, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- ilf2p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3iz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3iz";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.01 ns;
        thold_eclk_d	: VitalDelayType := 0.01 ns;
        tsetup_cd_sclk  : VitalDelayType := 0.01 ns;
        thold_sclk_cd   : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.01 ns;
        thold_sclk_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.01 ns;
        tpw_eclk	: VitalDelayType := 0.01 ns;
        tperiod_sclk	: VitalDelayType := 0.01 ns;
        tpw_sclk	: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        cd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3iz : ENTITY IS TRUE;

END ilf2p3iz ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL cd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on faling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on faling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "0";
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synclr1     : std_logic := 'X';
   VARIABLE synclr2     : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk, SetupLow => tsetup_cd_sclk,
            HoldHigh => thold_sclk_cd, HoldLow => thold_sclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    synclr2 := VitalAND2 (a => latched(1), b => NOT(cd_ipd));

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, sp_ipd, sclk_ipd, synclr2),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- ilf2p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3jx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3jx";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.01 ns;
        thold_eclk_d	: VitalDelayType := 0.01 ns;
        tsetup_pd_sclk  : VitalDelayType := 0.01 ns;
        thold_sclk_pd   : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.01 ns;
        thold_sclk_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.01 ns;
        tpw_eclk	: VitalDelayType := 0.01 ns;
        tperiod_sclk	: VitalDelayType := 0.01 ns;
        tpw_sclk	: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3jx : ENTITY IS TRUE;

END ilf2p3jx ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL pd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x

   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  pre  spr  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- sync. preset
	( '-', '1', '-', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '-', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '-', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk, SetupLow => tsetup_pd_sclk,
            HoldHigh => thold_sclk_pd, HoldLow => thold_sclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, pd_ipd, sp_ipd, sclk_ipd, latched(1)),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;


--
----- ilf2p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ilf2p3jz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath	: string := "ilf2p3jz";
        -- propagation delays
        tpd_sclk_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q	: VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk	: VitalDelayType := 0.01 ns;
        thold_eclk_d	: VitalDelayType := 0.01 ns;
        tsetup_pd_sclk  : VitalDelayType := 0.01 ns;
        thold_sclk_pd   : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk	: VitalDelayType := 0.01 ns;
        thold_sclk_sp	: VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp		: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk	: VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk	: VitalDelayType := 0.01 ns;
        tpw_eclk	: VitalDelayType := 0.01 ns;
        tperiod_sclk	: VitalDelayType := 0.01 ns;
        tpw_sclk	: VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        pd              : IN std_logic;
        q               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilf2p3jz : ENTITY IS TRUE;

END ilf2p3jz ;
 
-- architecture body --
ARCHITECTURE v OF ilf2p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL d_ipd    : std_logic := '0';
    SIGNAL eclk_ipd : std_logic := '0';
    SIGNAL sclk_ipd : std_logic := '0';
    SIGNAL sp_ipd   : std_logic := '0';
    SIGNAL pd_ipd   : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)

   CONSTANT latch_table : VitalStateTableType (1 to 5, 1 to 5) := (
      -- viol   ck    d    q  qnew
        ( 'X',  '-', '-', '-', 'X' ),  -- timing violation
        ( '-',  '1', '-', '-', 'S' ),  -- clock high
        ( '-',  '0', '0', '-', '0' ),  -- low d->q on falling edge ck
        ( '-',  '0', '1', '-', '1' ),  -- high d->q on falling edge ck
        ( '-',  '0', 'X', '-', 'X' ) );  -- clock an x if d is x
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   clk   d    q  qnew 
	( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
	( '-', '0', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
	( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
	( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge clk
	( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge clk
	( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of ck
	( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
	
   -- timing check results 
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results 
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata1   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE prevdata2   : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE latched     : std_logic_vector (1 to 1) := "1";
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd 		: std_ulogic IS results(1);
   VARIABLE synpre1     : std_logic := 'X';
   VARIABLE synpre2     : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;

 
   BEGIN

   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
	    TestSignal => d_ipd, TestSignalName => "d", 
	    RefSignal => eclk_ipd, RefSignalName => "eclk", 
	    SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1'), RefTransition => '\', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash, 
	    Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk, SetupLow => tsetup_pd_sclk,
            HoldHigh => thold_sclk_pd, HoldLow => thold_sclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
	    TestSignal => sp_ipd, TestSignalName => "sp", 
	    RefSignal => sclk_ipd, RefSignalName => "sclk", 
	    SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/', 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash, 
	    Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => eclk_ipd, TestSignalName => "eclk", 
	    Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk, 
	    PulseWidthLow => tpw_eclk, 
	    PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
        VitalPeriodPulseCheck (
	    TestSignal => sclk_ipd, TestSignalName => "sclk", 
	    Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk, 
	    PulseWidthLow => tpw_sclk, 
	    PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk, 
	    MsgOn => MsgOn, XOn => XOn, 
	    HeaderMsg => InstancePath, CheckEnabled => TRUE, 
	    MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_eclk or tviol_sclk;
 
    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;

    vitalstatetable (statetable => latch_table,
            datain => (violation,  eclk_ipd, d_ipd),
            numstates => 1,
            result => latched,
            previousdatain => prevdata1);

    synpre2 := VitalOR2 (a => latched(1), b => pd_ipd);

    vitalstatetable (statetable => ff_table,
	    datain => (violation, set_reset, sp_ipd, sclk_ipd, synpre2),
	    numstates => 1,
	    result => results,
	    previousdatain => prevdata2);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event, 
	              pathdelay => tpd_sclk_q, 
		      pathcondition => TRUE),
		1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
		2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
		3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);

END PROCESS;
 
END v;




--
----- cell ob6 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY ob6 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ob6";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ob6 : ENTITY IS TRUE;
 
END ob6;

-- architecture body --
ARCHITECTURE v OF ob6 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);
   VARIABLE tpd_tsall_o : VitalDelayType01 := (0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUFIF1 (data => i_ipd, enable => tsallnet);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (tsallnet'last_event, tpd_tsall_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ob12 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY ob12 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ob12";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ob12 : ENTITY IS TRUE;
 
END ob12;

-- architecture body --
ARCHITECTURE v OF ob12 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);
   VARIABLE tpd_tsall_o : VitalDelayType01 := (0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUFIF1 (data => i_ipd, enable => tsallnet);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (tsallnet'last_event, tpd_tsall_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell ob12f -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY ob12f IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "ob12f";
      tpd_i_o         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ob12f : ENTITY IS TRUE;
 
END ob12f;

-- architecture body --
ARCHITECTURE v OF ob12f IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);
   VARIABLE tpd_tsall_o : VitalDelayType01 := (0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      o_zd := VitalBUFIF1 (data => i_ipd, enable => tsallnet);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (tsallnet'last_event, tpd_tsall_o, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz6 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz6 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz6";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz6 : ENTITY IS TRUE;
 
END obz6;

-- architecture body --
ARCHITECTURE v OF obz6 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz6pd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz6pd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz6pd";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz6pd : ENTITY IS TRUE;
 
END obz6pd;

-- architecture body --
ARCHITECTURE v OF obz6pd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz6pu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz6pu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz6pu";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz6pu : ENTITY IS TRUE;
 
END obz6pu;

-- architecture body --
ARCHITECTURE v OF obz6pu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz12 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz12 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz12";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz12 : ENTITY IS TRUE;
 
END obz12;

-- architecture body --
ARCHITECTURE v OF obz12 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz12f -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz12f IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz12f";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz12f : ENTITY IS TRUE;
 
END obz12f;

-- architecture body --
ARCHITECTURE v OF obz12f IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri);

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz12fpd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz12fpd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz12fpd";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz12fpd : ENTITY IS TRUE;
 
END obz12fpd;

-- architecture body --
ARCHITECTURE v OF obz12fpd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz12fpu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz12fpu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz12fpu";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz12fpu : ENTITY IS TRUE;
 
END obz12fpu;

-- architecture body --
ARCHITECTURE v OF obz12fpu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz12pd -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz12pd IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz12pd";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz12pd : ENTITY IS TRUE;
 
END obz12pd;

-- architecture body --
ARCHITECTURE v OF obz12pd IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','L'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell obz12pu -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.tsallnet;


-- entity declaration --
ENTITY obz12pu IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "obz12pu";
      tpd_i_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :	VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i          :	VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_t          :	VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      i               :	IN std_logic;
      t               :	IN std_logic;
      o               :	OUT std_logic);

    ATTRIBUTE Vital_Level0 OF obz12pu : ENTITY IS TRUE;
 
END obz12pu;

-- architecture body --
ARCHITECTURE v OF obz12pu IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL i_ipd	 : std_logic := 'X';
   SIGNAL t_ipd	 : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (i_ipd, i, tipd_i);
   VitalWireDelay (t_ipd, t, tipd_t);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd, tsallnet)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd       : std_ulogic IS results(1);
   VARIABLE tri     : std_logic := 'X';
   VARIABLE tpd_tsall_b : VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData	: VitalGlitchDataType;

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      tri := VitalOR2 (a => NOT(tsallnet), b => t_ipd);
      o_zd := VitalBUFIF0 (data => i_ipd, enable => tri,
                         resultmap => ('U','X','0','1','H'));

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01z (
       OutSignal => o,
       OutSignalName => "o",
       OutTemp => o_zd,
       Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
                 1 => (t_ipd'last_event, tpd_t_o, TRUE),
                 2 => (tsallnet'last_event, tpd_tsall_b, TRUE)),
       GlitchData => o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

END PROCESS;

END v;


--
-----cell ofs1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofs1p3bx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofs1p3bx";
        -- propagation delays
        tpd_sclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk     : VitalDelayType := 0.01 ns;
        thold_sclk_d      : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk      : VitalDelayType := 0.01 ns;
        tpw_sclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofs1p3bx : ENTITY IS TRUE;
 
END ofs1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF ofs1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL pd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   sclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset
        ( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
        ( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
        ( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d       : X01 := '0';
   VARIABLE tviol_sp      : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
 
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_d_sclk, SetupLow => tsetup_d_sclk,
            HoldHigh => thold_sclk_d, HoldLow => thold_sclk_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => sclk_ipd, TestSignalName => "sclk",
            Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk,
            PulseWidthLow => tpw_sclk,
            PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => NOT(set_reset), b => pd_ipd);
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, preset, sp_ipd, sclk_ipd, d_ipd),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event,
                      pathdelay => tpd_sclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
                3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofs1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofs1p3dx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofs1p3dx";
        -- propagation delays
        tpd_sclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk     : VitalDelayType := 0.01 ns;
        thold_sclk_d      : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
        -- pulse width constraints
        tperiod_sclk      : VitalDelayType := 0.01 ns;
        tpw_sclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofs1p3dx : ENTITY IS TRUE;
 
END ofs1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF ofs1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL cd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   sclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear
        ( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
        ( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
        ( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d       : X01 := '0';
   VARIABLE tviol_sp      : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE clear       : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_d_sclk, SetupLow => tsetup_d_sclk,
            HoldHigh => thold_sclk_d, HoldLow => thold_sclk_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => sclk_ipd, TestSignalName => "sclk",
            Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk,
            PulseWidthLow => tpw_sclk,
            PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => NOT(set_reset), b => cd_ipd);
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, clear, sp_ipd, sclk_ipd, d_ipd),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event,
                      pathdelay => tpd_sclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
                3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofs1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
 
 
ENTITY ofs1p3ix IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofs1p3ix";
        -- propagation delays
        tpd_sclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk     : VitalDelayType := 0.01 ns;
        thold_sclk_d      : VitalDelayType := 0.01 ns;
        tsetup_cd_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_cd     : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk      : VitalDelayType := 0.01 ns;
        tpw_sclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofs1p3ix : ENTITY IS TRUE;
 
END ofs1p3ix ;
 
-- architecture body --
ARCHITECTURE v OF ofs1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL cd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
 
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  clr  scl  ce   sclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
        ( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- sync. clear
        ( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
        ( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
        ( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g.falling) preserve q
 
   -- timing check results
   VARIABLE tviol_sclk    : X01 := '0';
   VARIABLE tviol_d       : X01 := '0';
   VARIABLE tviol_cd      : X01 := '0';
   VARIABLE tviol_sp      : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_d_sclk, SetupLow => tsetup_d_sclk,
            HoldHigh => thold_sclk_d, HoldLow => thold_sclk_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk, SetupLow => tsetup_cd_sclk,
            HoldHigh => thold_sclk_cd, HoldLow => thold_sclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => sclk_ipd, TestSignalName => "sclk",
            Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk,
            PulseWidthLow => tpw_sclk,
            PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, cd_ipd, sp_ipd, sclk_ipd, d_ipd),
            numstates => 1,
            result => results,
 
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event,
                      pathdelay => tpd_sclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofs1p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofs1p3iz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofs1p3iz";
        -- propagation delays
        tpd_sclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk     : VitalDelayType := 0.01 ns;
        thold_sclk_d      : VitalDelayType := 0.01 ns;
        tsetup_cd_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_cd     : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk      : VitalDelayType := 0.01 ns;
        tpw_sclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofs1p3iz : ENTITY IS TRUE;
 
END ofs1p3iz ;
 
-- architecture body --
ARCHITECTURE v OF ofs1p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL cd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, cd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   sclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
        ( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
        ( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
        ( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE synclr      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_d_sclk, SetupLow => tsetup_d_sclk,
            HoldHigh => thold_sclk_d, HoldLow => thold_sclk_d,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_cd_sclk, SetupLow => tsetup_cd_sclk,
            HoldHigh => thold_sclk_cd, HoldLow => thold_sclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_sclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
 
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => sclk_ipd, TestSignalName => "sclk",
            Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk,
            PulseWidthLow => tpw_sclk,
            PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => NOT(cd_ipd));
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, VitalBUF(set_reset), sp_ipd, sclk_ipd, synclr),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event,
                      pathdelay => tpd_sclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
 
--
----- ofs1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofs1p3jx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofs1p3jx";
        -- propagation delays
        tpd_sclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_sclk     : VitalDelayType := 0.01 ns;
        thold_sclk_d      : VitalDelayType := 0.01 ns;
        tsetup_pd_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_pd     : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk      : VitalDelayType := 0.01 ns;
        tpw_sclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofs1p3jx : ENTITY IS TRUE;
 
END ofs1p3jx ;
 
-- architecture body --
ARCHITECTURE v OF ofs1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
 
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL pd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  pre  spr  ce   sclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
        ( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- sync. preset
        ( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
        ( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
        ( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_d_sclk, SetupLow => tsetup_d_sclk,
            HoldHigh => thold_sclk_d, HoldLow => thold_sclk_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk, SetupLow => tsetup_pd_sclk,
            HoldHigh => thold_sclk_pd, HoldLow => thold_sclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => sclk_ipd, TestSignalName => "sclk",
            Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk,
            PulseWidthLow => tpw_sclk,
            PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
 
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, pd_ipd, sp_ipd, sclk_ipd, d_ipd),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => sclk_ipd'last_event,
                      pathdelay => tpd_sclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofs1p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofs1p3jz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofs1p3jz";
        -- propagation delays
        tpd_sclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
        -- setup and hold constraints
        tsetup_d_sclk     : VitalDelayType := 0.01 ns;
        thold_sclk_d      : VitalDelayType := 0.01 ns;
        tsetup_pd_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_pd     : VitalDelayType := 0.01 ns;
        tsetup_sp_sclk    : VitalDelayType := 0.01 ns;
        thold_sclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_sclk      : VitalDelayType := 0.01 ns;
        tpw_sclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        sclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofs1p3jz : ENTITY IS TRUE;
 
END ofs1p3jz ;
 
-- architecture body --
ARCHITECTURE v OF ofs1p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL sclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL pd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(sclk_ipd, sclk, tipd_sclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;
 
   --------------------
   --  behavior section
 
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, sclk_ipd, pd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   sclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
        ( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge sclk
        ( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge sclk
        ( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of sclk
        ( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_sclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_sclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_sclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_sclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE synpre      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_d_sclk, SetupLow => tsetup_d_sclk,
            HoldHigh => thold_sclk_d, HoldLow => thold_sclk_d,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_sclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_pd_sclk, SetupLow => tsetup_pd_sclk,
            HoldHigh => thold_sclk_pd, HoldLow => thold_sclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_sclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => sclk_ipd, RefSignalName => "sclk",
            SetupHigh => tsetup_sp_sclk, SetupLow => tsetup_sp_sclk,
            HoldHigh => thold_sclk_sp, HoldLow => thold_sclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_sclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => sclk_ipd, TestSignalName => "sclk",
            Period => tperiod_sclk,
            PulseWidthHigh => tpw_sclk,
            PulseWidthLow => tpw_sclk,
            PeriodData => periodcheckinfo_sclk, Violation => tviol_sclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_sclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, sp_ipd, sclk_ipd, synpre),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
 
      Paths => (0 => (inputchangetime => sclk_ipd'last_event,
                      pathdelay => tpd_sclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
 
 
--
----- cell osmux21 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY osmux21 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "osmux21";
      tpd_d0_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d1_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_d0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      d0              : IN std_logic;
      d1              : IN std_logic;
      sclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF osmux21 : ENTITY IS TRUE;
 
END osmux21;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF osmux21 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL d0_ipd         : std_logic := 'X';
   SIGNAL d1_ipd         : std_logic := 'X';
   SIGNAL sclk_ipd       : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
 
   BEGIN
   VitalWireDelay (d0_ipd, d0, tipd_d0);
   VitalWireDelay (d1_ipd, d1, tipd_d1);
   VitalWireDelay (sclk_ipd, sclk, tipd_sclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, sclk_ipd)
 
 
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
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => sclk_ipd));
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (d0_ipd'last_event, tpd_d0_z, TRUE),
                 1 => (d1_ipd'last_event, tpd_d1_z, TRUE),
                 2 => (sclk_ipd'last_event, tpd_sclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell osnd2 -----
--
 
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY osnd2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "osnd2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sclk_z       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      sclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF osnd2 : ENTITY IS TRUE;
 
END osnd2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF osnd2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL sclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (sclk_ipd, sclk, tipd_sclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, sclk_ipd)
 
 
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd and sclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (sclk_ipd'last_event, tpd_sclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell osnr2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY osnr2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "osnr2";
 
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      sclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF osnr2 : ENTITY IS TRUE;
 
END osnr2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF osnr2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL sclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (sclk_ipd, sclk, tipd_sclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, sclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
 
      -------------------------
      z_zd := NOT (a_ipd or sclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (sclk_ipd'last_event, tpd_sclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell osor2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY osor2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "osor2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      sclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF osor2 : ENTITY IS TRUE;
 
END osor2;
 
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF osor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL sclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (sclk_ipd, sclk, tipd_sclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, sclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd or sclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (sclk_ipd'last_event, tpd_sclk_z, TRUE)),
       GlitchData => z_GlitchData,
 
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
 
--
----- cell osxnor2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY osxnor2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "osxnor2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      sclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF osxnor2 : ENTITY IS TRUE;
 
END osxnor2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF osxnor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL sclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (sclk_ipd, sclk, tipd_sclk);
   END BLOCK;
   --------------------
 
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, sclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd xor sclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (sclk_ipd'last_event, tpd_sclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell osxor2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY osxor2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE; 
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "osxor2";
      tpd_a_z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sclk_z      :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      sclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF osxor2 : ENTITY IS TRUE;
 
END osxor2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF osxor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL sclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (sclk_ipd, sclk, tipd_sclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, sclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd xor sclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (sclk_ipd'last_event, tpd_sclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
 
--
----- cell osand2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY osand2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "osand2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_sclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      sclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF osand2 : ENTITY IS TRUE;
 
END osand2;
 
-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF osand2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL sclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (sclk_ipd, sclk, tipd_sclk);
   END BLOCK;
   --------------------
 
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, sclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd and sclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (sclk_ipd'last_event, tpd_sclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 

--
----- cell ofe1p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofe1p3bx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofe1p3bx";
        -- propagation delays
        tpd_eclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_pd_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk     : VitalDelayType := 0.01 ns;
        thold_eclk_d      : VitalDelayType := 0.01 ns;
        tsetup_sp_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk      : VitalDelayType := 0.01 ns;
        tpw_eclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofe1p3bx : ENTITY IS TRUE;
 
END ofe1p3bx ;
 
-- architecture body --
ARCHITECTURE v OF ofe1p3bx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0'; 
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL pd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, pd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   eclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '1', '-', '-', '-', '-', '1' ),  -- async. preset
        ( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge eclk
        ( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge eclk
        ( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of eclk
        ( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_eclk    : X01 := '0';
   VARIABLE tviol_d       : X01 := '0';
   VARIABLE tviol_sp      : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE preset      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
 
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_sp_eclk, SetupLow => tsetup_sp_eclk,
            HoldHigh => thold_eclk_sp, HoldLow => thold_eclk_sp,
            CheckEnabled => (set_reset='1' AND pd_ipd='0'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_eclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => eclk_ipd, TestSignalName => "eclk",
            Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk,
            PulseWidthLow => tpw_eclk,
            PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_eclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    preset := VitalOR2 (a => NOT(set_reset), b => pd_ipd);
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, preset, sp_ipd, eclk_ipd, d_ipd),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => eclk_ipd'last_event,
                      pathdelay => tpd_eclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (pd_ipd'last_event, tpd_pd_q, TRUE),
                3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofe1p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofe1p3dx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofe1p3dx";
        -- propagation delays
        tpd_eclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_cd_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk     : VitalDelayType := 0.01 ns;
        thold_eclk_d      : VitalDelayType := 0.01 ns;
        tsetup_sp_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
        -- pulse width constraints
        tperiod_eclk      : VitalDelayType := 0.01 ns;
        tpw_eclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofe1p3dx : ENTITY IS TRUE;
 
END ofe1p3dx ;
 
-- architecture body --
ARCHITECTURE v OF ofe1p3dx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL cd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, cd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   eclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '1', '-', '-', '-', '-', '0' ),  -- async. clear
        ( '-', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge eclk
        ( '-', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge eclk
        ( '-', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of eclk 
        ( '-', '0', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE sp_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE clear       : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_sp_eclk, SetupLow => tsetup_sp_eclk,
            HoldHigh => thold_eclk_sp, HoldLow => thold_eclk_sp,
            CheckEnabled => (set_reset='1' AND cd_ipd='0'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_eclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => eclk_ipd, TestSignalName => "eclk",
            Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk,
            PulseWidthLow => tpw_eclk,
            PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_sp or tviol_eclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    clear := VitalOR2 (a => NOT(set_reset), b => cd_ipd);
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, clear, sp_ipd, eclk_ipd, d_ipd),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => eclk_ipd'last_event,
                      pathdelay => tpd_eclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (cd_ipd'last_event, tpd_cd_q, TRUE),
                3 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                4 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofe1p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
 
 
ENTITY ofe1p3ix IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofe1p3ix";
        -- propagation delays
        tpd_eclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk     : VitalDelayType := 0.01 ns;
        thold_eclk_d      : VitalDelayType := 0.01 ns;
        tsetup_cd_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_cd     : VitalDelayType := 0.01 ns;
        tsetup_sp_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk      : VitalDelayType := 0.01 ns;
        tpw_eclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofe1p3ix : ENTITY IS TRUE;
 
END ofe1p3ix ;
 
-- architecture body --
ARCHITECTURE v OF ofe1p3ix IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL cd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
 
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, cd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  clr  scl  ce   eclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
        ( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '-', '/', '-', '-', '0' ),  -- sync. clear
        ( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge eclk
        ( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge eclk
        ( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of eclk
        ( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
 
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND cd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_cd_eclk, SetupLow => tsetup_cd_eclk,
            HoldHigh => thold_eclk_cd, HoldLow => thold_eclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_eclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_sp_eclk, SetupLow => tsetup_sp_eclk,
            HoldHigh => thold_eclk_sp, HoldLow => thold_eclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_eclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => eclk_ipd, TestSignalName => "eclk",
            Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk,
            PulseWidthLow => tpw_eclk,
            PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_eclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, cd_ipd, sp_ipd, eclk_ipd, d_ipd),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => eclk_ipd'last_event,
                      pathdelay => tpd_eclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofe1p3iz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofe1p3iz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofe1p3iz";
        -- propagation delays
        tpd_eclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk     : VitalDelayType := 0.01 ns;
        thold_eclk_d      : VitalDelayType := 0.01 ns;
        tsetup_cd_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_cd     : VitalDelayType := 0.01 ns;
        tsetup_sp_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
 
        tipd_cd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk      : VitalDelayType := 0.01 ns;
        tpw_eclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        cd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofe1p3iz : ENTITY IS TRUE;
 
END ofe1p3iz ;
 
-- architecture body --
ARCHITECTURE v OF ofe1p3iz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL cd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(cd_ipd, cd, tipd_cd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, cd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  clr  ce   eclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '0' ),  -- async. clear (active low)
        ( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge eclk
        ( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge eclk
        ( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x 
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of eclk
        ( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_eclk    : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_cd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE cd_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "0";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE synclr      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => cd_ipd, TestSignalName => "cd",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_cd_eclk, SetupLow => tsetup_cd_eclk,
            HoldHigh => thold_eclk_cd, HoldLow => thold_eclk_cd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => cd_eclk_timingdatash,
            Violation => tviol_cd, MsgSeverity => warning);
 
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_sp_eclk, SetupLow => tsetup_sp_eclk,
            HoldHigh => thold_eclk_sp, HoldLow => thold_eclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_eclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => eclk_ipd, TestSignalName => "eclk",
            Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk,
            PulseWidthLow => tpw_eclk,
            PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_cd or tviol_sp or tviol_eclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synclr := VitalAND2 (a => d_ipd, b => NOT(cd_ipd));
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, VitalBUF(set_reset), sp_ipd, eclk_ipd, synclr),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => eclk_ipd'last_event,
                      pathdelay => tpd_eclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
 
--
----- ofe1p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofe1p3jx IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofe1p3jx";
        -- propagation delays
        tpd_eclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- setup and hold constraints
        tsetup_d_eclk     : VitalDelayType := 0.01 ns;
        thold_eclk_d      : VitalDelayType := 0.01 ns;
        tsetup_pd_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_pd     : VitalDelayType := 0.01 ns;
        tsetup_sp_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk      : VitalDelayType := 0.01 ns;
        tpw_eclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofe1p3jx : ENTITY IS TRUE;
 
END ofe1p3jx ;
 
-- architecture body --
ARCHITECTURE v OF ofe1p3jx IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
 
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL pd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk , tipd_eclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, pd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 9, 1 to 8) := (
      -- viol  pre  spr  ce   eclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
        ( '-', '1', '0', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '-', '/', '-', '-', '1' ),  -- sync. preset
        ( '-', '1', '0', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge eclk
        ( '-', '1', '0', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge eclk
        ( '-', '1', '0', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', '0', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of eclk
        ( '-', '1', '-', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND pd_ipd='0' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_pd_eclk, SetupLow => tsetup_pd_eclk,
            HoldHigh => thold_eclk_pd, HoldLow => thold_eclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_eclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_sp_eclk, SetupLow => tsetup_sp_eclk,
            HoldHigh => thold_eclk_sp, HoldLow => thold_eclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_eclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => eclk_ipd, TestSignalName => "eclk",
            Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk,
            PulseWidthLow => tpw_eclk,
            PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
 
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_eclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, pd_ipd, sp_ipd, eclk_ipd, d_ipd),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
      Paths => (0 => (inputchangetime => eclk_ipd'last_event,
                      pathdelay => tpd_eclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- ofe1p3jz -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
USE work.global.gsrnet;
USE work.global.purnet;
 
ENTITY ofe1p3jz IS
    GENERIC (

        disabled_gsr    : string := "0";

        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := FALSE;
        InstancePath    : string := "ofe1p3jz";
        -- propagation delays
        tpd_eclk_q        : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_sp_q          : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
        -- setup and hold constraints
        tsetup_d_eclk     : VitalDelayType := 0.01 ns;
        thold_eclk_d      : VitalDelayType := 0.01 ns;
        tsetup_pd_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_pd     : VitalDelayType := 0.01 ns;
        tsetup_sp_eclk    : VitalDelayType := 0.01 ns;
        thold_eclk_sp     : VitalDelayType := 0.01 ns;
        -- input SIGNAL delays
        tipd_d            : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_sp           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_eclk         : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_pd           : VitalDelayType01 := (0.0 ns, 0.0 ns);
        -- pulse width constraints
        tperiod_eclk      : VitalDelayType := 0.01 ns;
        tpw_eclk          : VitalDelayType := 0.01 ns);
 
    PORT (
        d               : IN std_logic;
        sp              : IN std_logic;
        pd              : IN std_logic;
        eclk            : IN std_logic;
        q               : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF ofe1p3jz : ENTITY IS TRUE;
 
END ofe1p3jz ;
 
-- architecture body --
ARCHITECTURE v OF ofe1p3jz IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL d_ipd     : std_logic := '0';
    SIGNAL eclk_ipd  : std_logic := '0';
    SIGNAL sp_ipd    : std_logic := '0';
    SIGNAL pd_ipd    : std_logic := '0';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(d_ipd, d, tipd_d);
       VitalWireDelay(eclk_ipd, eclk, tipd_eclk);
       VitalWireDelay(sp_ipd, sp, tipd_sp);
       VitalWireDelay(pd_ipd, pd, tipd_pd);
    END BLOCK;
 
   --------------------
   --  behavior section
 
   --------------------
   VitalBehavior : PROCESS (d_ipd, sp_ipd, eclk_ipd, pd_ipd, gsrnet, purnet)
 
   CONSTANT ff_table : VitalStateTableType (1 to 8, 1 to 7) := (
      -- viol  pre  ce   eclk  d    q  qnew
        ( 'X', '-', '-', '-', '-', '-', 'X' ),  -- timing violation
        ( '-', '0', '-', '-', '-', '-', '1' ),  -- async. preset (active low)
        ( '-', '1', '0', '-', '-', '-', 'S' ),  -- clock disabled
        ( '-', '1', '1', '/', '0', '-', '0' ),  -- low d->q on rising edge eclk
        ( '-', '1', '1', '/', '1', '-', '1' ),  -- high d->q on rising edge eclk
        ( '-', '1', '1', '/', 'X', '-', 'X' ),  -- clock an x if d is x
        ( '-', '1', 'X', '/', '-', '-', 'X' ),  -- ce is x on rising edge of eclk
        ( '-', '1', '-', 'B', '-', '-', 'S' ) );  -- non-x clock (e.g. falling) preserve q
 
   -- timing check results
   VARIABLE tviol_eclk  : X01 := '0';
   VARIABLE tviol_d     : X01 := '0';
   VARIABLE tviol_pd    : X01 := '0';
   VARIABLE tviol_sp    : X01 := '0';
   VARIABLE d_eclk_TimingDatash  : VitalTimingDataType;
   VARIABLE pd_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE sp_eclk_TimingDatash : VitalTimingDataType;
   VARIABLE periodcheckinfo_eclk : VitalPeriodDataType;
 
   -- functionality results
   VARIABLE set_reset : std_logic := '1';
   VARIABLE violation   : X01 := '0';
   VARIABLE prevdata    : std_logic_vector (0 to 5) := (others=>'X');
   VARIABLE results     : std_logic_vector (1 to 1) := "1";
   ALIAS q_zd           : std_ulogic IS results(1);
   VARIABLE synpre      : std_logic := 'X';
   VARIABLE tpd_gsr_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
   VARIABLE tpd_pur_q   : VitalDelayType01 := (0.1 ns, 0.1 ns);
 
   -- output glitch detection VARIABLEs
   VARIABLE q_GlitchData     : VitalGlitchDataType;
 
 
   BEGIN
 
   ------------------------
   --  timing check section
   ------------------------
 
    IF (TimingChecksOn) THEN
        VitalSetupHoldCheck (
            TestSignal => d_ipd, TestSignalName => "d",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_d_eclk, SetupLow => tsetup_d_eclk,
            HoldHigh => thold_eclk_d, HoldLow => thold_eclk_d,
            CheckEnabled => (set_reset='1' AND sp_ipd ='1'),
            RefTransition => '/', MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => d_eclk_timingdatash,
            Violation => tviol_d, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => pd_ipd, TestSignalName => "pd",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_pd_eclk, SetupLow => tsetup_pd_eclk,
            HoldHigh => thold_eclk_pd, HoldLow => thold_eclk_pd,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => pd_eclk_timingdatash,
            Violation => tviol_pd, MsgSeverity => warning);
        VitalSetupHoldCheck (
            TestSignal => sp_ipd, TestSignalName => "sp",
            RefSignal => eclk_ipd, RefSignalName => "eclk",
            SetupHigh => tsetup_sp_eclk, SetupLow => tsetup_sp_eclk,
            HoldHigh => thold_eclk_sp, HoldLow => thold_eclk_sp,
            CheckEnabled => (set_reset='1'), RefTransition => '/',
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, TimingData => sp_eclk_timingdatash,
            Violation => tviol_sp, MsgSeverity => warning);
        VitalPeriodPulseCheck (
            TestSignal => eclk_ipd, TestSignalName => "eclk",
            Period => tperiod_eclk,
            PulseWidthHigh => tpw_eclk,
            PulseWidthLow => tpw_eclk,
            PeriodData => periodcheckinfo_eclk, Violation => tviol_eclk,
            MsgOn => MsgOn, XOn => XOn,
            HeaderMsg => InstancePath, CheckEnabled => TRUE,
            MsgSeverity => warning);
    END IF;
 
    -----------------------------------
    -- functionality section.
    -----------------------------------
    violation := tviol_d or tviol_pd or tviol_sp or tviol_eclk;

    IF (disabled_gsr =  "1") THEN
       set_reset := purnet;
    ELSE
       set_reset := purnet AND gsrnet;
    END IF;
 
    synpre := VitalOR2 (a => d_ipd, b => pd_ipd);
 
    vitalstatetable (statetable => ff_table,
            datain => (violation, set_reset, sp_ipd, eclk_ipd, synpre),
            numstates => 1,
            result => results,
            previousdatain => prevdata);
 
    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01 (
      OutSignal => q,
      OutSignalName => "q",
      OutTemp => q_zd,
 
      Paths => (0 => (inputchangetime => eclk_ipd'last_event,
                      pathdelay => tpd_eclk_q,
                      pathcondition => TRUE),
                1 => (sp_ipd'last_event, tpd_sp_q, TRUE),
                2 => (gsrnet'last_event, tpd_gsr_q, TRUE),
                3 => (purnet'last_event, tpd_pur_q, TRUE)),
      GlitchData => q_GlitchData,
      Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
 
 
--
----- cell oemux21 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY oemux21 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "oemux21";
      tpd_d0_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_d1_z        : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_eclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_d0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_d1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_eclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      d0              : IN std_logic;
      d1              : IN std_logic;
      eclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF oemux21 : ENTITY IS TRUE;
 
END oemux21;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF oemux21 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL d0_ipd         : std_logic := 'X';
   SIGNAL d1_ipd         : std_logic := 'X';
   SIGNAL eclk_ipd       : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
 
   BEGIN
   VitalWireDelay (d0_ipd, d0, tipd_d0);
   VitalWireDelay (d1_ipd, d1, tipd_d1);
   VitalWireDelay (eclk_ipd, eclk, tipd_eclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0_ipd, d1_ipd, eclk_ipd)
 
 
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
                 (data => (d1_ipd, d0_ipd),
                  dselect => (0 => eclk_ipd));
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (d0_ipd'last_event, tpd_d0_z, TRUE),
                 1 => (d1_ipd'last_event, tpd_d1_z, TRUE),
                 2 => (eclk_ipd'last_event, tpd_eclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell oend2 -----
--
 
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY oend2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "oend2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_eclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_eclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      eclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF oend2 : ENTITY IS TRUE;
 
END oend2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF oend2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL eclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (eclk_ipd, eclk, tipd_eclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, eclk_ipd)
  
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd and eclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (eclk_ipd'last_event, tpd_eclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell oenr2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY oenr2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "oenr2"; 
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_eclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_eclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      eclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF oenr2 : ENTITY IS TRUE;
 
END oenr2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF oenr2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL eclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (eclk_ipd, eclk, tipd_eclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, eclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
 
      -------------------------
      z_zd := NOT (a_ipd or eclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (eclk_ipd'last_event, tpd_eclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell oeor2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY oeor2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "oeor2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_eclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_eclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      eclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF oeor2 : ENTITY IS TRUE;
 
END oeor2;
 
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF oeor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL eclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (eclk_ipd, eclk, tipd_eclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, eclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd or eclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (eclk_ipd'last_event, tpd_eclk_z, TRUE)),
       GlitchData => z_GlitchData,
 
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
 
--
----- cell oexnor2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY oexnor2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "oexnor2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_eclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_eclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      eclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF oexnor2 : ENTITY IS TRUE;
 
END oexnor2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF oexnor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL eclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (eclk_ipd, eclk, tipd_eclk);
   END BLOCK;
   --------------------
 
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, eclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := NOT (a_ipd xor eclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (eclk_ipd'last_event, tpd_eclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
--
----- cell oexor2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY oexor2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE; 
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "oexor2";
      tpd_a_z         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_eclk_z      :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_eclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      eclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF oexor2 : ENTITY IS TRUE;
 
END oexor2;
 
-- architecture body --
 
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF oexor2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL eclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (eclk_ipd, eclk, tipd_eclk);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, eclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd xor eclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (eclk_ipd'last_event, tpd_eclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
 
END PROCESS;
 
END v;
 
 
 
--
----- cell oeand2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_primitives.all;
USE ieee.vital_timing.all;
 
 
-- entity declaration --
ENTITY oeand2 IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "oeand2";
      tpd_a_z         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_eclk_z      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_a          : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_eclk       : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      a               : IN std_logic;
      eclk            : IN std_logic;
      z               : OUT std_logic);
 
   ATTRIBUTE Vital_Level0 OF oeand2 : ENTITY IS TRUE;
 
END oeand2;
 
-- architecture body --
LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF oeand2 IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL a_ipd     : std_logic := 'X';
   SIGNAL eclk_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (a_ipd, a, tipd_a);
   VitalWireDelay (eclk_ipd, eclk, tipd_eclk);
   END BLOCK;
   --------------------
 
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a_ipd, eclk_ipd)
 
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      IF (TimingChecksOn) THEN
      -----------------------------------
      -- no timing checks for a comb gate
      -----------------------------------
      END IF;
 
      -------------------------
      --  functionality section
      -------------------------
      z_zd := (a_ipd and eclk_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => z,
       OutSignalName => "z",
       OutTemp => z_zd,
       Paths => (0 => (a_ipd'last_event, tpd_a_z, TRUE),
                 1 => (eclk_ipd'last_event, tpd_eclk_z, TRUE)),
       GlitchData => z_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 


--
----- cell tbuf -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;


-- entity declaration --
ENTITY tbuf IS
   GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;        
      MsgOn           : boolean := TRUE;
      InstancePath    : string  := "tbuf";
      tpd_i_o         :  VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :  VitalDelayType01z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_t          : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_i 	      : VitalDelayType01 := (0.0 ns, 0.0 ns)) ;

   PORT(
      t		      : IN std_logic;
      i 	      : IN std_logic;
      o  	      : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF tbuf : ENTITY IS TRUE;
 
END tbuf ;

-- architecture body --
ARCHITECTURE v OF tbuf IS
    ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

    SIGNAL t_ipd  : std_logic := 'X';
    SIGNAL i_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(t_ipd, t, tipd_t);
   VitalWireDelay(i_ipd, i, tipd_i);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (t_ipd, i_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- functionality section.
    -----------------------------------
    o_zd := VitalBUFIF0 (enable => t_ipd, data => i_ipd);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01z (
     OutSignal => o,
     OutSignalName => "o",
     OutTemp => o_zd,
     Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
               1 => (t_ipd'last_event, tpd_t_o, TRUE)),
     GlitchData => o_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell tibuf -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY tibuf IS
   GENERIC (
      TimingChecksOn  : boolean := FALSE;
      XOn             : boolean := FALSE;        
      MsgOn           : boolean := FALSE;
      InstancePath    : string  := "tibuf";
      tpd_i_o         :  VitalDelayType01z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_t_o         :  VitalDelayType01z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_i 	      : VitalDelayType01 := (0.0 ns, 0.0 ns) ;
      tipd_t	      : VitalDelayType01 := (0.0 ns, 0.0 ns)) ;

   PORT(
      t		      : IN std_logic;
      i 	      : IN std_logic;
      o 	      : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF tibuf : ENTITY IS TRUE;
 
END tibuf ;

-- architecture body --
ARCHITECTURE v OF tibuf IS
    ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

    SIGNAL i_ipd  : std_logic := 'X';
    SIGNAL t_ipd  : std_logic := 'X';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(i_ipd, i, tipd_i);
   VitalWireDelay(t_ipd, t, tipd_t);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (i_ipd, t_ipd)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS o_zd : std_ulogic IS results(1);

   -- output glitch detection VARIABLEs
   VARIABLE o_GlitchData        : VitalGlitchDataType;

   BEGIN

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- functionality section.
    -----------------------------------
    o_zd := VitalBUFIF1 (data => i_ipd, enable => t_ipd);

    -----------------------------------
    -- path delay section.
    -----------------------------------
    VitalPathDelay01z (
     OutSignal => o,
     OutSignalName => "o",
     OutTemp => o_zd,
     Paths => (0 => (i_ipd'last_event, tpd_i_o, TRUE),
               1 => (t_ipd'last_event, tpd_t_o, TRUE)),
     GlitchData => o_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

END PROCESS;

END v;


--
----- cell pcmbufb -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
 
-- entity declaration --
ENTITY pcmbufb IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "pcmbufb";
      tpd_clkin_eclk  : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk  : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin      : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      clkin               : IN std_logic;
      eclk,sclk           : OUT std_logic);
    ATTRIBUTE Vital_Level0 OF pcmbufb : ENTITY IS TRUE;
 
END pcmbufb;
 
-- architecture body --
ARCHITECTURE v OF pcmbufb IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL clkin_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (clkin_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS eclk_zd : std_ulogic IS results(1);
   ALIAS sclk_zd : std_ulogic IS results(2);
 
 
 
   -- output glitch detection VARIABLEs
   VARIABLE eclk_GlitchData        : VitalGlitchDataType;
   VARIABLE sclk_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      eclk_zd := VitalBUF(clkin_ipd);
      sclk_zd := VitalBUF(clkin_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => eclk,
       OutSignalName => "eclk",
       OutTemp => eclk_zd,
       Paths => (0 => (clkin_ipd'last_event, (tpd_clkin_eclk), TRUE)),
       GlitchData => eclk_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => sclk,
       OutSignalName => "sclk",
       OutTemp => sclk_zd,
       Paths => (0 => (clkin_ipd'last_event, (tpd_clkin_sclk), TRUE)),
       GlitchData => sclk_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
  END PROCESS;
 
END v;
 
--
----- cell pcmbuft -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
 
-- entity declaration --
ENTITY pcmbuft IS
   GENERIC(
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
 
      InstancePath    : string := "pcmbuft";
      tpd_clkin_eclk  : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_clkin_sclk  : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_clkin      : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      clkin               : IN std_logic;
      eclk,sclk           : OUT std_logic);
    ATTRIBUTE Vital_Level0 OF pcmbuft : ENTITY IS TRUE;
 
END pcmbuft;
 
-- architecture body --
ARCHITECTURE v OF pcmbuft IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL clkin_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (clkin_ipd, clkin, tipd_clkin);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (clkin_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS eclk_zd : std_ulogic IS results(1);
   ALIAS sclk_zd : std_ulogic IS results(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE eclk_GlitchData        : VitalGlitchDataType;
   VARIABLE sclk_GlitchData        : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      eclk_zd := VitalBUF(clkin_ipd);
      sclk_zd := VitalBUF(clkin_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => eclk,
       OutSignalName => "eclk",
       OutTemp => eclk_zd,
       Paths => (0 => (clkin_ipd'last_event, (tpd_clkin_eclk), TRUE)),
       GlitchData => eclk_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
      VitalPathDelay01 (
       OutSignal => sclk,
       OutSignalName => "sclk",
       OutTemp => sclk_zd,
       Paths => (0 => (clkin_ipd'last_event, (tpd_clkin_sclk), TRUE)),
       GlitchData => sclk_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
  END PROCESS;
 
END v;
 
 
--
----- cell intrbuf -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
 
-- entity declaration --
ENTITY intrbuf IS
   GENERIC(
      TimingChecksOn         : boolean := TRUE;
      XOn                    : boolean := FALSE;
      MsgOn                  : boolean := TRUE;
      InstancePath           : string := "intrbuf";
      tpd_asbi_frasb         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasb_asbo         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasbm1_asbm1o     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasbm2_asbm2o     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasbm3_asbm3o     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_asbi              :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasb             :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasbm1           :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasbm2           :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasbm3           :  VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      asbi                :     IN   std_logic;
      toasb               :     IN   std_logic;
      toasbm1             :     IN   std_logic;
      toasbm2             :     IN   std_logic;
      toasbm3             :     IN   std_logic;
      frasb               :     OUT  std_logic;
      asbo                :     OUT  std_logic;
      asbm1o              :     OUT  std_logic;
      asbm2o              :     OUT  std_logic;
      asbm3o              :     OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF intrbuf : ENTITY IS TRUE;
 
END intrbuf;
 
-- architecture body --
ARCHITECTURE v OF intrbuf IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL asbi_ipd       : std_logic := 'X';
   SIGNAL toasb_ipd      : std_logic := 'X';
   SIGNAL toasbm1_ipd    : std_logic := 'X';
   SIGNAL toasbm2_ipd    : std_logic := 'X';
   SIGNAL toasbm3_ipd    : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (asbi_ipd, asbi, tipd_asbi);
   VitalWireDelay (toasb_ipd, toasb, tipd_toasb);
   VitalWireDelay (toasbm1_ipd, toasbm1, tipd_toasbm1);
   VitalWireDelay (toasbm2_ipd, toasbm2, tipd_toasbm2);
   VitalWireDelay (toasbm3_ipd, toasbm3, tipd_toasbm3);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (asbi_ipd, toasb_ipd, toasbm1_ipd, toasbm2_ipd, toasbm3_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 5) := (others => 'X');
   ALIAS frasb_zd   : std_ulogic IS results(1);
   ALIAS asbo_zd    : std_ulogic IS results(2);
   ALIAS asbm1o_zd  : std_ulogic IS results(3);
   ALIAS asbm2o_zd  : std_ulogic IS results(4);
   ALIAS asbm3o_zd  : std_ulogic IS results(5);
 
   -- output glitch detection VARIABLEs
   VARIABLE frasb_GlitchData    : VitalGlitchDataType;
   VARIABLE asbo_GlitchData     : VitalGlitchDataType;
   VARIABLE asbm1o_GlitchData   : VitalGlitchDataType;
   VARIABLE asbm2o_GlitchData   : VitalGlitchDataType;
   VARIABLE asbm3o_GlitchData   : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      frasb_zd  := VitalBUF(asbi_ipd);
      asbo_zd   := VitalBUF(toasb_ipd);
      asbm1o_zd := VitalBUF(toasbm1_ipd);
      asbm2o_zd := VitalBUF(toasbm2_ipd);
      asbm3o_zd := VitalBUF(toasbm3_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => frasb,
       OutSignalName => "frasb",
       OutTemp => frasb_zd,
       Paths => (0 => (asbi_ipd'last_event, (tpd_asbi_frasb), TRUE)),
       GlitchData => frasb_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbo,
       OutSignalName => "asbo",
       OutTemp => asbo_zd,
       Paths => (0 => (toasb_ipd'last_event, (tpd_toasb_asbo), TRUE)),
       GlitchData => asbo_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbm1o,
       OutSignalName => "asbm1o",
       OutTemp => asbm1o_zd,
       Paths => (0 => (toasbm1_ipd'last_event, (tpd_toasbm1_asbm1o), TRUE)),
       GlitchData => asbm1o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbm2o,
       OutSignalName => "asbm2o",
       OutTemp => asbm2o_zd,
       Paths => (0 => (toasbm2_ipd'last_event, (tpd_toasbm2_asbm2o), TRUE)),
       GlitchData => asbm2o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbm3o,
       OutSignalName => "asbm3o",
       OutTemp => asbm3o_zd,
       Paths => (0 => (toasbm3_ipd'last_event, (tpd_toasbm3_asbm3o), TRUE)),
       GlitchData => asbm3o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
--
----- cell intrbufs -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
 
-- entity declaration --
ENTITY intrbufs IS
   GENERIC(
      TimingChecksOn         : boolean := FALSE;
      XOn                    : boolean := FALSE;
      MsgOn                  : boolean := FALSE;
      InstancePath           : string := "intrbufs";
      tpd_asbi_frasb         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasb_asbo         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasbm1_asbm1o     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasbm2_asbm2o     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_toasbm3_asbm3o     :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_asbi              :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasb             :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasbm1           :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasbm2           :  VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_toasbm3           :  VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      asbi                :     IN   std_logic;
      toasb               :     IN   std_logic;
      toasbm1             :     IN   std_logic;
      toasbm2             :     IN   std_logic;
      toasbm3             :     IN   std_logic;
      frasb               :     OUT  std_logic;
      asbo                :     OUT  std_logic;
      asbm1o              :     OUT  std_logic;
      asbm2o              :     OUT  std_logic;
      asbm3o              :     OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF intrbufs : ENTITY IS TRUE;
 
END intrbufs;
 
-- architecture body --
ARCHITECTURE v OF intrbufs IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL asbi_ipd       : std_logic := 'X';
   SIGNAL toasb_ipd      : std_logic := 'X';
   SIGNAL toasbm1_ipd    : std_logic := 'X';
   SIGNAL toasbm2_ipd    : std_logic := 'X';
   SIGNAL toasbm3_ipd    : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (asbi_ipd, asbi, tipd_asbi);
   VitalWireDelay (toasb_ipd, toasb, tipd_toasb);
   VitalWireDelay (toasbm1_ipd, toasbm1, tipd_toasbm1);
   VitalWireDelay (toasbm2_ipd, toasbm2, tipd_toasbm2);
   VitalWireDelay (toasbm3_ipd, toasbm3, tipd_toasbm3);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (asbi_ipd, toasb_ipd, toasbm1_ipd, toasbm2_ipd, toasbm3_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 5) := (others => 'X');
   ALIAS frasb_zd   : std_ulogic IS results(1);
   ALIAS asbo_zd    : std_ulogic IS results(2);
   ALIAS asbm1o_zd  : std_ulogic IS results(3);
   ALIAS asbm2o_zd  : std_ulogic IS results(4);
   ALIAS asbm3o_zd  : std_ulogic IS results(5);
 
   -- output glitch detection VARIABLEs
   VARIABLE frasb_GlitchData    : VitalGlitchDataType;
   VARIABLE asbo_GlitchData     : VitalGlitchDataType;
   VARIABLE asbm1o_GlitchData   : VitalGlitchDataType;
   VARIABLE asbm2o_GlitchData   : VitalGlitchDataType;
   VARIABLE asbm3o_GlitchData   : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      frasb_zd  := VitalBUF(asbi_ipd);
      asbo_zd   := VitalBUF(toasb_ipd);
      asbm1o_zd := VitalBUF(toasbm1_ipd);
      asbm2o_zd := VitalBUF(toasbm2_ipd);
      asbm3o_zd := VitalBUF(toasbm3_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => frasb,
       OutSignalName => "frasb",
       OutTemp => frasb_zd,
       Paths => (0 => (asbi_ipd'last_event, (tpd_asbi_frasb), TRUE)),
       GlitchData => frasb_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbo,
       OutSignalName => "asbo",
       OutTemp => asbo_zd,
       Paths => (0 => (toasb_ipd'last_event, (tpd_toasb_asbo), TRUE)),
       GlitchData => asbo_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbm1o,
       OutSignalName => "asbm1o",
       OutTemp => asbm1o_zd,
       Paths => (0 => (toasbm1_ipd'last_event, (tpd_toasbm1_asbm1o), TRUE)),
       GlitchData => asbm1o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbm2o,
       OutSignalName => "asbm2o",
       OutTemp => asbm2o_zd,
       Paths => (0 => (toasbm2_ipd'last_event, (tpd_toasbm2_asbm2o), TRUE)),
       GlitchData => asbm2o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => asbm3o,
       OutSignalName => "asbm3o",
       OutTemp => asbm3o_zd,
       Paths => (0 => (toasbm3_ipd'last_event, (tpd_toasbm3_asbm3o), TRUE)),
       GlitchData => asbm3o_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- cell toasbck -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
 
-- entity declaration --
ENTITY toasbck IS
   GENERIC(
      TimingChecksOn        : boolean := FALSE;
      XOn                   : boolean := FALSE;
      MsgOn                 : boolean := FALSE;
      InstancePath          : string := "toasbck";
      tpd_cktoasb_asbcko    :   VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_cktoasb          :   VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      cktoasb              :    IN   std_logic;
      asbcko               :    OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF toasbck : ENTITY IS TRUE;
 
END toasbck;
 
-- architecture body --
ARCHITECTURE v OF toasbck IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL cktoasb_ipd    : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (cktoasb_ipd, cktoasb, tipd_cktoasb);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (cktoasb_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS asbcko_zd  : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE asbcko_GlitchData   : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      asbcko_zd := VitalBUF(cktoasb_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => asbcko,
       OutSignalName => "asbcko",
       OutTemp => asbcko_zd,
       Paths => (0 => (cktoasb_ipd'last_event, (tpd_cktoasb_asbcko), TRUE)),
       GlitchData => asbcko_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 
--
----- cell frasbck -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
 
-- entity declaration --
ENTITY frasbck IS
   GENERIC(
      TimingChecksOn       : boolean := FALSE;
      XOn                  : boolean := FALSE;
      MsgOn                : boolean := FALSE;
      InstancePath         : string := "frasbck";
      tpd_asbcki_ckfrasb   :    VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_asbcki          :    VitalDelayType01 := (0.0 ns, 0.0 ns));
 
   PORT(
      asbcki                :   IN   std_logic;
      ckfrasb               :   OUT  std_logic);
 
    ATTRIBUTE Vital_Level0 OF frasbck : ENTITY IS TRUE;
 
END frasbck;
 
-- architecture body --
ARCHITECTURE v OF frasbck IS
   ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL asbcki_ipd     : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (asbcki_ipd, asbcki, tipd_asbcki);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (asbcki_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS ckfrasb_zd : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE ckfrasb_GlitchData  : VitalGlitchDataType;
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      ckfrasb_zd := VitalBUF(asbcki_ipd);
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => ckfrasb,
       OutSignalName => "ckfrasb",
       OutTemp => ckfrasb_zd,
       Paths => (0 => (asbcki_ipd'last_event, (tpd_asbcki_ckfrasb), TRUE)),
       GlitchData => ckfrasb_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 
 


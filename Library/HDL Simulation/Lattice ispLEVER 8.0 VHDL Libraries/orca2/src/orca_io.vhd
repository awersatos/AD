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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca2/src/RCS/ORCA_IO.vhd,v 1.5 2005/05/19 20:04:10 pradeep Exp $ 
--

--
----- CELL TSALL -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;
 
 
-- entity declaration --
entity TSALL is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "TSALL");
 
   port(
      TSALL             : in STD_LOGIC := 'Z');

end TSALL;
 
-- architecture body --
architecture V of TSALL is
 
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
   TSALLNET <= TSALL;
 
end V;


--
----- CELL BMS6 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMS6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS6";
      tpd_I_B         :  VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :  VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :  VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :  inout STD_LOGIC;
      I               :  in    STD_LOGIC;
      T               :  in    STD_LOGIC;
      O               :  out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMS6 : entity is TRUE;
 
end BMS6;

-- architecture body --
architecture V of BMS6 is
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
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BMS12 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMS12 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS12";
      tpd_I_B         :  VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :  VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :  VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :  inout STD_LOGIC;
      I               :  in    STD_LOGIC;
      T               :  in    STD_LOGIC;
      O               :  out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMS12 : entity is TRUE;
 
end BMS12;

-- architecture body --
architecture V of BMS12 is
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
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BMS12F -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMS12F is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS12F";
      tpd_I_B         :  VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :  VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :  VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :  inout STD_LOGIC;
      I               :  in    STD_LOGIC;
      T               :  in    STD_LOGIC;
      O               :  out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMS12F : entity is TRUE;
 
end BMS12F;

-- architecture body --
architecture V of BMS12F is
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
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS6PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
 
 
 
 
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
 
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS6PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS12FPD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS12FPU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMS12PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath: String := "BMS12PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS6PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
 
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS6PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS12FPD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
 
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS12FPU";
 
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS12PD";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
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
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS12PU";
      tpd_I_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         : VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns));
 
 
 
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
----- CELL BMZ6 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ6";
      tpd_I_B         :  VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :  VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :  VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :  VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :  inout STD_LOGIC;
      I               :  in    STD_LOGIC;
      T               :  in    STD_LOGIC;
      O               :  out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ6 : entity is TRUE;
 
end BMZ6;

-- architecture body --
architecture V of BMZ6 is
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
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BMZ6PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ6PD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ6PD";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ6PD : entity is TRUE;
 
end BMZ6PD;

-- architecture body --
architecture V of BMZ6PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BMZ6PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ6PU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ6PU";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ6PU : entity is TRUE;
 
end BMZ6PU;

-- architecture body --
architecture V of BMZ6PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BMZ12 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ12 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ12";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ12 : entity is TRUE;
 
end BMZ12;

-- architecture body --
architecture V of BMZ12 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BMZ12F -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ12F is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ12F";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ12F : entity is TRUE;
 
end BMZ12F;

-- architecture body --
architecture V of BMZ12F is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BMZ12FPD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ12FPD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ12FPD";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ12FPD : entity is TRUE;
 
end BMZ12FPD;

-- architecture body --
architecture V of BMZ12FPD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BMZ12FPU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ12FPU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ12FPU";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ12FPU : entity is TRUE;
 
end BMZ12FPU;

-- architecture body --
architecture V of BMZ12FPU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BMZ12PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ12PD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BMZ12PD";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ12PD : entity is TRUE;
 
end BMZ12PD;

-- architecture body --
architecture V of BMZ12PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BMZ12PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BMZ12PU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath: String := "BMZ12PU";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BMZ12PU : entity is TRUE;
 
end BMZ12PU;

-- architecture body --
architecture V of BMZ12PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BPAD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity BPAD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BPAD";
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC := 'Z');

    attribute VITAL_LEVEL0 of BPAD : entity is TRUE;
 
end BPAD;

-- architecture body --
architecture V of BPAD is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal B_ipd  : STD_LOGIC := 'X';
begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(B_ipd, B, tipd_B);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (B_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS B_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   -- VARIABLE B_GlitchData     : VitalGlitchDataType;

   begin

   IF (TimingChecksOn) THEN
   END IF;

   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   B_zd := B_ipd;

   -----------------------------------
   -- Path Delay Section.
   -----------------------------------

   end process;

end V;


--
----- CELL BTS6 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTS6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS6";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTS6 : entity is TRUE;
 
end BTS6;

-- architecture body --
architecture V of BTS6 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BTS12 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTS12 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS12";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTS12 : entity is TRUE;
 
end BTS12;

-- architecture body --
architecture V of BTS12 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BTS12F -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTS12F is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTS12F";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTS12F : entity is TRUE;
 
end BTS12F;

-- architecture body --
architecture V of BTS12F is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BTZ6 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ6";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ6 : entity is TRUE;
 
end BTZ6;

-- architecture body --
architecture V of BTZ6 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BTZ6PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ6PD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ6PD";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ6PD : entity is TRUE;
 
end BTZ6PD;

-- architecture body --
architecture V of BTZ6PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BTZ6PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ6PU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ6PU";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ6PU : entity is TRUE;
 
end BTZ6PU;

-- architecture body --
architecture V of BTZ6PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BTZ12 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ12 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath: String := "BTZ12";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ12 : entity is TRUE;
 
end BTZ12;

-- architecture body --
architecture V of BTZ12 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BTZ12F -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ12F is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ12F";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ12F : entity is TRUE;
 
end BTZ12F;

-- architecture body --
architecture V of BTZ12F is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 2) := (others => 'X');
   ALIAS B_zd       : STD_ULOGIC is Results(1);
   ALIAS O_zd       : STD_ULOGIC is Results(2);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      B_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);
      O_zd := VitalBUF(B_ipd);

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
----- CELL BTZ12FPD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ12FPD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ12FPD";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ12FPD : entity is TRUE;
 
end BTZ12FPD;

-- architecture body --
architecture V of BTZ12FPD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BTZ12FPU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ12FPU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ12FPU";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ12FPU : entity is TRUE;
 
end BTZ12FPU;

-- architecture body --
architecture V of BTZ12FPU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BTZ12PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ12PD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ12PD";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ12PD : entity is TRUE;
 
end BTZ12PD;

-- architecture body --
architecture V of BTZ12PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL BTZ12PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity BTZ12PU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "BTZ12PU";
      tpd_I_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_B         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_B_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_B          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      B               :	inout STD_LOGIC;
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of BTZ12PU : entity is TRUE;
 
end BTZ12PU;

-- architecture body --
architecture V of BTZ12PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL B_ipd	 : STD_LOGIC := 'X';
   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

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
   VARIABLE B_GlitchData	: VitalGlitchDataType;
   VARIABLE O_GlitchData	: VitalGlitchDataType;

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
----- CELL IBM -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBM is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBM";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBM : entity is TRUE;
 
end IBM;

-- architecture body --
architecture V of IBM is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      O_zd := VitalBUF(I_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBMPD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBMPD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBMPD";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBMPD : entity is TRUE;
 
end IBMPD;

-- architecture body --
architecture V of IBMPD is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBMPDS -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBMPDS is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBMPDS";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBMPDS : entity is TRUE;
 
end IBMPDS;

-- architecture body --
architecture V of IBMPDS is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBMPU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBMPU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBMPU";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBMPU : entity is TRUE;
 
end IBMPU;

-- architecture body --
architecture V of IBMPU is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBMPUS -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBMPUS is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBMPUS";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBMPUS : entity is TRUE;
 
end IBMPUS;

-- architecture body --
architecture V of IBMPUS is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBMS -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBMS is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBMS";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBMS : entity is TRUE;
 
end IBMS;

-- architecture body --
architecture V of IBMS is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      O_zd := VitalBUF(I_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBT -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBT is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBT";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBT : entity is TRUE;
 
end IBT;

-- architecture body --
architecture V of IBT is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      O_zd := VitalBUF(I_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBTPD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBTPD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBTPD";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBTPD : entity is TRUE;
 
end IBTPD;

-- architecture body --
architecture V of IBTPD is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBTPDS -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBTPDS is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBTPDS";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBTPDS : entity is TRUE;
 
end IBTPDS;

-- architecture body --
architecture V of IBTPDS is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','L'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBTPU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBTPU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBTPU";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBTPU : entity is TRUE;
 
end IBTPU;

-- architecture body --
architecture V of IBTPU is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBTPUS -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBTPUS is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBTPUS";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBTPUS : entity is TRUE;
 
end IBTPUS;

-- architecture body --
architecture V of IBTPUS is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE I_ipd2 : STD_ULOGIC := 'X';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      I_ipd2 := VitalIdent (data => I_ipd,
                           ResultMap => ('U','X','0','1','H'));
      O_zd := VitalBUF(I_ipd2);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL IBTS -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity IBTS is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "IBTS";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of IBTS : entity is TRUE;
 
end IBTS;

-- architecture body --
architecture V of IBTS is
   attribute VITAL_LEVEL1 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      O_zd := VitalBUF(I_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, (tpd_I_O), TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;




--
----- CELL OB6 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OB6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OB6";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OB6 : entity is TRUE;
 
end OB6;

-- architecture body --
architecture V of OB6 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);
   VARIABLE tpd_TSALL_O : VitalDelayType01 := (0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      O_zd := VitalBUFIF1 (data => I_ipd, enable => TSALLNET);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (TSALLNET'last_event, tpd_TSALL_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OB12 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OB12 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OB12";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OB12 : entity is TRUE;
 
end OB12;

-- architecture body --
architecture V of OB12 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);
   VARIABLE tpd_TSALL_O : VitalDelayType01 := (0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      O_zd := VitalBUFIF1 (data => I_ipd, enable => TSALLNET);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (TSALLNET'last_event, tpd_TSALL_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OB12F -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OB12F is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OB12F";
      tpd_I_O         :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OB12F : entity is TRUE;
 
end OB12F;

-- architecture body --
architecture V of OB12F is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);
   VARIABLE tpd_TSALL_O : VitalDelayType01 := (0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      O_zd := VitalBUFIF1 (data => I_ipd, enable => TSALLNET);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (TSALLNET'last_event, tpd_TSALL_O, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ6 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ6 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ6";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ6 : entity is TRUE;
 
end OBZ6;

-- architecture body --
architecture V of OBZ6 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ6PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ6PD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ6PD";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ6PD : entity is TRUE;
 
end OBZ6PD;

-- architecture body --
architecture V of OBZ6PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ6PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ6PU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ6PU";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ6PU : entity is TRUE;
 
end OBZ6PU;

-- architecture body --
architecture V of OBZ6PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ12 -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ12 is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ12";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ12 : entity is TRUE;
 
end OBZ12;

-- architecture body --
architecture V of OBZ12 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ12F -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ12F is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ12F";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ12F : entity is TRUE;
 
end OBZ12F;

-- architecture body --
architecture V of OBZ12F is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ12FPD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ12FPD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ12FPD";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ12FPD : entity is TRUE;
 
end OBZ12FPD;

-- architecture body --
architecture V of OBZ12FPD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ12FPU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ12FPU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ12FPU";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ12FPU : entity is TRUE;
 
end OBZ12FPU;

-- architecture body --
architecture V of OBZ12FPU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ12PD -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ12PD is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ12PD";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ12PD : entity is TRUE;
 
end OBZ12PD;

-- architecture body --
architecture V of OBZ12PD is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','L'));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;


--
----- CELL OBZ12PU -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
use WORK.GLOBAL.TSALLNET;


-- entity declaration --
entity OBZ12PU is
   generic(
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;
      MsgOn           : Boolean := FALSE;
      InstancePath    : String := "OBZ12PU";
      tpd_I_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :	VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I          :	VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_T          :	VitalDelayType01 := (0.1 ns, 0.1 ns));

   port(
      I               :	in    STD_LOGIC;
      T               :	in    STD_LOGIC;
      O               :	out   STD_LOGIC);

    attribute VITAL_LEVEL0 of OBZ12PU : entity is TRUE;
 
end OBZ12PU;

-- architecture body --
architecture V of OBZ12PU is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL I_ipd	 : STD_LOGIC := 'X';
   SIGNAL T_ipd	 : STD_LOGIC := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (I_ipd, I, tipd_I);
   VitalWireDelay (T_ipd, T, tipd_T);
   end block;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd, TSALLNET)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd       : STD_ULOGIC is Results(1);
   VARIABLE Tri     : STD_LOGIC := 'X';
   VARIABLE tpd_TSALL_B : VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);

   -- output glitch detection variables
   VARIABLE O_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Tri := VitalOR2 (a => NOT(TSALLNET), b => T_ipd);
      O_zd := VitalBUFIF0 (data => I_ipd, enable => Tri,
                         ResultMap => ('U','X','0','1','H'));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => O,
       OutSignalName => "O",
       OutTemp => O_zd,
       Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
                 1 => (T_ipd'last_event, tpd_T_O, TRUE),
                 2 => (TSALLNET'last_event, tpd_TSALL_B, TRUE)),
       GlitchData => O_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

end process;

end V;



--
----- CELL TBUF -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_Primitives.all;


-- entity declaration --
entity TBUF is
   generic (
      TimingChecksOn  : Boolean := TRUE;
      XOn             : Boolean := FALSE;        
      MsgOn           : Boolean := FALSE;
      InstancePath    : String  := "TBUF";
      tpd_I_O         :  VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :  VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_T          : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_I 	      : VitalDelayType01 := (0.1 ns, 0.1 ns)) ;

   port(
      T		      : in std_logic;
      I 	      : in std_logic;
      O  	      : out std_logic);

    attribute VITAL_LEVEL0 of TBUF : entity is TRUE;
 
end TBUF ;

-- architecture body --
architecture V of TBUF is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal T_ipd  : std_logic := 'X';
    signal I_ipd  : std_logic := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(T_ipd, T, tipd_T);
   VitalWireDelay(I_ipd, I, tipd_I);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (T_ipd, I_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData : VitalGlitchDataType;

   begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_zd := VitalBUFIF0 (enable => T_ipd, data => I_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01Z (
     OutSignal => O,
     OutSignalName => "O",
     OutTemp => O_zd,
     Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
               1 => (T_ipd'last_event, tpd_T_O, TRUE)),
     GlitchData => O_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

end process;

end V;


--
----- CELL TIBUF -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.VITAL_timing.all;
use IEEE.VITAL_Primitives.all;

-- entity declaration --
entity TIBUF is
   generic (
      TimingChecksOn  : Boolean := FALSE;
      XOn             : Boolean := FALSE;        
      MsgOn           : Boolean := FALSE;
      InstancePath    : String  := "TIBUF";
      tpd_I_O         :  VitalDelayType01Z := 
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tpd_T_O         :  VitalDelayType01Z :=
               (0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns, 0.1 ns);
      tipd_I 	      : VitalDelayType01 := (0.1 ns, 0.1 ns) ;
      tipd_T	      : VitalDelayType01 := (0.1 ns, 0.1 ns)) ;

   port(
      T		      : in std_logic;
      I 	      : in std_logic;
      O 	      : out std_logic);

    attribute VITAL_LEVEL0 of TIBUF : entity is TRUE;
 
end TIBUF ;

-- architecture body --
architecture V of TIBUF is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;

    signal I_ipd  : std_logic := 'X';
    signal T_ipd  : std_logic := 'X';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay(I_ipd, I, tipd_I);
   VitalWireDelay(T_ipd, T, tipd_T);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (I_ipd, T_ipd)

   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS O_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE O_GlitchData        : VitalGlitchDataType;

   begin

    IF (TimingChecksOn) THEN
    END IF;

    -----------------------------------
    -- Functionality Section.
    -----------------------------------
    O_zd := VitalBUFIF1 (data => I_ipd, enable => T_ipd);

    -----------------------------------
    -- Path Delay Section.
    -----------------------------------
    VitalPathDelay01Z (
     OutSignal => O,
     OutSignalName => "O",
     OutTemp => O_zd,
     Paths => (0 => (I_ipd'last_event, tpd_I_O, TRUE),
               1 => (T_ipd'last_event, tpd_T_O, TRUE)),
     GlitchData => O_GlitchData,
     Mode => OnDetect,
     XOn => XOn,
     MsgOn => MsgOn);

end process;

end V;



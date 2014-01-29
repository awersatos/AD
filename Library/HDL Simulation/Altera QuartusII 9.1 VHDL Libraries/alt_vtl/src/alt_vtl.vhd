 ----------------------------------------------------------------
-- 
-- Copyright (c) 1995 by Altera Corporation.  All rights reserved. 
--                                                                 
-- FILENAME     :    alt_vtl.vhd (3.0)
-- DATE CREATED :    Mon Jul 24 15:54:24 1995
-- 
-- LIBRARY      :    alt_vtl
-- REVISION     :    1.0.2
-- LOGIC SYSTEM :    IEEE-1164
--
----------------------------------------------------------------
-- Changes in Revision 1.0.2
--   1. Changed setup and hold time checking for D in DFF,
--      DFF0, and DFF1.
--
----------------------------------------------------------------
-- Changes in Revision 1.0.1
--   1. DefGlitchMsgOn defaults to TRUE.
--   2. Timing check for D in DFFE, DFFE0, and DFFE1 is
--      disabled if ENA_ipd signal is inactive.
-- 
----------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

package SUPPORT is
-- default generic values
   CONSTANT DefWireDelay	: VitalDelayType01	:= (0 ns, 0 ns);
   CONSTANT DefPropDelay01	: VitalDelayType01	:= (0 ns, 0 ns);
   CONSTANT DefPropDelay01Z	: VitalDelayType01Z	:= (OTHERS => 0 ns);
   CONSTANT DefSetupHoldCnst	: TIME := 0 ns;
   CONSTANT DefPulseWdthCnst	: TIME := 0 ns;
-- default control options
   CONSTANT DefGlitchMode	: VitalGlitchKindType	:= OnEvent;
   CONSTANT DefGlitchMsgOn	: BOOLEAN	:= TRUE;
   CONSTANT DefGlitchXOn	: BOOLEAN	:= FALSE;
   CONSTANT DefTimingMsgOn	: BOOLEAN	:= TRUE;
   CONSTANT DefTimingXOn	: BOOLEAN	:= TRUE;
-- output strength mapping
						--  UX01ZWHL-
   CONSTANT PullUp	: VitalOutputMapType	:= "UX01HX01X";
   CONSTANT NoPullUpZ	: VitalOutputMapType	:= "UX01ZX01X";
   CONSTANT PullDown	: VitalOutputMapType	:= "UX01LX01X";
-- primitive result strength mapping
   CONSTANT wiredOR	: VitalResultMapType	:= ( 'U', 'X', 'L', '1' );
   CONSTANT wiredAND	: VitalResultMapType	:= ( 'U', 'X', '0', 'H' );
   CONSTANT L : VitalTableSymbolType := '0';
   CONSTANT H : VitalTableSymbolType := '1';
   CONSTANT x : VitalTableSymbolType := '-';
   CONSTANT S : VitalTableSymbolType := 'S';
   CONSTANT R : VitalTableSymbolType := '/';
   CONSTANT U : VitalTableSymbolType := 'X';
   CONSTANT V : VitalTableSymbolType := 'B'; -- valid clock signal (non-rising)
end SUPPORT;


----- CELL AND1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;

library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND1 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      MsgOn: Boolean := DefGlitchMsgOn;
      XOn: Boolean := DefGlitchXOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND1 : entity is TRUE;
end AND1;

-- architecture body --

architecture AltVITAL of AND1 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := TO_X01(IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND1_VITAL of AND1 is
   for AltVITAL
   end for;
end CFG_AND1_VITAL;


----- CELL AND2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND2 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      MsgOn: Boolean := DefGlitchMsgOn;
      XOn: Boolean := DefGlitchXOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND2 : entity is TRUE;
end AND2;

-- architecture body --
architecture AltVITAL of AND2 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (IN2_ipd) AND (IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND2_VITAL of AND2 is
   for AltVITAL
   end for;
end CFG_AND2_VITAL;


----- CELL AND3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND3 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      MsgOn: Boolean := DefGlitchMsgOn;
      XOn: Boolean := DefGlitchXOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND3 : entity is TRUE;
end AND3;

-- architecture body --

architecture AltVITAL of AND3 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND3_VITAL of AND3 is
   for AltVITAL
   end for;
end CFG_AND3_VITAL;


----- CELL AND4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND4 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND4 : entity is TRUE;
end AND4;

-- architecture body --

architecture AltVITAL of AND4 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND4_VITAL of AND4 is
   for AltVITAL
   end for;
end CFG_AND4_VITAL;


----- CELL AND5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND5 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND5 : entity is TRUE;
end AND5;

-- architecture body --

architecture AltVITAL of AND5 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND5_VITAL of AND5 is
   for AltVITAL
   end for;
end CFG_AND5_VITAL;


----- CELL AND6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND6 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND6 : entity is TRUE;
end AND6;

-- architecture body --

architecture AltVITAL of AND6 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND6_VITAL of AND6 is
   for AltVITAL
   end for;
end CFG_AND6_VITAL;


----- CELL AND7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND7 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND7 : entity is TRUE;
end AND7;

-- architecture body --

architecture AltVITAL of AND7 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND7_VITAL of AND7 is
   for AltVITAL
   end for;
end CFG_AND7_VITAL;


----- CELL AND8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND8 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean :=  DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND8 : entity is TRUE;
end AND8;

-- architecture body --

architecture AltVITAL of AND8 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND8_VITAL of AND8 is
   for AltVITAL
   end for;
end CFG_AND8_VITAL;


----- CELL AND9 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND9 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND9 : entity is TRUE;
end AND9;

-- architecture body --

architecture AltVITAL of AND9 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND9_VITAL of AND9 is
   for AltVITAL
   end for;
end CFG_AND9_VITAL;


----- CELL AND10 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND10 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND10 : entity is TRUE;
end AND10;

-- architecture body --

architecture AltVITAL of AND10 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd) AND (IN10_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND10_VITAL of AND10 is
   for AltVITAL
   end for;
end CFG_AND10_VITAL;


----- CELL AND11 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND11 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND11 : entity is TRUE;
end AND11;

-- architecture body --

architecture AltVITAL of AND11 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd) AND (IN10_ipd)
         AND (IN11_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND11_VITAL of AND11 is
   for AltVITAL
   end for;
end CFG_AND11_VITAL;


----- CELL AND12 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND12 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND12 : entity is TRUE;
end AND12;

-- architecture body --

architecture AltVITAL of AND12 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd) AND (IN10_ipd)
         AND (IN11_ipd) AND (IN12_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND12_VITAL of AND12 is
   for AltVITAL
   end for;
end CFG_AND12_VITAL;


----- CELL AND13 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND13 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND13 : entity is TRUE;
end AND13;

-- architecture body --

architecture AltVITAL of AND13 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd) AND (IN10_ipd)
         AND (IN11_ipd) AND (IN12_ipd) AND (IN13_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND13_VITAL of AND13 is
   for AltVITAL
   end for;
end CFG_AND13_VITAL;


----- CELL AND14 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND14 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN14_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN14                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC;
      IN14                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND14 : entity is TRUE;
end AND14;

-- architecture body --

architecture AltVITAL of AND14 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN14_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   VitalWireDelay (IN14_ipd, IN14, tipd_IN14);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd, IN14_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd) AND (IN10_ipd)
         AND (IN11_ipd) AND (IN12_ipd) AND (IN13_ipd) AND (IN14_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE),
                 13 => (IN14_ipd'last_event, tpd_IN14_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND14_VITAL of AND14 is
   for AltVITAL
   end for;
end CFG_AND14_VITAL;


----- CELL AND15 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND15 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN14_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN15_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN14                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN15                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC;
      IN14                           :	in    STD_LOGIC;
      IN15                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND15 : entity is TRUE;
end AND15;

-- architecture body --

architecture AltVITAL of AND15 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN14_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN15_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   VitalWireDelay (IN14_ipd, IN14, tipd_IN14);
   VitalWireDelay (IN15_ipd, IN15, tipd_IN15);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd, IN14_ipd, IN15_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd) AND (IN10_ipd)
         AND (IN11_ipd) AND (IN12_ipd) AND (IN13_ipd) AND (IN14_ipd) AND
         (IN15_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE),
                 13 => (IN14_ipd'last_event, tpd_IN14_Y, TRUE),
                 14 => (IN15_ipd'last_event, tpd_IN15_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND15_VITAL of AND15 is
   for AltVITAL
   end for;
end CFG_AND15_VITAL;


----- CELL AND16 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity AND16 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN14_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN15_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN16_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN14                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN15                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN16                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC;
      IN14                           :	in    STD_LOGIC;
      IN15                           :	in    STD_LOGIC;
      IN16                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of AND16 : entity is TRUE;
end AND16;

-- architecture body --

architecture AltVITAL of AND16 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN14_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN15_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN16_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   VitalWireDelay (IN14_ipd, IN14, tipd_IN14);
   VitalWireDelay (IN15_ipd, IN15, tipd_IN15);
   VitalWireDelay (IN16_ipd, IN16, tipd_IN16);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd, IN14_ipd, IN15_ipd, IN16_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) AND (IN1_ipd) AND (IN3_ipd) AND (IN4_ipd) AND (IN5_ipd) AND
         (IN6_ipd) AND (IN7_ipd) AND (IN8_ipd) AND (IN9_ipd) AND (IN10_ipd)
         AND (IN11_ipd) AND (IN12_ipd) AND (IN13_ipd) AND (IN14_ipd) AND
         (IN15_ipd) AND (IN16_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE),
                 13 => (IN14_ipd'last_event, tpd_IN14_Y, TRUE),
                 14 => (IN15_ipd'last_event, tpd_IN15_Y, TRUE),
                 15 => (IN16_ipd'last_event, tpd_IN16_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_AND16_VITAL of AND16 is
   for AltVITAL
   end for;
end CFG_AND16_VITAL;


----- CELL DELAY -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity DELAY is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of DELAY : entity is TRUE;
end DELAY;

-- architecture body --

architecture AltVITAL of DELAY is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := TO_X01(IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_DELAY_VITAL of DELAY is
   for AltVITAL
   end for;
end CFG_DELAY_VITAL;


----- CELL DFF -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity DFF is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_PRN_Q_negedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :	VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :	VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :	VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :	VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_CLRN                      :	VitalDelayType01 := DefPropDelay01;
      tipd_PRN                       :	VitalDelayType01 := DefPropDelay01;
      tipd_CLK                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '0';
      D                              :	in    STD_LOGIC;
      CLRN                           :	in    STD_LOGIC;
      PRN                            :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of DFF : entity is TRUE;
end DFF;

-- architecture body --

architecture AltVITAL of DFF is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL PRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLRN_ipd, CLRN, tipd_CLRN);
   VitalWireDelay (PRN_ipd, PRN, tipd_PRN);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLRN_ipd, PRN_ipd, CLK_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK	: STD_ULOGIC := '0';
   VARIABLE TimingData_D_CLK : VitalTimingDataType := VitalTimingDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(1 to 6) ;
   VARIABLE D_delayed : STD_ULOGIC := 'U';
   VARIABLE CLK_delayed : STD_ULOGIC := 'U';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => '0');

   -- output glitch detection variables
   VARIABLE Q_VitalGlitchData	: VitalGlitchDataType;

   CONSTANT DFF_Q_tab : VitalStateTableType := (
-- Violation, CLRN_ipd, CLK_delayed, D_delayed, PRN_ipd, CLK_ipd
    ( L, L,  x,  x,  x,  x,  x,  L ),
    ( L, H,  L,  H,  x,  H,  x,  H ),
    ( L, H,  H,  x,  H,  x,  x,  S ),
    ( L, H,  x,  x,  L,  x,  x,  H ),
    ( L, H,  x,  x,  H,  L,  x,  S ),
    ( L, x,  L,  L,  H,  H,  x,  L ) );

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
		Violation	=> Tviol_D_CLK,
		TimingData	=> TimingData_D_CLK,
		TestSignal	=> D_ipd,
		TestSignalName	=> "D",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_D_CLK_noedge_posedge,
                SetupLow        => tsetup_D_CLK_noedge_posedge,
		HoldHigh	=> thold_D_CLK_noedge_posedge,
                HoldLow         => thold_D_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFF",
                XOn             => XOn,
		MsgOn		=> MsgOn );

      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK;
      VitalStateTable(
        StateTable => DFF_Q_tab,
        DataIn => (
               Violation, CLRN_ipd, CLK_delayed, D_delayed, PRN_ipd, CLK_ipd),
        Result => Results,
	NumStates => 1,
        PreviousDataIn => PrevData_Q);
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       OutSignalName => "Q",
       OutTemp => Results(1),
       Paths => (0 => (PRN_ipd'last_event, tpd_PRN_Q_negedge, TRUE),
                 1 => (CLRN_ipd'last_event, tpd_CLRN_Q_negedge, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q_posedge, TRUE)),
       GlitchData => Q_VitalGlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_DFF_VITAL of DFF is
   for AltVITAL
   end for;
end CFG_DFF_VITAL;


----- CELL DFF1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity DFF1 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_PRN_Q_negedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :	VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :	VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :	VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :	VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_CLRN                      :	VitalDelayType01 := DefPropDelay01;
      tipd_PRN                       :	VitalDelayType01 := DefPropDelay01;
      tipd_CLK                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '1';
      D                              :	in    STD_LOGIC;
      CLRN                           :	in    STD_LOGIC;
      PRN                            :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of DFF1 : entity is TRUE;
end DFF1;

-- architecture body --

architecture AltVITAL of DFF1 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL PRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLRN_ipd, CLRN, tipd_CLRN);
   VitalWireDelay (PRN_ipd, PRN, tipd_PRN);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLRN_ipd, PRN_ipd, CLK_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK	: STD_ULOGIC := '0';
   VARIABLE TimingData_D_CLK : VitalTimingDataType := VitalTimingDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(1 to 6) ;
   VARIABLE D_delayed : STD_ULOGIC := 'U';
   VARIABLE CLK_delayed : STD_ULOGIC := 'U';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => '1');

   -- output glitch detection variables
   VARIABLE Q_VitalGlitchData	: VitalGlitchDataType;

   CONSTANT DFF1_Q_tab : VitalStateTableType := (
-- Violation, CLRN_ipd, CLK_delayed, D_delayed, PRN_ipd, CLK_ipd
    ( L, L,  x,  x,  x,  x,  x,  L ),
    ( L, H,  L,  H,  x,  H,  x,  H ),
    ( L, H,  H,  x,  H,  x,  x,  S ),
    ( L, H,  x,  x,  L,  x,  x,  H ),
    ( L, H,  x,  x,  H,  L,  x,  S ),
    ( L, x,  L,  L,  H,  H,  x,  L ) );

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
		Violation	=> Tviol_D_CLK,
		TimingData	=> TimingData_D_CLK,
		TestSignal	=> D_ipd,
		TestSignalName	=> "D",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_D_CLK_noedge_posedge,
                SetupLow        => tsetup_D_CLK_noedge_posedge,
		HoldHigh	=> thold_D_CLK_noedge_posedge,
                HoldLow         => thold_D_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFF1",
       XOn  => XOn,
		MsgOn		=> MsgOn );

      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK;
      VitalStateTable(
        StateTable => DFF1_Q_tab,
        DataIn => (
               Violation, CLRN_ipd, CLK_delayed, D_delayed, PRN_ipd, CLK_ipd),
        Result => Results,
	NumStates => 1,
        PreviousDataIn => PrevData_Q);
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       OutSignalName => "Q",
       OutTemp => Results(1),
       Paths => (0 => (PRN_ipd'last_event, tpd_PRN_Q_negedge, TRUE),
                 1 => (CLRN_ipd'last_event, tpd_CLRN_Q_negedge, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q_posedge, TRUE)),
       GlitchData => Q_VitalGlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_DFF1_VITAL of DFF1 is
   for AltVITAL
   end for;
end CFG_DFF1_VITAL;


----- CELL DFF0 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity DFF0 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_PRN_Q_negedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :	VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :	VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :	VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :	VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_CLRN                      :	VitalDelayType01 := DefPropDelay01;
      tipd_PRN                       :	VitalDelayType01 := DefPropDelay01;
      tipd_CLK                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '0';
      D                              :	in    STD_LOGIC;
      CLRN                           :	in    STD_LOGIC;
      PRN                            :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of DFF0 : entity is TRUE;
end DFF0;

-- architecture body --

architecture AltVITAL of DFF0 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL PRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLRN_ipd, CLRN, tipd_CLRN);
   VitalWireDelay (PRN_ipd, PRN, tipd_PRN);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLRN_ipd, PRN_ipd, CLK_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK	: STD_ULOGIC := '0';
   VARIABLE TimingData_D_CLK : VitalTimingDataType := VitalTimingDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(1 to 6) ;
   VARIABLE D_delayed : STD_ULOGIC := 'U';
   VARIABLE CLK_delayed : STD_ULOGIC := 'U';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => '0');

   -- output glitch detection variables
   VARIABLE Q_VitalGlitchData	: VitalGlitchDataType;

   CONSTANT DFF0_Q_tab : VitalStateTableType := (
-- Violation, CLRN_ipd, CLK_delayed, D_delayed, PRN_ipd, CLK_ipd
    ( L, L,  x,  x,  x,  x,  x,  L ),
    ( L, H,  L,  H,  x,  H,  x,  H ),
    ( L, H,  H,  x,  H,  x,  x,  S ),
    ( L, H,  x,  x,  L,  x,  x,  H ),
    ( L, H,  x,  x,  H,  L,  x,  S ),
    ( L, x,  L,  L,  H,  H,  x,  L ) );

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
		Violation	=> Tviol_D_CLK,
		TimingData	=> TimingData_D_CLK,
		TestSignal	=> D_ipd,
		TestSignalName	=> "D",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_D_CLK_noedge_posedge,
                SetupLow        => tsetup_D_CLK_noedge_posedge,
		HoldHigh	=> thold_D_CLK_noedge_posedge,
                HoldLow         => thold_D_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFF0",
       XOn  => XOn,
		MsgOn		=> MsgOn );

      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK;
      VitalStateTable(
        StateTable => DFF0_Q_tab,
        DataIn => (
               Violation, CLRN_ipd, CLK_delayed, D_delayed, PRN_ipd, CLK_ipd),
        Result => Results,
	NumStates => 1,
        PreviousDataIn => PrevData_Q);
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       OutSignalName => "Q",
       OutTemp => Results(1),
       Paths => (0 => (PRN_ipd'last_event, tpd_PRN_Q_negedge, TRUE),
                 1 => (CLRN_ipd'last_event, tpd_CLRN_Q_negedge, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q_posedge, TRUE)),
       GlitchData => Q_VitalGlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_DFF0_VITAL of DFF0 is
   for AltVITAL
   end for;
end CFG_DFF0_VITAL;


----- CELL DFFE -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity DFFE is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_PRN_Q_negedge                      :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge                     :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge                      :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge                      :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_ENA_CLK_noedge_posedge  :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge     :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge     :   VitalDelayType := DefSetupHoldCnst;
      thold_ENA_CLK_noedge_posedge   :   VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_CLRN                      :	VitalDelayType01 := DefPropDelay01;
      tipd_PRN                       :	VitalDelayType01 := DefPropDelay01;
      tipd_CLK                       :	VitalDelayType01 := DefPropDelay01;
      tipd_ENA                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '0';
      D                              :	in    STD_LOGIC;
      CLRN                           :	in    STD_LOGIC;
      PRN                            :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      ENA                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of DFFE : entity is TRUE;
end DFFE;

-- architecture body --

architecture AltVITAL of DFFE is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL PRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'U';
   SIGNAL ENA_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLRN_ipd, CLRN, tipd_CLRN);
   VitalWireDelay (PRN_ipd, PRN, tipd_PRN);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (ENA_ipd, ENA, tipd_ENA);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLRN_ipd, PRN_ipd, CLK_ipd, ENA_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK	: STD_ULOGIC := '0';
   VARIABLE Tviol_ENA_CLK	: STD_ULOGIC := '0';
   VARIABLE TimingData_D_CLK : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE TimingData_ENA_CLK : VitalTimingDataType := VitalTimingDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(1 to 8) ;
   VARIABLE D_delayed : STD_ULOGIC := 'U';
   VARIABLE CLK_delayed : STD_ULOGIC := 'U';
   VARIABLE ENA_delayed : STD_ULOGIC := 'U';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => '0');

   -- output glitch detection variables
   VARIABLE Q_VitalGlitchData	: VitalGlitchDataType;


   CONSTANT DFFE_Q_tab : VitalStateTableType := (
    ( L,  L,  x,  x,  x,  x,  x,  x,  x,  L ),
    ( L,  H,  L,  H,  H,  x,  x,  H,  x,  H ),
    ( L,  H,  L,  H,  x,  L,  x,  H,  x,  H ),
    ( L,  H,  L,  x,  H,  H,  x,  H,  x,  H ),
    ( L,  H,  H,  x,  x,  x,  H,  x,  x,  S ),
    ( L,  H,  x,  x,  x,  x,  L,  x,  x,  H ),
    ( L,  H,  x,  x,  x,  x,  H,  L,  x,  S ),
    ( L,  x,  L,  L,  L,  x,  H,  H,  x,  L ),
    ( L,  x,  L,  L,  x,  L,  H,  H,  x,  L ),
    ( L,  x,  L,  x,  L,  H,  H,  H,  x,  L ));
   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
		Violation	=> Tviol_D_CLK,
		TimingData	=> TimingData_D_CLK,
		TestSignal	=> D_ipd,
		TestSignalName	=> "D",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_D_CLK_noedge_posedge,
		SetupLow	=> tsetup_D_CLK_noedge_posedge,
		HoldHigh	=> thold_D_CLK_noedge_posedge,
		HoldLow		=> thold_D_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01((NOT PRN_ipd) OR (NOT CLRN_ipd) OR (NOT ENA_ipd) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFFE",
		XOn		=> XOn,
		MsgOn		=> MsgOn );  
  
         VitalSetupHoldCheck (
		Violation	=> Tviol_ENA_CLK,
		TimingData	=> TimingData_ENA_CLK,
		TestSignal	=> ENA_ipd,
		TestSignalName	=> "ENA",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_ENA_CLK_noedge_posedge,
		SetupLow	=> tsetup_ENA_CLK_noedge_posedge,
		HoldHigh	=> thold_ENA_CLK_noedge_posedge,
		HoldLow		=> thold_ENA_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFFE",
		XOn		=> XOn,
		MsgOn		=> MSgOn );  
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK or Tviol_ENA_CLK;
      VitalStateTable(
        StateTable => DFFE_Q_tab,
        DataIn => (
		Violation, CLRN_ipd, CLK_delayed, Results(1), D_delayed, ENA_delayed, PRN_ipd, CLK_ipd),
        Result => Results,
	NumStates => 1,
        PreviousDataIn => PrevData_Q);
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;
      ENA_delayed := ENA_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       OutSignalName => "Q",
       OutTemp => Results(1),
       Paths => (0 => (PRN_ipd'last_event, tpd_PRN_Q_negedge, TRUE),
                 1 => (CLRN_ipd'last_event, tpd_CLRN_Q_negedge, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q_posedge, TRUE)),
       GlitchData => Q_VitalGlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_DFFE_VITAL of DFFE is
   for AltVITAL
   end for;
end CFG_DFFE_VITAL;


----- CELL DFFE1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity DFFE1 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_PRN_Q_negedge                      :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge                     :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge                      :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge                      :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_ENA_CLK_noedge_posedge  :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge     :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge     :   VitalDelayType := DefSetupHoldCnst;
      thold_ENA_CLK_noedge_posedge   :   VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_CLRN                      :	VitalDelayType01 := DefPropDelay01;
      tipd_PRN                       :	VitalDelayType01 := DefPropDelay01;
      tipd_CLK                       :	VitalDelayType01 := DefPropDelay01;
      tipd_ENA                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '1';
      D                              :	in    STD_LOGIC;
      CLRN                           :	in    STD_LOGIC;
      PRN                            :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      ENA                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of DFFE1 : entity is TRUE;
end DFFE1;

-- architecture body --

architecture AltVITAL of DFFE1 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL PRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'U';
   SIGNAL ENA_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLRN_ipd, CLRN, tipd_CLRN);
   VitalWireDelay (PRN_ipd, PRN, tipd_PRN);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (ENA_ipd, ENA, tipd_ENA);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLRN_ipd, PRN_ipd, CLK_ipd, ENA_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK	: STD_ULOGIC := '0';
   VARIABLE Tviol_ENA_CLK	: STD_ULOGIC := '0';
   VARIABLE TimingData_D_CLK : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE TimingData_ENA_CLK : VitalTimingDataType := VitalTimingDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(1 to 8) ;
   VARIABLE D_delayed : STD_ULOGIC := 'U';
   VARIABLE CLK_delayed : STD_ULOGIC := 'U';
   VARIABLE ENA_delayed : STD_ULOGIC := 'U';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => '1');

   -- output glitch detection variables
   VARIABLE Q_VitalGlitchData	: VitalGlitchDataType;


   CONSTANT DFFE1_Q_tab : VitalStateTableType := (
    ( L,  L,  x,  x,  x,  x,  x,  x,  x,  L ),
    ( L,  H,  L,  H,  H,  x,  x,  H,  x,  H ),
    ( L,  H,  L,  H,  x,  L,  x,  H,  x,  H ),
    ( L,  H,  L,  x,  H,  H,  x,  H,  x,  H ),
    ( L,  H,  H,  x,  x,  x,  H,  x,  x,  S ),
    ( L,  H,  x,  x,  x,  x,  L,  x,  x,  H ),
    ( L,  H,  x,  x,  x,  x,  H,  L,  x,  S ),
    ( L,  x,  L,  L,  L,  x,  H,  H,  x,  L ),
    ( L,  x,  L,  L,  x,  L,  H,  H,  x,  L ),
    ( L,  x,  L,  x,  L,  H,  H,  H,  x,  L ));
   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
		Violation	=> Tviol_D_CLK,
		TimingData	=> TimingData_D_CLK,
		TestSignal	=> D_ipd,
		TestSignalName	=> "D",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_D_CLK_noedge_posedge,
		SetupLow	=> tsetup_D_CLK_noedge_posedge,
		HoldHigh	=> thold_D_CLK_noedge_posedge,
		HoldLow		=> thold_D_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01((NOT PRN_ipd) OR (NOT CLRN_ipd) OR (NOT ENA_ipd) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFFE1",
		XOn		=> XOn,
		MsgOn		=> MsgOn );  
  
         VitalSetupHoldCheck (
		Violation	=> Tviol_ENA_CLK,
		TimingData	=> TimingData_ENA_CLK,
		TestSignal	=> ENA_ipd,
		TestSignalName	=> "ENA",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_ENA_CLK_noedge_posedge,
		SetupLow	=> tsetup_ENA_CLK_noedge_posedge,
		HoldHigh	=> thold_ENA_CLK_noedge_posedge,
		HoldLow		=> thold_ENA_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFFE1",
		XOn		=> XOn,
		MsgOn		=> MsgOn );  
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK or Tviol_ENA_CLK;
      VitalStateTable(
        StateTable => DFFE1_Q_tab,
        DataIn => (
		Violation, CLRN_ipd, CLK_delayed, Results(1), D_delayed, ENA_delayed, PRN_ipd, CLK_ipd),
        Result => Results,
	NumStates => 1,
        PreviousDataIn => PrevData_Q);
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;
      ENA_delayed := ENA_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       OutSignalName => "Q",
       OutTemp => Results(1),
       Paths => (0 => (PRN_ipd'last_event, tpd_PRN_Q_negedge, TRUE),
                 1 => (CLRN_ipd'last_event, tpd_CLRN_Q_negedge, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q_posedge, TRUE)),
       GlitchData => Q_VitalGlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_DFFE1_VITAL of DFFE1 is
   for AltVITAL
   end for;
end CFG_DFFE1_VITAL;


----- CELL DFFE0 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity DFFE0 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_PRN_Q_negedge                      :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge                     :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge                      :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge                      :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_ENA_CLK_noedge_posedge  :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge     :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge     :   VitalDelayType := DefSetupHoldCnst;
      thold_ENA_CLK_noedge_posedge   :   VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_CLRN                      :	VitalDelayType01 := DefPropDelay01;
      tipd_PRN                       :	VitalDelayType01 := DefPropDelay01;
      tipd_CLK                       :	VitalDelayType01 := DefPropDelay01;
      tipd_ENA                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '0';
      D                              :	in    STD_LOGIC;
      CLRN                           :	in    STD_LOGIC;
      PRN                            :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      ENA                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of DFFE0 : entity is TRUE;
end DFFE0;

-- architecture body --

architecture AltVITAL of DFFE0 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL PRN_ipd	 : STD_ULOGIC := 'U';
   SIGNAL CLK_ipd	 : STD_ULOGIC := 'U';
   SIGNAL ENA_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (CLRN_ipd, CLRN, tipd_CLRN);
   VitalWireDelay (PRN_ipd, PRN, tipd_PRN);
   VitalWireDelay (CLK_ipd, CLK, tipd_CLK);
   VitalWireDelay (ENA_ipd, ENA, tipd_ENA);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, CLRN_ipd, PRN_ipd, CLK_ipd, ENA_ipd)

   -- timing check results
   VARIABLE Tviol_D_CLK	: STD_ULOGIC := '0';
   VARIABLE Tviol_ENA_CLK	: STD_ULOGIC := '0';
   VARIABLE TimingData_D_CLK : VitalTimingDataType := VitalTimingDataInit;
   VARIABLE TimingData_ENA_CLK : VitalTimingDataType := VitalTimingDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(1 to 8) ;
   VARIABLE D_delayed : STD_ULOGIC := 'U';
   VARIABLE CLK_delayed : STD_ULOGIC := 'U';
   VARIABLE ENA_delayed : STD_ULOGIC := 'U';
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => '0');

   -- output glitch detection variables
   VARIABLE Q_VitalGlitchData	: VitalGlitchDataType;


   CONSTANT DFFE0_Q_tab : VitalStateTableType := (
    ( L,  L,  x,  x,  x,  x,  x,  x,  x,  L ),
    ( L,  H,  L,  H,  H,  x,  x,  H,  x,  H ),
    ( L,  H,  L,  H,  x,  L,  x,  H,  x,  H ),
    ( L,  H,  L,  x,  H,  H,  x,  H,  x,  H ),
    ( L,  H,  H,  x,  x,  x,  H,  x,  x,  S ),
    ( L,  H,  x,  x,  x,  x,  L,  x,  x,  H ),
    ( L,  H,  x,  x,  x,  x,  H,  L,  x,  S ),
    ( L,  x,  L,  L,  L,  x,  H,  H,  x,  L ),
    ( L,  x,  L,  L,  x,  L,  H,  H,  x,  L ),
    ( L,  x,  L,  x,  L,  H,  H,  H,  x,  L ));
   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
		Violation	=> Tviol_D_CLK,
		TimingData	=> TimingData_D_CLK,
		TestSignal	=> D_ipd,
		TestSignalName	=> "D",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_D_CLK_noedge_posedge,
		SetupLow	=> tsetup_D_CLK_noedge_posedge,
		HoldHigh	=> thold_D_CLK_noedge_posedge,
		HoldLow		=> thold_D_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01((NOT PRN_ipd) OR (NOT CLRN_ipd) OR (NOT ENA_ipd) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFFE0",
		XOn		=> XOn,
		MsgOn		=> MsgOn );  
  
         VitalSetupHoldCheck (
		Violation	=> Tviol_ENA_CLK,
		TimingData	=> TimingData_ENA_CLK,
		TestSignal	=> ENA_ipd,
		TestSignalName	=> "ENA",
		RefSignal	=> CLK_ipd,
		RefSignalName	=> "CLK",
		SetupHigh	=> tsetup_ENA_CLK_noedge_posedge,
		SetupLow	=> tsetup_ENA_CLK_noedge_posedge,
		HoldHigh	=> thold_ENA_CLK_noedge_posedge,
		HoldLow		=> thold_ENA_CLK_noedge_posedge,
		CheckEnabled	=> TO_X01(( (NOT PRN_ipd) ) OR ( (NOT CLRN_ipd) ) ) /= '1',
		RefTransition	=> '/',
		HeaderMsg	=> InstancePath & "/DFFE0",
		XOn		=> XOn,
		MsgOn		=> MsgOn );  
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_CLK or Tviol_ENA_CLK;
      VitalStateTable(
        StateTable => DFFE0_Q_tab,
        DataIn => (
		Violation, CLRN_ipd, CLK_delayed, Results(1), D_delayed, ENA_delayed, PRN_ipd, CLK_ipd),
        Result => Results,
	NumStates => 1,
        PreviousDataIn => PrevData_Q);
      D_delayed := D_ipd;
      CLK_delayed := CLK_ipd;
      ENA_delayed := ENA_ipd;

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       OutSignalName => "Q",
       OutTemp => Results(1),
       Paths => (0 => (PRN_ipd'last_event, tpd_PRN_Q_negedge, TRUE),
                 1 => (CLRN_ipd'last_event, tpd_CLRN_Q_negedge, TRUE),
                 2 => (CLK_ipd'last_event, tpd_CLK_Q_posedge, TRUE)),
       GlitchData => Q_VitalGlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_DFFE0_VITAL of DFFE0 is
   for AltVITAL
   end for;
end CFG_DFFE0_VITAL;


----- CELL FILTER -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity FILTER is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpw_IN1_posedge                :  VitalDelayType   := DefPulseWdthCnst;
      tpw_IN1_negedge                :  VitalDelayType   := DefPulseWdthCnst;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of FILTER : entity is TRUE;
end FILTER;

-- architecture body --

architecture AltVITAL of FILTER is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd)


   -- timing check variable
   VARIABLE Tviol_pw_IN1 : std_ulogic := '0';
   VARIABLE PeriodData_IN1 : VitalPeriodDataType := VitalPeriodDataInit;
 
   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalPeriodPulseCheck (
		Violation	=> Tviol_pw_IN1,
		PeriodData	=> PeriodData_IN1,
		TestSignal	=> IN1_ipd,
		TestSignalName	=> "IN1",
		PulseWidthHigh	=> tpw_IN1_posedge,
		PulseWidthLow	=> tpw_IN1_negedge,
		CheckEnabled	=> True,
		HeaderMsg	=> InstancePath,
       XOn  => XOn,
		MsgOn		=> DefTimingMsgOn );
      end if;

      ------------------------
      --  Functionality Section
      -------------------------
      Y_zd := TO_X01(IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_FILTER_VITAL of FILTER is
   for AltVITAL
   end for;
end CFG_FILTER_VITAL;


----- CELL INV -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity INV is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of INV : entity is TRUE;
end INV;

-- architecture body --

architecture AltVITAL of INV is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (NOT IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_INV_VITAL of INV is
   for AltVITAL
   end for;
end CFG_INV_VITAL;


----- CELL LATCH -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity LATCH is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_D_Q_posedge                        :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge                      :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_ENA_noedge_posedge   :	VitalDelayType := DefSetupHoldCnst;
      tsetup_D_ENA_noedge_negedge   :	VitalDelayType := DefSetupHoldCnst;
      thold_D_ENA_noedge_posedge    :	VitalDelayType := DefSetupHoldCnst;
      thold_D_ENA_noedge_negedge    :	VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_ENA                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '0';
      D                              :	in    STD_LOGIC;
      ENA                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of LATCH : entity is TRUE;
end LATCH;

-- architecture body --

architecture AltVITAL of LATCH is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL D_ipd	 : STD_ULOGIC := 'U';
   SIGNAL ENA_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (D_ipd, D, tipd_D);
   VitalWireDelay (ENA_ipd, ENA, tipd_ENA);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (D_ipd, ENA_ipd)

   -- timing check results
   VARIABLE Tviol_D_ENA	: STD_ULOGIC := '0';
   VARIABLE TimingData_D_ENA : VitalTimingDataType := VitalTimingDataInit;

   -- functionality results
   VARIABLE Violation : STD_ULOGIC := '0';
   VARIABLE PrevData_Q : STD_LOGIC_VECTOR(1 to 3) ;
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');

   -- output glitch detection variables
   VARIABLE Q_VitalGlitchData	: VitalGlitchDataType;

   CONSTANT LATCH_Q_tab : VitalStateTableType := (
    ( L, L,  H,  x,  L ),
    ( L, H,  H,  x,  H ),
    ( L, x,  L,  x,  S ) );

   begin

      ------------------------
      --  Timing Check Section
      ------------------------
      if (TimingChecksOn) then
         VitalSetupHoldCheck (
		Violation	=> Tviol_D_ENA,
		TimingData	=> TimingData_D_ENA,
		TestSignal	=> D_ipd,
		TestSignalName	=> "D",
		RefSignal	=> ENA_ipd,
		RefSignalName	=> "ENA",
		SetupHigh	=> tsetup_D_ENA_noedge_posedge,
		SetupLow	=> tsetup_D_ENA_noedge_negedge,
		HoldHigh	=> thold_D_ENA_noedge_posedge, 
		HoldLow		=> thold_D_ENA_noedge_negedge,
		CheckEnabled	=>  TRUE,
		RefTransition	=> '\',
		HeaderMsg	=> InstancePath & "/LATCH",
		XOn		=> XOn,
		MsgOn		=> MsgOn );
      end if;

      -------------------------
      --  Functionality Section
      -------------------------
      Violation := Tviol_D_ENA;
      VitalStateTable(
        StateTable => LATCH_Q_tab,
        DataIn => (
               Violation, D_ipd, ENA_ipd),
        Result => Results,
	NumStates => 1,
        PreviousDataIn => PrevData_Q);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Q,
       OutSignalName => "Q",
       OutTemp => Results(1),
       Paths => (0 => (D_ipd'last_event, tpd_D_Q_posedge, TRUE),
                 1 => (ENA_ipd'last_event, tpd_ENA_Q_posedge, TRUE)),
       GlitchData => Q_VitalGlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_LATCH_VITAL of LATCH is
   for AltVITAL
   end for;
end CFG_LATCH_VITAL;


----- CELL OR1 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR1 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR1 : entity is TRUE;
end OR1;

-- architecture body --

architecture AltVITAL of OR1 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := TO_X01(IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR1_VITAL of OR1 is
   for AltVITAL
   end for;
end CFG_OR1_VITAL;


----- CELL OR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR2 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR2 : entity is TRUE;
end OR2;

-- architecture body --

architecture AltVITAL of OR2 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (IN2_ipd) OR (IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR2_VITAL of OR2 is
   for AltVITAL
   end for;
end CFG_OR2_VITAL;


----- CELL OR3 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR3 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR3 : entity is TRUE;
end OR3;

-- architecture body --

architecture AltVITAL of OR3 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR3_VITAL of OR3 is
   for AltVITAL
   end for;
end CFG_OR3_VITAL;


----- CELL OR4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR4 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR4 : entity is TRUE;
end OR4;

-- architecture body --

architecture AltVITAL of OR4 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR4_VITAL of OR4 is
   for AltVITAL
   end for;
end CFG_OR4_VITAL;


----- CELL OR5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR5 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR5 : entity is TRUE;
end OR5;

-- architecture body --

architecture AltVITAL of OR5 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR5_VITAL of OR5 is
   for AltVITAL
   end for;
end CFG_OR5_VITAL;


----- CELL OR6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR6 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR6 : entity is TRUE;
end OR6;

-- architecture body --

architecture AltVITAL of OR6 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR6_VITAL of OR6 is
   for AltVITAL
   end for;
end CFG_OR6_VITAL;


----- CELL OR7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR7 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR7 : entity is TRUE;
end OR7;

-- architecture body --

architecture AltVITAL of OR7 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR7_VITAL of OR7 is
   for AltVITAL
   end for;
end CFG_OR7_VITAL;


----- CELL OR8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR8 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR8 : entity is TRUE;
end OR8;

-- architecture body --

architecture AltVITAL of OR8 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR8_VITAL of OR8 is
   for AltVITAL
   end for;
end CFG_OR8_VITAL;


----- CELL OR9 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR9 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR9 : entity is TRUE;
end OR9;

-- architecture body --

architecture AltVITAL of OR9 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR9_VITAL of OR9 is
   for AltVITAL
   end for;
end CFG_OR9_VITAL;


----- CELL OR10 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR10 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR10 : entity is TRUE;
end OR10;

-- architecture body --

architecture AltVITAL of OR10 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd) OR (IN10_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR10_VITAL of OR10 is
   for AltVITAL
   end for;
end CFG_OR10_VITAL;


----- CELL OR11 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR11 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR11 : entity is TRUE;
end OR11;

-- architecture body --

architecture AltVITAL of OR11 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd) OR (IN10_ipd) OR
         (IN11_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR11_VITAL of OR11 is
   for AltVITAL
   end for;
end CFG_OR11_VITAL;


----- CELL OR12 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR12 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR12 : entity is TRUE;
end OR12;

-- architecture body --

architecture AltVITAL of OR12 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd) OR (IN10_ipd) OR
         (IN11_ipd) OR (IN12_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR12_VITAL of OR12 is
   for AltVITAL
   end for;
end CFG_OR12_VITAL;


----- CELL OR13 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR13 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR13 : entity is TRUE;
end OR13;

-- architecture body --

architecture AltVITAL of OR13 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd) OR (IN10_ipd) OR
         (IN11_ipd) OR (IN12_ipd) OR (IN13_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR13_VITAL of OR13 is
   for AltVITAL
   end for;
end CFG_OR13_VITAL;


----- CELL OR14 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR14 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN14_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN14                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC;
      IN14                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR14 : entity is TRUE;
end OR14;

-- architecture body --

architecture AltVITAL of OR14 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN14_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   VitalWireDelay (IN14_ipd, IN14, tipd_IN14);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd, IN14_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd) OR (IN10_ipd) OR
         (IN11_ipd) OR (IN12_ipd) OR (IN13_ipd) OR (IN14_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE),
                 13 => (IN14_ipd'last_event, tpd_IN14_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR14_VITAL of OR14 is
   for AltVITAL
   end for;
end CFG_OR14_VITAL;


----- CELL OR15 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR15 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN14_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN15_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN14                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN15                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC;
      IN14                           :	in    STD_LOGIC;
      IN15                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR15 : entity is TRUE;
end OR15;

-- architecture body --

architecture AltVITAL of OR15 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN14_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN15_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   VitalWireDelay (IN14_ipd, IN14, tipd_IN14);
   VitalWireDelay (IN15_ipd, IN15, tipd_IN15);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd, IN14_ipd, IN15_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd) OR (IN10_ipd) OR
         (IN11_ipd) OR (IN12_ipd) OR (IN13_ipd) OR (IN14_ipd) OR (IN15_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE),
                 13 => (IN14_ipd'last_event, tpd_IN14_Y, TRUE),
                 14 => (IN15_ipd'last_event, tpd_IN15_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR15_VITAL of OR15 is
   for AltVITAL
   end for;
end CFG_OR15_VITAL;


----- CELL OR16 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity OR16 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN4_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN5_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN6_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN7_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN8_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN9_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN10_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN11_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN12_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN13_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN14_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN15_Y                     :	VitalDelayType01 := DefPropDelay01;
      tpd_IN16_Y                     :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN4                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN5                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN6                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN7                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN8                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN9                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN10                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN11                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN12                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN13                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN14                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN15                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN16                      :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC;
      IN4                            :	in    STD_LOGIC;
      IN5                            :	in    STD_LOGIC;
      IN6                            :	in    STD_LOGIC;
      IN7                            :	in    STD_LOGIC;
      IN8                            :	in    STD_LOGIC;
      IN9                            :	in    STD_LOGIC;
      IN10                           :	in    STD_LOGIC;
      IN11                           :	in    STD_LOGIC;
      IN12                           :	in    STD_LOGIC;
      IN13                           :	in    STD_LOGIC;
      IN14                           :	in    STD_LOGIC;
      IN15                           :	in    STD_LOGIC;
      IN16                           :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of OR16 : entity is TRUE;
end OR16;

-- architecture body --

architecture AltVITAL of OR16 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN3_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN4_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN5_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN6_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN7_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN8_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN9_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN10_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN11_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN12_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN13_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN14_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN15_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN16_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   VitalWireDelay (IN3_ipd, IN3, tipd_IN3);
   VitalWireDelay (IN4_ipd, IN4, tipd_IN4);
   VitalWireDelay (IN5_ipd, IN5, tipd_IN5);
   VitalWireDelay (IN6_ipd, IN6, tipd_IN6);
   VitalWireDelay (IN7_ipd, IN7, tipd_IN7);
   VitalWireDelay (IN8_ipd, IN8, tipd_IN8);
   VitalWireDelay (IN9_ipd, IN9, tipd_IN9);
   VitalWireDelay (IN10_ipd, IN10, tipd_IN10);
   VitalWireDelay (IN11_ipd, IN11, tipd_IN11);
   VitalWireDelay (IN12_ipd, IN12, tipd_IN12);
   VitalWireDelay (IN13_ipd, IN13, tipd_IN13);
   VitalWireDelay (IN14_ipd, IN14, tipd_IN14);
   VitalWireDelay (IN15_ipd, IN15, tipd_IN15);
   VitalWireDelay (IN16_ipd, IN16, tipd_IN16);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd, IN3_ipd, IN4_ipd, IN5_ipd, IN6_ipd, IN7_ipd, IN8_ipd, IN9_ipd, IN10_ipd, IN11_ipd, IN12_ipd, IN13_ipd, IN14_ipd, IN15_ipd, IN16_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd :=
       (IN2_ipd) OR (IN1_ipd) OR (IN3_ipd) OR (IN4_ipd) OR (IN5_ipd) OR
         (IN6_ipd) OR (IN7_ipd) OR (IN8_ipd) OR (IN9_ipd) OR (IN10_ipd) OR
         (IN11_ipd) OR (IN12_ipd) OR (IN13_ipd) OR (IN14_ipd) OR (IN15_ipd)
         OR (IN16_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE),
                 2 => (IN3_ipd'last_event, tpd_IN3_Y, TRUE),
                 3 => (IN4_ipd'last_event, tpd_IN4_Y, TRUE),
                 4 => (IN5_ipd'last_event, tpd_IN5_Y, TRUE),
                 5 => (IN6_ipd'last_event, tpd_IN6_Y, TRUE),
                 6 => (IN7_ipd'last_event, tpd_IN7_Y, TRUE),
                 7 => (IN8_ipd'last_event, tpd_IN8_Y, TRUE),
                 8 => (IN9_ipd'last_event, tpd_IN9_Y, TRUE),
                 9 => (IN10_ipd'last_event, tpd_IN10_Y, TRUE),
                 10 => (IN11_ipd'last_event, tpd_IN11_Y, TRUE),
                 11 => (IN12_ipd'last_event, tpd_IN12_Y, TRUE),
                 12 => (IN13_ipd'last_event, tpd_IN13_Y, TRUE),
                 13 => (IN14_ipd'last_event, tpd_IN14_Y, TRUE),
                 14 => (IN15_ipd'last_event, tpd_IN15_Y, TRUE),
                 15 => (IN16_ipd'last_event, tpd_IN16_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_OR16_VITAL of OR16 is
   for AltVITAL
   end for;
end CFG_OR16_VITAL;


----- CELL RISEFALL -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity RISEFALL is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of RISEFALL : entity is TRUE;
end RISEFALL;

-- architecture body --

architecture AltVITAL of RISEFALL is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := TO_X01(IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_RISEFALL_VITAL of RISEFALL is
   for AltVITAL
   end for;
end CFG_RISEFALL_VITAL;

----- CELL TRIBUF -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity TRIBUF is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_OE_Y                       :	VitalDelayType01Z := DefPropDelay01Z;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_OE                        :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of TRIBUF : entity is TRUE;
end TRIBUF;

-- architecture body --

architecture AltVITAL of TRIBUF is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL OE_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (OE_ipd, OE, tipd_OE);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, OE_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := VitalBUFIF0 (data => IN1_ipd,
              enable => (NOT OE_ipd) );

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01Z (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, VitalExtendToFillDelay(tpd_IN1_Y), TRUE),
                 1 => (OE_ipd'last_event, tpd_OE_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn => MsgOn,
       OutputMap =>NoPullUpZ);


end process;

end AltVITAL;

configuration CFG_TRIBUF_VITAL of TRIBUF is
   for AltVITAL
   end for;
end CFG_TRIBUF_VITAL;


----- CELL XOR2 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
library alt_vtl;
use alt_vtl.SUPPORT.all;

-- entity declaration --
entity XOR2 is
   generic(
      TimingChecksOn: Boolean := True;
      XGenerationOn: Boolean := False;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC);
   attribute VITAL_LEVEL0 of XOR2 : entity is TRUE;
end XOR2;

-- architecture body --

architecture AltVITAL of XOR2 is
   attribute VITAL_LEVEL1 of AltVITAL : architecture is TRUE;

   SIGNAL IN1_ipd	 : STD_ULOGIC := 'U';
   SIGNAL IN2_ipd	 : STD_ULOGIC := 'U';

begin

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : block
   begin
   VitalWireDelay (IN1_ipd, IN1, tipd_IN1);
   VitalWireDelay (IN2_ipd, IN2, tipd_IN2);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (IN1_ipd, IN2_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Y_zd : STD_ULOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Y_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Y_zd := (IN2_ipd) XOR (IN1_ipd);

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Y,
       OutSignalName => "Y",
       OutTemp => Y_zd,
       Paths => (0 => (IN1_ipd'last_event, tpd_IN1_Y, TRUE),
                 1 => (IN2_ipd'last_event, tpd_IN2_Y, TRUE)),
       GlitchData => Y_GlitchData,
       Mode => DefGlitchMode,
       XOn  => XOn,
       MsgOn        => MsgOn );

end process;

end AltVITAL;

configuration CFG_XOR2_VITAL of XOR2 is
   for AltVITAL
   end for;
end CFG_XOR2_VITAL;


---- end of library ----

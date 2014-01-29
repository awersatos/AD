
----------------------------------------------------------------
-- 
-- Copyright (c) 1995 by Altera Corporation.  All rights reserved.      
--
-- FILENAME     :    alt_vtl.cmp
-- FILE CONTENTS:    VITAL Component Package (3.0)
-- DATE CREATED :    Fri Feb 17 15:54:24 1995
-- 
-- LIBRARY      :    alt_vtl
-- REVISION     :    1.0
-- LOGIC SYSTEM :    IEEE-1164
-- NOTES        :    
-- HISTORY      :
-- 
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;

package VCOMPONENTS is

CONSTANT DefaultTimingChecksOn : Boolean := True;
CONSTANT DefaultXGenerationOn : Boolean := False;
CONSTANT DefPropDelay01      : VitalDelayType01      := (0 ns, 0 ns);
CONSTANT DefPropDelay01Z     : VitalDelayType01Z     := (OTHERS => 0 ns);
CONSTANT DefSetupHoldCnst    : TIME := 0 ns;
CONSTANT DefPulseWdthCnst    : TIME := 0 ns;
CONSTANT DefGlitchMsgOn      : BOOLEAN       := TRUE;
CONSTANT DefGlitchXOn	: BOOLEAN	:= FALSE;

----- Component AND1 -----
component AND1
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
end component;


----- Component AND2 -----
component AND2
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC);
end component;


----- Component AND3 -----
component AND3
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND4 -----
component AND4
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND5 -----
component AND5
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND6 -----
component AND6
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND7 -----
component AND7
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND8 -----
component AND8
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND9 -----
component AND9
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND10 -----
component AND10
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND11 -----
component AND11
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND12 -----
component AND12
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND13 -----
component AND13
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND14 -----
component AND14
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND15 -----
component AND15
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component AND16 -----
component AND16
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component DELAY -----
component DELAY
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
end component;


----- Component DFF -----
component DFF
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      InstancePath: STRING := "*";
      tpd_PRN_Q_negedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :   VitalDelayType := DefSetupHoldCnst;
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
end component;


----- Component DFF1 -----
component DFF1
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_PRN_Q_negedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :   VitalDelayType := DefSetupHoldCnst;
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
end component;


----- Component DFF0 -----
component DFF0
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_PRN_Q_negedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :   VitalDelayType := DefSetupHoldCnst;
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
end component;


----- Component DFFE -----
component DFFE
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_PRN_Q_negedge                :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_ENA_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_ENA_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
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
end component;


----- Component DFFE1 -----
component DFFE1
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_PRN_Q_negedge                :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_ENA_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_ENA_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
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
end component;


----- Component DFFE0 -----
component DFFE0
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_PRN_Q_negedge                :	VitalDelayType01 := DefPropDelay01;
      tpd_CLRN_Q_negedge             :	VitalDelayType01 := DefPropDelay01;
      tpd_CLK_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_D_CLK_noedge_negedge    :  VitalDelayType := DefSetupHoldCnst;
      tsetup_ENA_CLK_noedge_posedge    :  VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_D_CLK_noedge_negedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_ENA_CLK_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
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
end component;


----- Component FILTER -----
component FILTER
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpw_IN1_posedge                :  VitalDelayType   := DefPulseWdthCnst;
      tpw_IN1_negedge                :  VitalDelayType   := DefPulseWdthCnst;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
end component;


----- Component INV -----
component INV
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
end component;


----- Component LATCH -----
component LATCH
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_D_Q_posedge                :	VitalDelayType01 := DefPropDelay01;
      tpd_ENA_Q_posedge              :	VitalDelayType01 := DefPropDelay01;
      tsetup_D_ENA_noedge_posedge   :   VitalDelayType := DefSetupHoldCnst;
      tsetup_D_ENA_noedge_negedge   :   VitalDelayType := DefSetupHoldCnst;
      thold_D_ENA_noedge_posedge    :   VitalDelayType := DefSetupHoldCnst;
      thold_D_ENA_noedge_negedge    :   VitalDelayType := DefSetupHoldCnst;
      tipd_D                         :	VitalDelayType01 := DefPropDelay01;
      tipd_ENA                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Q                              :	out   STD_LOGIC := '0';
      D                              :	in    STD_LOGIC;
      ENA                            :	in    STD_LOGIC);
end component;


----- Component OR1 -----
component OR1
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC);
end component;


----- Component OR2 -----
component OR2
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC);
end component;


----- Component OR3 -----
component OR3
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR4 -----
component OR4
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR5 -----
component OR5
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR6 -----
component OR6
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR7 -----
component OR7
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR8 -----
component OR8
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR9 -----
component OR9
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR10 -----
component OR10
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR11 -----
component OR11
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR12 -----
component OR12
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR13 -----
component OR13
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR14 -----
component OR14
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR15 -----
component OR15
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component OR16 -----
component OR16
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
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
end component;


----- Component RISEFALL -----
component RISEFALL
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :  VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :  VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :  out   STD_LOGIC;
      IN1                            :  in    STD_LOGIC);
end component;


----- Component TRIBUF -----
component TRIBUF
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_OE_Y                       :	VitalDelayType01z := DefPropDelay01Z;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_OE                        :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC);
end component;


----- Component XOR2 -----
component XOR2
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC);
end component;


end VCOMPONENTS;

---- end of VITAL components library ----

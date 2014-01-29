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
-- Simulation Library File for EC/XP
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca5mg/src/RCS/ORCA_LUT.vhd,v 1.3 2005/05/19 20:37:00 pradeep Exp $ 
--
----- CELL ORCALUT4 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT4 is
   generic(
      TimingChecksOn: Boolean := TRUE;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := False;
      tpd_A_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_C_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_D_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      INIT                          :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT4 : entity is TRUE;
end ORCALUT4;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT4 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C_ipd	 : STD_ULOGIC := 'X';
   SIGNAL D_ipd	 : STD_ULOGIC := 'X';

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
   ALIAS Z_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => To_StdLogicVector(INIT),
                  dselect => (D_ipd, C_ipd, B_ipd, A_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       GlitchData => Z_GlitchData,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE)),
       Mode => OnEvent,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end V;

configuration CFG_ORCALUT4_V of ORCALUT4 is
   for V
   end for;
end CFG_ORCALUT4_V;

----- CELL ORCALUT5 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT5 is
   generic(
      TimingChecksOn: Boolean := TRUE;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := False;
      tpd_A_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_C_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_D_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_E_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      INIT                           :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT5 : entity is TRUE;
end ORCALUT5;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT5 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C_ipd	 : STD_ULOGIC := 'X';
   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL E_ipd	 : STD_ULOGIC := 'X';

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
   ALIAS Z_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => To_StdLogicVector(INIT),
                  dselect => (E_ipd, D_ipd, C_ipd, B_ipd, A_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       GlitchData => Z_GlitchData,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE)),
       Mode => OnEvent,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end V;

configuration CFG_ORCALUT5_V of ORCALUT5 is
   for V
   end for;
end CFG_ORCALUT5_V;

----- CELL ORCALUT6 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT6 is
   generic(
      TimingChecksOn: Boolean := TRUE;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := False;
      tpd_A_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_C_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_D_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_E_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_F_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_F                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      INIT                           :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT6 : entity is TRUE;
end ORCALUT6;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT6 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C_ipd	 : STD_ULOGIC := 'X';
   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL E_ipd	 : STD_ULOGIC := 'X';
   SIGNAL F_ipd	 : STD_ULOGIC := 'X';

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
   ALIAS Z_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => To_StdLogicVector(INIT),
                  dselect => (F_ipd, E_ipd, D_ipd, C_ipd, B_ipd, A_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       GlitchData => Z_GlitchData,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE)),
       Mode => OnEvent,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end V;

configuration CFG_ORCALUT6_V of ORCALUT6 is
   for V
   end for;
end CFG_ORCALUT6_V;

----- CELL ORCALUT7 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT7 is
   generic(
      TimingChecksOn: Boolean := TRUE;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := False;
      tpd_A_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_C_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_D_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_E_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_F_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_G_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_F                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      INIT                           :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC;
      G                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT7 : entity is TRUE;
end ORCALUT7;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT7 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C_ipd	 : STD_ULOGIC := 'X';
   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL E_ipd	 : STD_ULOGIC := 'X';
   SIGNAL F_ipd	 : STD_ULOGIC := 'X';
   SIGNAL G_ipd	 : STD_ULOGIC := 'X';

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
   VitalWireDelay (G_ipd, G, tipd_G);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd, G_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => To_StdLogicVector(INIT),
                  dselect => (G_ipd, F_ipd, E_ipd, D_ipd, C_ipd, B_ipd, A_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       GlitchData => Z_GlitchData,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE),
                 6 => (G_ipd'last_event, tpd_G_Z, TRUE)),
       Mode => OnEvent,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end V;

configuration CFG_ORCALUT7_V of ORCALUT7 is
   for V
   end for;
end CFG_ORCALUT7_V;

----- CELL ORCALUT8 -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;


-- entity declaration --
entity ORCALUT8 is
   generic(
      TimingChecksOn: Boolean := TRUE;
      InstancePath: STRING := "*";
      Xon: Boolean := True;
      MsgOn: Boolean := False;
      tpd_A_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_B_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_C_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_D_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_E_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_F_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_G_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tpd_H_Z                       :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_A                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_B                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_C                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_D                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_E                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_F                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_G                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      tipd_H                        :	VitalDelayType01 := (0.000 ns, 0.000 ns);
      INIT                           :	bit_vector);

   port(
      Z                              :	out   STD_ULOGIC;
      A                             :	in    STD_ULOGIC;
      B                             :	in    STD_ULOGIC;
      C                             :	in    STD_ULOGIC;
      D                             :	in    STD_ULOGIC;
      E                             :	in    STD_ULOGIC;
      F                             :	in    STD_ULOGIC;
      G                             :	in    STD_ULOGIC;
      H                             :	in    STD_ULOGIC);
attribute VITAL_LEVEL0 of ORCALUT8 : entity is TRUE;
end ORCALUT8;

-- architecture body --
library IEEE;
use IEEE.VITAL_Primitives.all;
architecture V of ORCALUT8 is
   attribute VITAL_LEVEL0 of V : architecture is TRUE;

   SIGNAL A_ipd	 : STD_ULOGIC := 'X';
   SIGNAL B_ipd	 : STD_ULOGIC := 'X';
   SIGNAL C_ipd	 : STD_ULOGIC := 'X';
   SIGNAL D_ipd	 : STD_ULOGIC := 'X';
   SIGNAL E_ipd	 : STD_ULOGIC := 'X';
   SIGNAL F_ipd	 : STD_ULOGIC := 'X';
   SIGNAL G_ipd	 : STD_ULOGIC := 'X';
   SIGNAL H_ipd	 : STD_ULOGIC := 'X';

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
   VitalWireDelay (G_ipd, G, tipd_G);
   VitalWireDelay (H_ipd, H, tipd_H);
   end block;
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VITALBehavior : process (A_ipd, B_ipd, C_ipd, D_ipd, E_ipd, F_ipd, G_ipd, H_ipd)


   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd : STD_LOGIC is Results(1);

   -- output glitch detection variables
   VARIABLE Z_GlitchData	: VitalGlitchDataType;

   begin

      -------------------------
      --  Functionality Section
      -------------------------
      Z_zd := VitalMUX
                 (data => To_StdLogicVector(INIT),
                  dselect => (H_ipd, G_ipd, F_ipd, E_ipd, D_ipd, C_ipd, B_ipd, A_ipd));

      ----------------------
      --  Path Delay Section
      ----------------------
      VitalPathDelay01 (
       OutSignal => Z,
       GlitchData => Z_GlitchData,
       OutSignalName => "Z",
       OutTemp => Z_zd,
       Paths => (0 => (A_ipd'last_event, tpd_A_Z, TRUE),
                 1 => (B_ipd'last_event, tpd_B_Z, TRUE),
                 2 => (C_ipd'last_event, tpd_C_Z, TRUE),
                 3 => (D_ipd'last_event, tpd_D_Z, TRUE),
                 4 => (E_ipd'last_event, tpd_E_Z, TRUE),
                 5 => (F_ipd'last_event, tpd_F_Z, TRUE),
                 6 => (G_ipd'last_event, tpd_G_Z, TRUE),
                 7 => (H_ipd'last_event, tpd_H_Z, TRUE)),
       Mode => OnEvent,
       Xon => Xon,
       MsgOn => MsgOn,
       MsgSeverity => WARNING);

end process;

end V;

configuration CFG_ORCALUT8_V of ORCALUT8 is
   for V
   end for;
end CFG_ORCALUT8_V;

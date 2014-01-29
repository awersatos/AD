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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca2/src/RCS/ORCA_CNT.vhd,v 1.4 2005/05/19 20:04:10 pradeep Exp $ 
--
 
--
----- CELL BUF -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
 
-- entity declaration --
entity BUF is
    generic (
        TimingChecksOn  : Boolean := FALSE;
        XOn             : Boolean := FALSE;
	MsgOn           : Boolean := FALSE;
        InstancePath    : String  := "BUF";
        tpd_A_Z		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_A		: VitalDelayType01 := (0.1 ns, 0.1 ns)) ;
 
    port (
        A  : in STD_LOGIC;
        Z  : out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of BUF : entity is TRUE;
 
end BUF ;
 
-- architecture body --
architecture V of BUF is
    attribute VITAL_LEVEL1 of V : architecture is TRUE;
 
    signal A_ipd  : STD_LOGIC := 'X';
 
begin
 
   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WIREDELAY : block
   begin
   VitalWireDelay(A_ipd, A, tipd_A);
   end block;
 
   --------------------
   --  BEHAVIOR SECTION
   --------------------
   VitalBehavior : process (A_ipd)
 
   -- functionality results
   VARIABLE Results : STD_LOGIC_VECTOR(1 to 1) := (others => 'X');
   ALIAS Z_zd       : STD_ULOGIC is Results(1);
 
   -- output glitch detection variables
   VARIABLE Z_GlitchData     : VitalGlitchDataType;
 
   begin
 
   IF (TimingChecksOn) THEN
    -----------------------------------
    -- No Timing Checks for a comb gate
    -----------------------------------
   END IF;
 
   -----------------------------------
   -- Functionality Section.
   -----------------------------------
   Z_zd := VitalBUF(A_ipd);
 
   -----------------------------------
   -- Path Delay Section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => Z,
     OutSignalName => "Z",
     OutTemp => Z_zd,
     Paths => (0 => (InputChangeTime => A_ipd'LAST_EVENT, 
		     PathDelay => tpd_A_Z, 
		     PathCondition => TRUE)),
     GlitchData => Z_GlitchData,
     Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
   end process;
 
end V;


--
----- CB4 -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CB4 is
  generic (
    InstancePath  : String := "CB4");
  port (
    CI, PC0, PC1, PC2, PC3, CON: in STD_LOGIC;
    CO, NC0, NC1, NC2, NC3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CB4 : entity is TRUE;
 
end CB4;

architecture V of CB4 is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component INV
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal CII, CONN, I3, I4, I5, I6, I17, I15, I16, I18, I30, I28, I29,
    I31, I43, I41, I42, CONI: STD_LOGIC;
begin
  INST10: AND2 port map (A=>CII, B=>CONN, Z=>I3);
  INST11: AND2 port map (A=>PC0, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
  INST13: XOR3 port map (A=>PC0, B=>CONN, C=>CII, Z=>NC0);
  INST2: AND2 port map (A=>CONN, B=>PC0, Z=>I5);
  INST22: AND2 port map (A=>CONN, B=>PC1, Z=>I17);
  INST23: AND2 port map (A=>I6, B=>CONN, Z=>I15);
  INST24: AND2 port map (A=>PC1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
  INST26: XOR3 port map (A=>PC1, B=>CONN, C=>I6, Z=>NC1);
  INST35: AND2 port map (A=>CONN, B=>PC2, Z=>I30);
  INST36: AND2 port map (A=>I18, B=>CONN, Z=>I28);
  INST37: AND2 port map (A=>PC2, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
  INST39: XOR3 port map (A=>PC2, B=>CONN, C=>I18, Z=>NC2);
  INST48: AND2 port map (A=>CONN, B=>PC3, Z=>I43);
  INST49: AND2 port map (A=>I31, B=>CONN, Z=>I41);
  INST50: AND2 port map (A=>PC3, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
  INST52: XOR3 port map (A=>PC3, B=>CONN, C=>I31, Z=>NC3);
  INST96: INV port map (A=>CONI, Z=>CONN);
  INST990: BUF port map (A=>CI, Z=>CII);
  INST991: BUF port map (A=>CON, Z=>CONI);
end V;

library ORCA2;
configuration CB4C of CB4 is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: INV use entity ORCA2.INV(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
  end for;
end CB4C;


--
----- CB4P3BX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CB4P3BX is
  generic (
    InstancePath  : String := "CB4P3BX");
  port (
    CI, SP, CK, PD, CON: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CB4P3BX : entity is TRUE;
 
end CB4P3BX;

architecture V of CB4P3BX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3BX
    port (
      D, SP, CK, PD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component INV
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, CONN, I3, I4, I5, I6, I7, I17,
    I15, I16, I18, I19, I30, I28, I29, I31, I32, I43, I41, I42, I45,
    CONI: STD_LOGIC;
begin
  INST10: AND2 port map (A=>CII, B=>CONN, Z=>I3);
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
  INST13: XOR3 port map (A=>Q0_1, B=>CONN, C=>CII, Z=>I7);
  INST2: AND2 port map (A=>CONN, B=>Q0_1, Z=>I5);
  INST22: AND2 port map (A=>CONN, B=>Q1_1, Z=>I17);
  INST23: AND2 port map (A=>I6, B=>CONN, Z=>I15);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
  INST26: XOR3 port map (A=>Q1_1, B=>CONN, C=>I6, Z=>I19);
  INST35: AND2 port map (A=>CONN, B=>Q2_1, Z=>I30);
  INST36: AND2 port map (A=>I18, B=>CONN, Z=>I28);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
  INST39: XOR3 port map (A=>Q2_1, B=>CONN, C=>I18, Z=>I32);
  INST48: AND2 port map (A=>CONN, B=>Q3_1, Z=>I43);
  INST49: AND2 port map (A=>I31, B=>CONN, Z=>I41);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
  INST52: XOR3 port map (A=>Q3_1, B=>CONN, C=>I31, Z=>I45);
  INST96: INV port map (A=>CONI, Z=>CONN);
  INST68: FD1P3BX port map (D=>I7, SP=>SP, CK=>CK, PD=>PD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3BX port map (D=>I19, SP=>SP, CK=>CK, PD=>PD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3BX port map (D=>I32, SP=>SP, CK=>CK, PD=>PD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3BX port map (D=>I45, SP=>SP, CK=>CK, PD=>PD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  INST991: BUF port map (A=>CON, Z=>CONI);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CB4P3BXC of CB4P3BX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3BX use entity ORCA2.FD1P3BX(v); end for;
    for all: INV use entity ORCA2.INV(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
  end for;
end CB4P3BXC;


--
----- CB4P3DX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CB4P3DX is
  generic (
    InstancePath  : String := "CB4P3DX");
  port (
    CI, SP, CK, CD, CON: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CB4P3DX : entity is TRUE;
 
end CB4P3DX;

architecture V of CB4P3DX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3DX
    port (
      D, SP, CK, CD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component INV
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, CONN, I3, I4, I5, I6, I7, I17,
    I15, I16, I18, I19, I30, I28, I29, I31, I32, I43, I41, I42, I45,
    CONI: STD_LOGIC;
begin
  INST10: AND2 port map (A=>CII, B=>CONN, Z=>I3);
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
  INST13: XOR3 port map (A=>Q0_1, B=>CONN, C=>CII, Z=>I7);
  INST2: AND2 port map (A=>CONN, B=>Q0_1, Z=>I5);
  INST22: AND2 port map (A=>CONN, B=>Q1_1, Z=>I17);
  INST23: AND2 port map (A=>I6, B=>CONN, Z=>I15);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
  INST26: XOR3 port map (A=>Q1_1, B=>CONN, C=>I6, Z=>I19);
  INST35: AND2 port map (A=>CONN, B=>Q2_1, Z=>I30);
  INST36: AND2 port map (A=>I18, B=>CONN, Z=>I28);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
  INST39: XOR3 port map (A=>Q2_1, B=>CONN, C=>I18, Z=>I32);
  INST48: AND2 port map (A=>CONN, B=>Q3_1, Z=>I43);
  INST49: AND2 port map (A=>I31, B=>CONN, Z=>I41);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
  INST52: XOR3 port map (A=>Q3_1, B=>CONN, C=>I31, Z=>I45);
  INST96: INV port map (A=>CONI, Z=>CONN);
  INST68: FD1P3DX port map (D=>I7, SP=>SP, CK=>CK, CD=>CD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3DX port map (D=>I19, SP=>SP, CK=>CK, CD=>CD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3DX port map (D=>I32, SP=>SP, CK=>CK, CD=>CD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3DX port map (D=>I45, SP=>SP, CK=>CK, CD=>CD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  INST991: BUF port map (A=>CON, Z=>CONI);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CB4P3DXC of CB4P3DX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3DX use entity ORCA2.FD1P3DX(v); end for;
    for all: INV use entity ORCA2.INV(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
  end for;
end CB4P3DXC;


--
----- CB4P3IX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CB4P3IX is
  generic (
    InstancePath  : String := "CB4P3IX");
  port (
    CI, SP, CK, CD, CON: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CB4P3IX : entity is TRUE;
 
end CB4P3IX;

architecture V of CB4P3IX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3IZ
    port (
      D, SP, CK, CD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component INV
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, CONN, I3, I4, I5, I6, I7, I17,
    I15, I16, I18, I19, I30, I28, I29, I31, I32, I43, I41, I42, I45,
    CONI: STD_LOGIC;
begin
  INST10: AND2 port map (A=>CII, B=>CONN, Z=>I3);
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
  INST13: XOR3 port map (A=>Q0_1, B=>CONN, C=>CII, Z=>I7);
  INST2: AND2 port map (A=>CONN, B=>Q0_1, Z=>I5);
  INST22: AND2 port map (A=>CONN, B=>Q1_1, Z=>I17);
  INST23: AND2 port map (A=>I6, B=>CONN, Z=>I15);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
  INST26: XOR3 port map (A=>Q1_1, B=>CONN, C=>I6, Z=>I19);
  INST35: AND2 port map (A=>CONN, B=>Q2_1, Z=>I30);
  INST36: AND2 port map (A=>I18, B=>CONN, Z=>I28);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
  INST39: XOR3 port map (A=>Q2_1, B=>CONN, C=>I18, Z=>I32);
  INST48: AND2 port map (A=>CONN, B=>Q3_1, Z=>I43);
  INST49: AND2 port map (A=>I31, B=>CONN, Z=>I41);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
  INST52: XOR3 port map (A=>Q3_1, B=>CONN, C=>I31, Z=>I45);
  INST96: INV port map (A=>CONI, Z=>CONN);
  INST68: FD1P3IZ port map (D=>I7, SP=>SP, CK=>CK, CD=>CD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3IZ port map (D=>I19, SP=>SP, CK=>CK, CD=>CD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3IZ port map (D=>I32, SP=>SP, CK=>CK, CD=>CD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3IZ port map (D=>I45, SP=>SP, CK=>CK, CD=>CD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  INST991: BUF port map (A=>CON, Z=>CONI);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CB4P3IXC of CB4P3IX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3IZ use entity ORCA2.FD1P3IZ(v); end for;
    for all: INV use entity ORCA2.INV(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
  end for;
end CB4P3IXC;


--
----- CB4P3JX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CB4P3JX is
  generic (
    InstancePath  : String := "CB4P3JX");
  port (
    CI, SP, CK, PD, CON: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CB4P3JX : entity is TRUE;
 
end CB4P3JX;

architecture V of CB4P3JX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3JZ
    port (
      D, SP, CK, PD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component INV
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, CONN, I3, I4, I5, I6, I7, I17,
    I15, I16, I18, I19, I30, I28, I29, I31, I32, I43, I41, I42, I45,
    CONI: STD_LOGIC;
begin
  INST10: AND2 port map (A=>CII, B=>CONN, Z=>I3);
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
  INST13: XOR3 port map (A=>Q0_1, B=>CONN, C=>CII, Z=>I7);
  INST2: AND2 port map (A=>CONN, B=>Q0_1, Z=>I5);
  INST22: AND2 port map (A=>CONN, B=>Q1_1, Z=>I17);
  INST23: AND2 port map (A=>I6, B=>CONN, Z=>I15);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
  INST26: XOR3 port map (A=>Q1_1, B=>CONN, C=>I6, Z=>I19);
  INST35: AND2 port map (A=>CONN, B=>Q2_1, Z=>I30);
  INST36: AND2 port map (A=>I18, B=>CONN, Z=>I28);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
  INST39: XOR3 port map (A=>Q2_1, B=>CONN, C=>I18, Z=>I32);
  INST48: AND2 port map (A=>CONN, B=>Q3_1, Z=>I43);
  INST49: AND2 port map (A=>I31, B=>CONN, Z=>I41);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
  INST52: XOR3 port map (A=>Q3_1, B=>CONN, C=>I31, Z=>I45);
  INST96: INV port map (A=>CONI, Z=>CONN);
  INST68: FD1P3JZ port map (D=>I7, SP=>SP, CK=>CK, PD=>PD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3JZ port map (D=>I19, SP=>SP, CK=>CK, PD=>PD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3JZ port map (D=>I32, SP=>SP, CK=>CK, PD=>PD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3JZ port map (D=>I45, SP=>SP, CK=>CK, PD=>PD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  INST991: BUF port map (A=>CON, Z=>CONI);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CB4P3JXC of CB4P3JX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3JZ use entity ORCA2.FD1P3JZ(v); end for;
    for all: INV use entity ORCA2.INV(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
  end for;
end CB4P3JXC;


--
----- CD4 -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CD4 is
  generic (
    InstancePath  : String := "CD4");
  port (
    CI, PC0, PC1, PC2, PC3: in STD_LOGIC;
    CO, NC0, NC1, NC2, NC3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CD4 : entity is TRUE;
 
end CD4;

architecture V of CD4 is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XNOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal CII, I4, I6, I16, I18, I29, I31, I42: STD_LOGIC;
begin
  INST11: AND2 port map (A=>PC0, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>CII, B=>I4, C=>PC0, Z=>I6);
  INST13: XNOR2 port map (A=>PC0, B=>CII, Z=>NC0);
  INST24: AND2 port map (A=>PC1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I6, B=>I16, C=>PC1, Z=>I18);
  INST26: XNOR2 port map (A=>PC1, B=>I6, Z=>NC1);
  INST37: AND2 port map (A=>PC2, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I18, B=>I29, C=>PC2, Z=>I31);
  INST39: XNOR2 port map (A=>PC2, B=>I18, Z=>NC2);
  INST50: AND2 port map (A=>PC3, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I31, B=>I42, C=>PC3, Z=>CO);
  INST52: XNOR2 port map (A=>PC3, B=>I31, Z=>NC3);
  INST990: BUF port map (A=>CI, Z=>CII);
end V;

library ORCA2;
configuration CD4C of CD4 is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XNOR2 use entity ORCA2.XNOR2(v); end for;
  end for;
end CD4C;


--
----- CD4P3BX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CD4P3BX is
  generic (
    InstancePath  : String := "CD4P3BX");
  port (
    CI, SP, CK, PD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CD4P3BX : entity is TRUE;
 
end CD4P3BX;

architecture V of CD4P3BX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3BX
    port (
      D, SP, CK, PD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XNOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I4, I6, I7, I16, I18, I19, I29,
    I31, I32, I42, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>CII, B=>I4, C=>Q0_1, Z=>I6);
  INST13: XNOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I6, B=>I16, C=>Q1_1, Z=>I18);
  INST26: XNOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I18, B=>I29, C=>Q2_1, Z=>I31);
  INST39: XNOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I31, B=>I42, C=>Q3_1, Z=>CO);
  INST52: XNOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3BX port map (D=>I7, SP=>SP, CK=>CK, PD=>PD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3BX port map (D=>I19, SP=>SP, CK=>CK, PD=>PD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3BX port map (D=>I32, SP=>SP, CK=>CK, PD=>PD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3BX port map (D=>I45, SP=>SP, CK=>CK, PD=>PD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CD4P3BXC of CD4P3BX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3BX use entity ORCA2.FD1P3BX(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XNOR2 use entity ORCA2.XNOR2(v); end for;
  end for;
end CD4P3BXC;


--
----- CD4P3DX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CD4P3DX is
  generic (
    InstancePath  : String := "CD4P3DX");
  port (
    CI, SP, CK, CD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CD4P3DX : entity is TRUE;
 
end CD4P3DX;

architecture V of CD4P3DX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3DX
    port (
      D, SP, CK, CD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XNOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I4, I6, I7, I16, I18, I19, I29,
    I31, I32, I42, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>CII, B=>I4, C=>Q0_1, Z=>I6);
  INST13: XNOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I6, B=>I16, C=>Q1_1, Z=>I18);
  INST26: XNOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I18, B=>I29, C=>Q2_1, Z=>I31);
  INST39: XNOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I31, B=>I42, C=>Q3_1, Z=>CO);
  INST52: XNOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3DX port map (D=>I7, SP=>SP, CK=>CK, CD=>CD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3DX port map (D=>I19, SP=>SP, CK=>CK, CD=>CD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3DX port map (D=>I32, SP=>SP, CK=>CK, CD=>CD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3DX port map (D=>I45, SP=>SP, CK=>CK, CD=>CD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CD4P3DXC of CD4P3DX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3DX use entity ORCA2.FD1P3DX(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XNOR2 use entity ORCA2.XNOR2(v); end for;
  end for;
end CD4P3DXC;


--
----- CD4P3IX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CD4P3IX is
  generic (
    InstancePath  : String := "CD4P3IX");
  port (
    CI, SP, CK, CD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CD4P3IX : entity is TRUE;
 
end CD4P3IX;

architecture V of CD4P3IX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3IZ
    port (
      D, SP, CK, CD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XNOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I4, I6, I7, I16, I18, I19, I29,
    I31, I32, I42, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>CII, B=>I4, C=>Q0_1, Z=>I6);
  INST13: XNOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I6, B=>I16, C=>Q1_1, Z=>I18);
  INST26: XNOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I18, B=>I29, C=>Q2_1, Z=>I31);
  INST39: XNOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I31, B=>I42, C=>Q3_1, Z=>CO);
  INST52: XNOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3IZ port map (D=>I7, SP=>SP, CK=>CK, CD=>CD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3IZ port map (D=>I19, SP=>SP, CK=>CK, CD=>CD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3IZ port map (D=>I32, SP=>SP, CK=>CK, CD=>CD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3IZ port map (D=>I45, SP=>SP, CK=>CK, CD=>CD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CD4P3IXC of CD4P3IX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3IZ use entity ORCA2.FD1P3IZ(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XNOR2 use entity ORCA2.XNOR2(v); end for;
  end for;
end CD4P3IXC;


--
----- CD4P3JX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CD4P3JX is
  generic (
    InstancePath  : String := "CD4P3JX");
  port (
    CI, SP, CK, PD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CD4P3JX : entity is TRUE;
 
end CD4P3JX;

architecture V of CD4P3JX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3JZ
    port (
      D, SP, CK, PD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XNOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I4, I6, I7, I16, I18, I19, I29,
    I31, I32, I42, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>CII, B=>I4, C=>Q0_1, Z=>I6);
  INST13: XNOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I6, B=>I16, C=>Q1_1, Z=>I18);
  INST26: XNOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I18, B=>I29, C=>Q2_1, Z=>I31);
  INST39: XNOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I31, B=>I42, C=>Q3_1, Z=>CO);
  INST52: XNOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3JZ port map (D=>I7, SP=>SP, CK=>CK, PD=>PD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3JZ port map (D=>I19, SP=>SP, CK=>CK, PD=>PD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3JZ port map (D=>I32, SP=>SP, CK=>CK, PD=>PD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3JZ port map (D=>I45, SP=>SP, CK=>CK, PD=>PD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CD4P3JXC of CD4P3JX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3JZ use entity ORCA2.FD1P3JZ(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XNOR2 use entity ORCA2.XNOR2(v); end for;
  end for;
end CD4P3JXC;


--
----- CU4 -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CU4 is
  generic (
    InstancePath  : String := "CU4");
  port (
    CI, PC0, PC1, PC2, PC3: in STD_LOGIC;
    CO, NC0, NC1, NC2, NC3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CU4 : entity is TRUE;
 
end CU4;

architecture V of CU4 is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal CII, I6, I18, I31: STD_LOGIC;
begin
  INST11: AND2 port map (A=>PC0, B=>CII, Z=>I6);
  INST13: XOR2 port map (A=>PC0, B=>CII, Z=>NC0);
  INST24: AND2 port map (A=>PC1, B=>I6, Z=>I18);
  INST26: XOR2 port map (A=>PC1, B=>I6, Z=>NC1);
  INST37: AND2 port map (A=>PC2, B=>I18, Z=>I31);
  INST39: XOR2 port map (A=>PC2, B=>I18, Z=>NC2);
  INST50: AND2 port map (A=>PC3, B=>I31, Z=>CO);
  INST52: XOR2 port map (A=>PC3, B=>I31, Z=>NC3);
  INST990: BUF port map (A=>CI, Z=>CII);
end V;

library ORCA2;
configuration CU4C of CU4 is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: XOR2 use entity ORCA2.XOR2(v); end for;
  end for;
end CU4C;


--
----- CU4P3BX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CU4P3BX is
  generic (
    InstancePath  : String := "CU4P3BX");
  port (
    CI, SP, CK, PD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CU4P3BX : entity is TRUE;
 
end CU4P3BX;

architecture V of CU4P3BX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3BX
    port (
      D, SP, CK, PD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component XOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I6, I7, I18, I19, I31, I32, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I6);
  INST13: XOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I18);
  INST26: XOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I31);
  INST39: XOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>CO);
  INST52: XOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3BX port map (D=>I7, SP=>SP, CK=>CK, PD=>PD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3BX port map (D=>I19, SP=>SP, CK=>CK, PD=>PD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3BX port map (D=>I32, SP=>SP, CK=>CK, PD=>PD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3BX port map (D=>I45, SP=>SP, CK=>CK, PD=>PD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CU4P3BXC of CU4P3BX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3BX use entity ORCA2.FD1P3BX(v); end for;
    for all: XOR2 use entity ORCA2.XOR2(v); end for;
  end for;
end CU4P3BXC;


--
----- CU4P3DX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CU4P3DX is
  generic (
    InstancePath  : String := "CU4P3DX");
  port (
    CI, SP, CK, CD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CU4P3DX : entity is TRUE;
 
end CU4P3DX;

architecture V of CU4P3DX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3DX
    port (
      D, SP, CK, CD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component XOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I6, I7, I18, I19, I31, I32, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I6);
  INST13: XOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I18);
  INST26: XOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I31);
  INST39: XOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>CO);
  INST52: XOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3DX port map (D=>I7, SP=>SP, CK=>CK, CD=>CD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3DX port map (D=>I19, SP=>SP, CK=>CK, CD=>CD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3DX port map (D=>I32, SP=>SP, CK=>CK, CD=>CD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3DX port map (D=>I45, SP=>SP, CK=>CK, CD=>CD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CU4P3DXC of CU4P3DX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3DX use entity ORCA2.FD1P3DX(v); end for;
    for all: XOR2 use entity ORCA2.XOR2(v); end for;
  end for;
end CU4P3DXC;


--
----- CU4P3IX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CU4P3IX is
  generic (
    InstancePath  : String := "CU4P3IX");
  port (
    CI, SP, CK, CD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CU4P3IX : entity is TRUE;
 
end CU4P3IX;

architecture V of CU4P3IX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3IZ
    port (
      D, SP, CK, CD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component XOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I6, I7, I18, I19, I31, I32, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I6);
  INST13: XOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I18);
  INST26: XOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I31);
  INST39: XOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>CO);
  INST52: XOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3IZ port map (D=>I7, SP=>SP, CK=>CK, CD=>CD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3IZ port map (D=>I19, SP=>SP, CK=>CK, CD=>CD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3IZ port map (D=>I32, SP=>SP, CK=>CK, CD=>CD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3IZ port map (D=>I45, SP=>SP, CK=>CK, CD=>CD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CU4P3IXC of CU4P3IX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3IZ use entity ORCA2.FD1P3IZ(v); end for;
    for all: XOR2 use entity ORCA2.XOR2(v); end for;
  end for;
end CU4P3IXC;


--
----- CU4P3JX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity CU4P3JX is
  generic (
    InstancePath  : String := "CU4P3JX");
  port (
    CI, SP, CK, PD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of CU4P3JX : entity is TRUE;
 
end CU4P3JX;

architecture V of CU4P3JX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3JZ
    port (
      D, SP, CK, PD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component XOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I6, I7, I18, I19, I31, I32, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I6);
  INST13: XOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I18);
  INST26: XOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I31);
  INST39: XOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>CO);
  INST52: XOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FD1P3JZ port map (D=>I7, SP=>SP, CK=>CK, PD=>PD, Q=>Q0_1, QN=>
    open);
  INST69: FD1P3JZ port map (D=>I19, SP=>SP, CK=>CK, PD=>PD, Q=>Q1_1, QN=>
    open);
  INST70: FD1P3JZ port map (D=>I32, SP=>SP, CK=>CK, PD=>PD, Q=>Q2_1, QN=>
    open);
  INST71: FD1P3JZ port map (D=>I45, SP=>SP, CK=>CK, PD=>PD, Q=>Q3_1, QN=>
    open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration CU4P3JXC of CU4P3JX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3JZ use entity ORCA2.FD1P3JZ(v); end for;
    for all: XOR2 use entity ORCA2.XOR2(v); end for;
  end for;
end CU4P3JXC;


--
----- LB4P3AX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity LB4P3AX is
  generic (
    InstancePath  : String := "LB4P3AX");
  port (
    D0, D1, D2, D3, CI, SP, CK, SD, CON: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of LB4P3AX : entity is TRUE;
 
end LB4P3AX;

architecture V of LB4P3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3AX
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component FL1P3AZ
    port (
      D0, D1, SP, CK, SD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component INV
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, CONN, I3, I4, I5, I6, I7, I17,
    I15, I16, I18, I19, I30, I28, I29, I31, I32, I43, I41, I42, I45,
    CONI: STD_LOGIC;
begin
  INST10: AND2 port map (A=>CII, B=>CONN, Z=>I3);
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
  INST13: XOR3 port map (A=>Q0_1, B=>CONN, C=>CII, Z=>I7);
  INST2: AND2 port map (A=>CONN, B=>Q0_1, Z=>I5);
  INST22: AND2 port map (A=>CONN, B=>Q1_1, Z=>I17);
  INST23: AND2 port map (A=>I6, B=>CONN, Z=>I15);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
  INST26: XOR3 port map (A=>Q1_1, B=>CONN, C=>I6, Z=>I19);
  INST35: AND2 port map (A=>CONN, B=>Q2_1, Z=>I30);
  INST36: AND2 port map (A=>I18, B=>CONN, Z=>I28);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
  INST39: XOR3 port map (A=>Q2_1, B=>CONN, C=>I18, Z=>I32);
  INST48: AND2 port map (A=>CONN, B=>Q3_1, Z=>I43);
  INST49: AND2 port map (A=>I31, B=>CONN, Z=>I41);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
  INST52: XOR3 port map (A=>Q3_1, B=>CONN, C=>I31, Z=>I45);
  INST96: INV port map (A=>CONI, Z=>CONN);
  INST68: FL1P3AZ port map (D0=>I7, D1=>D0, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q0_1, QN=>open);
  INST69: FL1P3AZ port map (D0=>I19, D1=>D1, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q1_1, QN=>open);
  INST70: FL1P3AZ port map (D0=>I32, D1=>D2, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q2_1, QN=>open);
  INST71: FL1P3AZ port map (D0=>I45, D1=>D3, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q3_1, QN=>open);
  INST990: BUF port map (A=>CI, Z=>CII);
  INST991: BUF port map (A=>CON, Z=>CONI);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration LB4P3AXC of LB4P3AX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3AX use entity ORCA2.FD1P3AX(v); end for;
    for all: FL1P3AZ use entity ORCA2.FL1P3AZ(v); end for;
    for all: INV use entity ORCA2.INV(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
  end for;
end LB4P3AXC;


--
----- LB4P3AY -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity LB4P3AY is
  generic (
    InstancePath  : String := "LB4P3AY");
  port (
    D0, D1, D2, D3, CI, SP, CK, SD, CON: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of LB4P3AY : entity is TRUE;
 
end LB4P3AY;

architecture V of LB4P3AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3AY
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component FL1P3AY
    port (
      D0, D1, SP, CK, SD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component INV
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XOR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, CONN, I3, I4, I5, I6, I7, I17,
    I15, I16, I18, I19, I30, I28, I29, I31, I32, I43, I41, I42, I45,
    CONI: STD_LOGIC;
begin
  INST10: AND2 port map (A=>CII, B=>CONN, Z=>I3);
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>I3, B=>I4, C=>I5, Z=>I6);
  INST13: XOR3 port map (A=>Q0_1, B=>CONN, C=>CII, Z=>I7);
  INST2: AND2 port map (A=>CONN, B=>Q0_1, Z=>I5);
  INST22: AND2 port map (A=>CONN, B=>Q1_1, Z=>I17);
  INST23: AND2 port map (A=>I6, B=>CONN, Z=>I15);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I15, B=>I16, C=>I17, Z=>I18);
  INST26: XOR3 port map (A=>Q1_1, B=>CONN, C=>I6, Z=>I19);
  INST35: AND2 port map (A=>CONN, B=>Q2_1, Z=>I30);
  INST36: AND2 port map (A=>I18, B=>CONN, Z=>I28);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I28, B=>I29, C=>I30, Z=>I31);
  INST39: XOR3 port map (A=>Q2_1, B=>CONN, C=>I18, Z=>I32);
  INST48: AND2 port map (A=>CONN, B=>Q3_1, Z=>I43);
  INST49: AND2 port map (A=>I31, B=>CONN, Z=>I41);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I41, B=>I42, C=>I43, Z=>CO);
  INST52: XOR3 port map (A=>Q3_1, B=>CONN, C=>I31, Z=>I45);
  INST96: INV port map (A=>CONI, Z=>CONN);
  INST68: FL1P3AY port map (D0=>I7, D1=>D0, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q0_1, QN=>open);
  INST69: FL1P3AY port map (D0=>I19, D1=>D1, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q1_1, QN=>open);
  INST70: FL1P3AY port map (D0=>I32, D1=>D2, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q2_1, QN=>open);
  INST71: FL1P3AY port map (D0=>I45, D1=>D3, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q3_1, QN=>open);
  INST990: BUF port map (A=>CI, Z=>CII);
  INST991: BUF port map (A=>CON, Z=>CONI);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration LB4P3AYC of LB4P3AY is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3AY use entity ORCA2.FD1P3AY(v); end for;
    for all: FL1P3AY use entity ORCA2.FL1P3AY(v); end for;
    for all: INV use entity ORCA2.INV(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XOR3 use entity ORCA2.XOR3(v); end for;
  end for;
end LB4P3AYC;


--
----- LD4P3AX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity LD4P3AX is
  generic (
    InstancePath  : String := "LD4P3AX");
  port (
    D0, D1, D2, D3, CI, SP, CK, SD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of LD4P3AX : entity is TRUE;
 
end LD4P3AX;

architecture V of LD4P3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3AX
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component FL1P3AZ
    port (
      D0, D1, SP, CK, SD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XNOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I4, I6, I7, I16, I18, I19, I29,
    I31, I32, I42, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>CII, B=>I4, C=>Q0_1, Z=>I6);
  INST13: XNOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I6, B=>I16, C=>Q1_1, Z=>I18);
  INST26: XNOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I18, B=>I29, C=>Q2_1, Z=>I31);
  INST39: XNOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I31, B=>I42, C=>Q3_1, Z=>CO);
  INST52: XNOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FL1P3AZ port map (D0=>I7, D1=>D0, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q0_1, QN=>open);
  INST69: FL1P3AZ port map (D0=>I19, D1=>D1, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q1_1, QN=>open);
  INST70: FL1P3AZ port map (D0=>I32, D1=>D2, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q2_1, QN=>open);
  INST71: FL1P3AZ port map (D0=>I45, D1=>D3, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q3_1, QN=>open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration LD4P3AXC of LD4P3AX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3AX use entity ORCA2.FD1P3AX(v); end for;
    for all: FL1P3AZ use entity ORCA2.FL1P3AZ(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XNOR2 use entity ORCA2.XNOR2(v); end for;
  end for;
end LD4P3AXC;


--
----- LD4P3AY -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity LD4P3AY is
  generic (
    InstancePath  : String := "LD4P3AY");
  port (
    D0, D1, D2, D3, CI, SP, CK, SD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of LD4P3AY : entity is TRUE;
 
end LD4P3AY;

architecture V of LD4P3AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3AY
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component FL1P3AY
    port (
      D0, D1, SP, CK, SD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component OR3
    port (
      A, B, C: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component XNOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I4, I6, I7, I16, I18, I19, I29,
    I31, I32, I42, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I4);
  INST12: OR3 port map (A=>CII, B=>I4, C=>Q0_1, Z=>I6);
  INST13: XNOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I16);
  INST25: OR3 port map (A=>I6, B=>I16, C=>Q1_1, Z=>I18);
  INST26: XNOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I29);
  INST38: OR3 port map (A=>I18, B=>I29, C=>Q2_1, Z=>I31);
  INST39: XNOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>I42);
  INST51: OR3 port map (A=>I31, B=>I42, C=>Q3_1, Z=>CO);
  INST52: XNOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FL1P3AY port map (D0=>I7, D1=>D0, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q0_1, QN=>open);
  INST69: FL1P3AY port map (D0=>I19, D1=>D1, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q1_1, QN=>open);
  INST70: FL1P3AY port map (D0=>I32, D1=>D2, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q2_1, QN=>open);
  INST71: FL1P3AY port map (D0=>I45, D1=>D3, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q3_1, QN=>open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration LD4P3AYC of LD4P3AY is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3AY use entity ORCA2.FD1P3AY(v); end for;
    for all: FL1P3AY use entity ORCA2.FL1P3AY(v); end for;
    for all: OR3 use entity ORCA2.OR3(v); end for;
    for all: XNOR2 use entity ORCA2.XNOR2(v); end for;
  end for;
end LD4P3AYC;
 

--
----- LU4P3AX -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity LU4P3AX is
  generic (
    InstancePath  : String := "LU4P3AX");
  port (
    D0, D1, D2, D3, CI, SP, CK, SD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of LU4P3AX : entity is TRUE;
 
end LU4P3AX;

architecture V of LU4P3AX is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3AX
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component FL1P3AZ
    port (
      D0, D1, SP, CK, SD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component XOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I6, I7, I18, I19, I31, I32, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I6);
  INST13: XOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I18);
  INST26: XOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I31);
  INST39: XOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>CO);
  INST52: XOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FL1P3AZ port map (D0=>I7, D1=>D0, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q0_1, QN=>open);
  INST69: FL1P3AZ port map (D0=>I19, D1=>D1, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q1_1, QN=>open);
  INST70: FL1P3AZ port map (D0=>I32, D1=>D2, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q2_1, QN=>open);
  INST71: FL1P3AZ port map (D0=>I45, D1=>D3, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q3_1, QN=>open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration LU4P3AXC of LU4P3AX is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3AX use entity ORCA2.FD1P3AX(v); end for;
    for all: FL1P3AZ use entity ORCA2.FL1P3AZ(v); end for;
    for all: XOR2 use entity ORCA2.XOR2(v); end for;
  end for;
end LU4P3AXC;


--
----- LU4P3AY -----
--
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;

entity LU4P3AY is
  generic (
    InstancePath  : String := "LU4P3AY");
  port (
    D0, D1, D2, D3, CI, SP, CK, SD: in STD_LOGIC;
    CO, Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of LU4P3AY : entity is TRUE;
 
end LU4P3AY;

architecture V of LU4P3AY is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;
  component AND2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component BUF
    port (
      A: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  component FD1P3AY
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component FL1P3AY
    port (
      D0, D1, SP, CK, SD: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  component XOR2
    port (
      A, B: in STD_LOGIC;
      Z: out STD_LOGIC);
  end component;
  signal Q0_1, Q1_1, Q2_1, Q3_1, CII, I6, I7, I18, I19, I31, I32, I45: STD_LOGIC;
begin
  INST11: AND2 port map (A=>Q0_1, B=>CII, Z=>I6);
  INST13: XOR2 port map (A=>Q0_1, B=>CII, Z=>I7);
  INST24: AND2 port map (A=>Q1_1, B=>I6, Z=>I18);
  INST26: XOR2 port map (A=>Q1_1, B=>I6, Z=>I19);
  INST37: AND2 port map (A=>Q2_1, B=>I18, Z=>I31);
  INST39: XOR2 port map (A=>Q2_1, B=>I18, Z=>I32);
  INST50: AND2 port map (A=>Q3_1, B=>I31, Z=>CO);
  INST52: XOR2 port map (A=>Q3_1, B=>I31, Z=>I45);
  INST68: FL1P3AY port map (D0=>I7, D1=>D0, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q0_1, QN=>open);
  INST69: FL1P3AY port map (D0=>I19, D1=>D1, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q1_1, QN=>open);
  INST70: FL1P3AY port map (D0=>I32, D1=>D2, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q2_1, QN=>open);
  INST71: FL1P3AY port map (D0=>I45, D1=>D3, SP=>SP, CK=>CK, SD=>SD, Q=>
    Q3_1, QN=>open);
  INST990: BUF port map (A=>CI, Z=>CII);
  Q0 <= Q0_1;
  Q1 <= Q1_1;
  Q2 <= Q2_1;
  Q3 <= Q3_1;
end V;

library ORCA2;
configuration LU4P3AYC of LU4P3AY is
  for V
    for all: AND2 use entity ORCA2.AND2(v); end for;
    for all: BUF use entity ORCA2.BUF(v); end for;
    for all: FD1P3AY use entity ORCA2.FD1P3AY(v); end for;
    for all: FL1P3AY use entity ORCA2.FL1P3AY(v); end for;
    for all: XOR2 use entity ORCA2.XOR2(v); end for;
  end for;
end LU4P3AYC;



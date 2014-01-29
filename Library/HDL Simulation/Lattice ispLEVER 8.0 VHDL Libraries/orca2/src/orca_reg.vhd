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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca2/src/RCS/ORCA_REG.vhd,v 1.3 2005/05/19 20:04:11 pradeep Exp $ 
--

--
----- CELL RD4P3A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4P3A is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4P3A";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4P3A : entity is TRUE;
 
end RD4P3A;

architecture V of RD4P3A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3AX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1P3AX 
	port map (D=>D0, SP=>SP, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1P3AX 
	port map (D=>D1, SP=>SP, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1P3AX 
	port map (D=>D2, SP=>SP, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1P3AX 
	port map (D=>D3, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4P3AC of RD4P3A is
  for V
    for all: FD1P3AX use entity ORCA2.FD1P3AX(v); end for;
  end for;
end RD4P3AC;


--
----- CELL RD4P3B -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4P3B is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4P3B";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, PD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4P3B : entity is TRUE;
 
end RD4P3B;

architecture V of RD4P3B is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3BX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_PD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1P3BX 
	port map (D=>D0, PD=>PD, SP=>SP, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1P3BX 
	port map (D=>D1, PD=>PD, SP=>SP, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1P3BX 
	port map (D=>D2, PD=>PD, SP=>SP, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1P3BX 
	port map (D=>D3, PD=>PD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4P3BC of RD4P3B is
  for V
    for all: FD1P3BX use entity ORCA2.FD1P3BX(v); end for;
  end for;
end RD4P3BC;


--
----- CELL RD4P3D -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4P3D is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4P3D";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, CD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4P3D : entity is TRUE;
 
end RD4P3D;

architecture V of RD4P3D is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3DX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1P3DX 
	port map (D=>D0, CD=>CD, SP=>SP, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1P3DX 
	port map (D=>D1, CD=>CD, SP=>SP, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1P3DX 
	port map (D=>D2, CD=>CD, SP=>SP, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1P3DX 
	port map (D=>D3, CD=>CD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4P3DC of RD4P3D is
  for V
    for all: FD1P3DX use entity ORCA2.FD1P3DX(v); end for;
  end for;
end RD4P3DC;


--
----- CELL RD4P3I -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4P3I is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4P3I";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_CD_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_CD     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, CD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4P3I : entity is TRUE;
 
end RD4P3I;

architecture V of RD4P3I is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3IZ
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_CD_CK : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_CD  : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1P3IZ 
	port map (D=>D0, CD=>CD, SP=>SP, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1P3IZ 
	port map (D=>D1, CD=>CD, SP=>SP, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1P3IZ 
	port map (D=>D2, CD=>CD, SP=>SP, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1P3IZ 
	port map (D=>D3, CD=>CD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4P3IC of RD4P3I is
  for V
    for all: FD1P3IZ use entity ORCA2.FD1P3IZ(v); end for;
  end for;
end RD4P3IC;


--
----- CELL RD4P3J -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4P3J is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4P3J";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_PD_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_PD     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, PD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4P3J : entity is TRUE;
 
end RD4P3J;

architecture V of RD4P3J is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3JZ
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_PD_CK : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_PD  : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1P3JZ 
	port map (D=>D0, PD=>PD, SP=>SP, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1P3JZ 
	port map (D=>D1, PD=>PD, SP=>SP, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1P3JZ 
	port map (D=>D2, PD=>PD, SP=>SP, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1P3JZ 
	port map (D=>D3, PD=>PD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4P3JC of RD4P3J is
  for V
    for all: FD1P3JZ use entity ORCA2.FD1P3JZ(v); end for;
  end for;
end RD4P3JC;


--
----- CELL RD4S3A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4S3A is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4S3A";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4S3A : entity is TRUE;
 
end RD4S3A;

architecture V of RD4S3A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3AX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1S3AX 
	port map (D=>D0, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1S3AX 
	port map (D=>D1, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1S3AX 
	port map (D=>D2, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1S3AX 
	port map (D=>D3, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4S3AC of RD4S3A is
  for V
    for all: FD1S3AX use entity ORCA2.FD1S3AX(v); end for;
  end for;
end RD4S3AC;


--
----- CELL RD4S3B -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4S3B is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4S3B";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, CK, PD: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4S3B : entity is TRUE;
 
end RD4S3B;

architecture V of RD4S3B is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3BX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_PD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1S3BX 
	port map (D=>D0, PD=>PD, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1S3BX 
	port map (D=>D1, PD=>PD, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1S3BX 
	port map (D=>D2, PD=>PD, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1S3BX 
	port map (D=>D3, PD=>PD, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4S3BC of RD4S3B is
  for V
    for all: FD1S3BX use entity ORCA2.FD1S3BX(v); end for;
  end for;
end RD4S3BC;


--
----- CELL RD4S3D -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4S3D is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4S3D";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, CK, CD: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4S3D : entity is TRUE;
 
end RD4S3D;

architecture V of RD4S3D is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3DX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1S3DX 
	port map (D=>D0, CD=>CD, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1S3DX 
	port map (D=>D1, CD=>CD, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1S3DX 
	port map (D=>D2, CD=>CD, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1S3DX 
	port map (D=>D3, CD=>CD, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4S3DC of RD4S3D is
  for V
    for all: FD1S3DX use entity ORCA2.FD1S3DX(v); end for;
  end for;
end RD4S3DC;


--
----- CELL RD4S3I -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4S3I is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4S3I";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_CD_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_CD     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, CK, CD: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4S3I : entity is TRUE;
 
end RD4S3I;

architecture V of RD4S3I is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3IX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_CD_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_CD  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1S3IX 
	port map (D=>D0, CD=>CD, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1S3IX 
	port map (D=>D1, CD=>CD, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1S3IX 
	port map (D=>D2, CD=>CD, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1S3IX 
	port map (D=>D3, CD=>CD, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4S3IC of RD4S3I is
  for V
    for all: FD1S3IX use entity ORCA2.FD1S3IX(v); end for;
  end for;
end RD4S3IC;


--
----- CELL RD4S3J -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RD4S3J is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RD4S3J";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_PD_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_PD     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D0, D1, D2, D3, CK, PD: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RD4S3J : entity is TRUE;
 
end RD4S3J;

architecture V of RD4S3J is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3JX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_PD_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_PD  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
begin
  INST1: FD1S3JX 
	port map (D=>D0, PD=>PD, CK=>CK, Q=>Q0, QN=>open);
  INST2: FD1S3JX 
	port map (D=>D1, PD=>PD, CK=>CK, Q=>Q1, QN=>open);
  INST3: FD1S3JX 
	port map (D=>D2, PD=>PD, CK=>CK, Q=>Q2, QN=>open);
  INST4: FD1S3JX 
	port map (D=>D3, PD=>PD, CK=>CK, Q=>Q3, QN=>open);
end V;

library ORCA2;
configuration RD4S3JC of RD4S3J is
  for V
    for all: FD1S3JX use entity ORCA2.FD1S3JX(v); end for;
  end for;
end RD4S3JC;


--
----- CELL RLS4P3A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RLS4P3A is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RLS4P3A";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D0_CK    : VitalDelayType := 0.1 ns;
        tsetup_D1_CK    : VitalDelayType := 0.1 ns;
        tsetup_D2_CK    : VitalDelayType := 0.1 ns;
        tsetup_D3_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D0     : VitalDelayType := 0.1 ns;
        thold_CK_D1     : VitalDelayType := 0.1 ns;
        thold_CK_D2     : VitalDelayType := 0.1 ns;
        thold_CK_D3     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D0         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D1         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D2         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_D3         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, D0, D1, D2, D3, SP, SD, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RLS4P3A : entity is TRUE;
 
end RLS4P3A;

architecture V of RLS4P3A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FL1P3AZ
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D0_CK : VitalDelayType := 0.1 ns;
      tsetup_D1_CK : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D0  : VitalDelayType := 0.1 ns;
      thold_CK_D1  : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_D1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D0, D1, SP, SD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FL1P3AZ 
	port map (D0=>D, D1=>D0, SP=>SP, SD=>SD, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FL1P3AZ 
	port map (D0=>Q0_tmp, D1=>D1, SP=>SP, SD=>SD, CK=>CK, Q=>Q1_tmp, 
		QN=>open);
  INST3: FL1P3AZ 
	port map (D0=>Q1_tmp, D1=>D2, SP=>SP, SD=>SD, CK=>CK, Q=>Q2_tmp, 
		QN=>open);
  INST4: FL1P3AZ 
	port map (D0=>Q2_tmp, D1=>D3, SP=>SP, SD=>SD, CK=>CK, Q=>Q3, QN=>open); 
	Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp;
end V;

library ORCA2;
configuration RLS4P3AC of RLS4P3A is
  for V
    for all: FL1P3AZ use entity ORCA2.FL1P3AZ(v); end for;
  end for;
end RLS4P3AC;


--
----- CELL RS4P3A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4P3A is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4P3A";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4P3A : entity is TRUE;
 
end RS4P3A;

architecture V of RS4P3A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3AX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1P3AX 
	port map (D=>D, SP=>SP, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1P3AX 
	port map (D=>Q0_tmp, SP=>SP, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1P3AX 
	port map (D=>Q1_tmp, SP=>SP, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1P3AX 
	port map (D=>Q2_tmp, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4P3AC of RS4P3A is
  for V
    for all: FD1P3AX use entity ORCA2.FD1P3AX(v); end for;
  end for;
end RS4P3AC;


--
----- CELL RS4P3B -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4P3B is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4P3B";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, PD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4P3B : entity is TRUE;
 
end RS4P3B;

architecture V of RS4P3B is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3BX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_PD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1P3BX 
	port map (D=>D, PD=>PD, SP=>SP, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1P3BX 
	port map (D=>Q0_tmp, PD=>PD, SP=>SP, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1P3BX 
	port map (D=>Q1_tmp, PD=>PD, SP=>SP, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1P3BX 
	port map (D=>Q2_tmp, PD=>PD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4P3BC of RS4P3B is
  for V
    for all: FD1P3BX use entity ORCA2.FD1P3BX(v); end for;
  end for;
end RS4P3BC;


--
----- CELL RS4P3D -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4P3D is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4P3D";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, CD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4P3D : entity is TRUE;
 
end RS4P3D;

architecture V of RS4P3D is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3DX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1P3DX 
	port map (D=>D, CD=>CD, SP=>SP, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1P3DX 
	port map (D=>Q0_tmp, CD=>CD, SP=>SP, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1P3DX 
	port map (D=>Q1_tmp, CD=>CD, SP=>SP, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1P3DX 
	port map (D=>Q2_tmp, CD=>CD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4P3DC of RS4P3D is
  for V
    for all: FD1P3DX use entity ORCA2.FD1P3DX(v); end for;
  end for;
end RS4P3DC;


--
----- CELL RS4P3I -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4P3I is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4P3I";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        tsetup_CD_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        thold_CK_CD     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, CD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4P3I : entity is TRUE;
 
end RS4P3I;

architecture V of RS4P3I is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3IZ
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_CD_CK : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_CD  : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1P3IZ 
	port map (D=>D, CD=>CD, SP=>SP, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1P3IZ 
	port map (D=>Q0_tmp, CD=>CD, SP=>SP, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1P3IZ 
	port map (D=>Q1_tmp, CD=>CD, SP=>SP, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1P3IZ 
	port map (D=>Q2_tmp, CD=>CD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4P3IC of RS4P3I is
  for V
    for all: FD1P3IZ use entity ORCA2.FD1P3IZ(v); end for;
  end for;
end RS4P3IC;


--
----- CELL RS4P3J -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4P3J is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4P3J";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_SP_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        tsetup_PD_CK    : VitalDelayType := 0.1 ns;
        tsetup_SP_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        thold_CK_PD     : VitalDelayType := 0.1 ns;
        thold_CK_SP     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_SP         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, PD, SP, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4P3J : entity is TRUE;
 
end RS4P3J;

architecture V of RS4P3J is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1P3JZ
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_SP_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_PD_CK : VitalDelayType := 0.1 ns;
      tsetup_SP_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_PD  : VitalDelayType := 0.1 ns;
      thold_CK_SP  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_SP      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, SP, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1P3JZ 
	port map (D=>D, PD=>PD, SP=>SP, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1P3JZ 
	port map (D=>Q0_tmp, PD=>PD, SP=>SP, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1P3JZ 
	port map (D=>Q1_tmp, PD=>PD, SP=>SP, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1P3JZ 
	port map (D=>Q2_tmp, PD=>PD, SP=>SP, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4P3JC of RS4P3J is
  for V
    for all: FD1P3JZ use entity ORCA2.FD1P3JZ(v); end for;
  end for;
end RS4P3JC;


--
----- CELL RS4S3A -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4S3A is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4S3A";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4S3A : entity is TRUE;
 
end RS4S3A;

architecture V of RS4S3A is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3AX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1S3AX 
	port map (D=>D, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1S3AX 
	port map (D=>Q0_tmp, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1S3AX 
	port map (D=>Q1_tmp, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1S3AX 
	port map (D=>Q2_tmp, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4S3AC of RS4S3A is
  for V
    for all: FD1S3AX use entity ORCA2.FD1S3AX(v); end for;
  end for;
end RS4S3AC;


--
----- CELL RS4S3B -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4S3B is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4S3B";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, PD, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4S3B : entity is TRUE;
 
end RS4S3B;

architecture V of RS4S3B is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3BX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_PD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1S3BX 
	port map (D=>D, PD=>PD, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1S3BX 
	port map (D=>Q0_tmp, PD=>PD, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1S3BX 
	port map (D=>Q1_tmp, PD=>PD, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1S3BX 
	port map (D=>Q2_tmp, PD=>PD, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4S3BC of RS4S3B is
  for V
    for all: FD1S3BX use entity ORCA2.FD1S3BX(v); end for;
  end for;
end RS4S3BC;


--
----- CELL RS4S3D -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4S3D is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4S3D";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CD_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, CD, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4S3D : entity is TRUE;
 
end RS4S3D;

architecture V of RS4S3D is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3DX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_CD_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1S3DX 
	port map (D=>D, CD=>CD, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1S3DX 
	port map (D=>Q0_tmp, CD=>CD, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1S3DX 
	port map (D=>Q1_tmp, CD=>CD, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1S3DX 
	port map (D=>Q2_tmp, CD=>CD, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4S3DC of RS4S3D is
  for V
    for all: FD1S3DX use entity ORCA2.FD1S3DX(v); end for;
  end for;
end RS4S3DC;


--
----- CELL RS4S3I -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4S3I is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4S3I";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        tsetup_CD_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        thold_CK_CD     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tipd_CD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, CD, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4S3I : entity is TRUE;
 
end RS4S3I;

architecture V of RS4S3I is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3IX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_CD_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_CD  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, CD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1S3IX 
	port map (D=>D, CD=>CD, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1S3IX 
	port map (D=>Q0_tmp, CD=>CD, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1S3IX 
	port map (D=>Q1_tmp, CD=>CD, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1S3IX 
	port map (D=>Q2_tmp, CD=>CD, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4S3IC of RS4S3I is
  for V
    for all: FD1S3IX use entity ORCA2.FD1S3IX(v); end for;
  end for;
end RS4S3IC;


--
----- CELL RS4S3J -----
--
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;
use IEEE.VITAL_Primitives.all;
library ORCA2 ;
use ORCA2.orcacomp.all ;

entity RS4S3J is
    generic (
	TimingChecksOn  : Boolean := FALSE;
        InstancePath    : String := "RS4S3J";
        -- Propagation Delays
        tpd_CK_Q0       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q1       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q2       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CK_Q3       : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Setup and Hold Constraints
        tsetup_D_CK     : VitalDelayType := 0.1 ns;
        tsetup_PD_CK    : VitalDelayType := 0.1 ns;
        thold_CK_D      : VitalDelayType := 0.1 ns;
        thold_CK_PD     : VitalDelayType := 0.1 ns;
        -- Input Signal Delays
        tipd_D          : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_CK         : VitalDelayType01 := (0.1 ns, 0.1 ns);
	tipd_PD         : VitalDelayType01 := (0.1 ns, 0.1 ns);
        -- Pulse Width Constraints
        tperiod_CK      : VitalDelayType := 0.1 ns;
        tpw_CK          : VitalDelayType := 0.1 ns);

    port (
	D, PD, CK: in STD_LOGIC;
	Q0, Q1, Q2, Q3: out STD_LOGIC);
 
    attribute VITAL_LEVEL0 of RS4S3J : entity is TRUE;
 
end RS4S3J;

architecture V of RS4S3J is
    attribute VITAL_LEVEL0 of V : architecture is TRUE;

  component FD1S3JX
    generic (
      tpd_CK_Q     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tsetup_D_CK  : VitalDelayType := 0.1 ns;
      tsetup_PD_CK : VitalDelayType := 0.1 ns;
      thold_CK_D   : VitalDelayType := 0.1 ns;
      thold_CK_PD  : VitalDelayType := 0.1 ns;
      tipd_D       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_PD      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_CK      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tperiod_CK   : VitalDelayType := 0.1 ns;
      tpw_CK       : VitalDelayType := 0.1 ns);
    port (
      D, PD, CK: in STD_LOGIC;
      Q, QN: out STD_LOGIC);
  end component;
  signal Q0_tmp, Q1_tmp, Q2_tmp: STD_LOGIC;
begin
  INST1: FD1S3JX 
	port map (D=>D, PD=>PD, CK=>CK, Q=>Q0_tmp, QN=>open);
  INST2: FD1S3JX 
	port map (D=>Q0_tmp, PD=>PD, CK=>CK, Q=>Q1_tmp, QN=>open);
  INST3: FD1S3JX 
	port map (D=>Q1_tmp, PD=>PD, CK=>CK, Q=>Q2_tmp, QN=>open);
  INST4: FD1S3JX 
	port map (D=>Q2_tmp, PD=>PD, CK=>CK, Q=>Q3, QN=>open);
  Q0 <= Q0_tmp;  Q1 <= Q1_tmp; Q2 <= Q2_tmp; 
end V;

library ORCA2;
configuration RS4S3JC of RS4S3J is
  for V
    for all: FD1S3JX use entity ORCA2.FD1S3JX(v); end for;
  end for;
end RS4S3JC;



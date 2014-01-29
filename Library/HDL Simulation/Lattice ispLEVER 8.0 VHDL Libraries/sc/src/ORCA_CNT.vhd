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
-- Simulation Library File for SC
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca5/src/RCS/ORCA_CNT.vhd,v 1.10 2005/06/22 20:22:45 pradeep Exp $ 
--
 
--
----- buf -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
 
-- entity declaration --
ENTITY buf IS
 
    PORT (
        a  : IN std_logic;
        z  : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF buf : ENTITY IS TRUE;
 
END buf ;
 
-- architecture body --
ARCHITECTURE v OF buf IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
 
BEGIN
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : process (a)
 
   BEGIN
 
   -----------------------------------
   -- functionality section.
   -----------------------------------
   z <= VitalBuf(a);
 
   END process;
 
END v;



--
----- cd2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY cd2 IS

  PORT (
    ci, pc0, pc1 : IN std_logic;
    co, nc0, nc1 : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cd2 : ENTITY IS TRUE;
 
END cd2;

ARCHITECTURE v OF cd2 IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL cii, i4, i6, i16, i18, i29, i31, i42: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>pc0, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>pc0, z=>i6);
  inst13: xnor2 PORT MAP (a=>pc0, b=>cii, z=>nc0);
  inst24: and2 PORT MAP (a=>pc1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>pc1, z=>co);
  inst26: xnor2 PORT MAP (a=>pc1, b=>i6, z=>nc1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
END v;

CONFIGURATION cd2c OF cd2 IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END cd2c;



--
----- cu2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY cu2 IS

  PORT (
    ci, pc0, pc1: IN std_logic;
    co, nc0, nc1: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cu2 : ENTITY IS TRUE;
 
END cu2;

ARCHITECTURE v OF cu2 IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL cii, i6, i18, i31: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>pc0, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>pc0, b=>cii, z=>nc0);
  inst24: and2 PORT MAP (a=>pc1, b=>i6, z=>co);
  inst26: xor2 PORT MAP (a=>pc1, b=>i6, z=>nc1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
END v;

CONFIGURATION cu2c OF cu2 IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END cu2c;


--
----- cb2 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
----LIBRARY work;
USE work.components.all;

ENTITY cb2 IS

  PORT (
    ci, pc0, pc1, con: IN std_logic;
    co, nc0, nc1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cb2 : ENTITY IS TRUE;

END cb2;

ARCHITECTURE v OF cb2 IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL cii, conn, i3, i4, i5, i6, i17, i15, i16, coni: std_logic;
 
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>pc0, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>pc0, b=>conn, c=>cii, z=>nc0);
  inst2: and2 PORT MAP (a=>conn, b=>pc0, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>pc1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>pc1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>co);
  inst26: xor3 PORT MAP (a=>pc1, b=>conn, c=>i6, z=>nc1);

  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
END v;

CONFIGURATION cb2c OF cb2 IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END cb2c;


--
----- cb4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
----LIBRARY work;
USE work.components.all;

ENTITY cb4 IS

  PORT (
    ci, pc0, pc1, pc2, pc3, con: IN std_logic;
    co, nc0, nc1, nc2, nc3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cb4 : ENTITY IS TRUE;

END cb4;

ARCHITECTURE v OF cb4 IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL cii, conn, i3, i4, i5, i6, i17, i15, i16, i18, i30, i28, i29,
    i31, i43, i41, i42, coni: std_logic;
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>pc0, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>pc0, b=>conn, c=>cii, z=>nc0);
  inst2: and2 PORT MAP (a=>conn, b=>pc0, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>pc1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>pc1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>i18);
  inst26: xor3 PORT MAP (a=>pc1, b=>conn, c=>i6, z=>nc1);
  inst35: and2 PORT MAP (a=>conn, b=>pc2, z=>i30);
  inst36: and2 PORT MAP (a=>i18, b=>conn, z=>i28);
  inst37: and2 PORT MAP (a=>pc2, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i28, b=>i29, c=>i30, z=>i31);
  inst39: xor3 PORT MAP (a=>pc2, b=>conn, c=>i18, z=>nc2);
  inst48: and2 PORT MAP (a=>conn, b=>pc3, z=>i43);
  inst49: and2 PORT MAP (a=>i31, b=>conn, z=>i41);
  inst50: and2 PORT MAP (a=>pc3, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i41, b=>i42, c=>i43, z=>co);
  inst52: xor3 PORT MAP (a=>pc3, b=>conn, c=>i31, z=>nc3);
  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
END v;

CONFIGURATION cb4c OF cb4 IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END cb4c;



--
----- lb2p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lb2p3ax IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, con: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb2p3ax : ENTITY IS TRUE;

END lb2p3ax;

ARCHITECTURE v OF lb2p3ax IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i19, coni: std_logic;

BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>co);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);

  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=> q0_1);
  inst69: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=> q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
END v;

CONFIGURATION lb2p3axc OF lb2p3ax IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3az USE ENTITY work.fl1p3az(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb2p3axc;


--
----- lb2p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lb2p3ay IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, con: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb2p3ay : ENTITY IS TRUE;

END lb2p3ay;

ARCHITECTURE v OF lb2p3ay IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i19, coni: std_logic;

BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>co);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);

  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=> q0_1);
  inst69: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=> q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
END v;

CONFIGURATION lb2p3ayc OF lb2p3ay IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3ay USE ENTITY work.fl1p3ay(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb2p3ayc;


--
----- lb2p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb2p3bx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, pd, con: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb2p3bx : ENTITY IS TRUE;

END lb2p3bx;

ARCHITECTURE v OF lb2p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3bx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i19, coni: std_logic;

BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>co);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);

  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lb2p3bxc OF lb2p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3bx USE ENTITY work.fl1p3bx(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb2p3bxc;


--
----- lb2p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb2p3dx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, cd, con: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb2p3dx : ENTITY IS TRUE;

END lb2p3dx;

ARCHITECTURE v OF lb2p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3dx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i19, coni: std_logic;

BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>co);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);

  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lb2p3dxc OF lb2p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3dx USE ENTITY work.fl1p3dx(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb2p3dxc;


--
----- lb2p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb2p3ix IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, cd, con: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb2p3ix : ENTITY IS TRUE;

END lb2p3ix;

ARCHITECTURE v OF lb2p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3iy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i19, coni: std_logic;

BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>co);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);

  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lb2p3ixc OF lb2p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3iy USE ENTITY work.fl1p3iy(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb2p3ixc;


--
----- lb2p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb2p3jx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, pd, con: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb2p3jx : ENTITY IS TRUE;

END lb2p3jx;

ARCHITECTURE v OF lb2p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3jy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i19, coni: std_logic;

BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>co);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);

  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lb2p3jxc OF lb2p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3jy USE ENTITY work.fl1p3jy(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb2p3jxc;



--
----- lb4p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lb4p3ax IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb4p3ax : ENTITY IS TRUE;

END lb4p3ax;

ARCHITECTURE v OF lb4p3ax IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i18, i19, i30, i28, i29, i31, i32, i43, i41, i42, i45,
    coni: std_logic;
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>i18);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);
  inst35: and2 PORT MAP (a=>conn, b=>q2_1, z=>i30);
  inst36: and2 PORT MAP (a=>i18, b=>conn, z=>i28);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i28, b=>i29, c=>i30, z=>i31);
  inst39: xor3 PORT MAP (a=>q2_1, b=>conn, c=>i18, z=>i32);
  inst48: and2 PORT MAP (a=>conn, b=>q3_1, z=>i43);
  inst49: and2 PORT MAP (a=>i31, b=>conn, z=>i41);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i41, b=>i42, c=>i43, z=>co);
  inst52: xor3 PORT MAP (a=>q3_1, b=>conn, c=>i31, z=>i45);
  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=> q0_1);
  inst69: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=> q1_1);
  inst70: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=> q2_1);
  inst71: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=> q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION lb4p3axc OF lb4p3ax IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3az USE ENTITY work.fl1p3az(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb4p3axc;


--
----- lb4p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lb4p3ay IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb4p3ay : ENTITY IS TRUE;

END lb4p3ay;

ARCHITECTURE v OF lb4p3ay IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i18, i19, i30, i28, i29, i31, i32, i43, i41, i42, i45,
    coni: std_logic;
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>i18);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);
  inst35: and2 PORT MAP (a=>conn, b=>q2_1, z=>i30);
  inst36: and2 PORT MAP (a=>i18, b=>conn, z=>i28);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i28, b=>i29, c=>i30, z=>i31);
  inst39: xor3 PORT MAP (a=>q2_1, b=>conn, c=>i18, z=>i32);
  inst48: and2 PORT MAP (a=>conn, b=>q3_1, z=>i43);
  inst49: and2 PORT MAP (a=>i31, b=>conn, z=>i41);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i41, b=>i42, c=>i43, z=>co);
  inst52: xor3 PORT MAP (a=>q3_1, b=>conn, c=>i31, z=>i45);
  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=> q0_1);
  inst69: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=> q1_1);
  inst70: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=> q2_1);
  inst71: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=> q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION lb4p3ayc OF lb4p3ay IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3ay USE ENTITY work.fl1p3ay(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb4p3ayc;


--
----- lb4p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb4p3bx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, pd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb4p3bx : ENTITY IS TRUE;

END lb4p3bx;

ARCHITECTURE v OF lb4p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3bx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i18, i19, i30, i28, i29, i31, i32, i43, i41, i42, i45,
    coni: std_logic;
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>i18);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);
  inst35: and2 PORT MAP (a=>conn, b=>q2_1, z=>i30);
  inst36: and2 PORT MAP (a=>i18, b=>conn, z=>i28);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i28, b=>i29, c=>i30, z=>i31);
  inst39: xor3 PORT MAP (a=>q2_1, b=>conn, c=>i18, z=>i32);
  inst48: and2 PORT MAP (a=>conn, b=>q3_1, z=>i43);
  inst49: and2 PORT MAP (a=>i31, b=>conn, z=>i41);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i41, b=>i42, c=>i43, z=>co);
  inst52: xor3 PORT MAP (a=>q3_1, b=>conn, c=>i31, z=>i45);
  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst70: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1);
  inst71: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lb4p3bxc OF lb4p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3bx USE ENTITY work.fl1p3bx(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb4p3bxc;


--
----- lb4p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb4p3dx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, cd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb4p3dx : ENTITY IS TRUE;

END lb4p3dx;

ARCHITECTURE v OF lb4p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3dx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i18, i19, i30, i28, i29, i31, i32, i43, i41, i42, i45,
    coni: std_logic;
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>i18);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);
  inst35: and2 PORT MAP (a=>conn, b=>q2_1, z=>i30);
  inst36: and2 PORT MAP (a=>i18, b=>conn, z=>i28);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i28, b=>i29, c=>i30, z=>i31);
  inst39: xor3 PORT MAP (a=>q2_1, b=>conn, c=>i18, z=>i32);
  inst48: and2 PORT MAP (a=>conn, b=>q3_1, z=>i43);
  inst49: and2 PORT MAP (a=>i31, b=>conn, z=>i41);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i41, b=>i42, c=>i43, z=>co);
  inst52: xor3 PORT MAP (a=>q3_1, b=>conn, c=>i31, z=>i45);
  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst70: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1);
  inst71: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lb4p3dxc OF lb4p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3dx USE ENTITY work.fl1p3dx(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb4p3dxc;


--
----- lb4p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb4p3ix IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, cd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb4p3ix : ENTITY IS TRUE;

END lb4p3ix;

ARCHITECTURE v OF lb4p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3iy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i18, i19, i30, i28, i29, i31, i32, i43, i41, i42, i45,
    coni: std_logic;
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>i18);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);
  inst35: and2 PORT MAP (a=>conn, b=>q2_1, z=>i30);
  inst36: and2 PORT MAP (a=>i18, b=>conn, z=>i28);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i28, b=>i29, c=>i30, z=>i31);
  inst39: xor3 PORT MAP (a=>q2_1, b=>conn, c=>i18, z=>i32);
  inst48: and2 PORT MAP (a=>conn, b=>q3_1, z=>i43);
  inst49: and2 PORT MAP (a=>i31, b=>conn, z=>i41);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i41, b=>i42, c=>i43, z=>co);
  inst52: xor3 PORT MAP (a=>q3_1, b=>conn, c=>i31, z=>i45);
  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst70: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1);
  inst71: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lb4p3ixc OF lb4p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3iy USE ENTITY work.fl1p3iy(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb4p3ixc;


--
----- lb4p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lb4p3jx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, pd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb4p3jx : ENTITY IS TRUE;

END lb4p3jx;

ARCHITECTURE v OF lb4p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3jy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT inv
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xor3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, conn, i3, i4, i5, i6, i7, i17,
    i15, i16, i18, i19, i30, i28, i29, i31, i32, i43, i41, i42, i45,
    coni: std_logic;
BEGIN
  inst10: and2 PORT MAP (a=>cii, b=>conn, z=>i3);
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>i3, b=>i4, c=>i5, z=>i6);
  inst13: xor3 PORT MAP (a=>q0_1, b=>conn, c=>cii, z=>i7);
  inst2: and2 PORT MAP (a=>conn, b=>q0_1, z=>i5);
  inst22: and2 PORT MAP (a=>conn, b=>q1_1, z=>i17);
  inst23: and2 PORT MAP (a=>i6, b=>conn, z=>i15);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i15, b=>i16, c=>i17, z=>i18);
  inst26: xor3 PORT MAP (a=>q1_1, b=>conn, c=>i6, z=>i19);
  inst35: and2 PORT MAP (a=>conn, b=>q2_1, z=>i30);
  inst36: and2 PORT MAP (a=>i18, b=>conn, z=>i28);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i28, b=>i29, c=>i30, z=>i31);
  inst39: xor3 PORT MAP (a=>q2_1, b=>conn, c=>i18, z=>i32);
  inst48: and2 PORT MAP (a=>conn, b=>q3_1, z=>i43);
  inst49: and2 PORT MAP (a=>i31, b=>conn, z=>i41);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i41, b=>i42, c=>i43, z=>co);
  inst52: xor3 PORT MAP (a=>q3_1, b=>conn, c=>i31, z=>i45);
  inst96: inv PORT MAP (a=>coni, z=>conn);
  inst68: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst70: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1);
  inst71: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lb4p3jxc OF lb4p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3jy USE ENTITY work.fl1p3jy(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END lb4p3jxc;




--
----- ld2p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY ld2p3ax IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld2p3ax : ENTITY IS TRUE;

END ld2p3ax;

ARCHITECTURE v OF ld2p3ax IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i4, i6, i7, i16, i19 : std_logic;

BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>co);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;

CONFIGURATION ld2p3axc OF ld2p3ax IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3az USE ENTITY work.fl1p3az(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld2p3axc;


--
----- ld2p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY ld2p3ay IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld2p3ay : ENTITY IS TRUE;

END ld2p3ay;

ARCHITECTURE v OF ld2p3ay IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i4, i6, i7, i16, i19 : std_logic;

BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>co);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;

CONFIGURATION ld2p3ayc OF ld2p3ay IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3ay USE ENTITY work.fl1p3ay(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld2p3ayc;


--
----- ld2p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld2p3bx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld2p3bx : ENTITY IS TRUE;

END ld2p3bx;

ARCHITECTURE v OF ld2p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3bx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i4, i6, i7, i16, i19 : std_logic;

BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>co);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION ld2p3bxc OF ld2p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3bx USE ENTITY work.fl1p3bx(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld2p3bxc;


--
----- ld2p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld2p3dx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld2p3dx : ENTITY IS TRUE;

END ld2p3dx;

ARCHITECTURE v OF ld2p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3dx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i4, i6, i7, i16, i19 : std_logic;

BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>co);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION ld2p3dxc OF ld2p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3dx USE ENTITY work.fl1p3dx(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld2p3dxc;


--
----- ld2p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld2p3ix IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld2p3ix : ENTITY IS TRUE;

END ld2p3ix;

ARCHITECTURE v OF ld2p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3iy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i4, i6, i7, i16, i19 : std_logic;

BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>co);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION ld2p3ixc OF ld2p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3iy USE ENTITY work.fl1p3iy(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld2p3ixc;


--
----- ld2p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld2p3jx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld2p3jx : ENTITY IS TRUE;

END ld2p3jx;

ARCHITECTURE v OF ld2p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3jy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i4, i6, i7, i16, i19 : std_logic;

BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>co);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION ld2p3jxc OF ld2p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3jy USE ENTITY work.fl1p3jy(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld2p3jxc;


--
----- ld4p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY ld4p3ax IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld4p3ax : ENTITY IS TRUE;

END ld4p3ax;

ARCHITECTURE v OF ld4p3ax IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i4, i6, i7, i16, i18, i19, i29,
    i31, i32, i42, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>i18);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i18, b=>i29, c=>q2_1, z=>i31);
  inst39: xnor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i31, b=>i42, c=>q3_1, z=>co);
  inst52: xnor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst70: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1);
  inst71: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION ld4p3axc OF ld4p3ax IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3az USE ENTITY work.fl1p3az(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld4p3axc;


--
----- ld4p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY ld4p3ay IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld4p3ay : ENTITY IS TRUE;

END ld4p3ay;

ARCHITECTURE v OF ld4p3ay IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i4, i6, i7, i16, i18, i19, i29,
    i31, i32, i42, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>i18);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i18, b=>i29, c=>q2_1, z=>i31);
  inst39: xnor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i31, b=>i42, c=>q3_1, z=>co);
  inst52: xnor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst70: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1);
  inst71: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION ld4p3ayc OF ld4p3ay IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3ay USE ENTITY work.fl1p3ay(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld4p3ayc;


--
----- ld4p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld4p3bx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld4p3bx : ENTITY IS TRUE;

END ld4p3bx;

ARCHITECTURE v OF ld4p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3bx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i4, i6, i7, i16, i18, i19, i29,
    i31, i32, i42, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>i18);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i18, b=>i29, c=>q2_1, z=>i31);
  inst39: xnor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i31, b=>i42, c=>q3_1, z=>co);
  inst52: xnor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst70: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1);
  inst71: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION ld4p3bxc OF ld4p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3bx USE ENTITY work.fl1p3bx(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld4p3bxc;


--
----- ld4p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld4p3dx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld4p3dx : ENTITY IS TRUE;

END ld4p3dx;

ARCHITECTURE v OF ld4p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3dx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i4, i6, i7, i16, i18, i19, i29,
    i31, i32, i42, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>i18);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i18, b=>i29, c=>q2_1, z=>i31);
  inst39: xnor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i31, b=>i42, c=>q3_1, z=>co);
  inst52: xnor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst70: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1);
  inst71: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION ld4p3dxc OF ld4p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3dx USE ENTITY work.fl1p3dx(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld4p3dxc;


--
----- ld4p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld4p3ix IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld4p3ix : ENTITY IS TRUE;

END ld4p3ix;

ARCHITECTURE v OF ld4p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3iy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i4, i6, i7, i16, i18, i19, i29,
    i31, i32, i42, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>i18);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i18, b=>i29, c=>q2_1, z=>i31);
  inst39: xnor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i31, b=>i42, c=>q3_1, z=>co);
  inst52: xnor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst70: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1);
  inst71: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION ld4p3ixc OF ld4p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3iy USE ENTITY work.fl1p3iy(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld4p3ixc;


--
----- ld4p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY ld4p3jx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld4p3jx : ENTITY IS TRUE;

END ld4p3jx;

ARCHITECTURE v OF ld4p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3jy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT or3
    PORT (
      a, b, c: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT xnor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i4, i6, i7, i16, i18, i19, i29,
    i31, i32, i42, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i4);
  inst12: or3 PORT MAP (a=>cii, b=>i4, c=>q0_1, z=>i6);
  inst13: xnor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i16);
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>q1_1, z=>i18);
  inst26: xnor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i18, b=>i29, c=>q2_1, z=>i31);
  inst39: xnor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i31, b=>i42, c=>q3_1, z=>co);
  inst52: xnor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst70: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1);
  inst71: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION ld4p3jxc OF ld4p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3jy USE ENTITY work.fl1p3jy(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END ld4p3jxc;




--
----- lu2p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lu2p3ax IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu2p3ax : ENTITY IS TRUE;

END lu2p3ax;

ARCHITECTURE v OF lu2p3ax IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i6, i7, i19 : std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>co);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;

CONFIGURATION lu2p3axc OF lu2p3ax IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3az USE ENTITY work.fl1p3az(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu2p3axc;


--
----- lu2p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lu2p3ay IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu2p3ay : ENTITY IS TRUE;

END lu2p3ay;

ARCHITECTURE v OF lu2p3ay IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i6, i7, i19: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>co);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;

CONFIGURATION lu2p3ayc OF lu2p3ay IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3ay USE ENTITY work.fl1p3ay(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu2p3ayc;


--
----- lu2p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu2p3bx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu2p3bx : ENTITY IS TRUE;

END lu2p3bx;

ARCHITECTURE v OF lu2p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3bx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i6, i7, i19: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>co);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);

  inst68: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lu2p3bxc OF lu2p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3bx USE ENTITY work.fl1p3bx(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu2p3bxc;


--
----- lu2p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu2p3dx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu2p3dx : ENTITY IS TRUE;

END lu2p3dx;

ARCHITECTURE v OF lu2p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3dx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i6, i7, i19: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>co);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst68: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lu2p3dxc OF lu2p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3dx USE ENTITY work.fl1p3dx(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu2p3dxc;


--
----- lu2p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu2p3ix IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu2p3ix : ENTITY IS TRUE;

END lu2p3ix;

ARCHITECTURE v OF lu2p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3iy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i6, i7, i19: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>co);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst68: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lu2p3ixc OF lu2p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3iy USE ENTITY work.fl1p3iy(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu2p3ixc;


--
----- lu2p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu2p3jx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu2p3jx : ENTITY IS TRUE;

END lu2p3jx;

ARCHITECTURE v OF lu2p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3jy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, cii, i6, i7, i19: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>co);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst68: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
END v;


CONFIGURATION lu2p3jxc OF lu2p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3jy USE ENTITY work.fl1p3jy(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu2p3jxc;


--
----- lu4p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lu4p3ax IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu4p3ax : ENTITY IS TRUE;

END lu4p3ax;

ARCHITECTURE v OF lu4p3ax IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i6, i7, i18, i19, i31, i32, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i18);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i31);
  inst39: xor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>co);
  inst52: xor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst70: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1);
  inst71: fl1p3az generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION lu4p3axc OF lu4p3ax IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3az USE ENTITY work.fl1p3az(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu4p3axc;


--
----- lu4p3ay -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;

ENTITY lu4p3ay IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu4p3ay : ENTITY IS TRUE;

END lu4p3ay;

ARCHITECTURE v OF lu4p3ay IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i6, i7, i18, i19, i31, i32, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i18);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i31);
  inst39: xor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>co);
  inst52: xor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1);
  inst69: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1);
  inst70: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1);
  inst71: fl1p3ay generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION lu4p3ayc OF lu4p3ay IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3ay USE ENTITY work.fl1p3ay(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu4p3ayc;


--
----- lu4p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu4p3bx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu4p3bx : ENTITY IS TRUE;

END lu4p3bx;

ARCHITECTURE v OF lu4p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3bx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i6, i7, i18, i19, i31, i32, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i18);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i31);
  inst39: xor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>co);
  inst52: xor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst70: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1);
  inst71: fl1p3bx generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lu4p3bxc OF lu4p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3bx USE ENTITY work.fl1p3bx(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu4p3bxc;


--
----- lu4p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu4p3dx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu4p3dx : ENTITY IS TRUE;

END lu4p3dx;

ARCHITECTURE v OF lu4p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3dx
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i6, i7, i18, i19, i31, i32, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i18);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i31);
  inst39: xor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>co);
  inst52: xor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst70: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1);
  inst71: fl1p3dx generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lu4p3dxc OF lu4p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3dx USE ENTITY work.fl1p3dx(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu4p3dxc;


--
----- lu4p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu4p3ix IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu4p3ix : ENTITY IS TRUE;

END lu4p3ix;

ARCHITECTURE v OF lu4p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3iy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i6, i7, i18, i19, i31, i32, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i18);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i31);
  inst39: xor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>co);
  inst52: xor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1);
  inst69: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1);
  inst70: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1);
  inst71: fl1p3iy generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lu4p3ixc OF lu4p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3iy USE ENTITY work.fl1p3iy(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu4p3ixc;


--
----- lu4p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.components.all;
ENTITY lu4p3jx IS
  GENERIC (
    gsr  : String := "ENABLED");

  PORT (
    d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu4p3jx : ENTITY IS TRUE;

END lu4p3jx;

ARCHITECTURE v OF lu4p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT and2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT buf
    PORT (
      a: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3jy
    generic (gsr  : String := "ENABLED");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q: OUT std_logic);
  END COMPONENT;
  COMPONENT xor2
    PORT (
      a, b: IN std_logic;
      z: OUT std_logic);
  END COMPONENT;
  SIGNAL q0_1, q1_1, q2_1, q3_1, cii, i6, i7, i18, i19, i31, i32, i45: std_logic;
BEGIN
  inst11: and2 PORT MAP (a=>q0_1, b=>cii, z=>i6);
  inst13: xor2 PORT MAP (a=>q0_1, b=>cii, z=>i7);
  inst24: and2 PORT MAP (a=>q1_1, b=>i6, z=>i18);
  inst26: xor2 PORT MAP (a=>q1_1, b=>i6, z=>i19);
  inst37: and2 PORT MAP (a=>q2_1, b=>i18, z=>i31);
  inst39: xor2 PORT MAP (a=>q2_1, b=>i18, z=>i32);
  inst50: and2 PORT MAP (a=>q3_1, b=>i31, z=>co);
  inst52: xor2 PORT MAP (a=>q3_1, b=>i31, z=>i45);
  inst68: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1);
  inst69: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1);
  inst70: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1);
  inst71: fl1p3jy generic map (gsr => gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;


CONFIGURATION lu4p3jxc OF lu4p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fl1p3jy USE ENTITY work.fl1p3jy(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END lu4p3jxc;




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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCA_CNT.vhd,v 1.12 2005/05/19 20:04:54 pradeep Exp $ 
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
    GENERIC (
        TimingChecksOn  : boolean := FALSE;
        XOn             : boolean := FALSE;
	MsgOn           : boolean := FALSE;
        InstancePath    : string  := "buf";
        tpd_a_z		: VitalDelayType01 := (0.1 ns, 0.1 ns);
        tipd_a		: VitalDelayType01 := (0.0 ns, 0.0 ns)) ;
 
    PORT (
        a  : IN std_logic;
        z  : OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF buf : ENTITY IS TRUE;
 
END buf ;
 
-- architecture body --
ARCHITECTURE v OF buf IS
    ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
    SIGNAL a_ipd  : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(a_ipd, a, tipd_a);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : process (a_ipd)
 
   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS z_zd       : std_ulogic IS results(1);
 
   -- output glitch detection VARIABLEs
   VARIABLE z_GlitchData     : VitalGlitchDatatype;
 
   BEGIN
 
   IF (TimingChecksOn) THEN
    -----------------------------------
    -- no timing checks for a comb gate
    -----------------------------------
   END IF;
 
   -----------------------------------
   -- functionality section.
   -----------------------------------
   z_zd := VitalBuf(a_ipd);
 
   -----------------------------------
   -- path delay section.
   -----------------------------------
   VitalPathDelay01 (
     OutSignal => z,
     OutSignalName => "z",
     OutTemp => z_zd,
     Paths => (0 => (InputChangeTime => a_ipd'last_event, 
		     PathDelay => tpd_a_z, 
		     PathCondition => TRUE)),
     GlitchData => z_GlitchData,
     Mode => OnDetect, XOn => XOn, MsgOn => MsgOn);
 
   END process;
 
END v;


--
----- cb4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
----LIBRARY work;
USE work.orcacomp.all;

ENTITY cb4 IS
  GENERIC (
    InstancePath  : string := "cb4");
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
----- cb4p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cb4p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cb4p3bx");
  PORT (
    ci, sp, ck, pd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cb4p3bx : ENTITY IS TRUE;
 
END cb4p3bx;

ARCHITECTURE v OF cb4p3bx IS
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
  COMPONENT fd1p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, pd=>pd, q=>q0_1, qn=>open);
  inst69: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, pd=>pd, q=>q1_1, qn=>open);
  inst70: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, pd=>pd, q=>q2_1, qn=>open);
  inst71: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, pd=>pd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cb4p3bxc OF cb4p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3bx USE ENTITY work.fd1p3bx(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END cb4p3bxc;


--
----- cb4p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cb4p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cb4p3dx");
  PORT (
    ci, sp, ck, cd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cb4p3dx : ENTITY IS TRUE;
 
END cb4p3dx;

ARCHITECTURE v OF cb4p3dx IS
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
  COMPONENT fd1p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3dx generic map (disabled_gsr => disabled_gsr) 
          PORT MAP (d=>i7, sp=>sp, ck=>ck, cd=>cd, q=>q0_1, qn=>open);
  inst69: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, cd=>cd, q=>q1_1, qn=>open);
  inst70: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, cd=>cd, q=>q2_1, qn=>open);
  inst71: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, cd=>cd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cb4p3dxc OF cb4p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3dx USE ENTITY work.fd1p3dx(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END cb4p3dxc;


--
----- cb4p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cb4p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cb4p3ix");
  PORT (
    ci, sp, ck, cd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cb4p3ix : ENTITY IS TRUE;
 
END cb4p3ix;

ARCHITECTURE v OF cb4p3ix IS
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
  COMPONENT fd1p3iz
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, cd=>cd, q=>q0_1, qn=>open);
  inst69: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, cd=>cd, q=>q1_1, qn=>open);
  inst70: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, cd=>cd, q=>q2_1, qn=>open);
  inst71: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, cd=>cd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cb4p3ixc OF cb4p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3iz USE ENTITY work.fd1p3iz(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END cb4p3ixc;


--
----- cb4p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cb4p3jx IS
  GENERIC (
    disabled_gsr  : string := "0";

    InstancePath  : string := "cb4p3jx");
  PORT (
    ci, sp, ck, pd, con: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cb4p3jx : ENTITY IS TRUE;
 
END cb4p3jx;

ARCHITECTURE v OF cb4p3jx IS
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
  COMPONENT fd1p3jz
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, pd=>pd, q=>q0_1, qn=>open);
  inst69: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, pd=>pd, q=>q1_1, qn=>open);
  inst70: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, pd=>pd, q=>q2_1, qn=>open);
  inst71: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, pd=>pd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  inst991: buf PORT MAP (a=>con, z=>coni);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cb4p3jxc OF cb4p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3jz USE ENTITY work.fd1p3jz(v); END FOR;
    FOR ALL: inv USE ENTITY work.inv(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xor3 USE ENTITY work.xor3(v); END FOR;
  END FOR;
END cb4p3jxc;


--
----- cb8p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cb8p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cb8p3bx");
  PORT (
    ci, sp, ck, pd, con: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cb8p3bx : ENTITY IS TRUE;

END cb8p3bx;

ARCHITECTURE v OF cb8p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cb4p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, pd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cb4p3bx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, pd=>pd, con=>con, co=>
         co_int, q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cb4p3bx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, pd=>pd, con=>
         con, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cb8p3bxc OF cb8p3bx IS
  FOR v
    FOR ALL: cb4p3bx USE ENTITY work.cb4p3bx(v); END FOR;
  END FOR;
END cb8p3bxc;


--
----- cb8p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cb8p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cb8p3dx");
  PORT (
    ci, sp, ck, cd, con: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cb8p3dx : ENTITY IS TRUE;

END cb8p3dx;

ARCHITECTURE v OF cb8p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cb4p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, cd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cb4p3dx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, cd=>cd, con=>con, co=>
         co_int, q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cb4p3dx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, cd=>cd, con=>
         con, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cb8p3dxc OF cb8p3dx IS
  FOR v
    FOR ALL: cb4p3dx USE ENTITY work.cb4p3dx(v); END FOR;
  END FOR;
END cb8p3dxc;


--
----- cb8p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cb8p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cb8p3ix");
  PORT (
    ci, sp, ck, cd, con: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cb8p3ix : ENTITY IS TRUE;

END cb8p3ix;

ARCHITECTURE v OF cb8p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cb4p3ix
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, cd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cb4p3ix generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, cd=>cd, con=>con, co=>
         co_int, q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cb4p3ix generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, cd=>cd, con=>
         con, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cb8p3ixc OF cb8p3ix IS
  FOR v
    FOR ALL: cb4p3ix USE ENTITY work.cb4p3ix(v); END FOR;
  END FOR;
END cb8p3ixc;


--
----- cb8p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cb8p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cb8p3jx");
  PORT (
    ci, sp, ck, pd, con: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cb8p3jx : ENTITY IS TRUE;

END cb8p3jx;

ARCHITECTURE v OF cb8p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cb4p3jx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, pd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cb4p3jx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, pd=>pd, con=>con, co=>
         co_int, q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cb4p3jx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, pd=>pd, con=>
         con, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cb8p3jxc OF cb8p3jx IS
  FOR v
    FOR ALL: cb4p3jx USE ENTITY work.cb4p3jx(v); END FOR;
  END FOR;
END cb8p3jxc;


--
----- cd4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cd4 IS
  GENERIC (
    InstancePath  : string := "cd4");
  PORT (
    ci, pc0, pc1, pc2, pc3: IN std_logic;
    co, nc0, nc1, nc2, nc3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cd4 : ENTITY IS TRUE;
 
END cd4;

ARCHITECTURE v OF cd4 IS
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
  inst25: or3 PORT MAP (a=>i6, b=>i16, c=>pc1, z=>i18);
  inst26: xnor2 PORT MAP (a=>pc1, b=>i6, z=>nc1);
  inst37: and2 PORT MAP (a=>pc2, b=>i18, z=>i29);
  inst38: or3 PORT MAP (a=>i18, b=>i29, c=>pc2, z=>i31);
  inst39: xnor2 PORT MAP (a=>pc2, b=>i18, z=>nc2);
  inst50: and2 PORT MAP (a=>pc3, b=>i31, z=>i42);
  inst51: or3 PORT MAP (a=>i31, b=>i42, c=>pc3, z=>co);
  inst52: xnor2 PORT MAP (a=>pc3, b=>i31, z=>nc3);
  inst990: buf PORT MAP (a=>ci, z=>cii);
END v;

CONFIGURATION cd4c OF cd4 IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END cd4c;


--
----- cd4p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cd4p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd4p3bx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cd4p3bx : ENTITY IS TRUE;
 
END cd4p3bx;

ARCHITECTURE v OF cd4p3bx IS
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
  COMPONENT fd1p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, pd=>pd, q=>q0_1, qn=>open);
  inst69: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, pd=>pd, q=>q1_1, qn=>open);
  inst70: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, pd=>pd, q=>q2_1, qn=>open);
  inst71: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, pd=>pd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cd4p3bxc OF cd4p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3bx USE ENTITY work.fd1p3bx(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END cd4p3bxc;


--
----- cd4p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cd4p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd4p3dx");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cd4p3dx : ENTITY IS TRUE;
 
END cd4p3dx;

ARCHITECTURE v OF cd4p3dx IS
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
  COMPONENT fd1p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, cd=>cd, q=>q0_1, qn=>open);
  inst69: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, cd=>cd, q=>q1_1, qn=>open);
  inst70: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, cd=>cd, q=>q2_1, qn=>open);
  inst71: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, cd=>cd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cd4p3dxc OF cd4p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3dx USE ENTITY work.fd1p3dx(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END cd4p3dxc;


--
----- cd4p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cd4p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd4p3ix");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cd4p3ix : ENTITY IS TRUE;
 
END cd4p3ix;

ARCHITECTURE v OF cd4p3ix IS
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
  COMPONENT fd1p3iz
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, cd=>cd, q=>q0_1, qn=>open);
  inst69: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, cd=>cd, q=>q1_1, qn=>open);
  inst70: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, cd=>cd, q=>q2_1, qn=>open);
  inst71: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, cd=>cd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cd4p3ixc OF cd4p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3iz USE ENTITY work.fd1p3iz(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END cd4p3ixc;


--
----- cd4p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cd4p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd4p3jx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cd4p3jx : ENTITY IS TRUE;
 
END cd4p3jx;

ARCHITECTURE v OF cd4p3jx IS
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
  COMPONENT fd1p3jz
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, pd=>pd, q=>q0_1, qn=>open);
  inst69: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, pd=>pd, q=>q1_1, qn=>open);
  inst70: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, pd=>pd, q=>q2_1, qn=>open);
  inst71: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, pd=>pd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cd4p3jxc OF cd4p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3jz USE ENTITY work.fd1p3jz(v); END FOR;
    FOR ALL: or3 USE ENTITY work.or3(v); END FOR;
    FOR ALL: xnor2 USE ENTITY work.xnor2(v); END FOR;
  END FOR;
END cd4p3jxc;


--
----- cd8p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cd8p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd8p3bx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cd8p3bx : ENTITY IS TRUE;

END cd8p3bx;

ARCHITECTURE v OF cd8p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cd4p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cd4p3bx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, pd=>pd, co=>co_int,
         q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cd4p3bx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, pd=>pd, co=>co,
         q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cd8p3bxc OF cd8p3bx IS
  FOR v
    FOR ALL: cd4p3bx USE ENTITY work.cd4p3bx(v); END FOR;
  END FOR;
END cd8p3bxc;


--
----- cd8p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cd8p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd8p3dx");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cd8p3dx : ENTITY IS TRUE;

END cd8p3dx;

ARCHITECTURE v OF cd8p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cd4p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cd4p3dx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, cd=>cd, co=>co_int,
         q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cd4p3dx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, cd=>cd, co=>co,
         q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cd8p3dxc OF cd8p3dx IS
  FOR v
    FOR ALL: cd4p3dx USE ENTITY work.cd4p3dx(v); END FOR;
  END FOR;
END cd8p3dxc;


--
----- cd8p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cd8p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd8p3ix");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cd8p3ix : ENTITY IS TRUE;

END cd8p3ix;

ARCHITECTURE v OF cd8p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cd4p3ix
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cd4p3ix generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, cd=>cd, co=>co_int,
         q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cd4p3ix generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, cd=>cd, co=>co,
         q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cd8p3ixc OF cd8p3ix IS
  FOR v
    FOR ALL: cd4p3ix USE ENTITY work.cd4p3ix(v); END FOR;
  END FOR;
END cd8p3ixc;


--
----- cd8p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cd8p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cd8p3jx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cd8p3jx : ENTITY IS TRUE;

END cd8p3jx;

ARCHITECTURE v OF cd8p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cd4p3jx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cd4p3jx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>ci, sp=>sp, ck=>ck, pd=>pd, co=>co_int,
         q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cd4p3jx generic map (disabled_gsr => disabled_gsr)
         PORT MAP (ci=>co_int, sp=>sp, ck=>ck, pd=>pd, co=>co,
         q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cd8p3jxc OF cd8p3jx IS
  FOR v
    FOR ALL: cd4p3jx USE ENTITY work.cd4p3jx(v); END FOR;
  END FOR;
END cd8p3jxc;


--
----- cu4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cu4 IS
  GENERIC (
    InstancePath  : string := "cu4");
  PORT (
    ci, pc0, pc1, pc2, pc3: IN std_logic;
    co, nc0, nc1, nc2, nc3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cu4 : ENTITY IS TRUE;
 
END cu4;

ARCHITECTURE v OF cu4 IS
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
  inst24: and2 PORT MAP (a=>pc1, b=>i6, z=>i18);
  inst26: xor2 PORT MAP (a=>pc1, b=>i6, z=>nc1);
  inst37: and2 PORT MAP (a=>pc2, b=>i18, z=>i31);
  inst39: xor2 PORT MAP (a=>pc2, b=>i18, z=>nc2);
  inst50: and2 PORT MAP (a=>pc3, b=>i31, z=>co);
  inst52: xor2 PORT MAP (a=>pc3, b=>i31, z=>nc3);
  inst990: buf PORT MAP (a=>ci, z=>cii);
END v;

CONFIGURATION cu4c OF cu4 IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END cu4c;


--
----- cu4p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cu4p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu4p3bx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cu4p3bx : ENTITY IS TRUE;
 
END cu4p3bx;

ARCHITECTURE v OF cu4p3bx IS
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
  COMPONENT fd1p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, pd=>pd, q=>q0_1, qn=>open);
  inst69: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, pd=>pd, q=>q1_1, qn=>open);
  inst70: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, pd=>pd, q=>q2_1, qn=>open);
  inst71: fd1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, pd=>pd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cu4p3bxc OF cu4p3bx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3bx USE ENTITY work.fd1p3bx(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END cu4p3bxc;


--
----- cu4p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cu4p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu4p3dx");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cu4p3dx : ENTITY IS TRUE;
 
END cu4p3dx;

ARCHITECTURE v OF cu4p3dx IS
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
  COMPONENT fd1p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, cd=>cd, q=>q0_1, qn=>open);
  inst69: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, cd=>cd, q=>q1_1, qn=>open);
  inst70: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, cd=>cd, q=>q2_1, qn=>open);
  inst71: fd1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, cd=>cd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cu4p3dxc OF cu4p3dx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3dx USE ENTITY work.fd1p3dx(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END cu4p3dxc;


--
----- cu4p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cu4p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu4p3ix");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cu4p3ix : ENTITY IS TRUE;
 
END cu4p3ix;

ARCHITECTURE v OF cu4p3ix IS
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
  COMPONENT fd1p3iz
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, cd=>cd, q=>q0_1, qn=>open);
  inst69: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, cd=>cd, q=>q1_1, qn=>open);
  inst70: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, cd=>cd, q=>q2_1, qn=>open);
  inst71: fd1p3iz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, cd=>cd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cu4p3ixc OF cu4p3ix IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3iz USE ENTITY work.fd1p3iz(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END cu4p3ixc;


--
----- cu4p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY cu4p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu4p3jx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF cu4p3jx : ENTITY IS TRUE;
 
END cu4p3jx;

ARCHITECTURE v OF cu4p3jx IS
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
  COMPONENT fd1p3jz
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i7, sp=>sp, ck=>ck, pd=>pd, q=>q0_1, qn=>open);
  inst69: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i19, sp=>sp, ck=>ck, pd=>pd, q=>q1_1, qn=>open);
  inst70: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i32, sp=>sp, ck=>ck, pd=>pd, q=>q2_1, qn=>open);
  inst71: fd1p3jz generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d=>i45, sp=>sp, ck=>ck, pd=>pd, q=>q3_1, qn=>open);
  inst990: buf PORT MAP (a=>ci, z=>cii);
  q0 <= q0_1;
  q1 <= q1_1;
  q2 <= q2_1;
  q3 <= q3_1;
END v;

CONFIGURATION cu4p3jxc OF cu4p3jx IS
  FOR v
    FOR ALL: and2 USE ENTITY work.and2(v); END FOR;
    FOR ALL: buf USE ENTITY work.buf(v); END FOR;
    FOR ALL: fd1p3jz USE ENTITY work.fd1p3jz(v); END FOR;
    FOR ALL: xor2 USE ENTITY work.xor2(v); END FOR;
  END FOR;
END cu4p3jxc;


--
----- cu8p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cu8p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu8p3bx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cu8p3bx : ENTITY IS TRUE;

END cu8p3bx;

ARCHITECTURE v OF cu8p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cu4p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cu4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>ci, sp=>sp, ck=>ck, pd=>pd, co=>co_int,
    q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cu4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>co_int, sp=>sp, ck=>ck, pd=>pd, co=>co,
    q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cu8p3bxc OF cu8p3bx IS
  FOR v
    FOR ALL: cu4p3bx USE ENTITY work.cu4p3bx(v); END FOR;
  END FOR;
END cu8p3bxc;


--
----- cu8p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cu8p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu8p3dx");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cu8p3dx : ENTITY IS TRUE;

END cu8p3dx;

ARCHITECTURE v OF cu8p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cu4p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cu4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>ci, sp=>sp, ck=>ck, cd=>cd, co=>co_int,
    q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cu4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>co_int, sp=>sp, ck=>ck, cd=>cd, co=>co,
    q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cu8p3dxc OF cu8p3dx IS
  FOR v
    FOR ALL: cu4p3dx USE ENTITY work.cu4p3dx(v); END FOR;
  END FOR;
END cu8p3dxc;


--
----- cu8p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cu8p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu8p3ix");
  PORT (
    ci, sp, ck, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cu8p3ix : ENTITY IS TRUE;

END cu8p3ix;

ARCHITECTURE v OF cu8p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cu4p3ix
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cu4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>ci, sp=>sp, ck=>ck, cd=>cd, co=>co_int,
    q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cu4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>co_int, sp=>sp, ck=>ck, cd=>cd, co=>co,
    q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cu8p3ixc OF cu8p3ix IS
  FOR v
    FOR ALL: cu4p3ix USE ENTITY work.cu4p3ix(v); END FOR;
  END FOR;
END cu8p3ixc;


--
----- cu8p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY cu8p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "cu8p3jx");
  PORT (
    ci, sp, ck, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF cu8p3jx : ENTITY IS TRUE;

END cu8p3jx;

ARCHITECTURE v OF cu8p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT cu4p3jx
    generic (disabled_gsr : string := "0");
    PORT (
      ci, sp, ck, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: cu4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>ci, sp=>sp, ck=>ck, pd=>pd, co=>co_int,
    q0=>q0, q1=>q1, q2=>q2, q3=>q3);
  inst2: cu4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (ci=>co_int, sp=>sp, ck=>ck, pd=>pd, co=>co,
    q0=>q4, q1=>q5, q2=>q6, q3=>q7);
END v;


CONFIGURATION cu8p3jxc OF cu8p3jx IS
  FOR v
    FOR ALL: cu4p3jx USE ENTITY work.cu4p3jx(v); END FOR;
  END FOR;
END cu8p3jxc;


--
----- dec4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY dec4 IS
  GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string  := "dec4";
      tpd_ci_co       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ci         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc3        : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
  PORT (
    ci, pc0, pc1, pc2, pc3: IN std_logic;
    co, nc0, nc1, nc2, nc3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF dec4 : ENTITY IS TRUE;
 
END dec4;
 
ARCHITECTURE v OF dec4 IS
  ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ci_ipd  : std_logic := 'X';
   SIGNAL pc0_ipd : std_logic := 'X';
   SIGNAL pc1_ipd : std_logic := 'X';
   SIGNAL pc2_ipd : std_logic := 'X';
   SIGNAL pc3_ipd : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   VitalWireDelay (pc0_ipd, pc0, tipd_pc0);
   VitalWireDelay (pc1_ipd, pc1, tipd_pc1);
   VitalWireDelay (pc2_ipd, pc2, tipd_pc2);
   VitalWireDelay (pc3_ipd, pc3, tipd_pc3);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, pc0_ipd, pc1_ipd, pc2_ipd, pc3_ipd)
 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS c0_zd       : std_ulogic IS results0(1);
   ALIAS nc0_zd      : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS nc1_zd      : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS nc2_zd      : std_ulogic IS results2(2);
   ALIAS co_zd       : std_ulogic IS results3(1);
   ALIAS nc3_zd      : std_ulogic IS results3(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData     : VitalGlitchDataType;
   VARIABLE nc0_GlitchData    : VitalGlitchDataType;
   VARIABLE nc1_GlitchData    : VitalGlitchDataType;
   VARIABLE nc2_GlitchData    : VitalGlitchDataType;
   VARIABLE nc3_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   -- pc     ci     |    co    nc
   --------------------------------------------
   ( '0',   '0',        '0',  '1' ),
   ( '0',   '1',        '1',  '0' ),
   ( '1',   '0',        '1',  '0' ),
   ( '1',   '1',        '1',  '1' ));

   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc0_ipd, ci_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc1_ipd, c0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc2_ipd, c1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc3_ipd, c2_zd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_co, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_co, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_co, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_co, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc0,
       OutSignalName => "nc0",
       OutTemp => nc0_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc0, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc0, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc0, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc0, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc0, TRUE)),
       GlitchData => nc0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc1,
       OutSignalName => "nc1",
       OutTemp => nc1_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc1, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc1, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc1, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc1, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc1, TRUE)),
       GlitchData => nc1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc2,
       OutSignalName => "nc2",
       OutTemp => nc2_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc2, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc2, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc2, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc2, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc2, TRUE)),
       GlitchData => nc2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc3,
       OutSignalName => "nc3",
       OutTemp => nc3_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc3, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc3, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc3, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc3, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc3, TRUE)),
       GlitchData => nc3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 

--
----- dec8 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY dec8 IS
  GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string  := "dec8";
      tpd_ci_co       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ci         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc5        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc6        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc7        : VitalDelayType01 := (0.0 ns, 0.0 ns));

  PORT (
    ci, pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7: IN std_logic;
    co, nc0, nc1, nc2, nc3, nc4, nc5, nc6, nc7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF dec8 : ENTITY IS TRUE;

END dec8;

ARCHITECTURE v OF dec8 IS
  ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL ci_ipd  : std_logic := 'X';
   SIGNAL pc0_ipd : std_logic := 'X';
   SIGNAL pc1_ipd : std_logic := 'X';
   SIGNAL pc2_ipd : std_logic := 'X';
   SIGNAL pc3_ipd : std_logic := 'X';
   SIGNAL pc4_ipd : std_logic := 'X';
   SIGNAL pc5_ipd : std_logic := 'X';
   SIGNAL pc6_ipd : std_logic := 'X';
   SIGNAL pc7_ipd : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   VitalWireDelay (pc0_ipd, pc0, tipd_pc0);
   VitalWireDelay (pc1_ipd, pc1, tipd_pc1);
   VitalWireDelay (pc2_ipd, pc2, tipd_pc2);
   VitalWireDelay (pc3_ipd, pc3, tipd_pc3);
   VitalWireDelay (pc4_ipd, pc4, tipd_pc4);
   VitalWireDelay (pc5_ipd, pc5, tipd_pc5);
   VitalWireDelay (pc6_ipd, pc6, tipd_pc6);
   VitalWireDelay (pc7_ipd, pc7, tipd_pc7);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, pc0_ipd, pc1_ipd, pc2_ipd, pc3_ipd, pc4_ipd, 
         pc5_ipd, pc6_ipd, pc7_ipd)
 
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
   ALIAS nc0_zd      : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS nc1_zd      : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS nc2_zd      : std_ulogic IS results2(2);
   ALIAS c3_zd       : std_ulogic IS results3(1);
   ALIAS nc3_zd      : std_ulogic IS results3(2);
   ALIAS c4_zd       : std_ulogic IS results4(1);
   ALIAS nc4_zd      : std_ulogic IS results4(2);
   ALIAS c5_zd       : std_ulogic IS results5(1);
   ALIAS nc5_zd      : std_ulogic IS results5(2);
   ALIAS c6_zd       : std_ulogic IS results6(1);
   ALIAS nc6_zd      : std_ulogic IS results6(2);
   ALIAS co_zd       : std_ulogic IS results7(1);
   ALIAS nc7_zd      : std_ulogic IS results7(2);

   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData     : VitalGlitchDataType;
   VARIABLE nc0_GlitchData    : VitalGlitchDataType;
   VARIABLE nc1_GlitchData    : VitalGlitchDataType;
   VARIABLE nc2_GlitchData    : VitalGlitchDataType;
   VARIABLE nc3_GlitchData    : VitalGlitchDataType;
   VARIABLE nc4_GlitchData    : VitalGlitchDataType;
   VARIABLE nc5_GlitchData    : VitalGlitchDataType;
   VARIABLE nc6_GlitchData    : VitalGlitchDataType;
   VARIABLE nc7_GlitchData    : VitalGlitchDataType;

   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   -- pc     ci     |    co    nc
   --------------------------------------------
   ( '0',   '0',        '0',  '1' ),
   ( '0',   '1',        '1',  '0' ),
   ( '1',   '0',        '1',  '0' ),
   ( '1',   '1',        '1',  '1' ));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc0_ipd, ci_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc1_ipd, c0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc2_ipd, c1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc3_ipd, c2_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc4_ipd, c3_zd)
                );
      results5 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc5_ipd, c4_zd)
                );
      results6 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc6_ipd, c5_zd)
                );
      results7 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc7_ipd, c6_zd)
                );

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_co, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_co, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_co, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_co, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_co, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_co, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_co, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_co, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => nc0,
       OutSignalName => "nc0",
       OutTemp => nc0_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc0, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc0, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc0, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc0, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc0, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc0, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc0, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc0, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc0, TRUE)),
       GlitchData => nc0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc1,
       OutSignalName => "nc1",
       OutTemp => nc1_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc1, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc1, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc1, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc1, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc1, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc1, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc1, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc1, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc1, TRUE)),
       GlitchData => nc1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc2,
       OutSignalName => "nc2",
       OutTemp => nc2_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc2, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc2, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc2, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc2, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc2, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc2, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc2, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc2, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc2, TRUE)),
       GlitchData => nc2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc3,
       OutSignalName => "nc3",
       OutTemp => nc3_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc3, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc3, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc3, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc3, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc3, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc3, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc3, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc3, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc3, TRUE)),
       GlitchData => nc3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc4,
       OutSignalName => "nc4",
       OutTemp => nc4_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc4, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc4, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc4, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc4, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc4, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc4, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc4, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc4, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc4, TRUE)),
       GlitchData => nc4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc5,
       OutSignalName => "nc5",
       OutTemp => nc5_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc5, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc5, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc5, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc5, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc5, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc5, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc5, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc5, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc5, TRUE)),
       GlitchData => nc5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc6,
       OutSignalName => "nc6",
       OutTemp => nc6_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc6, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc6, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc6, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc6, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc6, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc6, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc6, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc6, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc6, TRUE)),
       GlitchData => nc6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc7,
       OutSignalName => "nc7",
       OutTemp => nc7_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc7, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc7, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc7, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc7, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc7, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc7, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc7, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc7, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc7, TRUE)),
       GlitchData => nc7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- inc4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY inc4 IS
  GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "inc4";
      tpd_ci_co       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ci         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc3        : VitalDelayType01 := (0.0 ns, 0.0 ns));
 
  PORT (
    ci, pc0, pc1, pc2, pc3: IN std_logic;
    co, nc0, nc1, nc2, nc3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF inc4 : ENTITY IS TRUE;
 
END inc4;
 
ARCHITECTURE v OF inc4 IS
  ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;
 
   SIGNAL ci_ipd  : std_logic := 'X';
   SIGNAL pc0_ipd : std_logic := 'X';
   SIGNAL pc1_ipd : std_logic := 'X';
   SIGNAL pc2_ipd : std_logic := 'X';
   SIGNAL pc3_ipd : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   VitalWireDelay (pc0_ipd, pc0, tipd_pc0);
   VitalWireDelay (pc1_ipd, pc1, tipd_pc1);
   VitalWireDelay (pc2_ipd, pc2, tipd_pc2);
   VitalWireDelay (pc3_ipd, pc3, tipd_pc3);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, pc0_ipd, pc1_ipd, pc2_ipd, pc3_ipd)
 
   -- functionality results
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results4 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS c0_zd       : std_ulogic IS results1(1);
   ALIAS nc0_zd      : std_ulogic IS results1(2);
   ALIAS c1_zd       : std_ulogic IS results2(1);
   ALIAS nc1_zd      : std_ulogic IS results2(2);
   ALIAS c2_zd       : std_ulogic IS results3(1);
   ALIAS nc2_zd      : std_ulogic IS results3(2);
   ALIAS co_zd       : std_ulogic IS results4(1);
   ALIAS nc3_zd      : std_ulogic IS results4(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData     : VitalGlitchDataType;
   VARIABLE nc0_GlitchData    : VitalGlitchDataType;
   VARIABLE nc1_GlitchData    : VitalGlitchDataType;
   VARIABLE nc2_GlitchData    : VitalGlitchDataType;
   VARIABLE nc3_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   -- pc     ci     |    co    nc
   --------------------------------------------
   ( '0',   '0',        '0',  '0' ),
   ( '0',   '1',        '0',  '1' ),
   ( '1',   '0',        '0',  '1' ),
   ( '1',   '1',        '1',  '0' ));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc0_ipd, ci_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc1_ipd, c0_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc2_ipd, c1_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc3_ipd, c2_zd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_co, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_co, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_co, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_co, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc0,
       OutSignalName => "nc0",
       OutTemp => nc0_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc0, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc0, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc0, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc0, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc0, TRUE)),
       GlitchData => nc0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc1,
       OutSignalName => "nc1",
       OutTemp => nc1_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc1, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc1, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc1, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc1, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc1, TRUE)),
       GlitchData => nc1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc2,
       OutSignalName => "nc2",
       OutTemp => nc2_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc2, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc2, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc2, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc2, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc2, TRUE)),
       GlitchData => nc2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc3,
       OutSignalName => "nc3",
       OutTemp => nc3_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc3, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc3, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc3, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc3, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc3, TRUE)),
       GlitchData => nc3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 


--
----- inc8 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY inc8 IS
  GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string  := "inc8";
      tpd_ci_co       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ci         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc5        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc6        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc7        : VitalDelayType01 := (0.0 ns, 0.0 ns));

  PORT (
    ci, pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7: IN std_logic;
    co, nc0, nc1, nc2, nc3, nc4, nc5, nc6, nc7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF inc8 : ENTITY IS TRUE;

END inc8;

ARCHITECTURE v OF inc8 IS
  ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL ci_ipd  : std_logic := 'X';
   SIGNAL pc0_ipd : std_logic := 'X';
   SIGNAL pc1_ipd : std_logic := 'X';
   SIGNAL pc2_ipd : std_logic := 'X';
   SIGNAL pc3_ipd : std_logic := 'X';
   SIGNAL pc4_ipd : std_logic := 'X';
   SIGNAL pc5_ipd : std_logic := 'X';
   SIGNAL pc6_ipd : std_logic := 'X';
   SIGNAL pc7_ipd : std_logic := 'X';
 
BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   VitalWireDelay (pc0_ipd, pc0, tipd_pc0);
   VitalWireDelay (pc1_ipd, pc1, tipd_pc1);
   VitalWireDelay (pc2_ipd, pc2, tipd_pc2);
   VitalWireDelay (pc3_ipd, pc3, tipd_pc3);
   VitalWireDelay (pc4_ipd, pc4, tipd_pc4);
   VitalWireDelay (pc5_ipd, pc5, tipd_pc5);
   VitalWireDelay (pc6_ipd, pc6, tipd_pc6);
   VitalWireDelay (pc7_ipd, pc7, tipd_pc7);
   END BLOCK;

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, pc0_ipd, pc1_ipd, pc2_ipd, pc3_ipd, pc4_ipd, 
         pc5_ipd, pc6_ipd, pc7_ipd)
 
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
   ALIAS nc0_zd      : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS nc1_zd      : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS nc2_zd      : std_ulogic IS results2(2);
   ALIAS c3_zd       : std_ulogic IS results3(1);
   ALIAS nc3_zd      : std_ulogic IS results3(2);
   ALIAS c4_zd       : std_ulogic IS results4(1);
   ALIAS nc4_zd      : std_ulogic IS results4(2);
   ALIAS c5_zd       : std_ulogic IS results5(1);
   ALIAS nc5_zd      : std_ulogic IS results5(2);
   ALIAS c6_zd       : std_ulogic IS results6(1);
   ALIAS nc6_zd      : std_ulogic IS results6(2);
   ALIAS co_zd       : std_ulogic IS results7(1);
   ALIAS nc7_zd      : std_ulogic IS results7(2);

   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData     : VitalGlitchDataType;
   VARIABLE nc0_GlitchData    : VitalGlitchDataType;
   VARIABLE nc1_GlitchData    : VitalGlitchDataType;
   VARIABLE nc2_GlitchData    : VitalGlitchDataType;
   VARIABLE nc3_GlitchData    : VitalGlitchDataType;
   VARIABLE nc4_GlitchData    : VitalGlitchDataType;
   VARIABLE nc5_GlitchData    : VitalGlitchDataType;
   VARIABLE nc6_GlitchData    : VitalGlitchDataType;
   VARIABLE nc7_GlitchData    : VitalGlitchDataType;

   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   -- pc     ci     |    co    nc
   --------------------------------------------
   ( '0',   '0',        '0',  '0' ),
   ( '0',   '1',        '0',  '1' ),
   ( '1',   '0',        '0',  '1' ),
   ( '1',   '1',        '1',  '0' ));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc0_ipd, ci_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc1_ipd, c0_zd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc2_ipd, c1_zd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc3_ipd, c2_zd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc4_ipd, c3_zd)
                );
      results5 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc5_ipd, c4_zd)
                );
      results6 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc6_ipd, c5_zd)
                );
      results7 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc7_ipd, c6_zd)
                );

      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_co, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_co, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_co, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_co, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_co, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_co, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_co, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_co, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);

      VitalPathDelay01 (
       OutSignal => nc0,
       OutSignalName => "nc0",
       OutTemp => nc0_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc0, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc0, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc0, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc0, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc0, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc0, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc0, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc0, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc0, TRUE)),
       GlitchData => nc0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc1,
       OutSignalName => "nc1",
       OutTemp => nc1_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc1, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc1, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc1, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc1, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc1, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc1, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc1, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc1, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc1, TRUE)),
       GlitchData => nc1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc2,
       OutSignalName => "nc2",
       OutTemp => nc2_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc2, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc2, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc2, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc2, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc2, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc2, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc2, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc2, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc2, TRUE)),
       GlitchData => nc2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc3,
       OutSignalName => "nc3",
       OutTemp => nc3_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc3, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc3, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc3, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc3, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc3, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc3, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc3, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc3, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc3, TRUE)),
       GlitchData => nc3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc4,
       OutSignalName => "nc4",
       OutTemp => nc4_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc4, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc4, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc4, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc4, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc4, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc4, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc4, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc4, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc4, TRUE)),
       GlitchData => nc4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc5,
       OutSignalName => "nc5",
       OutTemp => nc5_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc5, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc5, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc5, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc5, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc5, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc5, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc5, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc5, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc5, TRUE)),
       GlitchData => nc5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc6,
       OutSignalName => "nc6",
       OutTemp => nc6_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc6, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc6, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc6, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc6, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc6, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc6, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc6, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc6, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc6, TRUE)),
       GlitchData => nc6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc7,
       OutSignalName => "nc7",
       OutTemp => nc7_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc7, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc7, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc7, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc7, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc7, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc7, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc7, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc7, TRUE),
                 8 => (ci_ipd'last_event, tpd_ci_nc7, TRUE)),
       GlitchData => nc7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;


--
----- incdec4 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY incdec4 IS
  GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "incdec4";
      tpd_ci_co       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ci         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_con        : VitalDelayType01 := (0.0 ns, 0.0 ns));

  PORT (
    ci, pc0, pc1, pc2, pc3, con: IN std_logic;
    co, nc0, nc1, nc2, nc3: OUT std_logic);
 
    ATTRIBUTE Vital_Level0 OF incdec4 : ENTITY IS TRUE;
 
END incdec4;

ARCHITECTURE v OF incdec4 IS
  ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL ci_ipd  : std_logic := 'X';
   SIGNAL pc0_ipd : std_logic := 'X';
   SIGNAL pc1_ipd : std_logic := 'X';
   SIGNAL pc2_ipd : std_logic := 'X';
   SIGNAL pc3_ipd : std_logic := 'X';
   SIGNAL con_ipd : std_logic := 'X';

BEGIN
 
   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   VitalWireDelay (pc0_ipd, pc0, tipd_pc0);
   VitalWireDelay (pc1_ipd, pc1, tipd_pc1);
   VitalWireDelay (pc2_ipd, pc2, tipd_pc2);
   VitalWireDelay (pc3_ipd, pc3, tipd_pc3);
   VitalWireDelay (con_ipd, con, tipd_con);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, pc0_ipd, pc1_ipd, pc2_ipd, pc3_ipd, con_ipd)

 
   -- functionality results
   VARIABLE results0 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results1 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results2 : std_logic_vector(1 to 2) := (others => 'X');
   VARIABLE results3 : std_logic_vector(1 to 2) := (others => 'X');
   ALIAS c0_zd       : std_ulogic IS results0(1);
   ALIAS nc0_zd      : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS nc1_zd      : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS nc2_zd      : std_ulogic IS results2(2);
   ALIAS co_zd       : std_ulogic IS results3(1);
   ALIAS nc3_zd      : std_ulogic IS results3(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData     : VitalGlitchDataType;
   VARIABLE nc0_GlitchData    : VitalGlitchDataType;
   VARIABLE nc1_GlitchData    : VitalGlitchDataType;
   VARIABLE nc2_GlitchData    : VitalGlitchDataType;
   VARIABLE nc3_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   -- pc     ci    con    |    co    nc
   --------------------------------------------
   ( '0',   '0',   '0',        '0',  '1' ),
   ( '0',   '0',   '1',        '0',  '0' ),
   ( '0',   '1',   '0',        '1',  '0' ),
   ( '0',   '1',   '1',        '0',  '1' ),
   ( '1',   '0',   '0',        '1',  '0' ),
   ( '1',   '0',   '1',        '0',  '1' ),
   ( '1',   '1',   '0',        '1',  '1' ),
   ( '1',   '1',   '1',        '1',  '0' )); 

 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc0_ipd, ci_ipd, con_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc1_ipd, c0_zd, con_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc2_ipd, c1_zd, con_ipd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc3_ipd, c2_zd, con_ipd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_co, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_co, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_co, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_co, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_co, TRUE),
                 5 => (con_ipd'last_event, tpd_con_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc0,
       OutSignalName => "nc0",
       OutTemp => nc0_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc0, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc0, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc0, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc0, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc0, TRUE),
                 5 => (con_ipd'last_event, tpd_con_nc0, TRUE)),
       GlitchData => nc0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc1,
       OutSignalName => "nc1",
       OutTemp => nc1_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc1, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc1, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc1, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc1, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc1, TRUE),
                 5 => (con_ipd'last_event, tpd_con_nc1, TRUE)),
       GlitchData => nc1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc2,
       OutSignalName => "nc2",
       OutTemp => nc2_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc2, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc2, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc2, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc2, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc2, TRUE),
                 5 => (con_ipd'last_event, tpd_con_nc2, TRUE)),
       GlitchData => nc2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc3,
       OutSignalName => "nc3",
       OutTemp => nc3_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc3, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc3, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc3, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc3, TRUE),
                 4 => (ci_ipd'last_event, tpd_ci_nc3, TRUE),
                 5 => (con_ipd'last_event, tpd_con_nc3, TRUE)),
       GlitchData => nc3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 

--
----- incdec8 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

ENTITY incdec8 IS
  GENERIC (
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string  := "incdec8";
      tpd_ci_co       : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc0      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc1      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc2      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc3      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc4      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc5      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc6      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_ci_nc7      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc0_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc1_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc2_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc3_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc4_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc5_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc6_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_pc7_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_co      : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc0     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc1     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc2     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc3     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc4     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc5     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc6     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tpd_con_nc7     : VitalDelayType01 := (0.1 ns, 0.1 ns);
      tipd_ci         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc0        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc1        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc2        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc3        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc4        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc5        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc6        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_pc7        : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_con        : VitalDelayType01 := (0.0 ns, 0.0 ns));

  PORT (
    ci, pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7, con: IN std_logic;
    co, nc0, nc1, nc2, nc3, nc4, nc5, nc6, nc7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF incdec8 : ENTITY IS TRUE;

END incdec8;

ARCHITECTURE v OF incdec8 IS
  ATTRIBUTE Vital_Level1 OF v : ARCHITECTURE IS TRUE;

   SIGNAL ci_ipd  : std_logic := 'X';
   SIGNAL pc0_ipd : std_logic := 'X';
   SIGNAL pc1_ipd : std_logic := 'X';
   SIGNAL pc2_ipd : std_logic := 'X';
   SIGNAL pc3_ipd : std_logic := 'X';
   SIGNAL pc4_ipd : std_logic := 'X';
   SIGNAL pc5_ipd : std_logic := 'X';
   SIGNAL pc6_ipd : std_logic := 'X';
   SIGNAL pc7_ipd : std_logic := 'X';
   SIGNAL con_ipd : std_logic := 'X';
 
BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (ci_ipd, ci, tipd_ci);
   VitalWireDelay (pc0_ipd, pc0, tipd_pc0);
   VitalWireDelay (pc1_ipd, pc1, tipd_pc1);
   VitalWireDelay (pc2_ipd, pc2, tipd_pc2);
   VitalWireDelay (pc3_ipd, pc3, tipd_pc3);
   VitalWireDelay (pc4_ipd, pc4, tipd_pc4);
   VitalWireDelay (pc5_ipd, pc5, tipd_pc5);
   VitalWireDelay (pc6_ipd, pc6, tipd_pc6);
   VitalWireDelay (pc7_ipd, pc7, tipd_pc7);
   VitalWireDelay (con_ipd, con, tipd_con);
   END BLOCK;
 
   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (ci_ipd, pc0_ipd, pc1_ipd, pc2_ipd, pc3_ipd, pc4_ipd,
         pc5_ipd, pc6_ipd, pc7_ipd, con_ipd)
 
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
   ALIAS nc0_zd      : std_ulogic IS results0(2);
   ALIAS c1_zd       : std_ulogic IS results1(1);
   ALIAS nc1_zd      : std_ulogic IS results1(2);
   ALIAS c2_zd       : std_ulogic IS results2(1);
   ALIAS nc2_zd      : std_ulogic IS results2(2);
   ALIAS c3_zd       : std_ulogic IS results3(1);
   ALIAS nc3_zd      : std_ulogic IS results3(2);
   ALIAS c4_zd       : std_ulogic IS results4(1);
   ALIAS nc4_zd      : std_ulogic IS results4(2);
   ALIAS c5_zd       : std_ulogic IS results5(1);
   ALIAS nc5_zd      : std_ulogic IS results5(2);
   ALIAS c6_zd       : std_ulogic IS results6(1);
   ALIAS nc6_zd      : std_ulogic IS results6(2);
   ALIAS co_zd       : std_ulogic IS results7(1);
   ALIAS nc7_zd      : std_ulogic IS results7(2);
 
   -- output glitch detection VARIABLEs
   VARIABLE co_GlitchData     : VitalGlitchDataType;
   VARIABLE nc0_GlitchData    : VitalGlitchDataType;
   VARIABLE nc1_GlitchData    : VitalGlitchDataType;
   VARIABLE nc2_GlitchData    : VitalGlitchDataType;
   VARIABLE nc3_GlitchData    : VitalGlitchDataType;
   VARIABLE nc4_GlitchData    : VitalGlitchDataType;
   VARIABLE nc5_GlitchData    : VitalGlitchDataType;
   VARIABLE nc6_GlitchData    : VitalGlitchDataType;
   VARIABLE nc7_GlitchData    : VitalGlitchDataType;
 
   constant add_table : vitaltruthtabletype := (
   --------------------------------------------
   -- pc     ci    con    |    co    nc
   --------------------------------------------
   ( '0',   '0',   '0',        '0',  '1' ),
   ( '0',   '0',   '1',        '0',  '0' ),
   ( '0',   '1',   '0',        '1',  '0' ),
   ( '0',   '1',   '1',        '0',  '1' ),
   ( '1',   '0',   '0',        '1',  '0' ),
   ( '1',   '0',   '1',        '0',  '1' ),
   ( '1',   '1',   '0',        '1',  '1' ),
   ( '1',   '1',   '1',        '1',  '0' ));
 
   BEGIN
 
      -------------------------
      --  functionality section
      -------------------------
      results0 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc0_ipd, ci_ipd, con_ipd)
                );
      results1 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc1_ipd, c0_zd, con_ipd)
                );
      results2 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc2_ipd, c1_zd, con_ipd)
                );
      results3 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc3_ipd, c2_zd, con_ipd)
                );
      results4 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc4_ipd, c3_zd, con_ipd)
                );
      results5 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc5_ipd, c4_zd, con_ipd)
                );
      results6 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc6_ipd, c5_zd, con_ipd)
                );
      results7 := vitaltruthtable (
                truthtable => add_table,
                datain => (pc7_ipd, c6_zd, con_ipd)
                );
 
      ----------------------
      --  path delay section
      ----------------------
      VitalPathDelay01 (
       OutSignal => co,
       OutSignalName => "co",
       OutTemp => co_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_co, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_co, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_co, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_co, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_co, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_co, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_co, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_co, TRUE),
                 8 => (con_ipd'last_event, tpd_con_co, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_co, TRUE)),
       GlitchData => co_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc0,
       OutSignalName => "nc0",
       OutTemp => nc0_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc0, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc0, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc0, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc0, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc0, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc0, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc0, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc0, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc0, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc0, TRUE)),
       GlitchData => nc0_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc1,
       OutSignalName => "nc1",
       OutTemp => nc1_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc1, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc1, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc1, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc1, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc1, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc1, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc1, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc1, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc1, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc1, TRUE)),
       GlitchData => nc1_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc2,
       OutSignalName => "nc2",
       OutTemp => nc2_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc2, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc2, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc2, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc2, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc2, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc2, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc2, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc2, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc2, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc2, TRUE)),
       GlitchData => nc2_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc3,
       OutSignalName => "nc3",
       OutTemp => nc3_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc3, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc3, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc3, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc3, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc3, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc3, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc3, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc3, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc3, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc3, TRUE)),
       GlitchData => nc3_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc4,
       OutSignalName => "nc4",
       OutTemp => nc4_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc4, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc4, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc4, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc4, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc4, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc4, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc4, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc4, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc4, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc4, TRUE)),
       GlitchData => nc4_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc5,
       OutSignalName => "nc5",
       OutTemp => nc5_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc5, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc5, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc5, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc5, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc5, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc5, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc5, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc5, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc5, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc5, TRUE)),
       GlitchData => nc5_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc6,
       OutSignalName => "nc6",
       OutTemp => nc6_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc6, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc6, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc6, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc6, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc6, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc6, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc6, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc6, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc6, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc6, TRUE)),
       GlitchData => nc6_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
      VitalPathDelay01 (
       OutSignal => nc7,
       OutSignalName => "nc7",
       OutTemp => nc7_zd,
       Paths => (0 => (pc0_ipd'last_event, tpd_pc0_nc7, TRUE),
                 1 => (pc1_ipd'last_event, tpd_pc1_nc7, TRUE),
                 2 => (pc2_ipd'last_event, tpd_pc2_nc7, TRUE),
                 3 => (pc3_ipd'last_event, tpd_pc3_nc7, TRUE),
                 4 => (pc4_ipd'last_event, tpd_pc4_nc7, TRUE),
                 5 => (pc5_ipd'last_event, tpd_pc5_nc7, TRUE),
                 6 => (pc6_ipd'last_event, tpd_pc6_nc7, TRUE),
                 7 => (pc7_ipd'last_event, tpd_pc7_nc7, TRUE),
                 8 => (con_ipd'last_event, tpd_con_nc7, TRUE),
                 9 => (ci_ipd'last_event, tpd_ci_nc7, TRUE)),
       GlitchData => nc7_GlitchData,
       Mode => OnDetect,
       XOn => XOn,
       MsgOn => MsgOn);
 
END PROCESS;
 
END v;
 

--
----- lb4p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY lb4p3ax IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb4p3ax");
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
  COMPONENT fd1p3ax
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck: IN std_logic;
      q, qn: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1, qn=>open);
  inst69: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1, qn=>open);
  inst70: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1, qn=>open);
  inst71: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1, qn=>open);
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
    FOR ALL: fd1p3ax USE ENTITY work.fd1p3ax(v); END FOR;
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
USE work.orcacomp.all;

ENTITY lb4p3ay IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb4p3ay");
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
  COMPONENT fd1p3ay
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck: IN std_logic;
      q, qn: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1, qn=>open);
  inst69: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1, qn=>open);
  inst70: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1, qn=>open);
  inst71: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1, qn=>open);
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
    FOR ALL: fd1p3ay USE ENTITY work.fd1p3ay(v); END FOR;
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
USE work.orcacomp.all;
ENTITY lb4p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb4p3bx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1, qn=>open);
  inst69: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1, qn=>open);
  inst70: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1, qn=>open);
  inst71: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY lb4p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb4p3dx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1, qn=>open);
  inst69: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1, qn=>open);
  inst70: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1, qn=>open);
  inst71: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY lb4p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb4p3ix");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1, qn=>open);
  inst69: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1, qn=>open);
  inst70: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1, qn=>open);
  inst71: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY lb4p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb4p3jx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1, qn=>open);
  inst69: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1, qn=>open);
  inst70: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1, qn=>open);
  inst71: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1, qn=>open);
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
----- lb8p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lb8p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb8p3bx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, pd, con: in
      std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb8p3bx : ENTITY IS TRUE;

END lb8p3bx;

ARCHITECTURE v OF lb8p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lb4p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, pd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lb4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, pd=>pd, con=>con, co=>co_int, q0=>q0, q1=>q1,
    q2=>q2, q3=>q3);
  inst2: lb4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, pd=>pd, con=>con, co=>co, q0=>q4, q1=>q5,
    q2=>q6, q3=>q7);
END v;


CONFIGURATION lb8p3bxc OF lb8p3bx IS
  FOR v
    FOR ALL: lb4p3bx USE ENTITY work.lb4p3bx(v); END FOR;
  END FOR;
END lb8p3bxc;


--
----- lb8p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lb8p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb8p3dx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, cd, con: in
      std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb8p3dx : ENTITY IS TRUE;

END lb8p3dx;

ARCHITECTURE v OF lb8p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lb4p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, cd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lb4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, cd=>cd, con=>con, co=>co_int, q0=>q0, q1=>q1,
    q2=>q2, q3=>q3);
  inst2: lb4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, cd=>cd, con=>con, co=>co, q0=>q4, q1=>q5,
    q2=>q6, q3=>q7);
END v;


CONFIGURATION lb8p3dxc OF lb8p3dx IS
  FOR v
    FOR ALL: lb4p3dx USE ENTITY work.lb4p3dx(v); END FOR;
  END FOR;
END lb8p3dxc;


--
----- lb8p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lb8p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb8p3ix");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, cd, con: in
      std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb8p3ix : ENTITY IS TRUE;

END lb8p3ix;

ARCHITECTURE v OF lb8p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lb4p3ix
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, cd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lb4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, cd=>cd, con=>con, co=>co_int, q0=>q0, q1=>q1,
    q2=>q2, q3=>q3);
  inst2: lb4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, cd=>cd, con=>con, co=>co, q0=>q4, q1=>q5,
    q2=>q6, q3=>q7);
END v;


CONFIGURATION lb8p3ixc OF lb8p3ix IS
  FOR v
    FOR ALL: lb4p3ix USE ENTITY work.lb4p3ix(v); END FOR;
  END FOR;
END lb8p3ixc;


--
----- lb8p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lb8p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lb8p3jx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, pd, con: in
      std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lb8p3jx : ENTITY IS TRUE;

END lb8p3jx;

ARCHITECTURE v OF lb8p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lb4p3jx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, pd, con: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lb4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, pd=>pd, con=>con, co=>co_int, q0=>q0, q1=>q1,
    q2=>q2, q3=>q3);
  inst2: lb4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, pd=>pd, con=>con, co=>co, q0=>q4, q1=>q5,
    q2=>q6, q3=>q7);
END v;


CONFIGURATION lb8p3jxc OF lb8p3jx IS
  FOR v
    FOR ALL: lb4p3jx USE ENTITY work.lb4p3jx(v); END FOR;
  END FOR;
END lb8p3jxc;


--
----- ld4p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY ld4p3ax IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld4p3ax");
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
  COMPONENT fd1p3ax
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck: IN std_logic;
      q, qn: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1, qn=>open);
  inst69: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1, qn=>open);
  inst70: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1, qn=>open);
  inst71: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1, qn=>open);
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
    FOR ALL: fd1p3ax USE ENTITY work.fd1p3ax(v); END FOR;
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
USE work.orcacomp.all;

ENTITY ld4p3ay IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld4p3ay");
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
  COMPONENT fd1p3ay
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck: IN std_logic;
      q, qn: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1, qn=>open);
  inst69: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1, qn=>open);
  inst70: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1, qn=>open);
  inst71: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1, qn=>open);
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
    FOR ALL: fd1p3ay USE ENTITY work.fd1p3ay(v); END FOR;
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
USE work.orcacomp.all;
ENTITY ld4p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld4p3bx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1, qn=>open);
  inst69: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1, qn=>open);
  inst70: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1, qn=>open);
  inst71: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY ld4p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld4p3dx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1, qn=>open);
  inst69: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1, qn=>open);
  inst70: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1, qn=>open);
  inst71: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY ld4p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld4p3ix");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1, qn=>open);
  inst69: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1, qn=>open);
  inst70: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1, qn=>open);
  inst71: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY ld4p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld4p3jx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1, qn=>open);
  inst69: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1, qn=>open);
  inst70: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1, qn=>open);
  inst71: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1, qn=>open);
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
----- ld8p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY ld8p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld8p3bx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld8p3bx : ENTITY IS TRUE;

END ld8p3bx;

ARCHITECTURE v OF ld8p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT ld4p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: ld4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, pd=>pd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: ld4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, pd=>pd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION ld8p3bxc OF ld8p3bx IS
  FOR v
    FOR ALL: ld4p3bx USE ENTITY work.ld4p3bx(v); END FOR;
  END FOR;
END ld8p3bxc;


--
----- ld8p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY ld8p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld8p3dx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld8p3dx : ENTITY IS TRUE;

END ld8p3dx;

ARCHITECTURE v OF ld8p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT ld4p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: ld4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, cd=>cd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: ld4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, cd=>cd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION ld8p3dxc OF ld8p3dx IS
  FOR v
    FOR ALL: ld4p3dx USE ENTITY work.ld4p3dx(v); END FOR;
  END FOR;
END ld8p3dxc;


--
----- ld8p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY ld8p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld8p3ix");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld8p3ix : ENTITY IS TRUE;

END ld8p3ix;

ARCHITECTURE v OF ld8p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT ld4p3ix
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: ld4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, cd=>cd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: ld4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, cd=>cd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION ld8p3ixc OF ld8p3ix IS
  FOR v
    FOR ALL: ld4p3ix USE ENTITY work.ld4p3ix(v); END FOR;
  END FOR;
END ld8p3ixc;


--
----- ld8p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY ld8p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "ld8p3jx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ld8p3jx : ENTITY IS TRUE;

END ld8p3jx;

ARCHITECTURE v OF ld8p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT ld4p3jx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: ld4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, pd=>pd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: ld4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, pd=>pd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION ld8p3jxc OF ld8p3jx IS
  FOR v
    FOR ALL: ld4p3jx USE ENTITY work.ld4p3jx(v); END FOR;
  END FOR;
END ld8p3jxc;


--
----- lu4p3ax -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;

ENTITY lu4p3ax IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu4p3ax");
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
  COMPONENT fd1p3ax
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck: IN std_logic;
      q, qn: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3az
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1, qn=>open);
  inst69: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1, qn=>open);
  inst70: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1, qn=>open);
  inst71: fl1p3az generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1, qn=>open);
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
    FOR ALL: fd1p3ax USE ENTITY work.fd1p3ax(v); END FOR;
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
USE work.orcacomp.all;

ENTITY lu4p3ay IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu4p3ay");
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
  COMPONENT fd1p3ay
    generic (disabled_gsr : string := "0");
    PORT (
      d, sp, ck: IN std_logic;
      q, qn: OUT std_logic);
  END COMPONENT;
  COMPONENT fl1p3ay
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, q=>
    q0_1, qn=>open);
  inst69: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, q=>
    q1_1, qn=>open);
  inst70: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, q=>
    q2_1, qn=>open);
  inst71: fl1p3ay generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, q=>
    q3_1, qn=>open);
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
    FOR ALL: fd1p3ay USE ENTITY work.fd1p3ay(v); END FOR;
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
USE work.orcacomp.all;
ENTITY lu4p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu4p3bx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1, qn=>open);
  inst69: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1, qn=>open);
  inst70: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1, qn=>open);
  inst71: fl1p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY lu4p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu4p3dx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1, qn=>open);
  inst69: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1, qn=>open);
  inst70: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1, qn=>open);
  inst71: fl1p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY lu4p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu4p3ix");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, cd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q0_1, qn=>open);
  inst69: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q1_1, qn=>open);
  inst70: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q2_1, qn=>open);
  inst71: fl1p3iy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, cd=>
    cd, q=>q3_1, qn=>open);
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
USE work.orcacomp.all;
ENTITY lu4p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu4p3jx");
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
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, sp, ck, sd, pd: IN std_logic;
      q, qn: OUT std_logic);
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
  inst68: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i7, d1=>d0, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q0_1, qn=>open);
  inst69: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i19, d1=>d1, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q1_1, qn=>open);
  inst70: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i32, d1=>d2, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q2_1, qn=>open);
  inst71: fl1p3jy generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>i45, d1=>d3, sp=>sp, ck=>ck, sd=>sd, pd=>
    pd, q=>q3_1, qn=>open);
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


--
----- lu8p3bx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lu8p3bx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu8p3bx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu8p3bx : ENTITY IS TRUE;

END lu8p3bx;

ARCHITECTURE v OF lu8p3bx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lu4p3bx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lu4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, pd=>pd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: lu4p3bx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, pd=>pd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION lu8p3bxc OF lu8p3bx IS
  FOR v
    FOR ALL: lu4p3bx USE ENTITY work.lu4p3bx(v); END FOR;
  END FOR;
END lu8p3bxc;


--
----- lu8p3dx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lu8p3dx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu8p3dx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu8p3dx : ENTITY IS TRUE;

END lu8p3dx;

ARCHITECTURE v OF lu8p3dx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lu4p3dx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lu4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, cd=>cd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: lu4p3dx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, cd=>cd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION lu8p3dxc OF lu8p3dx IS
  FOR v
    FOR ALL: lu4p3dx USE ENTITY work.lu4p3dx(v); END FOR;
  END FOR;
END lu8p3dxc;


--
----- lu8p3ix -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lu8p3ix IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu8p3ix");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, cd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu8p3ix : ENTITY IS TRUE;

END lu8p3ix;

ARCHITECTURE v OF lu8p3ix IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lu4p3ix
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, cd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lu4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, cd=>cd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: lu4p3ix generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, cd=>cd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION lu8p3ixc OF lu8p3ix IS
  FOR v
    FOR ALL: lu4p3ix USE ENTITY work.lu4p3ix(v); END FOR;
  END FOR;
END lu8p3ixc;


--
----- lu8p3jx -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;
--LIBRARY work;
USE work.orcacomp.all;
ENTITY lu8p3jx IS
  GENERIC (

    disabled_gsr  : string := "0";

    InstancePath  : string := "lu8p3jx");
  PORT (
    d0, d1, d2, d3, d4, d5, d6, d7, ci, sp, ck, sd, pd: IN std_logic;
    co, q0, q1, q2, q3, q4, q5, q6, q7: OUT std_logic);

    ATTRIBUTE Vital_Level0 OF lu8p3jx : ENTITY IS TRUE;

END lu8p3jx;

ARCHITECTURE v OF lu8p3jx IS
  ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;
  COMPONENT lu4p3jx
    generic (disabled_gsr : string := "0");
    PORT (
      d0, d1, d2, d3, ci, sp, ck, sd, pd: IN std_logic;
      co, q0, q1, q2, q3: OUT std_logic);
  END COMPONENT;
  SIGNAL co_int: std_logic;
BEGIN
  inst1: lu4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d0, d1=>d1, d2=>d2, d3=>d3, ci=>ci, sp=>
    sp, ck=>ck, sd=>sd, pd=>pd, co=>co_int, q0=>q0, q1=>q1, q2=>q2, q3=>
    q3);
  inst2: lu4p3jx generic map (disabled_gsr => disabled_gsr)
          PORT MAP (d0=>d4, d1=>d5, d2=>d6, d3=>d7, ci=>co_int,
    sp=>sp, ck=>ck, sd=>sd, pd=>pd, co=>co, q0=>q4, q1=>q5, q2=>q6, q3=>
    q7);
END v;


CONFIGURATION lu8p3jxc OF lu8p3jx IS
  FOR v
    FOR ALL: lu4p3jx USE ENTITY work.lu4p3jx(v); END FOR;
  END FOR;
END lu8p3jxc;


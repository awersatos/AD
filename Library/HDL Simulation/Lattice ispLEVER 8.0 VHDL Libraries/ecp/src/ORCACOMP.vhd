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
-- Simulation Library File for ECP
--
-- $Header: /home/rel01/env5_1a.34/vhdl/pkg/vhdsclibs/data/orca5ecp/src/RCS/ORCACOMP.vhd,v 1.6 2005/05/19 20:35:48 pradeep Exp $ 
--

--- 
LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
PACKAGE components IS 
   function str2std(L: string) return std_logic_vector;
   function Str2int( L : string) return integer;
   function Str2real( L : string) return REAL;
--
-----functions for Multipliers----------
function INT2VEC(INT: INTEGER; BWIDTH: INTEGER) RETURN STD_LOGIC_VECTOR;
function VEC2INT(v: std_logic_vector) return integer;
function ADDVECT(A, B: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR;
function SUBVECT(A, B: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR;
function TSCOMP(VECT: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR;
function BITX              (VECT: std_logic) return boolean;
function VECX              (VECT: std_logic_vector) return boolean;

-- 
COMPONENT ageb2
PORT(
        a0, a1: IN std_logic := 'X';
        b0, b1: IN std_logic := 'X';
        ci: IN std_logic := 'X';
        ge: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT aleb2
PORT( 
	a0, a1: IN std_logic := 'X';
	b0, b1: IN std_logic := 'X';
	ci: IN std_logic := 'X';
	le: OUT std_logic := 'X'
  );
END COMPONENT;
--
component CCU2
   generic (
      inject1_0 : string := "YES";
      inject1_1 : string := "YES";
      init0: string := "0x0000";
      init1: string := "0x0000"
   );
   port (
      A0,A1 : in std_ulogic;
      B0,B1 : in std_ulogic;
      C0,C1 : in std_ulogic;
      D0,D1 : in std_ulogic;
      CIN : in std_ulogic;
      S0,S1 : out std_ulogic;
      COUT0,COUT1 : out std_ulogic
   );
end component;
--
COMPONENT aneb2
PORT(
        a0, a1: IN std_logic := 'X';
        b0, b1: IN std_logic := 'X';
        ci: IN std_logic := 'X';
        ne: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT and2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT and3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT and4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT and5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd2
PORT(
        ci : IN std_logic := 'X';
        pc0, pc1 : IN std_logic := 'X';
        co : OUT std_logic := 'X';
        nc0, nc1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cu2
PORT(
        ci : IN std_logic := 'X';
        pc0, pc1 : IN std_logic := 'X';
        co : OUT std_logic := 'X';
        nc0, nc1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
--
COMPONENT JTAGB
    GENERIC (ER1 : string := "ENABLED";
             ER2 : string := "ENABLED");
PORT(
      TCK                : IN    std_logic := 'X';
      TMS                : IN    std_logic := 'X';
      TDI                : IN    std_logic := 'X';
      JTDO1              : IN    std_logic := 'X';
      JTDO2              : IN    std_logic := 'X';
      TDO                :      OUT  std_logic;
      JTCK               :      OUT  std_logic;
      JTDI               :      OUT  std_logic;
      JSHIFT             :      OUT  std_logic;
      JUPDATE            :      OUT  std_logic;
      JRSTN              :      OUT  std_logic;
      JCE1               :      OUT  std_logic;
      JCE2               :      OUT  std_logic;
      JRTI1              :      OUT  std_logic;
      JRTI2              :      OUT  std_logic);

END COMPONENT;
--
COMPONENT cb2
PORT(
        ci : IN std_logic := 'X';
        pc0, pc1 : IN std_logic := 'X';
        con: IN std_logic := 'X';
        co : OUT std_logic := 'X';
        nc0, nc1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb2p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lb4p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        con: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld2p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu2p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ld4p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3ax
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3ay
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT lu4p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d0, d1, d2, d3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        sp: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadd2
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        cout0, cout1 : OUT std_logic := 'X';
        s0, s1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadd4
PORT(
        a0, a1, a2, a3 : IN std_logic := 'X';
        b0, b1, b2, b3 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        s0, s1, s2, s3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadd8
PORT(
        a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
        b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        co: OUT std_logic := 'X';
        s0, s1, s2, s3, s4, s5, s6, s7 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadsu4
PORT(
        a0, a1, a2, a3 : IN std_logic := 'X';
        b0, b1, b2, b3 : IN std_logic := 'X';
        bci: IN std_logic := 'X';
        con: IN std_logic := 'X';
        bco: OUT std_logic := 'X';
        s0, s1, s2, s3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadsu8
PORT(
        a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
        b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
        bci: IN std_logic := 'X';
        con: IN std_logic := 'X';
        bco: OUT std_logic := 'X';
        s0, s1, s2, s3, s4, s5, s6, s7 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fsub4
PORT(
        a0, a1, a2, a3 : IN std_logic := 'X';
        b0, b1, b2, b3 : IN std_logic := 'X';
        bi: IN std_logic := 'X';
        bo: OUT std_logic := 'X';
        s0, s1, s2, s3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fsub8
PORT(
        a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
        b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
        bi: IN std_logic := 'X';
        bo: OUT std_logic := 'X';
        s0, s1, s2, s3, s4, s5, s6, s7 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fsub2
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        bi: IN std_logic := 'X';
        bout0, bout1 : OUT std_logic := 'X';
        s0, s1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fadsu2
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        bci: IN std_logic := 'X';
        con: IN std_logic := 'X';
        bco: OUT std_logic := 'X';
        s0, s1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fd1s1a
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1b
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1d
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1i
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1j
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ax
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3bx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3dx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ix
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3jx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ax
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3bx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3dx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ix
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3jx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3az
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3bx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3dx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3iy
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3jy
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1a
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1b
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1d
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1i
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1j
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s3ax
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s3ay
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT gsr
PORT( 
      gsr: IN std_logic := 'X'
  );
END COMPONENT;
--
--
COMPONENT sgsr
PORT(
      gsr: IN std_logic := 'X';
      clk : IN std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT inv
PORT( 
	a: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1p3bx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1p3dx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1p3ix
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1p3jx
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1s1b
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1s1d
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1s1i
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1s1j
    GENERIC (gsr : String := "ENABLED");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux21
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT l6mux21
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        sd: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux41
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	d2: IN std_logic := 'X';
	d3: IN std_logic := 'X';
	sd1: IN std_logic := 'X';
	sd2: IN std_logic := 'X';
	z : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux81
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	d2: IN std_logic := 'X';
	d3: IN std_logic := 'X';
	d4: IN std_logic := 'X';
	d5: IN std_logic := 'X';
	d6: IN std_logic := 'X';
	d7: IN std_logic := 'X';
	sd1: IN std_logic := 'X';
	sd2: IN std_logic := 'X';
	sd3: IN std_logic := 'X';
	z : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT mux161
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        d2: IN std_logic := 'X';
        d3: IN std_logic := 'X';
        d4: IN std_logic := 'X';
        d5: IN std_logic := 'X';
        d6: IN std_logic := 'X';
        d7: IN std_logic := 'X';
        d8: IN std_logic := 'X';
        d9: IN std_logic := 'X';
        d10: IN std_logic := 'X';
        d11: IN std_logic := 'X';
        d12: IN std_logic := 'X';
        d13: IN std_logic := 'X';
        d14: IN std_logic := 'X';
        d15: IN std_logic := 'X';
        sd1: IN std_logic := 'X';
        sd2: IN std_logic := 'X';
        sd3: IN std_logic := 'X';
        sd4: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT mux321
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        d2: IN std_logic := 'X';
        d3: IN std_logic := 'X';
        d4: IN std_logic := 'X';
        d5: IN std_logic := 'X';
        d6: IN std_logic := 'X';
        d7: IN std_logic := 'X';
        d8: IN std_logic := 'X';
        d9: IN std_logic := 'X';
        d10: IN std_logic := 'X';
        d11: IN std_logic := 'X';
        d12: IN std_logic := 'X';
        d13: IN std_logic := 'X';
        d14: IN std_logic := 'X';
        d15: IN std_logic := 'X';
        d16: IN std_logic := 'X';
        d17: IN std_logic := 'X';
        d18: IN std_logic := 'X';
        d19: IN std_logic := 'X';
        d20: IN std_logic := 'X';
        d21: IN std_logic := 'X';
        d22: IN std_logic := 'X';
        d23: IN std_logic := 'X';
        d24: IN std_logic := 'X';
        d25: IN std_logic := 'X';
        d26: IN std_logic := 'X';
        d27: IN std_logic := 'X';
        d28: IN std_logic := 'X';
        d29: IN std_logic := 'X';
        d30: IN std_logic := 'X';
        d31: IN std_logic := 'X';
        sd1: IN std_logic := 'X';
        sd2: IN std_logic := 'X';
        sd3: IN std_logic := 'X';
        sd4: IN std_logic := 'X';
        sd5: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT nd2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nd3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nd4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nd5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT nr5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ofe1p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofe1p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofe1p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofe1p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofs1p3bx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofs1p3dx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofs1p3ix
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofs1p3jx
    GENERIC (gsr : String := "ENABLED");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT or2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT or3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT or4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT or5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT pfumx
PORT( 
	alut: IN std_logic := 'X';
	blut: IN std_logic := 'X';
	c0  : IN std_logic := 'X';
	z   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT pur
   GENERIC (
      RST_PULSE          : Integer   := 1);
PORT(
      pur: IN std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dpr16x2b
PORT(   di0  : IN std_logic;
        di1  : IN std_logic;
        wck  : IN std_logic;
        wre  : IN std_logic;
        rad0 : IN std_logic;
        rad1 : IN std_logic;
        rad2 : IN std_logic;
        rad3 : IN std_logic;
        wad0 : IN std_logic;
        wad1 : IN std_logic;
        wad2 : IN std_logic;
        wad3 : IN std_logic;
        wdo0 : OUT std_logic;
        wdo1 : OUT std_logic;
        rdo0 : OUT std_logic;
        rdo1 : OUT std_logic
  );
END COMPONENT;
--
COMPONENT spr16x2b
PORT(   di0  : IN std_logic;
        di1  : IN std_logic;
        ck   : IN std_logic;
        wre  : IN std_logic;
        ad0  : IN std_logic;
        ad1  : IN std_logic;
        ad2  : IN std_logic;
        ad3  : IN std_logic;
        do0  : OUT std_logic;
        do1  : OUT std_logic
  );
END COMPONENT;
--
COMPONENT rom32x1
GENERIC(
        initval : string := "0x00000000"
  );
PORT( 
	ad0, ad1, ad2, ad3, ad4: IN std_logic := 'X';
	do0: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT rom16x1
GENERIC(
        initval : string := "0x0000"
  );
PORT( 
	ad0, ad1, ad2, ad3: IN std_logic := 'X';
	do0: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT rom64x1
GENERIC(
        initval : string := "0x0000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT rom128x1
GENERIC(
        initval : string := "0x00000000000000000000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5, ad6 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT rom256x1
GENERIC(
        initval : string := "0x0000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT strtup
PORT( 
	uclk : IN std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT tsall
PORT( 
       tsall: IN std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT vhi
PORT( 
	 z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT vlo
PORT( 
	 z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor11
PORT( 
        a, b, c, d, e, f, g, h, i, j, k: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xor21
PORT( 
	a, b, c, d, e, f, g, h, i, j, k: IN std_logic := 'X';
	l, m, n, o, p, q, r, s, t, u: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor3
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT xnor5
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT bufba
PORT(
        a: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dp8ka
GENERIC(
        DATA_WIDTH_A : in Integer := 18;
        DATA_WIDTH_B : in Integer := 18;
        REGMODE_A    : String  := "NOREG";
        REGMODE_B    : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE_A   : String  := "000";
        CSDECODE_B   : String  := "000";
        WRITEMODE_A  : String  := "NORMAL";
        WRITEMODE_B  : String  := "NORMAL";
        GSR : String  := "DISABLED";
        initval_00 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic := 'X';
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic := 'X';
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic := 'X';
        ada9, ada10, ada11, ada12                                       : in std_logic := 'X';
        cea, clka, wea, csa0, csa1, csa2, rsta                         : in std_logic := 'X';
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic := 'X';
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic := 'X';
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic := 'X';
        adb9, adb10, adb11, adb12                                       : in std_logic := 'X';
        ceb, clkb, web, csb0, csb1, csb2, rstb                         : in std_logic := 'X';

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic := 'X';
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic := 'X';
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic := 'X';
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pdp8ka
GENERIC(
        DATA_WIDTH_W : in Integer := 18;
        DATA_WIDTH_R : in Integer := 18;
        REGMODE      : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE_W   : String  := "000";
        CSDECODE_R   : String  := "000";
        GSR : String  := "DISABLED";
        initval_00 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        di18, di19, di20, di21, di22, di23, di24, di25, di26   : in std_logic := 'X';
        di27, di28, di29, di30, di31, di32, di33, di34, di35   : in std_logic := 'X';
        adw0, adw1, adw2, adw3, adw4, adw5, adw6, adw7, adw8   : in std_logic := 'X';
        adw9, adw10, adw11, adw12                              : in std_logic := 'X';
        cew, clkw, we, csw0, csw1, csw2                        : in std_logic := 'X';
        adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8   : in std_logic := 'X';
        adr9, adr10, adr11, adr12                              : in std_logic := 'X';
        cer, clkr, csr0, csr1, csr2, rst                       : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X';
        do18, do19, do20, do21, do22, do23, do24, do25, do26   : out std_logic := 'X';
        do27, do28, do29, do30, do31, do32, do33, do34, do35   : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sp8ka
GENERIC(
        DATA_WIDTH   : in Integer := 18;
        REGMODE      : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE     : String  := "000";
        WRITEMODE    : String  := "NORMAL";
        GSR : String  := "DISABLED";
        initval_00 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8            : in std_logic := 'X';
        ad9, ad10, ad11, ad12                                  : in std_logic := 'X';
        ce, clk, we, cs0, cs1, cs2, rst                        : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X'
  );
END COMPONENT;
--

COMPONENT bbw
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obw
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ilvds
PORT(
        a : IN std_logic := 'X';
        an: IN std_logic := 'X';
        z : OUT std_logic
 );
END COMPONENT;
--
COMPONENT olvds
PORT(
        a  : IN std_logic := 'X';
        z  : OUT std_logic ;
        zn : OUT std_logic
 );
END COMPONENT;
--
COMPONENT bb
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bbpd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bbpu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ib
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibpd
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibpu
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ob
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obzpd
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obzpu
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT dcs
GENERIC(
      DCSMODE         : String  := "NEG");
PORT(
        clk0              : IN std_logic;
        clk1              : IN std_logic;
        sel               : IN std_logic;
        dcsout            : OUT std_logic);
END COMPONENT;
--
COMPONENT delay
PORT(
        a                 : IN std_logic;
        z                 : OUT std_logic);
END COMPONENT;
--
component EPLLB
   generic(
      FIN           : string  := "100.0";
      CLKI_DIV      : string  := "1";
      CLKOP_DIV     : string  := "8";
      CLKFB_DIV     : string  := "1";
      FDEL          : string  := "0";
      FB_MODE       : string  := "CLOCKTREE";
      WAKE_ON_LOCK  : string  := "OFF");
    port(
          CLKI          :       in      STD_ULOGIC;
          RST           :       in      STD_ULOGIC;
          CLKFB         :       in      STD_ULOGIC;
          CLKOP         :       out     STD_ULOGIC;
          LOCK          :       out     STD_ULOGIC
        );
end component;
--
component EHXPLLB
   generic(
      FIN             : string  := "100.0";
      CLKI_DIV        : string  := "1";
      CLKOP_DIV       : string  := "8";
      CLKFB_DIV       : string  := "1";
      FDEL            : string  := "0";
      FB_MODE         : string  := "CLOCKTREE";
      CLKOK_DIV       : string  := "2";
      WAKE_ON_LOCK    : string  := "OFF";
      DELAY_CNTL      : string  := "STATIC";
      PHASEADJ        : string  := "0";
      DUTY            : string  := "4");

   port(
      CLKI            : in    STD_ULOGIC;
      CLKFB           : in    STD_ULOGIC;
      RST             : in    STD_ULOGIC := '0';

      DDAMODE           : in    STD_ULOGIC;
      DDAIZR            : in    STD_ULOGIC;
      DDAILAG           : in    STD_ULOGIC;
      DDAIDEL0          : in    STD_ULOGIC;
      DDAIDEL1          : in    STD_ULOGIC;
      DDAIDEL2          : in    STD_ULOGIC;

      CLKOP             : out   STD_ULOGIC;
      CLKOS             : out   STD_ULOGIC;
      CLKOK             : out   STD_ULOGIC;
      LOCK              : out   STD_ULOGIC;

      DDAOZR            : out   STD_ULOGIC;
      DDAOLAG           : out   STD_ULOGIC;
      DDAODEL0          : out    STD_ULOGIC;
      DDAODEL1          : out    STD_ULOGIC;
      DDAODEL2          : out    STD_ULOGIC
);
end component;
--
------Component ORCALUT4------
component ORCALUT4
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT5------
component ORCALUT5
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT6------
component ORCALUT6
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          F             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT7------
component ORCALUT7
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          F             :       in      STD_ULOGIC;
          G             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component ORCALUT8------
component ORCALUT8
    generic(  INIT      :       bit_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          F             :       in      STD_ULOGIC;
          G             :       in      STD_ULOGIC;
          H             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;
--
component MULT2
   port(
      A0                             :  in    STD_ULOGIC;
      A1                             :  in    STD_ULOGIC;
      A2                             :  in    STD_ULOGIC;
      A3                             :  in    STD_ULOGIC;
      B0                             :  in    STD_ULOGIC;
      B1                             :  in    STD_ULOGIC;
      B2                             :  in    STD_ULOGIC;
      B3                             :  in    STD_ULOGIC;
      CI                             :  in    STD_ULOGIC;
      P0                             :  out   STD_ULOGIC;
      P1                             :  out   STD_ULOGIC;
      CO                             :  out   STD_ULOGIC);
end component;
--
component IDDRXB
   generic( REGSET  : string  := "RESET");
    port(
          D             :       in      STD_LOGIC;
          ECLK          :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          LSR           :       in      STD_LOGIC;
          CE            :       in      STD_LOGIC;
          DDRCLKPOL     :       in      STD_LOGIC;
          QA            :       out     STD_LOGIC;
          QB            :       out     STD_LOGIC
        );
end component;
--
component ODDRXB
   generic( REGSET  : string  := "RESET");
    port(
          DA            :       in      STD_LOGIC;
          DB            :       in      STD_LOGIC;
          CLK           :       in      STD_LOGIC;
          LSR           :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC
        );
end component;
--
component DQSBUFB
    generic(DEL_ADJ          : string  := "PLUS";
            DEL_VAL          : string  := "0");
    port(
          DQSI          :       in      STD_LOGIC;
          CLK           :       in      STD_LOGIC;
          READ          :       in      STD_LOGIC;
          DQSDEL        :       in      STD_LOGIC;
          DQSO          :       out     STD_LOGIC;
          DDRCLKPOL     :       out     STD_LOGIC;
          DQSC          :       out     STD_LOGIC;
          PRMBDET       :       out     STD_LOGIC
        );
end component;
--
component DQSDLL
    generic(DEL_ADJ          : string  := "PLUS";
            DEL_VAL          : string  := "0";
            LOCK_SENSITIVITY : string  := "LOW");
    port(
          CLK           :       in      STD_ULOGIC;
          RST           :       in      STD_ULOGIC;
          UDDCNTL       :       in      STD_ULOGIC;
          LOCK          :       out     STD_ULOGIC;
          DQSDEL        :       out     STD_ULOGIC
        );
end component;
--
  component MULT9X9
  generic(
         REG_INPUTA_CLK       : string     := "NONE";
         REG_INPUTA_CE        : string     := "CE0";
         REG_INPUTA_RST       : string     := "RST0";
         REG_INPUTB_CLK       : string     := "NONE";
         REG_INPUTB_CE        : string     := "CE0";
         REG_INPUTB_RST       : string     := "RST0";
         REG_PIPELINE_CLK     : string     := "NONE";
         REG_PIPELINE_CE      : string     := "CE0";
         REG_PIPELINE_RST     : string     := "RST0";
         REG_OUTPUT_CLK       : string     := "NONE";
         REG_OUTPUT_CE        : string     := "CE0";
         REG_OUTPUT_RST       : string     := "RST0";
         REG_SIGNEDAB_0_CLK   : string     := "NONE";
         REG_SIGNEDAB_0_CE    : string     := "CE0";
         REG_SIGNEDAB_0_RST   : string     := "RST0";
         REG_SIGNEDAB_1_CLK   : string     := "NONE";
         REG_SIGNEDAB_1_CE    : string     := "CE0";
         REG_SIGNEDAB_1_RST   : string     := "RST0";
         SHIFT_IN_A           : string     := "FALSE";
         SHIFT_IN_B           : string     := "FALSE";
         GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;

        P0 : out STD_ULOGIC;
        P1 : out STD_ULOGIC;
        P2 : out STD_ULOGIC;
        P3 : out STD_ULOGIC;
        P4 : out STD_ULOGIC;
        P5 : out STD_ULOGIC;
        P6 : out STD_ULOGIC;
        P7 : out STD_ULOGIC;
        P8 : out STD_ULOGIC;
        P9 : out STD_ULOGIC;
        P10 : out STD_ULOGIC;
        P11 : out STD_ULOGIC;
        P12 : out STD_ULOGIC;
        P13 : out STD_ULOGIC;
        P14 : out STD_ULOGIC;
        P15 : out STD_ULOGIC;
        P16 : out STD_ULOGIC;
        P17 : out STD_ULOGIC
       );
  end component;

  component MULT9X9ADDSUB
  generic(
         REG_INPUTA0_CLK       : string     := "NONE";
         REG_INPUTA0_CE        : string     := "CE0";
         REG_INPUTA0_RST       : string     := "RST0";
         REG_INPUTA1_CLK       : string     := "NONE";
         REG_INPUTA1_CE        : string     := "CE0";
         REG_INPUTA1_RST       : string     := "RST0";
         REG_INPUTB0_CLK       : string     := "NONE";
         REG_INPUTB0_CE        : string     := "CE0";
         REG_INPUTB0_RST       : string     := "RST0";
         REG_INPUTB1_CLK       : string     := "NONE";
         REG_INPUTB1_CE        : string     := "CE0";
         REG_INPUTB1_RST       : string     := "RST0";
         REG_PIPELINE0_CLK     : string     := "NONE";
         REG_PIPELINE0_CE      : string     := "CE0";
         REG_PIPELINE0_RST     : string     := "RST0";
         REG_PIPELINE1_CLK     : string     := "NONE";
         REG_PIPELINE1_CE      : string     := "CE0";
         REG_PIPELINE1_RST     : string     := "RST0";
         REG_OUTPUT_CLK       : string     := "NONE";
         REG_OUTPUT_CE        : string     := "CE0";
         REG_OUTPUT_RST       : string     := "RST0";
         REG_SIGNEDAB_0_CLK   : string     := "NONE";
         REG_SIGNEDAB_0_CE    : string     := "CE0";
         REG_SIGNEDAB_0_RST   : string     := "RST0";
         REG_SIGNEDAB_1_CLK   : string     := "NONE";
         REG_SIGNEDAB_1_CE    : string     := "CE0";
         REG_SIGNEDAB_1_RST   : string     := "RST0";
         REG_ADDNSUB_0_CLK    : string     := "NONE";
         REG_ADDNSUB_0_CE     : string     := "CE0";
         REG_ADDNSUB_0_RST    : string     := "RST0";
         REG_ADDNSUB_1_CLK    : string     := "NONE";
         REG_ADDNSUB_1_CE     : string     := "CE0";
         REG_ADDNSUB_1_RST    : string     := "RST0";
         SHIFT_IN_A0          : string     := "FALSE";
         SHIFT_IN_B0          : string     := "FALSE";
         SHIFT_IN_A1          : string     := "FALSE";
         SHIFT_IN_B1          : string     := "FALSE";
         GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;
        ADDNSUB  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC
       );
  end component;
--
component MULT9X9ADDSUBSUM
  generic(
	 REG_INPUTA0_CLK       : string     := "NONE";
	 REG_INPUTA0_CE        : string     := "CE0";
	 REG_INPUTA0_RST       : string     := "RST0";
	 REG_INPUTA1_CLK       : string     := "NONE";
	 REG_INPUTA1_CE        : string     := "CE0";
	 REG_INPUTA1_RST       : string     := "RST0";
	 REG_INPUTA2_CLK       : string     := "NONE";
	 REG_INPUTA2_CE        : string     := "CE0";
	 REG_INPUTA2_RST       : string     := "RST0";
	 REG_INPUTA3_CLK       : string     := "NONE";
	 REG_INPUTA3_CE        : string     := "CE0";
	 REG_INPUTA3_RST       : string     := "RST0";
	 REG_INPUTB0_CLK       : string     := "NONE";
	 REG_INPUTB0_CE        : string     := "CE0";
	 REG_INPUTB0_RST       : string     := "RST0";
	 REG_INPUTB1_CLK       : string     := "NONE";
	 REG_INPUTB1_CE        : string     := "CE0";
	 REG_INPUTB1_RST       : string     := "RST0";
	 REG_INPUTB2_CLK       : string     := "NONE";
	 REG_INPUTB2_CE        : string     := "CE0";
	 REG_INPUTB2_RST       : string     := "RST0";
	 REG_INPUTB3_CLK       : string     := "NONE";
	 REG_INPUTB3_CE        : string     := "CE0";
	 REG_INPUTB3_RST       : string     := "RST0";
	 REG_PIPELINE0_CLK     : string     := "NONE";
	 REG_PIPELINE0_CE      : string     := "CE0";
	 REG_PIPELINE0_RST     : string     := "RST0";
	 REG_PIPELINE1_CLK     : string     := "NONE";
	 REG_PIPELINE1_CE      : string     := "CE0";
	 REG_PIPELINE1_RST     : string     := "RST0";
	 REG_PIPELINE2_CLK     : string     := "NONE";
	 REG_PIPELINE2_CE      : string     := "CE0";
	 REG_PIPELINE2_RST     : string     := "RST0";
	 REG_PIPELINE3_CLK     : string     := "NONE";
	 REG_PIPELINE3_CE      : string     := "CE0";
	 REG_PIPELINE3_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDAB_0_CLK   : string     := "NONE";
	 REG_SIGNEDAB_0_CE    : string     := "CE0";
	 REG_SIGNEDAB_0_RST   : string     := "RST0";
	 REG_SIGNEDAB_1_CLK   : string     := "NONE";
	 REG_SIGNEDAB_1_CE    : string     := "CE0";
	 REG_SIGNEDAB_1_RST   : string     := "RST0";
	 REG_ADDNSUB1_0_CLK    : string     := "NONE";
	 REG_ADDNSUB1_0_CE     : string     := "CE0";
	 REG_ADDNSUB1_0_RST    : string     := "RST0";
	 REG_ADDNSUB1_1_CLK    : string     := "NONE";
	 REG_ADDNSUB1_1_CE     : string     := "CE0";
	 REG_ADDNSUB1_1_RST    : string     := "RST0";
	 REG_ADDNSUB3_0_CLK    : string     := "NONE";
	 REG_ADDNSUB3_0_CE     : string     := "CE0";
	 REG_ADDNSUB3_0_RST    : string     := "RST0";
	 REG_ADDNSUB3_1_CLK    : string     := "NONE";
	 REG_ADDNSUB3_1_CE     : string     := "CE0";
	 REG_ADDNSUB3_1_RST    : string     := "RST0";
	 SHIFT_IN_A0          : string     := "FALSE";
	 SHIFT_IN_B0          : string     := "FALSE";
	 SHIFT_IN_A1          : string     := "FALSE";
	 SHIFT_IN_B1          : string     := "FALSE";
	 SHIFT_IN_A2          : string     := "FALSE";
	 SHIFT_IN_B2          : string     := "FALSE";
	 SHIFT_IN_A3          : string     := "FALSE";
	 SHIFT_IN_B3          : string     := "FALSE";
	 GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;

        A20 : in STD_ULOGIC;
        A21 : in STD_ULOGIC;
        A22 : in STD_ULOGIC;
        A23 : in STD_ULOGIC;
        A24 : in STD_ULOGIC;
        A25 : in STD_ULOGIC;
        A26 : in STD_ULOGIC;
        A27 : in STD_ULOGIC;
        A28 : in STD_ULOGIC;

        A30 : in STD_ULOGIC;
        A31 : in STD_ULOGIC;
        A32 : in STD_ULOGIC;
        A33 : in STD_ULOGIC;
        A34 : in STD_ULOGIC;
        A35 : in STD_ULOGIC;
        A36 : in STD_ULOGIC;
        A37 : in STD_ULOGIC;
        A38 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;

        B20 : in STD_ULOGIC;
        B21 : in STD_ULOGIC;
        B22 : in STD_ULOGIC;
        B23 : in STD_ULOGIC;
        B24 : in STD_ULOGIC;
        B25 : in STD_ULOGIC;
        B26 : in STD_ULOGIC;
        B27 : in STD_ULOGIC;
        B28 : in STD_ULOGIC;

        B30 : in STD_ULOGIC;
        B31 : in STD_ULOGIC;
        B32 : in STD_ULOGIC;
        B33 : in STD_ULOGIC;
        B34 : in STD_ULOGIC;
        B35 : in STD_ULOGIC;
        B36 : in STD_ULOGIC;
        B37 : in STD_ULOGIC;
        B38 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;
        ADDNSUB1  : in STD_ULOGIC;
        ADDNSUB3  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC;
        SUM19 : out STD_ULOGIC
       ); 
  end component;

  component MULT9X9MAC
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDAB_0_CLK   : string     := "NONE";
	 REG_SIGNEDAB_0_CE    : string     := "CE0";
	 REG_SIGNEDAB_0_RST   : string     := "RST0";
	 REG_SIGNEDAB_1_CLK   : string     := "NONE";
	 REG_SIGNEDAB_1_CE    : string     := "CE0";
	 REG_SIGNEDAB_1_RST   : string     := "RST0";
	 REG_ACCUMSLOAD_0_CLK : string     := "NONE";
	 REG_ACCUMSLOAD_0_CE  : string     := "CE0";
	 REG_ACCUMSLOAD_0_RST : string     := "RST0";
	 REG_ACCUMSLOAD_1_CLK : string     := "NONE";
	 REG_ACCUMSLOAD_1_CE  : string     := "CE0";
	 REG_ACCUMSLOAD_1_RST : string     := "RST0";
	 REG_ADDNSUB_0_CLK    : string     := "NONE";
	 REG_ADDNSUB_0_CE     : string     := "CE0";
	 REG_ADDNSUB_0_RST    : string     := "RST0";
	 REG_ADDNSUB_1_CLK    : string     := "NONE";
	 REG_ADDNSUB_1_CE     : string     := "CE0";
	 REG_ADDNSUB_1_RST    : string     := "RST0";
	 SHIFT_IN_A           : string     := "FALSE";
	 SHIFT_IN_B           : string     := "FALSE";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;
        ACCUMSLOAD : in STD_ULOGIC;
        ADDNSUB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;

        ACCUM0 : out STD_ULOGIC;
        ACCUM1 : out STD_ULOGIC;
        ACCUM2 : out STD_ULOGIC;
        ACCUM3 : out STD_ULOGIC;
        ACCUM4 : out STD_ULOGIC;
        ACCUM5 : out STD_ULOGIC;
        ACCUM6 : out STD_ULOGIC;
        ACCUM7 : out STD_ULOGIC;
        ACCUM8 : out STD_ULOGIC;
        ACCUM9 : out STD_ULOGIC;
        ACCUM10 : out STD_ULOGIC;
        ACCUM11 : out STD_ULOGIC;
        ACCUM12 : out STD_ULOGIC;
        ACCUM13 : out STD_ULOGIC;
        ACCUM14 : out STD_ULOGIC;
        ACCUM15 : out STD_ULOGIC;
        ACCUM16 : out STD_ULOGIC;
        ACCUM17 : out STD_ULOGIC;
        ACCUM18 : out STD_ULOGIC;
        ACCUM19 : out STD_ULOGIC;
        ACCUM20 : out STD_ULOGIC;
        ACCUM21 : out STD_ULOGIC;
        ACCUM22 : out STD_ULOGIC;
        ACCUM23 : out STD_ULOGIC;
        ACCUM24 : out STD_ULOGIC;
        ACCUM25 : out STD_ULOGIC;
        ACCUM26 : out STD_ULOGIC;
        ACCUM27 : out STD_ULOGIC;
        ACCUM28 : out STD_ULOGIC;
        ACCUM29 : out STD_ULOGIC;
        ACCUM30 : out STD_ULOGIC;
        ACCUM31 : out STD_ULOGIC;
        ACCUM32 : out STD_ULOGIC;
        ACCUM33 : out STD_ULOGIC;
        OVERFLOW : out STD_ULOGIC
       ); 
  end component;

  component MULT18X18
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDAB_0_CLK   : string     := "NONE";
	 REG_SIGNEDAB_0_CE    : string     := "CE0";
	 REG_SIGNEDAB_0_RST   : string     := "RST0";
	 REG_SIGNEDAB_1_CLK   : string     := "NONE";
	 REG_SIGNEDAB_1_CE    : string     := "CE0";
	 REG_SIGNEDAB_1_RST   : string     := "RST0";
	 SHIFT_IN_A           : string     := "FALSE";
	 SHIFT_IN_B           : string     := "FALSE";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;
        A9 : in STD_ULOGIC;
        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;
        B9 : in STD_ULOGIC;
        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        P0 : out STD_ULOGIC;
        P1 : out STD_ULOGIC;
        P2 : out STD_ULOGIC;
        P3 : out STD_ULOGIC;
        P4 : out STD_ULOGIC;
        P5 : out STD_ULOGIC;
        P6 : out STD_ULOGIC;
        P7 : out STD_ULOGIC;
        P8 : out STD_ULOGIC;
        P9 : out STD_ULOGIC;
        P10 : out STD_ULOGIC;
        P11 : out STD_ULOGIC;
        P12 : out STD_ULOGIC;
        P13 : out STD_ULOGIC;
        P14 : out STD_ULOGIC;
        P15 : out STD_ULOGIC;
        P16 : out STD_ULOGIC;
        P17 : out STD_ULOGIC;
        P18 : out STD_ULOGIC;
        P19 : out STD_ULOGIC;
        P20 : out STD_ULOGIC;
        P21 : out STD_ULOGIC;
        P22 : out STD_ULOGIC;
        P23 : out STD_ULOGIC;
        P24 : out STD_ULOGIC;
        P25 : out STD_ULOGIC;
        P26 : out STD_ULOGIC;
        P27 : out STD_ULOGIC;
        P28 : out STD_ULOGIC;
        P29 : out STD_ULOGIC;
        P30 : out STD_ULOGIC;
        P31 : out STD_ULOGIC;
        P32 : out STD_ULOGIC;
        P33 : out STD_ULOGIC;
        P34 : out STD_ULOGIC;
        P35 : out STD_ULOGIC
       ); 
  end component;

  component MULT18X18ADDSUB
  generic(
	 REG_INPUTA0_CLK       : string     := "NONE";
	 REG_INPUTA0_CE        : string     := "CE0";
	 REG_INPUTA0_RST       : string     := "RST0";
	 REG_INPUTA1_CLK       : string     := "NONE";
	 REG_INPUTA1_CE        : string     := "CE0";
	 REG_INPUTA1_RST       : string     := "RST0";
	 REG_INPUTB0_CLK       : string     := "NONE";
	 REG_INPUTB0_CE        : string     := "CE0";
	 REG_INPUTB0_RST       : string     := "RST0";
	 REG_INPUTB1_CLK       : string     := "NONE";
	 REG_INPUTB1_CE        : string     := "CE0";
	 REG_INPUTB1_RST       : string     := "RST0";
	 REG_PIPELINE0_CLK     : string     := "NONE";
	 REG_PIPELINE0_CE      : string     := "CE0";
	 REG_PIPELINE0_RST     : string     := "RST0";
	 REG_PIPELINE1_CLK     : string     := "NONE";
	 REG_PIPELINE1_CE      : string     := "CE0";
	 REG_PIPELINE1_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDAB_0_CLK   : string     := "NONE";
	 REG_SIGNEDAB_0_CE    : string     := "CE0";
	 REG_SIGNEDAB_0_RST   : string     := "RST0";
	 REG_SIGNEDAB_1_CLK   : string     := "NONE";
	 REG_SIGNEDAB_1_CE    : string     := "CE0";
	 REG_SIGNEDAB_1_RST   : string     := "RST0";
	 REG_ADDNSUB_0_CLK    : string     := "NONE";
	 REG_ADDNSUB_0_CE     : string     := "CE0";
	 REG_ADDNSUB_0_RST    : string     := "RST0";
	 REG_ADDNSUB_1_CLK    : string     := "NONE";
	 REG_ADDNSUB_1_CE     : string     := "CE0";
	 REG_ADDNSUB_1_RST    : string     := "RST0";
	 SHIFT_IN_A0          : string     := "FALSE";
	 SHIFT_IN_B0          : string     := "FALSE";
	 SHIFT_IN_A1          : string     := "FALSE";
	 SHIFT_IN_B1          : string     := "FALSE";
	 GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;
        A09 : in STD_ULOGIC;
        A010 : in STD_ULOGIC;
        A011 : in STD_ULOGIC;
        A012 : in STD_ULOGIC;
        A013 : in STD_ULOGIC;
        A014 : in STD_ULOGIC;
        A015 : in STD_ULOGIC;
        A016 : in STD_ULOGIC;
        A017 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;
        A19 : in STD_ULOGIC;
        A110 : in STD_ULOGIC;
        A111 : in STD_ULOGIC;
        A112 : in STD_ULOGIC;
        A113 : in STD_ULOGIC;
        A114 : in STD_ULOGIC;
        A115 : in STD_ULOGIC;
        A116 : in STD_ULOGIC;
        A117 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;
        B09 : in STD_ULOGIC;
        B010 : in STD_ULOGIC;
        B011 : in STD_ULOGIC;
        B012 : in STD_ULOGIC;
        B013 : in STD_ULOGIC;
        B014 : in STD_ULOGIC;
        B015 : in STD_ULOGIC;
        B016 : in STD_ULOGIC;
        B017 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;
        B19 : in STD_ULOGIC;
        B110 : in STD_ULOGIC;
        B111 : in STD_ULOGIC;
        B112 : in STD_ULOGIC;
        B113 : in STD_ULOGIC;
        B114 : in STD_ULOGIC;
        B115 : in STD_ULOGIC;
        B116 : in STD_ULOGIC;
        B117 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;
        ADDNSUB  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC;
        SUM19 : out STD_ULOGIC;
        SUM20 : out STD_ULOGIC;
        SUM21 : out STD_ULOGIC;
        SUM22 : out STD_ULOGIC;
        SUM23 : out STD_ULOGIC;
        SUM24 : out STD_ULOGIC;
        SUM25 : out STD_ULOGIC;
        SUM26 : out STD_ULOGIC;
        SUM27 : out STD_ULOGIC;
        SUM28 : out STD_ULOGIC;
        SUM29 : out STD_ULOGIC;
        SUM30 : out STD_ULOGIC;
        SUM31 : out STD_ULOGIC;
        SUM32 : out STD_ULOGIC;
        SUM33 : out STD_ULOGIC;
        SUM34 : out STD_ULOGIC;
        SUM35 : out STD_ULOGIC;
        SUM36 : out STD_ULOGIC
       ); 
  end component;

  component MULT18X18ADDSUBSUM
  generic(
	 REG_INPUTA0_CLK       : string     := "NONE";
	 REG_INPUTA0_CE        : string     := "CE0";
	 REG_INPUTA0_RST       : string     := "RST0";
	 REG_INPUTA1_CLK       : string     := "NONE";
	 REG_INPUTA1_CE        : string     := "CE0";
	 REG_INPUTA1_RST       : string     := "RST0";
	 REG_INPUTA2_CLK       : string     := "NONE";
	 REG_INPUTA2_CE        : string     := "CE0";
	 REG_INPUTA2_RST       : string     := "RST0";
	 REG_INPUTA3_CLK       : string     := "NONE";
	 REG_INPUTA3_CE        : string     := "CE0";
	 REG_INPUTA3_RST       : string     := "RST0";
	 REG_INPUTB0_CLK       : string     := "NONE";
	 REG_INPUTB0_CE        : string     := "CE0";
	 REG_INPUTB0_RST       : string     := "RST0";
	 REG_INPUTB1_CLK       : string     := "NONE";
	 REG_INPUTB1_CE        : string     := "CE0";
	 REG_INPUTB1_RST       : string     := "RST0";
	 REG_INPUTB2_CLK       : string     := "NONE";
	 REG_INPUTB2_CE        : string     := "CE0";
	 REG_INPUTB2_RST       : string     := "RST0";
	 REG_INPUTB3_CLK       : string     := "NONE";
	 REG_INPUTB3_CE        : string     := "CE0";
	 REG_INPUTB3_RST       : string     := "RST0";
	 REG_PIPELINE0_CLK     : string     := "NONE";
	 REG_PIPELINE0_CE      : string     := "CE0";
	 REG_PIPELINE0_RST     : string     := "RST0";
	 REG_PIPELINE1_CLK     : string     := "NONE";
	 REG_PIPELINE1_CE      : string     := "CE0";
	 REG_PIPELINE1_RST     : string     := "RST0";
	 REG_PIPELINE2_CLK     : string     := "NONE";
	 REG_PIPELINE2_CE      : string     := "CE0";
	 REG_PIPELINE2_RST     : string     := "RST0";
	 REG_PIPELINE3_CLK     : string     := "NONE";
	 REG_PIPELINE3_CE      : string     := "CE0";
	 REG_PIPELINE3_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDAB_0_CLK   : string     := "NONE";
	 REG_SIGNEDAB_0_CE    : string     := "CE0";
	 REG_SIGNEDAB_0_RST   : string     := "RST0";
	 REG_SIGNEDAB_1_CLK   : string     := "NONE";
	 REG_SIGNEDAB_1_CE    : string     := "CE0";
	 REG_SIGNEDAB_1_RST   : string     := "RST0";
	 REG_ADDNSUB1_0_CLK    : string     := "NONE";
	 REG_ADDNSUB1_0_CE     : string     := "CE0";
	 REG_ADDNSUB1_0_RST    : string     := "RST0";
	 REG_ADDNSUB1_1_CLK    : string     := "NONE";
	 REG_ADDNSUB1_1_CE     : string     := "CE0";
	 REG_ADDNSUB1_1_RST    : string     := "RST0";
	 REG_ADDNSUB3_0_CLK    : string     := "NONE";
	 REG_ADDNSUB3_0_CE     : string     := "CE0";
	 REG_ADDNSUB3_0_RST    : string     := "RST0";
	 REG_ADDNSUB3_1_CLK    : string     := "NONE";
	 REG_ADDNSUB3_1_CE     : string     := "CE0";
	 REG_ADDNSUB3_1_RST    : string     := "RST0";
	 SHIFT_IN_A0          : string     := "FALSE";
	 SHIFT_IN_B0          : string     := "FALSE";
	 SHIFT_IN_A1          : string     := "FALSE";
	 SHIFT_IN_B1          : string     := "FALSE";
	 SHIFT_IN_A2          : string     := "FALSE";
	 SHIFT_IN_B2          : string     := "FALSE";
	 SHIFT_IN_A3          : string     := "FALSE";
	 SHIFT_IN_B3          : string     := "FALSE";
	 GSR                  : string     := "ENABLED");
  port (
        A00 : in STD_ULOGIC;
        A01 : in STD_ULOGIC;
        A02 : in STD_ULOGIC;
        A03 : in STD_ULOGIC;
        A04 : in STD_ULOGIC;
        A05 : in STD_ULOGIC;
        A06 : in STD_ULOGIC;
        A07 : in STD_ULOGIC;
        A08 : in STD_ULOGIC;
        A09 : in STD_ULOGIC;
        A010 : in STD_ULOGIC;
        A011 : in STD_ULOGIC;
        A012 : in STD_ULOGIC;
        A013 : in STD_ULOGIC;
        A014 : in STD_ULOGIC;
        A015 : in STD_ULOGIC;
        A016 : in STD_ULOGIC;
        A017 : in STD_ULOGIC;

        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;
        A19 : in STD_ULOGIC;
        A110 : in STD_ULOGIC;
        A111 : in STD_ULOGIC;
        A112 : in STD_ULOGIC;
        A113 : in STD_ULOGIC;
        A114 : in STD_ULOGIC;
        A115 : in STD_ULOGIC;
        A116 : in STD_ULOGIC;
        A117 : in STD_ULOGIC;

        A20 : in STD_ULOGIC;
        A21 : in STD_ULOGIC;
        A22 : in STD_ULOGIC;
        A23 : in STD_ULOGIC;
        A24 : in STD_ULOGIC;
        A25 : in STD_ULOGIC;
        A26 : in STD_ULOGIC;
        A27 : in STD_ULOGIC;
        A28 : in STD_ULOGIC;
        A29 : in STD_ULOGIC;
        A210 : in STD_ULOGIC;
        A211 : in STD_ULOGIC;
        A212 : in STD_ULOGIC;
        A213 : in STD_ULOGIC;
        A214 : in STD_ULOGIC;
        A215 : in STD_ULOGIC;
        A216 : in STD_ULOGIC;
        A217 : in STD_ULOGIC;

        A30 : in STD_ULOGIC;
        A31 : in STD_ULOGIC;
        A32 : in STD_ULOGIC;
        A33 : in STD_ULOGIC;
        A34 : in STD_ULOGIC;
        A35 : in STD_ULOGIC;
        A36 : in STD_ULOGIC;
        A37 : in STD_ULOGIC;
        A38 : in STD_ULOGIC;
        A39 : in STD_ULOGIC;
        A310 : in STD_ULOGIC;
        A311 : in STD_ULOGIC;
        A312 : in STD_ULOGIC;
        A313 : in STD_ULOGIC;
        A314 : in STD_ULOGIC;
        A315 : in STD_ULOGIC;
        A316 : in STD_ULOGIC;
        A317 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B00 : in STD_ULOGIC;
        B01 : in STD_ULOGIC;
        B02 : in STD_ULOGIC;
        B03 : in STD_ULOGIC;
        B04 : in STD_ULOGIC;
        B05 : in STD_ULOGIC;
        B06 : in STD_ULOGIC;
        B07 : in STD_ULOGIC;
        B08 : in STD_ULOGIC;
        B09 : in STD_ULOGIC;
        B010 : in STD_ULOGIC;
        B011 : in STD_ULOGIC;
        B012 : in STD_ULOGIC;
        B013 : in STD_ULOGIC;
        B014 : in STD_ULOGIC;
        B015 : in STD_ULOGIC;
        B016 : in STD_ULOGIC;
        B017 : in STD_ULOGIC;

        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;
        B19 : in STD_ULOGIC;
        B110 : in STD_ULOGIC;
        B111 : in STD_ULOGIC;
        B112 : in STD_ULOGIC;
        B113 : in STD_ULOGIC;
        B114 : in STD_ULOGIC;
        B115 : in STD_ULOGIC;
        B116 : in STD_ULOGIC;
        B117 : in STD_ULOGIC;

        B20 : in STD_ULOGIC;
        B21 : in STD_ULOGIC;
        B22 : in STD_ULOGIC;
        B23 : in STD_ULOGIC;
        B24 : in STD_ULOGIC;
        B25 : in STD_ULOGIC;
        B26 : in STD_ULOGIC;
        B27 : in STD_ULOGIC;
        B28 : in STD_ULOGIC;
        B29 : in STD_ULOGIC;
        B210 : in STD_ULOGIC;
        B211 : in STD_ULOGIC;
        B212 : in STD_ULOGIC;
        B213 : in STD_ULOGIC;
        B214 : in STD_ULOGIC;
        B215 : in STD_ULOGIC;
        B216 : in STD_ULOGIC;
        B217 : in STD_ULOGIC;

        B30 : in STD_ULOGIC;
        B31 : in STD_ULOGIC;
        B32 : in STD_ULOGIC;
        B33 : in STD_ULOGIC;
        B34 : in STD_ULOGIC;
        B35 : in STD_ULOGIC;
        B36 : in STD_ULOGIC;
        B37 : in STD_ULOGIC;
        B38 : in STD_ULOGIC;
        B39 : in STD_ULOGIC;
        B310 : in STD_ULOGIC;
        B311 : in STD_ULOGIC;
        B312 : in STD_ULOGIC;
        B313 : in STD_ULOGIC;
        B314 : in STD_ULOGIC;
        B315 : in STD_ULOGIC;
        B316 : in STD_ULOGIC;
        B317 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;
        ADDNSUB1  : in STD_ULOGIC;
        ADDNSUB3  : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        SUM0 : out STD_ULOGIC;
        SUM1 : out STD_ULOGIC;
        SUM2 : out STD_ULOGIC;
        SUM3 : out STD_ULOGIC;
        SUM4 : out STD_ULOGIC;
        SUM5 : out STD_ULOGIC;
        SUM6 : out STD_ULOGIC;
        SUM7 : out STD_ULOGIC;
        SUM8 : out STD_ULOGIC;
        SUM9 : out STD_ULOGIC;
        SUM10 : out STD_ULOGIC;
        SUM11 : out STD_ULOGIC;
        SUM12 : out STD_ULOGIC;
        SUM13 : out STD_ULOGIC;
        SUM14 : out STD_ULOGIC;
        SUM15 : out STD_ULOGIC;
        SUM16 : out STD_ULOGIC;
        SUM17 : out STD_ULOGIC;
        SUM18 : out STD_ULOGIC;
        SUM19 : out STD_ULOGIC;
        SUM20 : out STD_ULOGIC;
        SUM21 : out STD_ULOGIC;
        SUM22 : out STD_ULOGIC;
        SUM23 : out STD_ULOGIC;
        SUM24 : out STD_ULOGIC;
        SUM25 : out STD_ULOGIC;
        SUM26 : out STD_ULOGIC;
        SUM27 : out STD_ULOGIC;
        SUM28 : out STD_ULOGIC;
        SUM29 : out STD_ULOGIC;
        SUM30 : out STD_ULOGIC;
        SUM31 : out STD_ULOGIC;
        SUM32 : out STD_ULOGIC;
        SUM33 : out STD_ULOGIC;
        SUM34 : out STD_ULOGIC;
        SUM35 : out STD_ULOGIC;
        SUM36 : out STD_ULOGIC;
        SUM37 : out STD_ULOGIC
       ); 
  end component;

  component MULT18X18MAC
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDAB_0_CLK   : string     := "NONE";
	 REG_SIGNEDAB_0_CE    : string     := "CE0";
	 REG_SIGNEDAB_0_RST   : string     := "RST0";
	 REG_SIGNEDAB_1_CLK   : string     := "NONE";
	 REG_SIGNEDAB_1_CE    : string     := "CE0";
	 REG_SIGNEDAB_1_RST   : string     := "RST0";
	 REG_ACCUMSLOAD_0_CLK : string     := "NONE";
	 REG_ACCUMSLOAD_0_CE  : string     := "CE0";
	 REG_ACCUMSLOAD_0_RST : string     := "RST0";
	 REG_ACCUMSLOAD_1_CLK : string     := "NONE";
	 REG_ACCUMSLOAD_1_CE  : string     := "CE0";
	 REG_ACCUMSLOAD_1_RST : string     := "RST0";
	 REG_ADDNSUB_0_CLK    : string     := "NONE";
	 REG_ADDNSUB_0_CE     : string     := "CE0";
	 REG_ADDNSUB_0_RST    : string     := "RST0";
	 REG_ADDNSUB_1_CLK    : string     := "NONE";
	 REG_ADDNSUB_1_CE     : string     := "CE0";
	 REG_ADDNSUB_1_RST    : string     := "RST0";
	 SHIFT_IN_A           : string     := "FALSE";
	 SHIFT_IN_B           : string     := "FALSE";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;
        A9 : in STD_ULOGIC;
        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;

        SRIA0 : in STD_ULOGIC;
        SRIA1 : in STD_ULOGIC;
        SRIA2 : in STD_ULOGIC;
        SRIA3 : in STD_ULOGIC;
        SRIA4 : in STD_ULOGIC;
        SRIA5 : in STD_ULOGIC;
        SRIA6 : in STD_ULOGIC;
        SRIA7 : in STD_ULOGIC;
        SRIA8 : in STD_ULOGIC;
        SRIA9 : in STD_ULOGIC;
        SRIA10 : in STD_ULOGIC;
        SRIA11 : in STD_ULOGIC;
        SRIA12 : in STD_ULOGIC;
        SRIA13 : in STD_ULOGIC;
        SRIA14 : in STD_ULOGIC;
        SRIA15 : in STD_ULOGIC;
        SRIA16 : in STD_ULOGIC;
        SRIA17 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;
        B9 : in STD_ULOGIC;
        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;

        SRIB0 : in STD_ULOGIC;
        SRIB1 : in STD_ULOGIC;
        SRIB2 : in STD_ULOGIC;
        SRIB3 : in STD_ULOGIC;
        SRIB4 : in STD_ULOGIC;
        SRIB5 : in STD_ULOGIC;
        SRIB6 : in STD_ULOGIC;
        SRIB7 : in STD_ULOGIC;
        SRIB8 : in STD_ULOGIC;
        SRIB9 : in STD_ULOGIC;
        SRIB10 : in STD_ULOGIC;
        SRIB11 : in STD_ULOGIC;
        SRIB12 : in STD_ULOGIC;
        SRIB13 : in STD_ULOGIC;
        SRIB14 : in STD_ULOGIC;
        SRIB15 : in STD_ULOGIC;
        SRIB16 : in STD_ULOGIC;
        SRIB17 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;
        ACCUMSLOAD : in STD_ULOGIC;
        ADDNSUB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        SROA0 : out STD_ULOGIC;
        SROA1 : out STD_ULOGIC;
        SROA2 : out STD_ULOGIC;
        SROA3 : out STD_ULOGIC;
        SROA4 : out STD_ULOGIC;
        SROA5 : out STD_ULOGIC;
        SROA6 : out STD_ULOGIC;
        SROA7 : out STD_ULOGIC;
        SROA8 : out STD_ULOGIC;
        SROA9 : out STD_ULOGIC;
        SROA10 : out STD_ULOGIC;
        SROA11 : out STD_ULOGIC;
        SROA12 : out STD_ULOGIC;
        SROA13 : out STD_ULOGIC;
        SROA14 : out STD_ULOGIC;
        SROA15 : out STD_ULOGIC;
        SROA16 : out STD_ULOGIC;
        SROA17 : out STD_ULOGIC;

        SROB0 : out STD_ULOGIC;
        SROB1 : out STD_ULOGIC;
        SROB2 : out STD_ULOGIC;
        SROB3 : out STD_ULOGIC;
        SROB4 : out STD_ULOGIC;
        SROB5 : out STD_ULOGIC;
        SROB6 : out STD_ULOGIC;
        SROB7 : out STD_ULOGIC;
        SROB8 : out STD_ULOGIC;
        SROB9 : out STD_ULOGIC;
        SROB10 : out STD_ULOGIC;
        SROB11 : out STD_ULOGIC;
        SROB12 : out STD_ULOGIC;
        SROB13 : out STD_ULOGIC;
        SROB14 : out STD_ULOGIC;
        SROB15 : out STD_ULOGIC;
        SROB16 : out STD_ULOGIC;
        SROB17 : out STD_ULOGIC;

        ACCUM0 : out STD_ULOGIC;
        ACCUM1 : out STD_ULOGIC;
        ACCUM2 : out STD_ULOGIC;
        ACCUM3 : out STD_ULOGIC;
        ACCUM4 : out STD_ULOGIC;
        ACCUM5 : out STD_ULOGIC;
        ACCUM6 : out STD_ULOGIC;
        ACCUM7 : out STD_ULOGIC;
        ACCUM8 : out STD_ULOGIC;
        ACCUM9 : out STD_ULOGIC;
        ACCUM10 : out STD_ULOGIC;
        ACCUM11 : out STD_ULOGIC;
        ACCUM12 : out STD_ULOGIC;
        ACCUM13 : out STD_ULOGIC;
        ACCUM14 : out STD_ULOGIC;
        ACCUM15 : out STD_ULOGIC;
        ACCUM16 : out STD_ULOGIC;
        ACCUM17 : out STD_ULOGIC;
        ACCUM18 : out STD_ULOGIC;
        ACCUM19 : out STD_ULOGIC;
        ACCUM20 : out STD_ULOGIC;
        ACCUM21 : out STD_ULOGIC;
        ACCUM22 : out STD_ULOGIC;
        ACCUM23 : out STD_ULOGIC;
        ACCUM24 : out STD_ULOGIC;
        ACCUM25 : out STD_ULOGIC;
        ACCUM26 : out STD_ULOGIC;
        ACCUM27 : out STD_ULOGIC;
        ACCUM28 : out STD_ULOGIC;
        ACCUM29 : out STD_ULOGIC;
        ACCUM30 : out STD_ULOGIC;
        ACCUM31 : out STD_ULOGIC;
        ACCUM32 : out STD_ULOGIC;
        ACCUM33 : out STD_ULOGIC;
        ACCUM34 : out STD_ULOGIC;
        ACCUM35 : out STD_ULOGIC;
        ACCUM36 : out STD_ULOGIC;
        ACCUM37 : out STD_ULOGIC;
        ACCUM38 : out STD_ULOGIC;
        ACCUM39 : out STD_ULOGIC;
        ACCUM40 : out STD_ULOGIC;
        ACCUM41 : out STD_ULOGIC;
        ACCUM42 : out STD_ULOGIC;
        ACCUM43 : out STD_ULOGIC;
        ACCUM44 : out STD_ULOGIC;
        ACCUM45 : out STD_ULOGIC;
        ACCUM46 : out STD_ULOGIC;
        ACCUM47 : out STD_ULOGIC;
        ACCUM48 : out STD_ULOGIC;
        ACCUM49 : out STD_ULOGIC;
        ACCUM50 : out STD_ULOGIC;
        ACCUM51 : out STD_ULOGIC;
        OVERFLOW : out STD_ULOGIC
       ); 
  end component;

  component MULT36X36
  generic(
	 REG_INPUTA_CLK       : string     := "NONE";
	 REG_INPUTA_CE        : string     := "CE0";
	 REG_INPUTA_RST       : string     := "RST0";
	 REG_INPUTB_CLK       : string     := "NONE";
	 REG_INPUTB_CE        : string     := "CE0";
	 REG_INPUTB_RST       : string     := "RST0";
	 REG_PIPELINE_CLK     : string     := "NONE";
	 REG_PIPELINE_CE      : string     := "CE0";
	 REG_PIPELINE_RST     : string     := "RST0";
	 REG_OUTPUT_CLK       : string     := "NONE";
	 REG_OUTPUT_CE        : string     := "CE0";
	 REG_OUTPUT_RST       : string     := "RST0";
	 REG_SIGNEDAB_0_CLK   : string     := "NONE";
	 REG_SIGNEDAB_0_CE    : string     := "CE0";
	 REG_SIGNEDAB_0_RST   : string     := "RST0";
	 REG_SIGNEDAB_1_CLK   : string     := "NONE";
	 REG_SIGNEDAB_1_CE    : string     := "CE0";
	 REG_SIGNEDAB_1_RST   : string     := "RST0";
	 GSR                  : string     := "ENABLED");
  port (
        A0 : in STD_ULOGIC;
        A1 : in STD_ULOGIC;
        A2 : in STD_ULOGIC;
        A3 : in STD_ULOGIC;
        A4 : in STD_ULOGIC;
        A5 : in STD_ULOGIC;
        A6 : in STD_ULOGIC;
        A7 : in STD_ULOGIC;
        A8 : in STD_ULOGIC;
        A9 : in STD_ULOGIC;
        A10 : in STD_ULOGIC;
        A11 : in STD_ULOGIC;
        A12 : in STD_ULOGIC;
        A13 : in STD_ULOGIC;
        A14 : in STD_ULOGIC;
        A15 : in STD_ULOGIC;
        A16 : in STD_ULOGIC;
        A17 : in STD_ULOGIC;
        A18 : in STD_ULOGIC;
        A19 : in STD_ULOGIC;
        A20 : in STD_ULOGIC;
        A21 : in STD_ULOGIC;
        A22 : in STD_ULOGIC;
        A23 : in STD_ULOGIC;
        A24 : in STD_ULOGIC;
        A25 : in STD_ULOGIC;
        A26 : in STD_ULOGIC;
        A27 : in STD_ULOGIC;
        A28 : in STD_ULOGIC;
        A29 : in STD_ULOGIC;
        A30 : in STD_ULOGIC;
        A31 : in STD_ULOGIC;
        A32 : in STD_ULOGIC;
        A33 : in STD_ULOGIC;
        A34 : in STD_ULOGIC;
        A35 : in STD_ULOGIC;

        B0 : in STD_ULOGIC;
        B1 : in STD_ULOGIC;
        B2 : in STD_ULOGIC;
        B3 : in STD_ULOGIC;
        B4 : in STD_ULOGIC;
        B5 : in STD_ULOGIC;
        B6 : in STD_ULOGIC;
        B7 : in STD_ULOGIC;
        B8 : in STD_ULOGIC;
        B9 : in STD_ULOGIC;
        B10 : in STD_ULOGIC;
        B11 : in STD_ULOGIC;
        B12 : in STD_ULOGIC;
        B13 : in STD_ULOGIC;
        B14 : in STD_ULOGIC;
        B15 : in STD_ULOGIC;
        B16 : in STD_ULOGIC;
        B17 : in STD_ULOGIC;
        B18 : in STD_ULOGIC;
        B19 : in STD_ULOGIC;
        B20 : in STD_ULOGIC;
        B21 : in STD_ULOGIC;
        B22 : in STD_ULOGIC;
        B23 : in STD_ULOGIC;
        B24 : in STD_ULOGIC;
        B25 : in STD_ULOGIC;
        B26 : in STD_ULOGIC;
        B27 : in STD_ULOGIC;
        B28 : in STD_ULOGIC;
        B29 : in STD_ULOGIC;
        B30 : in STD_ULOGIC;
        B31 : in STD_ULOGIC;
        B32 : in STD_ULOGIC;
        B33 : in STD_ULOGIC;
        B34 : in STD_ULOGIC;
        B35 : in STD_ULOGIC;

        SIGNEDAB : in STD_ULOGIC;

        CE0 : in STD_ULOGIC;
        CE1 : in STD_ULOGIC;
        CE2 : in STD_ULOGIC;
        CE3 : in STD_ULOGIC;

        CLK0 : in STD_ULOGIC;
        CLK1 : in STD_ULOGIC;
        CLK2 : in STD_ULOGIC;
        CLK3 : in STD_ULOGIC;

        RST0 : in STD_ULOGIC;
        RST1 : in STD_ULOGIC;
        RST2 : in STD_ULOGIC;
        RST3 : in STD_ULOGIC;

        P0 : out STD_ULOGIC;
        P1 : out STD_ULOGIC;
        P2 : out STD_ULOGIC;
        P3 : out STD_ULOGIC;
        P4 : out STD_ULOGIC;
        P5 : out STD_ULOGIC;
        P6 : out STD_ULOGIC;
        P7 : out STD_ULOGIC;
        P8 : out STD_ULOGIC;
        P9 : out STD_ULOGIC;
        P10 : out STD_ULOGIC;
        P11 : out STD_ULOGIC;
        P12 : out STD_ULOGIC;
        P13 : out STD_ULOGIC;
        P14 : out STD_ULOGIC;
        P15 : out STD_ULOGIC;
        P16 : out STD_ULOGIC;
        P17 : out STD_ULOGIC;
        P18 : out STD_ULOGIC;
        P19 : out STD_ULOGIC;
        P20 : out STD_ULOGIC;
        P21 : out STD_ULOGIC;
        P22 : out STD_ULOGIC;
        P23 : out STD_ULOGIC;
        P24 : out STD_ULOGIC;
        P25 : out STD_ULOGIC;
        P26 : out STD_ULOGIC;
        P27 : out STD_ULOGIC;
        P28 : out STD_ULOGIC;
        P29 : out STD_ULOGIC;
        P30 : out STD_ULOGIC;
        P31 : out STD_ULOGIC;
        P32 : out STD_ULOGIC;
        P33 : out STD_ULOGIC;
        P34 : out STD_ULOGIC;
        P35 : out STD_ULOGIC;
        P36 : out STD_ULOGIC;
        P37 : out STD_ULOGIC;
        P38 : out STD_ULOGIC;
        P39 : out STD_ULOGIC;
        P40 : out STD_ULOGIC;
        P41 : out STD_ULOGIC;
        P42 : out STD_ULOGIC;
        P43 : out STD_ULOGIC;
        P44 : out STD_ULOGIC;
        P45 : out STD_ULOGIC;
        P46 : out STD_ULOGIC;
        P47 : out STD_ULOGIC;
        P48 : out STD_ULOGIC;
        P49 : out STD_ULOGIC;
        P50 : out STD_ULOGIC;
        P51 : out STD_ULOGIC;
        P52 : out STD_ULOGIC;
        P53 : out STD_ULOGIC;
        P54 : out STD_ULOGIC;
        P55 : out STD_ULOGIC;
        P56 : out STD_ULOGIC;
        P57 : out STD_ULOGIC;
        P58 : out STD_ULOGIC;
        P59 : out STD_ULOGIC;
        P60 : out STD_ULOGIC;
        P61 : out STD_ULOGIC;
        P62 : out STD_ULOGIC;
        P63 : out STD_ULOGIC;
        P64 : out STD_ULOGIC;
        P65 : out STD_ULOGIC;
        P66 : out STD_ULOGIC;
        P67 : out STD_ULOGIC;
        P68 : out STD_ULOGIC;
        P69 : out STD_ULOGIC;
        P70 : out STD_ULOGIC;
        P71 : out STD_ULOGIC
       ); 
  end component;

end Components;

package body Components is
    function str2std(L: string) return std_logic_vector is
        variable vpos : integer := 0;   -- Index of last valid bit in val.
        variable lpos : integer;        -- Index of next unused char in L.
        variable val  : std_logic_vector(1 to L'right); -- lenth of the vector.
    begin
            lpos := L'left;
            while lpos <= L'right and vpos < VAL'length loop
                if L(lpos) = '0' then
                    vpos := vpos + 1;
                    val(vpos) := '0';
                elsif L(lpos) = '1' then
                    vpos := vpos + 1;
                    val(vpos) := '1';
                else
                    exit;       -- Bit values must be '0' or '1'.
                end if;
                lpos := lpos + 1;
            end loop;
        return val;
    end str2std;

 function str2int( L : string) return integer is
        variable ok:         boolean;
        variable pos:        integer:=1;
        variable sign: integer := 1;
        variable rval: integer := 0;
        variable value: integer := 0;
    begin
        ok := FALSE;
        if pos < L'right and (L(pos) = '-' or L(pos) = '+') then
            if L(pos) = '-' then
                sign := -1;
            end if;
            pos := pos + 1;
        end if;

        -- Once the optional leading sign is removed, an integer can
        --   contain only the digits '0' through '9' and the '_'
        --   (underscore) character.  VHDL disallows two successive
        --   underscores, and leading or trailing underscores.

        if pos <= L'right and L(pos) >= '0' and L(pos) <= '9' then
            while pos <= L'right loop
                if L(pos) >= '0' and L(pos) <= '9' then
                    rval := rval * 10
                            + character'pos(L(pos)) - character'pos('0');
                    ok := TRUE;
                elsif L(pos) = '_' then
                    if pos = L'right
                    or L(pos + 1) < '0'
                    or L(pos + 1) > '9' then
                        ok := FALSE;
                        exit;
                    end if;
                else
                    exit;
                end if;
                pos := pos + 1;
            end loop;
        end if;

        value := sign * rval;
        RETURN(value);
    end str2int;

    function str2real( L: string) return real is
        variable pos:        integer;
        variable value:      real;
        variable ok:         boolean;
        variable sign:       real := 1.0;
        variable rval:       real := 0.0;
        variable powerten:   real := 0.1;

        begin

        pos := L'left;
        if (pos <= L'right) and (L(pos) = '-') then
            sign := -1.0;
            pos := pos + 1;
        end if;

            ok := FALSE;
            rval := 0.0;
            if pos <= L'right and L(pos) >= '0' and L(pos) <= '9' then
                while pos <= L'right and L(pos) /= '.' and L(pos) /= ' ' and L(pos) /= HT
  loop
                    if L(pos) >= '0' and L(pos) <= '9' then
                        rval := rval*10.0 + real(character'pos(L(pos)) - character'pos('0'));
                        pos := pos+1;
                        ok := true;
                    else
                        ok := false;
                        exit;
                    end if;
                end loop;
            end if;

            if ok and pos <= L'right and L(pos) = '.' then
            pos := pos + 1;
            end if;

            if pos <= L'right then
               while pos <= L'right and ((L(pos) >= '0' and L(pos) <= '9') or L(pos) = '_') loop
                       rval := rval + (real(character'pos(L(pos))-character'pos('0'))*powerten);
                       powerten := powerten*0.1;
                      pos := pos+1;
                     ok := true;
            end loop;
        end if;

        if ok then
            value := rval * sign;
        end if;
        return (value);
      end str2real;

  function INT2VEC(INT: INTEGER; BWIDTH: INTEGER) RETURN STD_LOGIC_VECTOR is

     variable result : STD_LOGIC_VECTOR (BWIDTH-1 downto 0);
     variable tmp : integer := INT;
  begin
     tmp := INT;
     for i in 0 to BWIDTH-1 loop
         if (tmp mod 2) = 1 then
              result(i) := '1';
         else
              result(i) := '0';
         end if;
         if tmp > 0 then
             tmp := tmp /2 ;
         elsif (tmp > integer'low) then
             tmp := (tmp-1) / 2;
         else
             tmp := tmp / 2;
         end if;
     end loop;
     return result;
  end;

  function VEC2INT(v: std_logic_vector) return integer is
      variable result: integer := 0;
      variable addition: integer := 1;
  begin
      for b in v'reverse_range loop
         if v(b) = '1' then
            result := result + addition;
         end if;
         addition := addition * 2;
      end loop;
      return result;
  end VEC2INT;

  function VECX              (VECT: std_logic_vector) return boolean is
   begin
      for b in VECT'range loop
         if bitX (VECT (b)) then
            return true;
         end if;
      end loop;
      return false;
   end VECX;

  function TSCOMP(VECT: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR is
    variable result : STD_LOGIC_VECTOR (VECT'left downto 0);
    variable is1 : std_ulogic := '0';
  begin
    for i in 0 to VECT'left loop
      if (is1 = '0') then
        result(i) := VECT(i);
        if (VECT(i) = '1' ) then
           is1 := '1';
        end if;
      else
        result(i) := NOT VECT(i);
      end if;
    end loop;
    return result;
  end;

  function ADDVECT(A, B: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR is

    variable cout: STD_ULOGIC;
    variable BVect, result: STD_LOGIC_VECTOR(A'left downto 0);

  begin
    for i in 0 to A'left loop
    if (A(i) = 'X') then
       result := (others => 'X');
       return(result);
    end if;
    end loop;
    for i in 0 to B'left loop
    if (B(i) = 'X') then
       result := (others => 'X');
       return(result);
    end if;
    end loop;

    cout := '0';
    BVEct := B;

    for i in 0 to A'left loop
      result(i) := A(i) xor BVect(i) xor cout;
      cout := (A(i) and BVect(i)) or
              (A(i) and cout) or
              (cout and BVect(i));
    end loop;
    return result;
  end;

  function SUBVECT(A, B: STD_LOGIC_VECTOR ) RETURN STD_LOGIC_VECTOR is

    variable cout: STD_ULOGIC;
    variable result: STD_LOGIC_VECTOR(A'left downto 0);

  begin
    for i in 0 to A'left loop
    if (A(i) = 'X') then
       result := (others => 'X');
       return(result);
    end if;
    end loop;
    for i in 0 to B'left loop
    if (B(i) = 'X') then
       result := (others => 'X');
       return(result);
    end if;
    end loop;

    cout := '1';

    for i in 0 to A'left loop
      result(i) := A(i) xor not B(i) xor cout;
      cout := (A(i) and not B(i)) or
              (A(i) and cout) or
              (cout and not B(i));
    end loop;
    return result;
  end;

  function BITX              (VECT: std_logic) return boolean is
   begin
      case VECT is
         when 'X'    => return true;
         when others => return false;
      end case;
   end BITX;

END components;

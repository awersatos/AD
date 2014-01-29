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
-- Simulation Library File for ECP3
--
-- $Header:  
--

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
COMPONENT aneb2
PORT(
        a0, a1: IN std_logic := 'X';
        b0, b1: IN std_logic := 'X';
        ci: IN std_logic := 'X';
        ne: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT CCU2C
   generic (
      inject1_0 : string := "YES";
      inject1_1 : string := "YES";
      init0: std_logic_vector(15 downto 0) := "0000000000000000";
      init1: std_logic_vector(15 downto 0) := "0000000000000000"
   );
   port (
      A0,A1 : in std_ulogic;
      B0,B1 : in std_ulogic;
      C0,C1 : in std_ulogic;
      D0,D1 : in std_ulogic;
      CIN : in std_ulogic;
      S0,S1 : out std_ulogic;
      COUT : out std_ulogic
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
COMPONENT JTAGE
    GENERIC (ER1 : string := "ENABLED";
             ER2 : string := "ENABLED");
PORT(
      TCK                : IN   std_logic := 'X';
      TMS                : IN   std_logic := 'X';
      TDI                : IN   std_logic := 'X';
      JTDO1              : IN   std_logic := 'X';
      JTDO2              : IN   std_logic := 'X';
      TDO                : OUT  std_logic;
      JTCK               : OUT  std_logic;
      JTDI               : OUT  std_logic;
      JSHIFT             : OUT  std_logic;
      JUPDATE            : OUT  std_logic;
      JRSTN              : OUT  std_logic;
      JCE1               : OUT  std_logic;
      JCE2               : OUT  std_logic;
      JRTI1              : OUT  std_logic;
      JRTI2              : OUT  std_logic);
END COMPONENT;
--
COMPONENT SEDCA
  generic(
         OSC_DIV       : integer  := 1;
         CHECKALWAYS   : string   := "DISABLED";
         AUTORECONFIG  : string   := "OFF";
         MCCLK_FREQ    : string   := "2.5";
         DEV_DENSITY   : string   := "95K");
PORT(
      SEDENABLE        : in std_logic;
      SEDSTART         : in std_logic;
      SEDFRCERR        : in std_logic;
      SEDERR           : out std_logic;
      SEDDONE          : out std_logic;
      SEDINPROG        : out std_logic;
      SEDCLKOUT        : out std_logic;
      AUTODONE         : out std_logic);
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
COMPONENT ehxpllf
    GENERIC (
      FIN                : string    := "100.0";
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 8;
      CLKOK_DIV          : Integer   := 2;
      PHASEADJ           : String    := "0.0";
      DUTY               : Integer   := 8;
      PHASE_DELAY_CNTL   : String    := "STATIC";
      CLKOP_BYPASS       : String    := "DISABLED";
      CLKOS_BYPASS       : String    := "DISABLED";
      CLKOK_BYPASS       : String    := "DISABLED";
      CLKOP_TRIM_POL     : String    := "RISING";
      CLKOP_TRIM_DELAY   : Integer   := 0;
      CLKOS_TRIM_POL     : String    := "RISING";
      CLKOS_TRIM_DELAY   : Integer   := 0;
      DELAY_VAL          : Integer   := 0;
      DELAY_PWD          : String    := "DISABLED";
      CLKOK_INPUT        : String    := "CLKOP";
      LOCK_DELAY         : Integer   := 100);
PORT(
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rst                   : in std_logic;
      rstk                  : in std_logic;
      drpai3                : in std_logic;
      drpai2                : in std_logic;
      drpai1                : in std_logic;
      drpai0                : in std_logic;
      dfpai3                : in std_logic;
      dfpai2                : in std_logic;
      dfpai1                : in std_logic;
      dfpai0                : in std_logic;
      fda3                  : in std_logic;
      fda2                  : in std_logic;
      fda1                  : in std_logic;
      fda0                  : in std_logic;
      wrdel                 : in std_logic;
      clkop                 : out std_logic;
      clkos                 : out std_logic;
      clkok                 : out std_logic;
      clkok2                : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic);
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
COMPONENT fadd2b
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        ci: IN std_logic := 'X';
        cout : OUT std_logic := 'X';
        s0, s1 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fsub2b
PORT(
        a0, a1 : IN std_logic := 'X';
        b0, b1 : IN std_logic := 'X';
        bi: IN std_logic := 'X';
        bout : OUT std_logic := 'X';
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
COMPONENT ofd1s3ax
    GENERIC (gsr : String := "DISABLED");
PORT(
     d : IN std_logic := 'X';
     sclk: IN std_logic := 'X';
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
COMPONENT rom16x1a
GENERIC(
        initval : std_logic_vector(15 downto 0) := "0000000000000000"
  );
PORT( 
	ad0, ad1, ad2, ad3: IN std_logic := 'X';
	do0: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT rom32x1a
GENERIC(
        initval : std_logic_vector(31 downto 0) := "00000000000000000000000000000000"
  );
PORT( 
	ad0, ad1, ad2, ad3, ad4: IN std_logic := 'X';
	do0: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT rom64x1a
GENERIC(
        initval : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT rom128x1a
GENERIC(
        initval : std_logic_vector(127 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5, ad6 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT rom256x1a
GENERIC(
        initval : std_logic_vector(255 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7 : IN std_logic := 'X';
        do0: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT spr16x4c
GENERIC(
        initval : string := "0x0000000000000000"
  );
PORT(
        di0  : IN std_logic;
        di1  : IN std_logic;
        di2  : IN std_logic;
        di3  : IN std_logic;
        ck  : IN std_logic;
        wre  : IN std_logic;
        ad0 : IN std_logic;
        ad1 : IN std_logic;
        ad2 : IN std_logic;
        ad3 : IN std_logic;
        do0 : OUT std_logic;
        do1 : OUT std_logic;
        do2 : OUT std_logic;
        do3 : OUT std_logic);
END COMPONENT;
--
COMPONENT dpr16x4c
GENERIC(
        initval : string := "0x0000000000000000"
  );
PORT(
        di0  : IN std_logic;
        di1  : IN std_logic;
        di2  : IN std_logic;
        di3  : IN std_logic;
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
        do0 : OUT std_logic;
        do1 : OUT std_logic;
        do2 : OUT std_logic;
        do3 : OUT std_logic);
END COMPONENT;
--
COMPONENT start
PORT( 
	startclk : IN std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT SPIM
PORT(
       SEL           : in std_logic;
       A0            : in std_logic;
       A1            : in std_logic;
       A2            : in std_logic;
       A3            : in std_logic;
       A4            : in std_logic;
       A5            : in std_logic;
       A6            : in std_logic;
       A7            : in std_logic);
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
COMPONENT bbw
PORT(
        b:  INOUT std_logic := 'X';
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
COMPONENT obco
PORT(
        i :  IN std_logic := 'X';
        ot:  OUT std_logic;
        oc:  OUT std_logic);
END COMPONENT;
--
COMPONENT obw
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
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
COMPONENT oscf
GENERIC(
      NOM_FREQ         : String  := "2.5");
PORT(
        osc            : OUT std_logic);
END COMPONENT;
--
COMPONENT CLKDIVB
GENERIC(
      GSR         : String  := "DISABLED");
PORT(
        clki              : IN std_logic;
        rst              : IN std_logic;
        release               : IN std_logic;
        cdiv1            : OUT std_logic;
        cdiv2            : OUT std_logic;
        cdiv4            : OUT std_logic;
        cdiv8            : OUT std_logic);
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
COMPONENT ODDRXD
  generic(
         MEMMODE        : string := "DISABLED");
PORT(
          DA            :       in      STD_LOGIC;
          DB            :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          DQCLK1        :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC);
END COMPONENT;
--
COMPONENT ODDRXD1
PORT(
          DA            :       in      STD_LOGIC;
          DB            :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC);
END COMPONENT;
--
COMPONENT ODDRX2D
  generic(
         ISI_CAL        : string := "BYPASS";
         MEMMODE        : string := "DISABLED");
PORT(
          DA0           :       in      STD_LOGIC;
          DB0           :       in      STD_LOGIC;
          DA1           :       in      STD_LOGIC;
          DB1           :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          DQCLK0        :       in      STD_LOGIC;
          DQCLK1        :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC);
END COMPONENT;
--
COMPONENT ODDRTDQA
PORT(
          TA            :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          DQCLK0        :       in      STD_LOGIC;
          DQCLK1        :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC);
END COMPONENT;
--
COMPONENT ODDRXDQSA
  generic(
         MEMMODE        : string := "DISABLED");
PORT(
          DA            :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          DQSW          :       in      STD_LOGIC;
          DQCLK1        :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC;
          DQSTCLK       :       out     STD_LOGIC);
END COMPONENT;
--
COMPONENT ODDRTDQSA
PORT(
          TA            :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          DQSTCLK       :       in      STD_LOGIC;
          DQSW          :       in      STD_LOGIC;
          DB            :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC);
END COMPONENT;
--
COMPONENT ODDRX2DQSA
  generic(
         ISI_CAL        : string := "BYPASS";
         MEMMODE        : string := "DISABLED");
PORT(
          DB0           :       in      STD_LOGIC;
          DB1           :       in      STD_LOGIC;
          SCLK          :       in      STD_LOGIC;
          DQCLK0        :       in      STD_LOGIC;
          DQCLK1        :       in      STD_LOGIC;
          DQSW          :       in      STD_LOGIC;
          Q             :       out     STD_LOGIC;
          DQSTCLK       :       out     STD_LOGIC);
END COMPONENT;
--
COMPONENT IDDRXD
  generic(
         SCLKLATENCY    : integer := 1;
         DELAYMODE    : string := "ALIGNED");
PORT(
        D               : IN std_logic;
        SCLK            : IN std_logic;
        ECLKDQSR        : IN std_logic;
        DDRCLKPOL       : IN std_logic;
        QA              : OUT std_logic;
        QB              : OUT std_logic);
END COMPONENT;
--
COMPONENT IDDRXD1
PORT(
        D               : IN std_logic;
        SCLK            : IN std_logic;
        QA              : OUT std_logic;
        QB              : OUT std_logic);
END COMPONENT;
--
COMPONENT IDDRX2D
  generic(
         SCLKLATENCY    : integer := 1;
         DELAYMODE    : string := "ALIGNED");
PORT(
        D               : IN std_logic;
        SCLK            : IN std_logic;
        ECLK            : IN std_logic;
        ECLKDQSR        : IN std_logic;
        DDRLAT          : IN std_logic;
        DDRCLKPOL       : IN std_logic;
        QA0             : OUT std_logic;
        QB0             : OUT std_logic;
        QA1             : OUT std_logic;
        QB1             : OUT std_logic);
END COMPONENT;
--
COMPONENT IDDRX2D1
  generic(
         DR_CONFIG        : string := "DISABLED");
PORT(
        D               : IN std_logic;
        SCLK            : IN std_logic;
        ECLK            : IN std_logic;
        QA0             : OUT std_logic;
        QB0             : OUT std_logic;
        QA1             : OUT std_logic;
        QB1             : OUT std_logic);
END COMPONENT;
--
COMPONENT DQSBUFD
  generic(
         NRZMODE        : string := "DISABLED";
         DYNDEL_TYPE     : string := "NORMAL";
         DYNDEL_VAL     : integer := 0;
         DYNDEL_CNTL    : string := "DYNAMIC");
PORT(
          DQSI          :       IN      std_logic;
          SCLK          :       IN      std_logic;
          READ          :       IN      std_logic;
          DQSDEL        :       IN      std_logic;
          ECLK          :       IN      std_logic;
          ECLKW         :       IN      std_logic;
          RST           :       IN      std_logic;
          DYNDELPOL     :       IN      std_logic;
          DYNDELAY6     :       IN      std_logic;
          DYNDELAY5     :       IN      std_logic;
          DYNDELAY4     :       IN      std_logic;
          DYNDELAY3     :       IN      std_logic;
          DYNDELAY2     :       IN      std_logic;
          DYNDELAY1     :       IN      std_logic;
          DYNDELAY0     :       IN      std_logic;
          DQSW          :       OUT     std_logic;
          DDRCLKPOL     :       OUT     std_logic;
          PRMBDET       :       OUT     std_logic;
          DATAVALID     :       OUT     std_logic;
          DDRLAT        :       OUT     std_logic;
          ECLKDQSR      :       OUT     std_logic;
          DQCLK0        :       OUT     std_logic;
          DQCLK1        :       OUT     std_logic);
END COMPONENT;
--
COMPONENT DQSBUFE
  generic(
         DYNDEL_TYPE    : string := "NORMAL";
         DYNDEL_VAL     : integer := 0;
         DYNDEL_CNTL    : string := "DYNAMIC");
PORT(
          SCLK          :       IN      std_logic;
          ECLK          :       IN      std_logic;
          ECLKW         :       IN      std_logic;
          RST           :       IN      std_logic;
          DYNDELPOL     :       IN      std_logic;
          DYNDELAY6     :       IN      std_logic;
          DYNDELAY5     :       IN      std_logic;
          DYNDELAY4     :       IN      std_logic;
          DYNDELAY3     :       IN      std_logic;
          DYNDELAY2     :       IN      std_logic;
          DYNDELAY1     :       IN      std_logic;
          DYNDELAY0     :       IN      std_logic;
          DQCLK0        :       OUT     std_logic;
          DQCLK1        :       OUT     std_logic;
          DDRCLKPOL     :       OUT     std_logic;
          DDRLAT        :       OUT     std_logic
        );
END COMPONENT;
--
COMPONENT DQSBUFE1
  generic(
         DYNDEL_TYPE    : string := "NORMAL";
         DYNDEL_VAL     : integer := 0;
         DYNDEL_CNTL    : string := "DYNAMIC");
PORT(
          ECLK          :       IN      std_logic;
          ECLKW         :       IN      std_logic;
          RST           :       IN      std_logic;
          DYNDELPOL     :       IN      std_logic;
          DYNDELAY6     :       IN      std_logic;
          DYNDELAY5     :       IN      std_logic;
          DYNDELAY4     :       IN      std_logic;
          DYNDELAY3     :       IN      std_logic;
          DYNDELAY2     :       IN      std_logic;
          DYNDELAY1     :       IN      std_logic;
          DYNDELAY0     :       IN      std_logic;
          DQCLK0        :       OUT     std_logic;
          DQCLK1        :       OUT     std_logic
        );
END COMPONENT;
--
COMPONENT DQSBUFF
PORT(
          DQSI          :       IN      std_logic;
          SCLK          :       IN      std_logic;
          READ          :       IN      std_logic;
          DQSDEL        :       IN      std_logic;
          DQSW          :       OUT     std_logic;
          DDRCLKPOL     :       OUT     std_logic;
          PRMBDET       :       OUT     std_logic;
          DATAVALID     :       OUT     std_logic;
          ECLKDQSR      :       OUT     std_logic;
          DQCLK1        :       OUT     std_logic);
END COMPONENT;
--
COMPONENT DQSBUFG
PORT(
          SCLK          :       IN      std_logic;
          DDRCLKPOL     :       OUT     std_logic;
          DQCLK1        :       OUT     std_logic);
END COMPONENT;
--
COMPONENT DQSDLLB
  generic( LOCK_SENSITIVITY : string := "LOW" );
  PORT(
          CLK           :       in      STD_ULOGIC;
          RST           :       in      STD_ULOGIC;
          UDDCNTLN      :       in      STD_ULOGIC;
          LOCK          :       out     STD_ULOGIC;
          DQSDEL        :       out     STD_ULOGIC);
END COMPONENT;
--
COMPONENT delayb
PORT(
      a             : IN std_logic;
      del0          : IN std_logic;
      del1          : IN std_logic;
      del2          : IN std_logic;
      del3          : IN std_logic;
      z             : OUT std_logic);
END COMPONENT;
--
COMPONENT delayc
PORT(
      a             : IN std_logic;
      z             : OUT std_logic);
END COMPONENT;
--
------Component LUT4------
component LUT4
    generic(  INIT      :       std_logic_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component LUT5------
component LUT5
    generic(  INIT      :       std_logic_vector);
    port(
          A             :       in      STD_ULOGIC;
          B             :       in      STD_ULOGIC;
          C             :       in      STD_ULOGIC;
          D             :       in      STD_ULOGIC;
          E             :       in      STD_ULOGIC;
          Z             :       out     STD_ULOGIC
        );
end component;

------Component LUT6------
component LUT6
    generic(  INIT      :       std_logic_vector);
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

------Component LUT7------
component LUT7
    generic(  INIT      :       std_logic_vector);
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

------Component LUT8------
component LUT8
    generic(  INIT      :       std_logic_vector);
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
  component MULT9X9B
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
         REG_SIGNEDA_CLK   : string     := "NONE";
         REG_SIGNEDA_CE    : string     := "CE0";
         REG_SIGNEDA_RST   : string     := "RST0";
         REG_SIGNEDB_CLK   : string     := "NONE";
         REG_SIGNEDB_CE    : string     := "CE0";
         REG_SIGNEDB_RST   : string     := "RST0";
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

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA : in STD_ULOGIC;
        SOURCEB : in STD_ULOGIC;

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

  component MULT9X9ADDSUBB
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
         REG_SIGNEDA_0_CLK   : string     := "NONE";
         REG_SIGNEDA_0_CE    : string     := "CE0";
         REG_SIGNEDA_0_RST   : string     := "RST0";
         REG_SIGNEDA_1_CLK   : string     := "NONE";
         REG_SIGNEDA_1_CE    : string     := "CE0";
         REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
         REG_ADDNSUB_0_CLK    : string     := "NONE";
         REG_ADDNSUB_0_CE     : string     := "CE0";
         REG_ADDNSUB_0_RST    : string     := "RST0";
         REG_ADDNSUB_1_CLK    : string     := "NONE";
         REG_ADDNSUB_1_CE     : string     := "CE0";
         REG_ADDNSUB_1_RST    : string     := "RST0";
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

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        ADDNSUB  : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;

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
component MULT9X9ADDSUBSUMB
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
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
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

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        ADDNSUB1  : in STD_ULOGIC;
        ADDNSUB3  : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEA2 : in STD_ULOGIC;
        SOURCEA3 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;
        SOURCEB2 : in STD_ULOGIC;
        SOURCEB3 : in STD_ULOGIC;

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

  component MULT18X18B
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
	 REG_SIGNEDA_CLK   : string     := "NONE";
	 REG_SIGNEDA_CE    : string     := "CE0";
	 REG_SIGNEDA_RST   : string     := "RST0";
         REG_SIGNEDB_CLK   : string     := "NONE";
         REG_SIGNEDB_CE    : string     := "CE0";
         REG_SIGNEDB_RST   : string     := "RST0";
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

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA : in STD_ULOGIC;
        SOURCEB : in STD_ULOGIC;

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

  component MULT18X18ADDSUBB
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
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
	 REG_ADDNSUB_0_CLK    : string     := "NONE";
	 REG_ADDNSUB_0_CE     : string     := "CE0";
	 REG_ADDNSUB_0_RST    : string     := "RST0";
	 REG_ADDNSUB_1_CLK    : string     := "NONE";
	 REG_ADDNSUB_1_CE     : string     := "CE0";
	 REG_ADDNSUB_1_RST    : string     := "RST0";
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

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;
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

  component MULT18X18ADDSUBSUMB
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
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
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

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA0 : in STD_ULOGIC;
        SOURCEA1 : in STD_ULOGIC;
        SOURCEA2 : in STD_ULOGIC;
        SOURCEA3 : in STD_ULOGIC;
        SOURCEB0 : in STD_ULOGIC;
        SOURCEB1 : in STD_ULOGIC;
        SOURCEB2 : in STD_ULOGIC;
        SOURCEB3 : in STD_ULOGIC;
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

  component MULT18X18MACB
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
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
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

        LD0    : in STD_ULOGIC;
        LD1    : in STD_ULOGIC;
        LD2    : in STD_ULOGIC;
        LD3    : in STD_ULOGIC;
        LD4    : in STD_ULOGIC;
        LD5    : in STD_ULOGIC;
        LD6    : in STD_ULOGIC;
        LD7    : in STD_ULOGIC;
        LD8    : in STD_ULOGIC;
        LD9    : in STD_ULOGIC;
        LD10    : in STD_ULOGIC;
        LD11    : in STD_ULOGIC;
        LD12    : in STD_ULOGIC;
        LD13    : in STD_ULOGIC;
        LD14    : in STD_ULOGIC;
        LD15    : in STD_ULOGIC;
        LD16    : in STD_ULOGIC;
        LD17    : in STD_ULOGIC;
        LD18    : in STD_ULOGIC;
        LD19    : in STD_ULOGIC;
        LD20    : in STD_ULOGIC;
        LD21    : in STD_ULOGIC;
        LD22    : in STD_ULOGIC;
        LD23    : in STD_ULOGIC;
        LD24    : in STD_ULOGIC;
        LD25    : in STD_ULOGIC;
        LD26    : in STD_ULOGIC;
        LD27    : in STD_ULOGIC;
        LD28    : in STD_ULOGIC;
        LD29    : in STD_ULOGIC;
        LD30    : in STD_ULOGIC;
        LD31    : in STD_ULOGIC;
        LD32    : in STD_ULOGIC;
        LD33    : in STD_ULOGIC;
        LD34    : in STD_ULOGIC;
        LD35    : in STD_ULOGIC;
        LD36    : in STD_ULOGIC;
        LD37    : in STD_ULOGIC;
        LD38    : in STD_ULOGIC;
        LD39    : in STD_ULOGIC;
        LD40    : in STD_ULOGIC;
        LD41    : in STD_ULOGIC;
        LD42    : in STD_ULOGIC;
        LD43    : in STD_ULOGIC;
        LD44    : in STD_ULOGIC;
        LD45    : in STD_ULOGIC;
        LD46    : in STD_ULOGIC;
        LD47    : in STD_ULOGIC;
        LD48    : in STD_ULOGIC;
        LD49    : in STD_ULOGIC;
        LD50    : in STD_ULOGIC;
        LD51    : in STD_ULOGIC;

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;
        SOURCEA : in STD_ULOGIC;
        SOURCEB : in STD_ULOGIC;
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

  component MULT36X36B
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
	 REG_SIGNEDA_0_CLK   : string     := "NONE";
	 REG_SIGNEDA_0_CE    : string     := "CE0";
	 REG_SIGNEDA_0_RST   : string     := "RST0";
	 REG_SIGNEDA_1_CLK   : string     := "NONE";
	 REG_SIGNEDA_1_CE    : string     := "CE0";
	 REG_SIGNEDA_1_RST   : string     := "RST0";
         REG_SIGNEDB_0_CLK   : string     := "NONE";
         REG_SIGNEDB_0_CE    : string     := "CE0";
         REG_SIGNEDB_0_RST   : string     := "RST0";
         REG_SIGNEDB_1_CLK   : string     := "NONE";
         REG_SIGNEDB_1_CE    : string     := "CE0";
         REG_SIGNEDB_1_RST   : string     := "RST0";
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

        SIGNEDA : in STD_ULOGIC;
        SIGNEDB : in STD_ULOGIC;

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
--
component MULT18X18C
    generic (
	     REG_INPUTA_CLK   : string := "NONE";
	     REG_INPUTA_CE    : string := "CE0";
	     REG_INPUTA_RST   : string := "RST0";
	     REG_INPUTB_CLK   : string := "NONE";
	     REG_INPUTB_CE    : string := "CE0";
	     REG_INPUTB_RST   : string := "RST0";
	     REG_PIPELINE_CLK : string := "NONE";
	     REG_PIPELINE_CE  : string := "CE0";
	     REG_PIPELINE_RST : string := "RST0";
	     REG_OUTPUT_CLK   : string := "NONE";
	     REG_OUTPUT_CE    : string := "CE0";
	     REG_OUTPUT_RST   : string := "RST0";
	     CAS_MATCH_REG    : string := "FALSE";
	     MULT_BYPASS      : string := "DISABLED";
	     GSR              : string := "ENABLED";
	     RESETMODE        : string := "SYNC");
    port (
	  A17,A16,A15,A14,A13,A12,A11,A10,A9,A8,A7,A6,A5,A4,A3,A2,A1,A0           : in std_logic;
	  B17,B16,B15,B14,B13,B12,B11,B10,B9,B8,B7,B6,B5,B4,B3,B2,B1,B0           : in std_logic;
	  SIGNEDA, SIGNEDB, SOURCEA, SOURCEB                                      : in std_logic;
	  CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3                 : in std_logic;
	  SRIA17,SRIA16,SRIA15,SRIA14,SRIA13,SRIA12,SRIA11,SRIA10,SRIA9           : in std_logic;
	  SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0                   : in std_logic;
	  SRIB17,SRIB16,SRIB15,SRIB14,SRIB13,SRIB12,SRIB11,SRIB10,SRIB9           : in std_logic;
	  SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0                   : in std_logic;
	  SROA17,SROA16,SROA15,SROA14,SROA13,SROA12,SROA11,SROA10,SROA9           : out std_logic;
	  SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0                   : out std_logic;
	  SROB17,SROB16,SROB15,SROB14,SROB13,SROB12,SROB11,SROB10,SROB9           : out std_logic;
	  SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0                   : out std_logic;
	  ROA17,ROA16,ROA15,ROA14,ROA13,ROA12,ROA11,ROA10,ROA9                    : out std_logic;
	  ROA8,ROA7,ROA6,ROA5,ROA4,ROA3,ROA2,ROA1,ROA0                            : out std_logic;
	  ROB17,ROB16,ROB15,ROB14,ROB13,ROB12,ROB11,ROB10,ROB9                    : out std_logic;
	  ROB8,ROB7,ROB6,ROB5,ROB4,ROB3,ROB2,ROB1,ROB0                            : out std_logic;
	  P35,P34,P33,P32,P31,P30,P29,P28,P27,P26,P25,P24,P23,P22,P21,P20,P19,P18 : out std_logic;
	  P17,P16,P15,P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0           : out std_logic;
	  SIGNEDP                                                                 : out std_logic);
end component;
--
component MULT9X9C
    generic (
	     REG_INPUTA_CLK   : string := "NONE";
	     REG_INPUTA_CE    : string := "CE0";
	     REG_INPUTA_RST   : string := "RST0";
	     REG_INPUTB_CLK   : string := "NONE";
	     REG_INPUTB_CE    : string := "CE0";
	     REG_INPUTB_RST   : string := "RST0";
	     REG_PIPELINE_CLK : string := "NONE";
	     REG_PIPELINE_CE  : string := "CE0";
	     REG_PIPELINE_RST : string := "RST0";
	     REG_OUTPUT_CLK   : string := "NONE";
	     REG_OUTPUT_CE    : string := "CE0";
	     REG_OUTPUT_RST   : string := "RST0";
	     CAS_MATCH_REG    : string := "FALSE";
	     MULT_BYPASS      : string := "DISABLED";
	     GSR              : string := "ENABLED";
	     RESETMODE        : string := "SYNC");
    port (
	  A8,A7,A6,A5,A4,A3,A2,A1,A0                                     : in std_logic;
	  B8,B7,B6,B5,B4,B3,B2,B1,B0                                     : in std_logic;
	  SIGNEDA, SIGNEDB, SOURCEA, SOURCEB                             : in std_logic;
	  CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3        : in std_logic;
	  SRIA8,SRIA7,SRIA6,SRIA5,SRIA4,SRIA3,SRIA2,SRIA1,SRIA0          : in std_logic;
	  SRIB8,SRIB7,SRIB6,SRIB5,SRIB4,SRIB3,SRIB2,SRIB1,SRIB0          : in std_logic;
	  SROA8,SROA7,SROA6,SROA5,SROA4,SROA3,SROA2,SROA1,SROA0          : out std_logic;
	  SROB8,SROB7,SROB6,SROB5,SROB4,SROB3,SROB2,SROB1,SROB0          : out std_logic;
	  ROA8,ROA7,ROA6,ROA5,ROA4,ROA3,ROA2,ROA1,ROA0                   : out std_logic;
	  ROB8,ROB7,ROB6,ROB5,ROB4,ROB3,ROB2,ROB1,ROB0                   : out std_logic;
	  P17,P16,P15,P14,P13,P12,P11,P10,P9,P8,P7,P6,P5,P4,P3,P2,P1,P0  : out std_logic;
	  SIGNEDP                                                        : out std_logic);
end component;
--
component ALU54A
    generic (
         REG_INPUTC0_CLK       : string     := "NONE";
         REG_INPUTC0_CE        : string     := "CE0";
         REG_INPUTC0_RST       : string     := "RST0";
         REG_INPUTC1_CLK       : string     := "NONE";
         REG_INPUTC1_CE        : string     := "CE0";
         REG_INPUTC1_RST       : string     := "RST0";
         REG_OPCODEOP0_0_CLK     : string     := "NONE";
         REG_OPCODEOP0_0_CE      : string     := "CE0";
         REG_OPCODEOP0_0_RST     : string     := "RST0";
         REG_OPCODEOP1_0_CLK     : string     := "NONE";
--         REG_OPCODEOP1_0_CE      : string     := "CE0";
--         REG_OPCODEOP1_0_RST     : string     := "RST0";
         REG_OPCODEOP0_1_CLK     : string     := "NONE";
         REG_OPCODEOP0_1_CE      : string     := "CE0";
         REG_OPCODEOP0_1_RST     : string     := "RST0";
         REG_OPCODEOP1_1_CLK     : string     := "NONE";
--         REG_OPCODEOP1_1_CE      : string     := "CE0";
--         REG_OPCODEOP1_1_RST     : string     := "RST0";
         REG_OPCODEIN_0_CLK     : string     := "NONE";
         REG_OPCODEIN_0_CE      : string     := "CE0";
         REG_OPCODEIN_0_RST     : string     := "RST0";
         REG_OPCODEIN_1_CLK     : string     := "NONE";
         REG_OPCODEIN_1_CE      : string     := "CE0";
         REG_OPCODEIN_1_RST     : string     := "RST0";
         REG_OUTPUT0_CLK      : string     := "NONE";
         REG_OUTPUT0_CE       : string     := "CE0";
         REG_OUTPUT0_RST      : string     := "RST0";
         REG_OUTPUT1_CLK      : string     := "NONE";
         REG_OUTPUT1_CE       : string     := "CE0";
         REG_OUTPUT1_RST      : string     := "RST0";
         REG_FLAG_CLK         : string     := "NONE";
         REG_FLAG_CE          : string     := "CE0";
         REG_FLAG_RST         : string     := "RST0";
         MCPAT_SOURCE         : string     := "STATIC";
         MASKPAT_SOURCE       : string     := "STATIC";
         MASK01               : string     := "0x00000000000000";
         MCPAT                : string     := "0x00000000000000";
         MASKPAT              : string     := "0x00000000000000";
         RNDPAT               : string     := "0x00000000000000";
         GSR                  : string     := "ENABLED";
         RESETMODE            : string     := "SYNC";
         MULT9_MODE           : string     := "DISABLED";
         LEGACY               : string     := "DISABLED");

  port (
        A35,A34,A33,A32,A31,A30,A29,A28,A27  : in STD_ULOGIC;
        A26,A25,A24,A23,A22,A21,A20,A19,A18  : in STD_ULOGIC;
        A17,A16,A15,A14,A13,A12,A11,A10,A9   : in STD_ULOGIC;
        A8,A7,A6,A5,A4,A3,A2,A1,A0           : in STD_ULOGIC;

        B35,B34,B33,B32,B31,B30,B29,B28,B27  : in STD_ULOGIC;
        B26,B25,B24,B23,B22,B21,B20,B19,B18  : in STD_ULOGIC;
        B17,B16,B15,B14,B13,B12,B11,B10,B9   : in STD_ULOGIC;
        B8,B7,B6,B5,B4,B3,B2,B1,B0           : in STD_ULOGIC;

        C53,C52,C51,C50,C49,C48,C47,C46,C45  : in STD_ULOGIC;
        C44,C43,C42,C41,C40,C39,C38,C37,C36  : in STD_ULOGIC;
        C35,C34,C33,C32,C31,C30,C29,C28,C27  : in STD_ULOGIC;
        C26,C25,C24,C23,C22,C21,C20,C19,C18  : in STD_ULOGIC;
        C17,C16,C15,C14,C13,C12,C11,C10,C9   : in STD_ULOGIC;
        C8,C7,C6,C5,C4,C3,C2,C1,C0           : in STD_ULOGIC;

        CE0, CE1, CE2, CE3 : in STD_ULOGIC;
        CLK0, CLK1, CLK2, CLK3 : in STD_ULOGIC;
        RST0, RST1, RST2, RST3, SIGNEDIA, SIGNEDIB, SIGNEDCIN : in STD_ULOGIC;

        MA35,MA34,MA33,MA32,MA31,MA30,MA29,MA28,MA27  : in STD_ULOGIC;
        MA26,MA25,MA24,MA23,MA22,MA21,MA20,MA19,MA18  : in STD_ULOGIC;
        MA17,MA16,MA15,MA14,MA13,MA12,MA11,MA10,MA9   : in STD_ULOGIC;
        MA8,MA7,MA6,MA5,MA4,MA3,MA2,MA1,MA0           : in STD_ULOGIC;

        MB35,MB34,MB33,MB32,MB31,MB30,MB29,MB28,MB27  : in STD_ULOGIC;
        MB26,MB25,MB24,MB23,MB22,MB21,MB20,MB19,MB18  : in STD_ULOGIC;
        MB17,MB16,MB15,MB14,MB13,MB12,MB11,MB10,MB9   : in STD_ULOGIC;
        MB8,MB7,MB6,MB5,MB4,MB3,MB2,MB1,MB0           : in STD_ULOGIC;

        CIN53,CIN52,CIN51,CIN50,CIN49,CIN48,CIN47,CIN46,CIN45  : in STD_ULOGIC;
        CIN44,CIN43,CIN42,CIN41,CIN40,CIN39,CIN38,CIN37,CIN36  : in STD_ULOGIC;
        CIN35,CIN34,CIN33,CIN32,CIN31,CIN30,CIN29,CIN28,CIN27  : in STD_ULOGIC;
        CIN26,CIN25,CIN24,CIN23,CIN22,CIN21,CIN20,CIN19,CIN18  : in STD_ULOGIC;
        CIN17,CIN16,CIN15,CIN14,CIN13,CIN12,CIN11,CIN10,CIN9   : in STD_ULOGIC;
        CIN8,CIN7,CIN6,CIN5,CIN4,CIN3,CIN2,CIN1,CIN0           : in STD_ULOGIC;

        OP10,OP9,OP8,OP7,OP6,OP5,OP4,OP3,OP2,OP1,OP0   : in STD_ULOGIC;

        R53,R52,R51,R50,R49,R48,R47,R46,R45  : out STD_ULOGIC;
        R44,R43,R42,R41,R40,R39,R38,R37,R36  : out STD_ULOGIC;
        R35,R34,R33,R32,R31,R30,R29,R28,R27  : out STD_ULOGIC;
        R26,R25,R24,R23,R22,R21,R20,R19,R18  : out STD_ULOGIC;
        R17,R16,R15,R14,R13,R12,R11,R10,R9   : out STD_ULOGIC;
        R8,R7,R6,R5,R4,R3,R2,R1,R0           : out STD_ULOGIC;
        EQZ,EQZM,EQOM,EQPAT,EQPATB,OVER,UNDER,OVERUNDER,SIGNEDR           : out STD_ULOGIC
        );
end component;
--
component ALU24A
    generic (
	     REG_OUTPUT_CLK     : string := "NONE";
	     REG_OUTPUT_CE      : string := "CE0";
	     REG_OUTPUT_RST     : string := "RST0";
	     REG_OPCODE_0_CLK  : string := "NONE";
	     REG_OPCODE_0_CE   : string := "CE0";
	     REG_OPCODE_0_RST  : string := "RST0";
	     REG_OPCODE_1_CLK  : string := "NONE";
	     REG_OPCODE_1_CE   : string := "CE0";
	     REG_OPCODE_1_RST  : string := "RST0";
	     GSR                : string := "ENABLED";
	     RESETMODE          : string := "SYNC");
    port (
	  CE0,CE1,CE2,CE3,CLK0,CLK1,CLK2,CLK3,RST0,RST1,RST2,RST3,SIGNEDIA,SIGNEDIB        : in std_ulogic;
	  MA17,MA16,MA15,MA14,MA13,MA12,MA11,MA10,MA9,MA8,MA7,MA6,MA5,MA4,MA3,MA2,MA1,MA0  : in std_ulogic;
	  MB17,MB16,MB15,MB14,MB13,MB12,MB11,MB10,MB9,MB8,MB7,MB6,MB5,MB4,MB3,MB2,MB1,MB0  : in std_ulogic;
	  CIN23,CIN22,CIN21,CIN20,CIN19,CIN18,CIN17,CIN16,CIN15,CIN14                      : in std_ulogic;
	  CIN13,CIN12,CIN11,CIN10,CIN9,CIN8,CIN7,CIN6,CIN5,CIN4,CIN3,CIN2,CIN1,CIN0        : in std_ulogic;
	  OPADDNSUB,OPCINSEL                                                               : in std_ulogic;
	  R23,R22,R21,R20,R19,R18                                                          : out std_ulogic;
	  R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0                    : out std_ulogic);
end component;
--
COMPONENT sp16kc
GENERIC(
        DATA_WIDTH   : Integer := 18;
        REGMODE      : String  := "NOREG";
        CSDECODE     : string  := "0b000";
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
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        DI17, DI16, DI15, DI14, DI13, DI12, DI11, DI10, DI9 : in std_logic := 'X';
        DI8, DI7, DI6, DI5, DI4, DI3, DI2, DI1, DI0         : in std_logic := 'X';
        AD13, AD12, AD11, AD10, AD9, AD8, AD7, AD6, AD5     : in std_logic := 'X';
        AD4, AD3,  AD2, AD1, AD0                            : in std_logic := 'X';
        CE, OCE, CLK, WE, CS2, CS1, CS0, RST                : in std_logic := 'X';
        DO17, DO16, DO15, DO14, DO13, DO12, DO11, DO10, DO9 : out std_logic := 'X';
        DO8, DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0         : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dp16kc
GENERIC(
        DATA_WIDTH_A : Integer := 18;
        DATA_WIDTH_B : Integer := 18;
        REGMODE_A    : String  := "NOREG";
        REGMODE_B    : String  := "NOREG";
        CSDECODE_A   : string  := "0b000";
        CSDECODE_B   : string  := "0b000";
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
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        DIA17, DIA16, DIA15, DIA14, DIA13, DIA12, DIA11, DIA10, DIA9 : in std_logic := 'X';
        DIA8, DIA7, DIA6, DIA5, DIA4, DIA3, DIA2, DIA1, DIA0         : in std_logic := 'X';
        ADA13, ADA12, ADA11, ADA10, ADA9, ADA8, ADA7, ADA6, ADA5     : in std_logic := 'X';
        ADA4,  ADA3,  ADA2, ADA1, ADA0                               : in std_logic := 'X';
        CEA, OCEA, CLKA, WEA, CSA2, CSA1, CSA0, RSTA                 : in std_logic := 'X';
        DIB17, DIB16, DIB15, DIB14, DIB13, DIB12, DIB11, DIB10, DIB9 : in std_logic := 'X';
        DIB8, DIB7, DIB6, DIB5, DIB4, DIB3, DIB2, DIB1, DIB0         : in std_logic := 'X';
        ADB13, ADB12, ADB11, ADB10, ADB9, ADB8, ADB7, ADB6, ADB5     : in std_logic := 'X';
        ADB4,  ADB3,  ADB2, ADB1, ADB0                               : in std_logic := 'X';
        CEB, OCEB, CLKB, WEB, CSB2, CSB1, CSB0, RSTB                 : in std_logic := 'X';
        DOA17, DOA16, DOA15, DOA14, DOA13, DOA12, DOA11, DOA10, DOA9 : out std_logic := 'X';
        DOA8, DOA7, DOA6, DOA5, DOA4, DOA3, DOA2, DOA1, DOA0         : out std_logic := 'X';
        DOB17, DOB16, DOB15, DOB14, DOB13, DOB12, DOB11, DOB10, DOB9 : out std_logic := 'X';
        DOB8, DOB7, DOB6, DOB5, DOB4, DOB3, DOB2, DOB1, DOB0         : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pdpw16kc
GENERIC(
        DATA_WIDTH_W : Integer := 36;
        DATA_WIDTH_R : Integer := 18;
        REGMODE      : String  := "NOREG";
        CSDECODE_W   : string  := "0b000";
        CSDECODE_R   : string  := "0b000";
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
        initval_1f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : string := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000"
  );
PORT(
        DI35, DI34, DI33, DI32, DI31, DI30, DI29, DI28, DI27     : in std_logic := 'X';
        DI26, DI25, DI24, DI23, DI22, DI21, DI20, DI19, DI18     : in std_logic := 'X';
        DI17, DI16, DI15, DI14, DI13, DI12, DI11, DI10, DI9      : in std_logic := 'X';
        DI8, DI7, DI6, DI5, DI4, DI3, DI2, DI1, DI0              : in std_logic := 'X';
        ADW8, ADW7, ADW6, ADW5, ADW4, ADW3, ADW2, ADW1, ADW0     : in std_logic := 'X';
        BE3, BE2, BE1, BE0                                       : in std_logic := 'X';
        CEW, CLKW, CSW2, CSW1, CSW0                              : in std_logic := 'X';
        ADR13, ADR12, ADR11, ADR10, ADR9, ADR8, ADR7, ADR6, ADR5 : in std_logic := 'X';
        ADR4,  ADR3,  ADR2, ADR1, ADR0                           : in std_logic := 'X';
        CER, CLKR, CSR2, CSR1, CSR0, RST                         : in std_logic := 'X';
        DO35, DO34, DO33, DO32, DO31, DO30, DO29, DO28, DO27     : out std_logic := 'X';
        DO26, DO25, DO24, DO23, DO22, DO21, DO20, DO19, DO18     : out std_logic := 'X';
        DO17, DO16, DO15, DO14, DO13, DO12, DO11, DO10, DO9      : out std_logic := 'X';
        DO8, DO7, DO6, DO5, DO4, DO3, DO2, DO1, DO0              : out std_logic := 'X'
  );
END COMPONENT;
--
component DCCA
    port (CLKI : in std_logic;
          CE   : in std_logic;
          CLKO : out std_logic);
end component;
--
component PERREGA
    port (D15, D14, D13, D12, D11, D10, D9, D8, D7, D6, D5, D4, D3, D2, D1, D0 : in std_logic;
          Q15, Q14, Q13, Q12, Q11, Q10, Q9, Q8, Q7, Q6, Q5, Q4, Q3, Q2, Q1, Q0 : out std_logic);
end component;
--
component AMBOOTA
    generic (CS_SS          : string := "STATIC";
             AUTOREBOOT     : string := "OFF";
             CS_SS_VAL      : string := "CHIP1";
             SECTOR_ADDRESS : string := "0x00");
    port (CSI, AUTOREBOOTI, A7, A6, A5, A4, A3, A2, A1, A0 : in std_logic;
          CSO, O7, O6, O5, O4, O3, O2, O1, O0 : out std_logic);
end component;
--
COMPONENT trdllb
GENERIC(
      CLKOP_PHASE         : Integer   := 0;
      CLKOS_PHASE         : Integer   := 0;
      CLKOS_FPHASE        : Integer   := 101;
      CLKOS_DIV           : Integer   := 1;
      GSR                 : String    := "DISABLED";
      CLKOS_FPHASE_ADJVAL : Integer   := 0;
      ALU_LOCK_CNT        : Integer   := 3;
      ALU_UNLOCK_CNT      : Integer   := 3;
      GLITCH_TOLERANCE    : Integer   := 2;
      LOCK_DELAY          : Integer   := 100;
      CLKOP_DUTY50        : String    := "DISABLED";
      CLKOS_DUTY50        : String    := "DISABLED");
PORT(
        clki               : IN std_logic;
        rstn               : IN std_logic;
        aluhold            : IN std_logic;
        uddcntl            : IN std_logic;
        clkop              : OUT std_logic;
        clkos              : OUT std_logic;
        lock               : OUT std_logic;
        inco               : OUT std_logic;
        diff               : OUT std_logic;
        grayo5             : OUT std_logic;
        grayo4             : OUT std_logic;
        grayo3             : OUT std_logic;
        grayo2             : OUT std_logic;
        grayo1             : OUT std_logic;
        grayo0             : OUT std_logic;
        dcntl5             : OUT std_logic;
        dcntl4             : OUT std_logic;
        dcntl3             : OUT std_logic;
        dcntl2             : OUT std_logic;
        dcntl1             : OUT std_logic;
        dcntl0             : OUT std_logic);
END COMPONENT;
--
COMPONENT tr1dllb
GENERIC(
      CLKOP_PHASE         : Integer   := 0;
      CLKOS_PHASE         : Integer   := 0;
      CLKOS_FPHASE        : Integer   := 101;
      CLKOS_DIV           : Integer   := 1;
      GSR                 : String    := "DISABLED";
      CLKOS_FPHASE_ADJVAL : Integer   := 0;
      ALU_LOCK_CNT        : Integer   := 3;
      ALU_UNLOCK_CNT      : Integer   := 3;
      GLITCH_TOLERANCE    : Integer   := 2;
      LOCK_DELAY          : Integer   := 100;
      CLKOP_DUTY50        : String    := "DISABLED";
      CLKOS_DUTY50        : String    := "DISABLED");
PORT(
        clki               : IN std_logic;
        rstn               : IN std_logic;
        aluhold            : IN std_logic;
        uddcntl            : IN std_logic;
        deladjpol          : IN std_logic;
        delval4            : IN std_logic;
        delval3            : IN std_logic;
        delval2            : IN std_logic;
        delval1            : IN std_logic;
        delval0            : IN std_logic;
        clkop              : OUT std_logic;
        clkos              : OUT std_logic;
        lock               : OUT std_logic;
        inco               : OUT std_logic;
        diff               : OUT std_logic;
        grayo5             : OUT std_logic;
        grayo4             : OUT std_logic;
        grayo3             : OUT std_logic;
        grayo2             : OUT std_logic;
        grayo1             : OUT std_logic;
        grayo0             : OUT std_logic;
        dcntl5             : OUT std_logic;
        dcntl4             : OUT std_logic;
        dcntl3             : OUT std_logic;
        dcntl2             : OUT std_logic;
        dcntl1             : OUT std_logic;
        dcntl0             : OUT std_logic);
END COMPONENT;
--
COMPONENT ciddllb
GENERIC(
      CLKOP_PHASE        : Integer   := 0;
      CLKOS_PHASE        : Integer   := 0;
      CLKOS_FPHASE       : Integer   := 101;
      CLKI_DIV           : Integer   := 1;
      CLKOS_DIV          : Integer   := 1;
      GSR                : String    := "DISABLED";
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 2;
      ALU_INIT_CNTVAL    : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      CLKOP_DUTY50       : String    := "DISABLED";
      CLKOS_DUTY50       : String    := "DISABLED";
      DEL0_GRAY          : String    := "DISABLED";
      DEL1_GRAY          : String    := "DISABLED";
      DEL2_GRAY          : String    := "DISABLED";
      DEL3_GRAY          : String    := "DISABLED";
      DEL4_GRAY          : String    := "DISABLED");
PORT(
        clki               : IN std_logic;
        clkfb              : IN std_logic;
        rstn               : IN std_logic;
        aluhold            : IN std_logic;
        inci               : IN std_logic;
        grayi5             : IN std_logic;
        grayi4             : IN std_logic;
        grayi3             : IN std_logic;
        grayi2             : IN std_logic;
        grayi1             : IN std_logic;
        grayi0             : IN std_logic;
        clkop              : OUT std_logic;
        clkos              : OUT std_logic;
        lock               : OUT std_logic);
END COMPONENT;
--
COMPONENT dlldelb
PORT(
      clki            : IN std_logic;
      dcntl0          : IN std_logic;
      dcntl1          : IN std_logic;
      dcntl2          : IN std_logic;
      dcntl3          : IN std_logic;
      dcntl4          : IN std_logic;
      dcntl5          : IN std_logic;
      clko            : OUT std_logic);
END COMPONENT;
--
component ECLKSYNCA
    port (ECLKI, STOP : in std_logic;
          ECLKO       : out std_logic);
end component;
--
component DTSA
    port (DTSI3, DTSI2, DTSI1, DTSI0 : in std_logic;
          DTSO                       : out std_logic);
end component;

--
-- SLICE Model components --
--
COMPONENT SLUTA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SLUTA";

        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LUT1_INITVAL    : bit_vector := X"0000";
        LUT0_INITVAL    : bit_vector := X"0000"
        );

   PORT(
        M1, FXA, FXB, A1, B1, C1, D1                      : in std_ulogic := '0';
        A0, B0, C0, D0, M0                                : in std_ulogic := '0';
        OFX1, F1, OFX0, F0                                : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SLOGICB IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SLOGICB";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        LUT1_INITVAL    : bit_vector := X"0000";
        LUT0_INITVAL    : bit_vector := X"0000";
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE
        );

   PORT(
        M1, FXA, FXB, A1, B1, C1, D1, DI1, DI0            : in std_ulogic := '0';
        A0, B0, C0, D0, M0, CE, CLK, LSR                  : in std_ulogic := '0';
        OFX1, F1, Q1, OFX0, F0, Q0                        : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SRIPPLEB IS
   GENERIC (
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SRIPPLEB";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        ALU2_MULT_MODE  : string := "ADD";  -- "ADD", "SUB", "ADDSUB", "CNTUP", "CNTDN", "CNTUPDN", "MULT", "A_GE_B", "A_NE_B"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE
        );

   PORT(
        M1, A1, B1, C1, D1, DI1, DI0                   : in std_ulogic := '0';
        A0, B0, C0, D0, FCI, M0, CE, CLK, LSR          : in std_ulogic := '0';
        FCO, F1, Q1, F0, Q0                            : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SCCU2C IS
   GENERIC (
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SCCU2C";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"
        CCU2_INJECT1_0  : string := "YES";     -- "NO", "YES"
        CCU2_INJECT1_1  : string := "YES";     -- "NO", "YES"
        INIT0_INITVAL   : std_logic_vector(15 downto 0) := "0000000000000000";
        INIT1_INITVAL   : std_logic_vector(15 downto 0) := "0000000000000000";

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE
        );

   PORT(
        M1, A1, B1, C1, D1, DI1, DI0                   : in std_ulogic := '0';
        A0, B0, C0, D0, FCI, M0, CE, CLK, LSR          : in std_ulogic := '0';
        FCO, F1, Q1, F0, Q0                            : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SRAMWA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SRAMWA";

        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        check_LSR       : boolean := FALSE
        );

   PORT(
        A1, B1, C1, D1, A0, B0, C0, D0, CLK, LSR                         : in std_ulogic := '0';
        WDO0, WDO1, WDO2, WDO3, WADO0, WADO1, WADO2, WADO3, WCKO, WREO   : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SDPRAMD IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SDPRAMD";

        GSR             : string := "ENABLED";
        SRMODE          : string := "LSR_OVER_CE";      -- "LSR_OVER_CE", "ASYNC"
        M1MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        M0MUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        LSRMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CEMUX           : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        CLKMUX          : string := "VLO";      -- "SIG", "INV", "VLO", "VHI"
        REG1_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG0_SD         : string := "VLO";      -- "VLO", "VHI", "SIG"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"
        initval : string := "0x0000000000000000";

        -- timing check enable for each port
        check_RAD0      : boolean := FALSE;
        check_RAD1      : boolean := FALSE;
        check_RAD2      : boolean := FALSE;
        check_RAD3      : boolean := FALSE;
        check_WD1       : boolean := FALSE;
        check_WD0       : boolean := FALSE;
        check_WAD0      : boolean := FALSE;
        check_WAD1      : boolean := FALSE;
        check_WAD2      : boolean := FALSE;
        check_WAD3      : boolean := FALSE;
        CHECK_WRE       : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_M1        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR       : boolean := FALSE;
        check_DI1       : boolean := FALSE;
        check_DI0       : boolean := FALSE
        );

   PORT(
        M1, RAD0, RAD1, RAD2, RAD3, WD1, WD0, WAD0, WAD1, WAD2, WAD3, WRE, WCK  : in std_ulogic := '0';
        M0, CE, CLK, LSR, DI1, DI0                                              : in std_ulogic := '0';
        F0, Q0, F1, Q1                                                          : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SBRAMC IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SBRAMC";

        DATA_WIDTH_A               : Integer  := 18;
        DATA_WIDTH_B               : Integer  := 18;
        REGMODE_A                  : String  := "NOREG";
        REGMODE_B                  : String  := "NOREG";
        CSDECODE_A                 : String  := "0b000";
        CSDECODE_B                 : String  := "0b000";
        WRITEMODE_A                : String  := "NORMAL";
        WRITEMODE_B                : String  := "NORMAL";
        GSR                        : String  := "DISABLED";

        initval_00 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_20 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_21 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_22 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_23 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_24 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_25 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_26 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_27 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_28 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_29 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_2f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_30 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_31 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_32 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_33 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_34 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_35 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_36 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_37 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_38 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_39 : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3a : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3b : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3c : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3d : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3e : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";
        initval_3f : String := "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000";

        CLKA_NEGEDGE    : boolean := FALSE;
        CLKB_NEGEDGE    : boolean := FALSE;

        check_DIA0      : boolean := FALSE;
        check_DIA1      : boolean := FALSE;
        check_DIA2      : boolean := FALSE;
        check_DIA3      : boolean := FALSE;
        check_DIA4      : boolean := FALSE;
        check_DIA5      : boolean := FALSE;
        check_DIA6      : boolean := FALSE;
        check_DIA7      : boolean := FALSE;
        check_DIA8      : boolean := FALSE;
        check_DIA9      : boolean := FALSE;
        check_DIA10     : boolean := FALSE;
        check_DIA11     : boolean := FALSE;
        check_DIA12     : boolean := FALSE;
        check_DIA13     : boolean := FALSE;
        check_DIA14     : boolean := FALSE;
        check_DIA15     : boolean := FALSE;
        check_DIA16     : boolean := FALSE;
        check_DIA17     : boolean := FALSE;
        check_ADA0      : boolean := FALSE;
        check_ADA1      : boolean := FALSE;
        check_ADA2      : boolean := FALSE;
        check_ADA3      : boolean := FALSE;
        check_ADA4      : boolean := FALSE;
        check_ADA5      : boolean := FALSE;
        check_ADA6      : boolean := FALSE;
        check_ADA7      : boolean := FALSE;
        check_ADA8      : boolean := FALSE;
        check_ADA9      : boolean := FALSE;
        check_ADA10     : boolean := FALSE;
        check_ADA11     : boolean := FALSE;
        check_ADA12     : boolean := FALSE;
        check_ADA13     : boolean := FALSE;
        check_CEA       : boolean := FALSE;
        check_OCEA      : boolean := FALSE;
        check_WEA       : boolean := FALSE;
        check_CSA0      : boolean := FALSE;
        check_CSA1      : boolean := FALSE;
        check_CSA2      : boolean := FALSE;
        check_RSTA      : boolean := FALSE;

        check_DIB0      : boolean := FALSE;
        check_DIB1      : boolean := FALSE;
        check_DIB2      : boolean := FALSE;
        check_DIB3      : boolean := FALSE;
        check_DIB4      : boolean := FALSE;
        check_DIB5      : boolean := FALSE;
        check_DIB6      : boolean := FALSE;
        check_DIB7      : boolean := FALSE;
        check_DIB8      : boolean := FALSE;
        check_DIB9      : boolean := FALSE;
        check_DIB10     : boolean := FALSE;
        check_DIB11     : boolean := FALSE;
        check_DIB12     : boolean := FALSE;
        check_DIB13     : boolean := FALSE;
        check_DIB14     : boolean := FALSE;
        check_DIB15     : boolean := FALSE;
        check_DIB16     : boolean := FALSE;
        check_DIB17     : boolean := FALSE;
        check_ADB0      : boolean := FALSE;
        check_ADB1      : boolean := FALSE;
        check_ADB2      : boolean := FALSE;
        check_ADB3      : boolean := FALSE;
        check_ADB4      : boolean := FALSE;
        check_ADB5      : boolean := FALSE;
        check_ADB6      : boolean := FALSE;
        check_ADB7      : boolean := FALSE;
        check_ADB8      : boolean := FALSE;
        check_ADB9      : boolean := FALSE;
        check_ADB10     : boolean := FALSE;
        check_ADB11     : boolean := FALSE;
        check_ADB12     : boolean := FALSE;
        check_ADB13     : boolean := FALSE;
        check_CEB       : boolean := FALSE;
        check_OCEB      : boolean := FALSE;
        check_WEB       : boolean := FALSE;
        check_CSB0      : boolean := FALSE;
        check_CSB1      : boolean := FALSE;
        check_CSB2      : boolean := FALSE;
        check_RSTB      : boolean := FALSE
        );

   PORT(
        DIA0, DIA1, DIA2, DIA3, DIA4, DIA5, DIA6, DIA7, DIA8            : in std_logic := 'X';
        DIA9, DIA10, DIA11, DIA12, DIA13, DIA14, DIA15, DIA16, DIA17    : in std_logic := 'X';
        ADA0, ADA1, ADA2, ADA3, ADA4, ADA5, ADA6, ADA7, ADA8            : in std_logic := 'X';
        ADA9, ADA10, ADA11, ADA12, ADA13                                : in std_logic := 'X';
        CEA, OCEA, CLKA, WEA, CSA0, CSA1, CSA2, RSTA                    : in std_logic := 'X';
        DIB0, DIB1, DIB2, DIB3, DIB4, DIB5, DIB6, DIB7, DIB8            : in std_logic := 'X';
        DIB9, DIB10, DIB11, DIB12, DIB13, DIB14, DIB15, DIB16, DIB17    : in std_logic := 'X';
        ADB0, ADB1, ADB2, ADB3, ADB4, ADB5, ADB6, ADB7, ADB8            : in std_logic := 'X';
        ADB9, ADB10, ADB11, ADB12, ADB13                                : in std_logic := 'X';
        CEB, OCEB, CLKB, WEB, CSB0, CSB1, CSB2, RSTB                    : in std_logic := 'X';

        DOA0, DOA1, DOA2, DOA3, DOA4, DOA5, DOA6, DOA7, DOA8            : out std_logic := 'X';
        DOA9, DOA10, DOA11, DOA12, DOA13, DOA14, DOA15, DOA16, DOA17    : out std_logic := 'X';
        DOB0, DOB1, DOB2, DOB3, DOB4, DOB5, DOB6, DOB7, DOB8            : out std_logic := 'X';
        DOB9, DOB10, DOB11, DOB12, DOB13, DOB14, DOB15, DOB16, DOB17    : out std_logic := 'X'
        );

END COMPONENT ;
--
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

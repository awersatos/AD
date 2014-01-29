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
-- Simulation Library File for ORCA4
--
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca4/src/RCS/ORCACOMP.vhd,v 1.14 2005/05/19 20:33:55 pradeep Exp $ 
--
--
----- package conversion----
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

PACKAGE conversion IS
   Type pcm_mode is(DLL1X, DLLPD, PCMBUF, PLL);
   FUNCTION pdelay_tostd_logic_vector (pdelay: Integer) RETURN std_logic_vector;
   FUNCTION duty_tap_to_reg (duty_2x_tap: Integer) RETURN std_logic_vector;
   FUNCTION divider_to_ratio (div_all: std_logic_vector(3 downto 0)) RETURN Integer;
   FUNCTION make_integer (val: std_logic_vector(2 downto 0)) RETURN Integer;
   PROCEDURE initialize (MODE : in pcm_mode; duty_tap : in Integer; duty_reg : in real;
                         div0_reg1 : in Integer; div1_reg1 : in Integer; div2_reg1 : in Integer;
                         pdelay_reg : in std_logic_vector(7 downto 0);
                         signal configreg6 : out std_logic_vector(7 downto 0);
                         signal configreg5 : out std_logic_vector(7 downto 0);
                         signal configreg4 : out std_logic_vector(7 downto 0);
                         signal configreg3 : out std_logic_vector(7 downto 0);
                         signal configreg2 : out std_logic_vector(7 downto 0);
                         signal configreg1 : out std_logic_vector(7 downto 0);
                         signal configreg0 : out std_logic_vector(7 downto 0));
END conversion;

PACKAGE BODY conversion IS
   FUNCTION pdelay_tostd_logic_vector (pdelay: Integer) RETURN std_logic_vector IS
   VARIABLE result : std_logic_vector (7 downto 0);
   BEGIN
       CASE pdelay IS
         WHEN 1  => result := "00XXX000";
         WHEN 2  => result := "00XXX001";
         WHEN 3  => result := "00XXX010";
         WHEN 4  => result := "00XXX011";
         WHEN 5  => result := "00XXX100";
         WHEN 6  => result := "00XXX101";
         WHEN 7  => result := "00XXX110";
         WHEN 8  => result := "00XXX111";
         WHEN 9  => result := "01XXX000";
         WHEN 10 => result := "01XXX001";
         WHEN 11 => result := "01XXX010";
         WHEN 12 => result := "01XXX011";
         WHEN 13 => result := "01XXX100";
         WHEN 14 => result := "01XXX101";
         WHEN 15 => result := "01XXX110";
         WHEN 16 => result := "01111XXX";
         WHEN 17 => result := "10000XXX";
         WHEN 18 => result := "10001XXX";
         WHEN 19 => result := "10010XXX";
         WHEN 20 => result := "10011XXX";
         WHEN 21 => result := "10100XXX";
         WHEN 22 => result := "10001XXX";
         WHEN 23 => result := "10110XXX";
         WHEN 24 => result := "10111XXX";
         WHEN 25 => result := "11000XXX";
         WHEN 26 => result := "11001XXX";
         WHEN 27 => result := "11010XXX";
         WHEN 28 => result := "11011XXX";
         WHEN 29 => result := "11100XXX";
         WHEN 30 => result := "11101XXX";
         WHEN 31 => result := "11110XXX";
         WHEN others => NULL;
       END CASE;
       RETURN result;
   END pdelay_tostd_logic_vector;

   FUNCTION duty_tap_to_reg (duty_2x_tap: Integer) RETURN std_logic_vector IS
   VARIABLE result : std_logic_vector (3 downto 0);
   BEGIN
       CASE duty_2x_tap IS
         WHEN 1   => result := "0000";
         WHEN 2   => result := "0001";
         WHEN 3   => result := "0010";
         WHEN 4   => result := "0011";
         WHEN 5   => result := "0100";
         WHEN 6   => result := "0101";
         WHEN 7   => result := "0110";
         WHEN 8   => result := "0111";
         WHEN 9   => result := "1000";
         WHEN 10  => result := "1001";
         WHEN 11  => result := "1010";
         WHEN 12  => result := "1011";
         WHEN 13  => result := "1100";
         WHEN 14  => result := "1101";
         WHEN 15  => result := "1110";
         WHEN others => NULL;
       END CASE;
       RETURN result;
   END duty_tap_to_reg;

   FUNCTION divider_to_ratio (div_all: std_logic_vector(3 downto 0)) RETURN Integer IS
   VARIABLE result : Integer;
   BEGIN
       CASE div_all IS
         WHEN "0000" => result := 1;
         WHEN "0001" => result := 1;
         WHEN "0010" => result := 2;
         WHEN "0011" => result := 3;
         WHEN "0100" => result := 4;
         WHEN "0101" => result := 5;
         WHEN "0110" => result := 6;
         WHEN "0111" => result := 7;
         WHEN "1000" => result := 8;
         WHEN "1001" => result := 1;
         WHEN "1010" => result := 2;
         WHEN "1011" => result := 3;
         WHEN "1100" => result := 4;
         WHEN "1101" => result := 5;
         WHEN "1110" => result := 6;
         WHEN "1111" => result := 7;
         WHEN others => NULL;
       END CASE;
       RETURN result;
   END divider_to_ratio;

   FUNCTION make_integer (val: std_logic_vector(2 downto 0)) RETURN Integer IS
   VARIABLE result : Integer;
   BEGIN
       CASE val IS
         WHEN "000" => result := 0;
         WHEN "001" => result := 1;
         WHEN "010" => result := 2;
         WHEN "011" => result := 3;
         WHEN "100" => result := 4;
         WHEN "101" => result := 5;
         WHEN "110" => result := 6;
         WHEN "111" => result := 7;
         WHEN others => NULL;
       END CASE;
       RETURN result;
   END make_integer;


   PROCEDURE initialize (mode : in pcm_mode; duty_tap : in Integer; duty_reg : in real;
                         div0_reg1 : in Integer; div1_reg1 : in Integer; div2_reg1 : in Integer;
                         pdelay_reg : in std_logic_vector(7 downto 0);
                         signal configreg6 : out std_logic_vector(7 downto 0);
                         signal configreg5 : out std_logic_vector(7 downto 0);
                         signal configreg4 : out std_logic_vector(7 downto 0);
                         signal configreg3 : out std_logic_vector(7 downto 0);
                         signal configreg2 : out std_logic_vector(7 downto 0);
                         signal configreg1 : out std_logic_vector(7 downto 0);
                         signal configreg0 : out std_logic_vector(7 downto 0)) IS

   VARIABLE tap1, tap2 : std_logic_vector(3 downto 0);

   BEGIN
     CASE mode  IS
       WHEN DLL1X => configreg5 <= "00010100";
                       configreg6 <= "01010001";
                       configreg4 <= pdelay_tostd_logic_vector(duty_tap);
       WHEN DLLPD => configreg5 <= "00000100";
                       configreg4 <= pdelay_reg;
                       if (div2_reg1 > 1) then
                         configreg6 <= "10110001";
                       else
                         configreg6 <= "10100000";
                       end if;
       WHEN PCMBUF => configreg5 <= "00000000";
                        configreg6(7 downto 2) <= "000000";
                        configreg0 <= "00000000";
                        configreg1 <= "00000000";
                        configreg2 <= "00000000";
       WHEN PLL    => configreg5 <= "00000001";
                        if (div2_reg1 > 1) then
                           configreg6 <= "01110001";
                        else
                           configreg6 <= "01100001";
                        end if;
                        configreg4 <= "00000111";
       WHEN others => NULL;
     END CASE;
   END initialize;
END conversion;


--- 
LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE work.conversion.all;
PACKAGE orcacomp IS 
-- 
COMPONENT ageb4
PORT( 
	a0, a1, a2, a3: IN std_logic := 'X';
	b0, b1, b2, b3: IN std_logic := 'X';
	ci: IN std_logic := 'X';
	ge: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ageb8
PORT( 
	a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
	b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	ge: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT aleb4
PORT( 
	a0, a1, a2, a3: IN std_logic := 'X';
	b0, b1, b2, b3: IN std_logic := 'X';
	ci: IN std_logic := 'X';
	le: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT aleb8
PORT( 
	a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
	b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	le: OUT std_logic := 'X'
  );
END COMPONENT;
COMPONENT aneb4
PORT( 
        a0, a1, a2, a3: IN std_logic := 'X';
        b0, b1, b2, b3: IN std_logic := 'X';
	ci: IN std_logic := 'X';
	ne: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT aneb8
PORT( 
	a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
	b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
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
COMPONENT bms6
PORT(
	b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms12
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms12f
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms6pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms6pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms12fpd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms12fpu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms12pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bms12pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz6
PORT(
	b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz6pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz6pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz12
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz12f
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz12fpd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz12fpu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz12pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bmz12pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bndscan
PORT(
	ptdi:  IN std_logic := 'X';
	ptms: IN std_logic := 'X';
	ptck: IN std_logic := 'X';
	bso1: IN std_logic := 'X';
	bso2: IN std_logic := 'X';
	tdi: OUT std_logic;
	tck: OUT std_logic;
	bsen1: OUT std_logic;
	bsen2: OUT std_logic;
	tdo: OUT std_logic
  );
END COMPONENT;
--
COMPONENT bts12
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts12f
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts12fpd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts12fpu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts12pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts12pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts6
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts6pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT bts6pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz12
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz12f
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz12fpd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz12fpu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz12pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz12pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz6
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz6pd
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT btz6pu
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT cb4
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3 : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cb4p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cb4p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0 , q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cb4p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cb4p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cb8p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cb8p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cb8p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cb8p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd4
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3 : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd4p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd4p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd4p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd4p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd8p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd8p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd8p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cd8p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cfd1p3bx
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cfd1p3dx
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cfd1p3ix
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cfd1p3iz
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cfd1p3jx
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cfd1p3jz
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        ck: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT cu4
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3 : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu4p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu4p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu4p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu4p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
        q0, q1, q2, q3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu8p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu8p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu8p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	cd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT cu8p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	ci : IN std_logic := 'X';
	sp : IN std_logic := 'X';
	ck : IN std_logic := 'X';
	pd : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT dce32x4
GENERIC(
        disabled_gsr : string := "0";
        initval : string := "0x00000000000000000000000000000000"
  );
PORT( 
	di0, di1, di2, di3 : IN std_logic := 'X';
	ck  : IN std_logic := 'X';
	wren: IN std_logic := 'X';
	wpe0: IN std_logic := 'X';
	wpe1: IN std_logic := 'X';
	rad0, rad1, rad2, rad3, rad4: IN std_logic := 'X';
	wad0, wad1, wad2, wad3, wad4: IN std_logic := 'X';
	do0, do1, do2, do3 : OUT std_logic := 'X';
	qdo0, qdo1, qdo2, qdo3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT dec4
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3 : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT dec8
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7 : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3, nc4, nc5, nc6, nc7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT dll1xb
GENERIC(
        duty  : in Real;
        disabled_gsr  : in std_logic;
        div0  : in Integer
  );
PORT(
	clkin : IN std_logic := 'X';
	eclk : OUT std_logic := 'X';
	sclk : OUT std_logic := 'X';
	lock : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dll1xt
GENERIC(
        duty  : in Real;
        disabled_gsr  : in std_logic;
        div0  : in Integer
  );
PORT(
	clkin : IN std_logic := 'X';
	eclk : OUT std_logic := 'X';
	sclk : OUT std_logic := 'X';
	lock : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dllpdb
GENERIC(
        pdelay : in Integer;
        div0 : in Integer;
        disabled_gsr  : in std_logic;
        div2 : in Integer
  );
PORT(
	clkin : IN std_logic := 'X';
	eclk : OUT std_logic := 'X';
	sclk : OUT std_logic := 'X';
	lock : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dllpdt
GENERIC(
        pdelay : in Integer;
        div0 : in Integer;
        disabled_gsr  : in std_logic;
        div2 : in Integer
  );
PORT(
	clkin : IN std_logic := 'X';
	eclk : OUT std_logic := 'X';
	sclk : OUT std_logic := 'X';
	lock : OUT std_logic := 'X'
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
COMPONENT fadd4o
PORT( 
        a0, a1, a2, a3 : IN std_logic := 'X';
        b0, b1, b2, b3 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	ofl: OUT std_logic := 'X';
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
COMPONENT fadd8o
PORT( 
        a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
        b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	ofl: OUT std_logic := 'X';
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
COMPONENT fadsu4o
PORT( 
        a0, a1, a2, a3 : IN std_logic := 'X';
        b0, b1, b2, b3 : IN std_logic := 'X';
	bci: IN std_logic := 'X';
	con: IN std_logic := 'X';
	ofl: OUT std_logic := 'X';
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
COMPONENT fadsu8o
PORT( 
        a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
        b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
	bci: IN std_logic := 'X';
	con: IN std_logic := 'X';
	ofl: OUT std_logic := 'X';
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
COMPONENT fsub4o
PORT( 
        a0, a1, a2, a3 : IN std_logic := 'X';
        b0, b1, b2, b3 : IN std_logic := 'X';
	bi: IN std_logic := 'X';
	ofl: OUT std_logic := 'X';
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
COMPONENT fsub8o
PORT( 
        a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
        b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
	bi: IN std_logic := 'X';
	ofl: OUT std_logic := 'X';
        s0, s1, s2, s3, s4, s5, s6, s7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fmult41
PORT( 
        a0, a1, a2, a3 : IN std_logic := 'X';
        b0, b1, b2, b3 : IN std_logic := 'X';
	mult: IN std_logic := 'X';
	ci: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        p0, p1, p2, p3 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fmult81
PORT( 
        a0, a1, a2, a3, a4, a5, a6, a7 : IN std_logic := 'X';
        b0, b1, b2, b3, b4, b5, b6, b7 : IN std_logic := 'X';
	mult: IN std_logic := 'X';
	ci: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        p0, p1, p2, p3, p4, p5, p6, p7 : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fd1s1a
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1ay
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1b
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1d
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1i
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s1j
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ax
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ay
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3iz
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1p3jz
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ax
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ay
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fd1s3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d : IN std_logic := 'X';
	ck: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3az
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3ay
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3iy
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3iz
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3jy
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1p3jz
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1a
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1ay
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1b
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1d
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1i
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s1j
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s3ax
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT fl1s3ay
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	q : OUT std_logic := 'X';
	qn: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT gsr
PORT( 
      gsr: IN std_logic := 'X'
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
COMPONENT ibm
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibmpd
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibmpds
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibmpu
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibmpus
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibms
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibt
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibtpd
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibtpds
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibtpu
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibtpus
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ibts
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ifs1p3bx
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1p3iz
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1p3jz
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1s1d
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1s1i
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ifs1s1j
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ilf2p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
        eclk: IN std_logic := 'X';	
        sclk: IN std_logic := 'X';
	pd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ilf2p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
	sp  : IN std_logic := 'X';
        eclk: IN std_logic := 'X';      
        sclk: IN std_logic := 'X';
        cd  : IN std_logic := 'X';
	q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ilf2p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d   : IN std_logic := 'X';
        sp  : IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        cd  : IN std_logic := 'X';
        q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ilf2p3iz
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d   : IN std_logic := 'X';
        sp  : IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        cd  : IN std_logic := 'X';
        q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ilf2p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
        sp  : IN std_logic := 'X';
        eclk: IN std_logic := 'X';      
        sclk: IN std_logic := 'X';
        pd  : IN std_logic := 'X';
        q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ilf2p3jz
    GENERIC (disabled_gsr : string := "0");
PORT( 
	d   : IN std_logic := 'X';
        sp  : IN std_logic := 'X';
        eclk: IN std_logic := 'X';      
        sclk: IN std_logic := 'X';
        pd  : IN std_logic := 'X';
        q   : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT inc4
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3 : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT inc8
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7 : IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3, nc4, nc5, nc6, nc7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT incdec4
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3 : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT incdec8
PORT( 
	ci : IN std_logic := 'X';
	pc0, pc1, pc2, pc3, pc4, pc5, pc6, pc7 : IN std_logic := 'X';
	con: IN std_logic := 'X';
	co : OUT std_logic := 'X';
	nc0, nc1, nc2, nc3, nc4, nc5, nc6, nc7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lb4p3ax
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
COMPONENT lb8p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	con: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lb8p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	con: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lb8p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	con: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lb8p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	con: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ld4p3ax
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
COMPONENT ld8p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ld8p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ld8p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT ld8p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lu4p3ax
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
COMPONENT lu8p3bx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lu8p3dx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lu8p3ix
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	cd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT lu8p3jx
    GENERIC (disabled_gsr : string := "0");
PORT( 
        d0, d1, d2, d3, d4, d5, d6, d7 : IN std_logic := 'X';
	ci: IN std_logic := 'X';
	sp: IN std_logic := 'X';
	ck: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	pd: IN std_logic := 'X';
	co: OUT std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7 : OUT std_logic := 'X'
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
COMPONENT mux21e
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	sd: IN std_logic := 'X';
	e : IN std_logic := 'X';
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
COMPONENT mux41e
PORT( 
	d0: IN std_logic := 'X';
	d1: IN std_logic := 'X';
	d2: IN std_logic := 'X';
	d3: IN std_logic := 'X';
	sd1: IN std_logic := 'X';
	sd2: IN std_logic := 'X';
	e : IN std_logic := 'X';
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
COMPONENT ob12
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ob12f
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ob6
PORT(
        i:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz12
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz12f
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz12fpd
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz12fpu
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz12pd
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz12pu
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz6
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz6pd
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obz6pu
PORT(
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT ofe1p3bx
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofe1p3iz
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofe1p3jz
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        cd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofs1p3iz
    GENERIC (disabled_gsr : string := "0");
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
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ofs1p3jz
    GENERIC (disabled_gsr : string := "0");
PORT(
        d : IN std_logic := 'X';
        sp: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        pd: IN std_logic := 'X';
        q : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT oeand2
PORT(
        a: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT oemux21
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT oend2
PORT(
        a: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT oenr2
PORT(
        a: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT oeor2
PORT(
        a: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT oexnor2
PORT(
        a: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT oexor2
PORT(
        a: IN std_logic := 'X';
        eclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT osand2
PORT( 
	a: IN std_logic := 'X';
	sclk: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT osmux21
PORT(
        d0: IN std_logic := 'X';
        d1: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        z : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT osnd2
PORT(
        a: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT osnr2
PORT(
        a: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT osor2
PORT(
        a: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT osxnor2
PORT(
        a: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT osxor2
PORT(
        a: IN std_logic := 'X';
        sclk: IN std_logic := 'X';
        z: OUT std_logic := 'X'
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
COMPONENT oscil
PORT(
	test: IN std_logic := 'X';
	osc: OUT std_logic := 'X');
END COMPONENT;
-- 
COMPONENT pcmbufb
PORT(
	clkin  : IN std_logic := 'X';
	eclk   : OUT std_logic := 'X';
	sclk   : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pcmbuft
PORT(
        clkin  : IN std_logic := 'X';
        eclk   : OUT std_logic := 'X';
        sclk   : OUT std_logic := 'X'
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
COMPONENT pfumx41
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
COMPONENT pllb
GENERIC(
        div0 : in Integer;
        div1 : in Integer;
        div2 : in Integer;
        disabled_gsr  : in std_logic;
        fbdelay   : Time    := 0 ns
  );
PORT(
	clkin : IN std_logic := 'X';
	fb    : IN std_logic := 'X';
	eclk : OUT std_logic := 'X';
	sclk : OUT std_logic := 'X';
	lock : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pllt
GENERIC(
        div0 : in Integer;
        div1 : in Integer;
        div2 : in Integer;
        disabled_gsr  : in std_logic;
        fbdelay   : Time    := 0 ns
  );
PORT(
	clkin : IN std_logic := 'X';
	fb    : IN std_logic := 'X';
	eclk : OUT std_logic := 'X';
	sclk : OUT std_logic := 'X';
	lock : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pur
PORT(
      pur: IN std_logic := 'X'
  );
END COMPONENT;
--

COMPONENT rce32x4
GENERIC(
        disabled_gsr : string := "0";
        initval : string := "0x00000000000000000000000000000000"
  );
PORT( 
	ad0, ad1, ad2, ad3, ad4: IN std_logic := 'X';
	di0, di1, di2, di3: IN std_logic := 'X';
	ck  : IN std_logic := 'X';
	wren: IN std_logic := 'X';
	wpe0: IN std_logic := 'X';
	wpe1: IN std_logic := 'X';
	do0, do1, do2, do3: OUT std_logic := 'X';
	qdo0, qdo1, qdo2, qdo3: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT rom32x4
GENERIC(
        disabled_gsr : string := "0";
        initval : string := "0x00000000000000000000000000000000"
  );
PORT( 
	ad0, ad1, ad2, ad3, ad4: IN std_logic := 'X';
	ck  : IN std_logic := 'X';
	do0, do1, do2, do3: OUT std_logic := 'X';
	qdo0, qdo1, qdo2, qdo3: OUT std_logic := 'X'
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
COMPONENT readbk
PORT(
      rdcfgn : IN std_logic := 'X';
      capt : IN std_logic := 'X';
      prddata : OUT std_logic := 'X';
      rdbo : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sand2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT sand4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT sand6
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	f: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT sand8
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	f: IN std_logic := 'X';
	g: IN std_logic := 'X';
	h: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT sand10
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	f: IN std_logic := 'X';
	g: IN std_logic := 'X';
	h: IN std_logic := 'X';
	i: IN std_logic := 'X';
	j: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT saoi42
PORT( 
	a1: IN std_logic := 'X';
	a2: IN std_logic := 'X';
	a3: IN std_logic := 'X';
	a4: IN std_logic := 'X';
	b1: IN std_logic := 'X';
	b2: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT saoi44
PORT( 
	a1: IN std_logic := 'X';
	a2: IN std_logic := 'X';
	a3: IN std_logic := 'X';
	a4: IN std_logic := 'X';
	b1: IN std_logic := 'X';
	b2: IN std_logic := 'X';
	b3: IN std_logic := 'X';
	b4: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT saoi442
PORT( 
	a1: IN std_logic := 'X';
	a2: IN std_logic := 'X';
	a3: IN std_logic := 'X';
	a4: IN std_logic := 'X';
	b1: IN std_logic := 'X';
	b2: IN std_logic := 'X';
	b3: IN std_logic := 'X';
	b4: IN std_logic := 'X';
	c1: IN std_logic := 'X';
	c2: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sor2
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sor4
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sor6
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	f: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sor8
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	f: IN std_logic := 'X';
	g: IN std_logic := 'X';
	h: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT sor10
PORT( 
	a: IN std_logic := 'X';
	b: IN std_logic := 'X';
	c: IN std_logic := 'X';
	d: IN std_logic := 'X';
	e: IN std_logic := 'X';
	f: IN std_logic := 'X';
	g: IN std_logic := 'X';
	h: IN std_logic := 'X';
	i: IN std_logic := 'X';
	j: IN std_logic := 'X';
	z: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT strtup
PORT( 
	uclk : IN std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT tbuf
PORT( 
	i: IN std_logic := 'X';
	t: IN std_logic := 'X';
	o: OUT std_logic := 'X'
  );
END COMPONENT;
-- 
COMPONENT tibuf
PORT( 
	i: IN std_logic := 'X';
	t: IN std_logic := 'X';
	o: OUT std_logic := 'X'
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
COMPONENT intrbuf
PORT(
        asbi     : IN std_logic := 'X';
        toasb    : IN std_logic := 'X';
        toasbm1  : IN std_logic := 'X';
        toasbm2  : IN std_logic := 'X';
        toasbm3  : IN std_logic := 'X';
        frasb    : OUT std_logic := 'X';
        asbo     : OUT std_logic := 'X';
        asbm1o   : OUT std_logic := 'X';
        asbm2o   : OUT std_logic := 'X';
        asbm3o   : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT intrbufs
PORT(
        asbi     : IN std_logic := 'X';
        toasb    : IN std_logic := 'X';
        toasbm1  : IN std_logic := 'X';
        toasbm2  : IN std_logic := 'X';
        toasbm3  : IN std_logic := 'X';
        frasb    : OUT std_logic := 'X';
        asbo     : OUT std_logic := 'X';
        asbm1o   : OUT std_logic := 'X';
        asbm2o   : OUT std_logic := 'X';
        asbm3o   : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT toasbck
PORT(
        cktoasb     : IN std_logic := 'X';
        asbcko    : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT frasbck
PORT(
        asbcki     : IN std_logic := 'X';
        ckfrasb    : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pll1
PORT(
        clkin     : IN std_logic  := 'X';
        clkout    : OUT std_logic := 'X';
        lock      : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pll2
PORT(
        clkin     : IN std_logic  := 'X';
        clkout    : OUT std_logic := 'X';
        lock      : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT ppll
   GENERIC (
      div0               : Integer   := 1;
      div1               : Integer   := 1;
      div2               : Integer   := 1;
      div3               : Integer   := 1;
      mclkmode           : String    := "BYPASS";
      nclkmode           : String    := "BYPASS";
      vcotap             : Integer   := 4;
      disabled_gsr       : std_logic := '1');
PORT(
      clkin              : in std_logic := 'X';
      fb                 : in std_logic := 'X';
      mclk               : out std_logic;
      nclk               : out std_logic;
      lock               : out std_logic;
      intfb              : out std_logic
  );
END COMPONENT;
--
COMPONENT hppll
   GENERIC (
      div0               : Integer   := 1;
      div1               : Integer   := 1;
      div2               : Integer   := 1;
      div3               : Integer   := 1;
      mclkmode           : String    := "DUTYCYCLE";
      nclkmode           : String    := "DUTYCYCLE";
      vcotap             : Integer   := 4;
      disabled_gsr       : std_logic := '1');
PORT(
      clkin              : in std_logic := 'X';
      fb                 : in std_logic := 'X';
      mclk               : out std_logic;
      nclk               : out std_logic;
      lock               : out std_logic;
      intfb              : out std_logic
  );
END COMPONENT;
--
COMPONENT br512x18
GENERIC(
        BRAMMODE0 : in String := "NOREG";
        BRAMMODE1 : in String := "NOREG";
        ARBITERMODE : in String := "FALSE";
        initval_00 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_01 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_02 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_03 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_04 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_05 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_06 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_07 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_08 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_09 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0a : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0b : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0c : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0d : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0e : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0f : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_10 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_11 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_12 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_13 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_14 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_15 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_16 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_17 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_18 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_19 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1a : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1b : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1c : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1d : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1e : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1f : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  );
PORT(
        aw18, aw17, aw16, aw15, aw14, aw13, aw12, aw11, aw10   : in std_logic := 'X';
        aw08, aw07, aw06, aw05, aw04, aw03, aw02, aw01, aw00   : in std_logic := 'X';
        d117, d116, d115, d114, d113, d112, d111, d110, d19    : in std_logic := 'X';
        d18, d17, d16, d15, d14, d13, d12, d11, d10            : in std_logic := 'X';
        d017, d016, d015, d014, d013, d012, d011, d010, d09    : in std_logic := 'X';
        d08, d07, d06, d05, d04, d03, d02, d01, d00            : in std_logic := 'X';
        bw11, bw10, bw01, bw00                                 : in std_logic := 'X';
        ar18, ar17, ar16, ar15, ar14, ar13, ar12, ar11, ar10   : in std_logic := 'X';
        ar08, ar07, ar06, ar05, ar04, ar03, ar02, ar01, ar00   : in std_logic := 'X';
        ckw1, ckw0, ckr1, ckr0, csw1, csw0, csr1, csr0         : in std_logic := 'X';

        q117, q116, q115, q114, q113, q112, q111, q110, q19    : out std_logic := 'X';
        q18, q17, q16, q15, q14, q13, q12, q11, q10            : out std_logic := 'X';
        q017, q016, q015, q014, q013, q012, q011, q010, q09    : out std_logic := 'X';
        q08, q07, q06, q05, q04, q03, q02, q01, q00, busy      : out std_logic := 'X' 
  );
END COMPONENT;
--
COMPONENT br1024x18
GENERIC(
        BRAMMODE0 : in String := "NOREG";
        BRAMMODE1 : in String := "NOREG";
        ARBITERMODE : in String := "FALSE";
        initval_00 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_01 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_02 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_03 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_04 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_05 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_06 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_07 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_08 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_09 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0a : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0b : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0c : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0d : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0e : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0f : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_10 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_11 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_12 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_13 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_14 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_15 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_16 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_17 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_18 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_19 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1a : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1b : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1c : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1d : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1e : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1f : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_20 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_21 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_22 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_23 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_24 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_25 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_26 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_27 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_28 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_29 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2a : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2b : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2c : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2d : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2e : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2f : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_30 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_31 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_32 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_33 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_34 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_35 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_36 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_37 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_38 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_39 : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3a : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3b : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3c : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3d : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3e : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3f : string := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  );
PORT(
        aw19, aw18, aw17, aw16, aw15, aw14, aw13, aw12, aw11, aw10   : in std_logic := 'X';
        aw09, aw08, aw07, aw06, aw05, aw04, aw03, aw02, aw01, aw00   : in std_logic := 'X';
        d117, d116, d115, d114, d113, d112, d111, d110, d19          : in std_logic := 'X';
        d18, d17, d16, d15, d14, d13, d12, d11, d10                  : in std_logic := 'X';
        d017, d016, d015, d014, d013, d012, d011, d010, d09          : in std_logic := 'X';
        d08, d07, d06, d05, d04, d03, d02, d01, d00                  : in std_logic := 'X';
        bw11, bw10, bw01, bw00                                       : in std_logic := 'X';
        ar19, ar18, ar17, ar16, ar15, ar14, ar13, ar12, ar11, ar10   : in std_logic := 'X';
        ar09, ar08, ar07, ar06, ar05, ar04, ar03, ar02, ar01, ar00   : in std_logic := 'X';
        ckw1, ckw0, ckr1, ckr0, csw1, csw0, csr1, csr0               : in std_logic := 'X';

        q117, q116, q115, q114, q113, q112, q111, q110, q19          : out std_logic ;
        q18, q17, q16, q15, q14, q13, q12, q11, q10                  : out std_logic ;
        q017, q016, q015, q014, q013, q012, q011, q010, q09          : out std_logic ;
        q08, q07, q06, q05, q04, q03, q02, q01, q00, busy            : out std_logic 
  );
END COMPONENT;
--
COMPONENT ff512x18
    GENERIC (FFMODE : String := "NOREG";
        INHIBITMODE : String := "TRUE";
        ASYNCMODE   : String := "FALSE");
PORT(
      d17, d16, d15, d14, d13, d12, d11, d10, d9        : in std_logic := 'X';
      d8, d7, d6, d5, d4, d3, d2, d1, d0                : in std_logic := 'X';
      ckw, ckr, wre, rde, rstn                          : in std_logic := 'X';
      pf8, pf7, pf6, pf5, pf4, pf3, pf2, pf1, pf0       : in std_logic := 'X';
      pe8, pe7, pe6, pe5, pe4, pe3, pe2, pe1, pe0       : in std_logic := 'X';

      q17, q16, q15, q14, q13, q12, q11, q10, q9        : out std_logic ;
      q8, q7, q6, q5, q4, q3, q2, q1, q0                : out std_logic ;
      ef, ff, pef, pff                                  : out std_logic  
 );
END COMPONENT;
--
--
COMPONENT ff256X36
    GENERIC (FFMODE : String := "NOREG";
        INHIBITMODE : String := "TRUE";
        ASYNCMODE   : String := "FALSE");
PORT(
      d35, d34, d33, d32, d31, d30, d29, d28, d27       : in std_logic := 'X';
      d26, d25, d24, d23, d22, d21, d20, d19, d18       : in std_logic := 'X';
      d17, d16, d15, d14, d13, d12, d11, d10, d9        : in std_logic := 'X';
      d8, d7, d6, d5, d4, d3, d2, d1, d0                : in std_logic := 'X';
      ckw, ckr, wre, rde, rstn                          : in std_logic := 'X';
      pf7, pf6, pf5, pf4, pf3, pf2, pf1, pf0            : in std_logic := 'X';
      pe7, pe6, pe5, pe4, pe3, pe2, pe1, pe0            : in std_logic := 'X';

      q35, q34, q33, q32, q31, q30, q29, q28, q27       : out std_logic ;
      q26, q25, q24, q23, q22, q21, q20, q19, q18       : out std_logic ;
      q17, q16, q15, q14, q13, q12, q11, q10, q9        : out std_logic ;
      q8, q7, q6, q5, q4, q3, q2, q1, q0                : out std_logic ;
      ef, ff, pef, pff                                  : out std_logic 
 );
END COMPONENT;
--
COMPONENT ff1024X9
    GENERIC (FFMODE : String := "NOREG";
        INHIBITMODE : String := "TRUE";
        ASYNCMODE   : String := "FALSE");
PORT(
      d8, d7, d6, d5, d4, d3, d2, d1, d0                : in std_logic := 'X';
      ckw, ckr, wre, rde, rstn                          : in std_logic := 'X';
      pf9, pf8, pf7, pf6, pf5, pf4, pf3, pf2, pf1, pf0  : in std_logic := 'X';
      pe9, pe8, pe7, pe6, pe5, pe4, pe3, pe2, pe1, pe0  : in std_logic := 'X';

      q8, q7, q6, q5, q4, q3, q2, q1, q0                : out std_logic ;
      ef, ff, pef, pff                                  : out std_logic 
 );
END COMPONENT;
--
COMPONENT ff2X512X9
    GENERIC (FFMODE0 : String := "NOREG";
             FFMODE1 : String := "NOREG";
        INHIBITMODE0 : String := "TRUE";
        INHIBITMODE1 : String := "TRUE";
        ASYNCMODE0   : String := "FALSE");
PORT(
      d18, d17, d16, d15, d14, d13, d12, d11, d10           : in std_logic := 'X';
      ckw1, ckr1, wre1, rde1, rstn1                         : in std_logic := 'X';
      pf18, pf17, pf16, pf15, pf14, pf13, pf12, pf11, pf10  : in std_logic := 'X';
      pe18, pe17, pe16, pe15, pe14, pe13, pe12, pe11, pe10  : in std_logic := 'X';
      d08, d07, d06, d05, d04, d03, d02, d01, d00           : in std_logic := 'X';
      ckw0, ckr0, wre0, rde0, rstn0                         : in std_logic := 'X';
      pf08, pf07, pf06, pf05, pf04, pf03, pf02, pf01, pf00  : in std_logic := 'X';
      pe08, pe07, pe06, pe05, pe04, pe03, pe02, pe01, pe00  : in std_logic := 'X';

      q18, q17, q16, q15, q14, q13, q12, q11, q10           : out std_logic ;
      ef1, ff1, pef1, pff1                                  : out std_logic ;
      q08, q07, q06, q05, q04, q03, q02, q01, q00           : out std_logic ;
      ef0, ff0, pef0, pff0                                  : out std_logic 
 );
END COMPONENT;
--
COMPONENT cmult16
    GENERIC (CMULTMODE : String := "NOREG";
        initval_00 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_01 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_02 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_03 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_04 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_05 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_06 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_07 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_08 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_09 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_0a : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_0b : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_0c : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_0d : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_0e : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_0f : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_10 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_11 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_12 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_13 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_14 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_15 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_16 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_17 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_18 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_19 : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_1a : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_1b : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_1c : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_1d : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_1e : String := "0X0000000000000000000000000000000000000000000000000000000000000000";
        initval_1f : String := "0X0000000000000000000000000000000000000000000000000000000000000000");
PORT(
      m15, m14, m13, m12, m11, m10, m9, m8                         : in std_logic := 'X';
      m7, m6, m5, m4, m3, m2, m1, m0, mck, en                      : in std_logic := 'X';
      aw08, aw07, aw06, aw05, aw04, aw03, aw02, aw01, aw00         : in std_logic := 'X';
      d015, d014, d013, d012, d011, d010, d09, d08                 : in std_logic := 'X';
      d07, d06, d05, d04, d03, d02, d01, d00, ckw0, csw0           : in std_logic := 'X';
      aw18, aw17, aw16, aw15, aw14, aw13, aw12, aw11, aw10         : in std_logic := 'X';
      d115, d114, d113, d112, d111, d110, d19, d18                 : in std_logic := 'X';
      d17, d16, d15, d14, d13, d12, d11, d10, ckw1, csw1           : in std_logic := 'X';

      p23, p22, p21, p20, p19, p18, p17, p16, p15, p14, p13        : out std_logic ;
      p12, p11, p10, p9, p8, p7, p6, p5, p4, p3, p2, p1, p0        : out std_logic  

 );
END COMPONENT;
--
COMPONENT mult8x8
    GENERIC (MULTMODE : String := "NOREG");
PORT(
      a7, a6, a5, a4, a3, a2, a1, a0         : in std_logic := 'X';
      b7, b6, b5, b4, b3, b2, b1, b0         : in std_logic := 'X';
      ck, en                                 : in std_logic := 'X';
      p15, p14, p13, p12, p11, p10, p9       : out std_logic ;
      p8, p7, p6, p5, p4, p3, p2, p1, p0     : out std_logic  
 );
END COMPONENT;
--
COMPONENT cam2x256x16
    GENERIC (CAMMODE0 : String := "NOREG";
             CAMMODE1 : String := "NOREG");
PORT(
        dw17, dw16, dw15, dw14, dw13, dw12, dw11, dw10        : in std_logic := 'X';
        ad13, ad12, ad11, ad10, cd1, sm1, wre1, ckw1          : in std_logic := 'X';
        dm17, dm16, dm15, dm14, dm13, dm12, dm11, dm10        : in std_logic := 'X';
        rde1, ckr1                                            : in std_logic := 'X';
        dw07, dw06, dw05, dw04, dw03, dw02, dw01, dw00        : in std_logic := 'X';
        ad03, ad02, ad01, ad00, cd0, sm0, wre0, ckw0          : in std_logic := 'X';
        dm07, dm06, dm05, dm04, dm03, dm02, dm01, dm00        : in std_logic := 'X';
        rde0, ckr0                                            : in std_logic := 'X';

        q115, q114, q113, q112, q111, q110, q19, q18          : out std_logic := 'X';
        q17, q16, q15, q14, q13, q12, q11, q10                : out std_logic := 'X';
        q015, q014, q013, q012, q011, q010, q09, q08          : out std_logic := 'X';
        q07, q06, q05, q04, q03, q02, q01, q00                : out std_logic := 'X' 
 );
END COMPONENT;
--
COMPONENT iosr2
PORT(
        ind, outd0, outd1, ck, update       : IN std_logic   := 'X';
        inq0, inq1, outq      : OUT std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT iosr4
PORT(
        ind, outd0, outd1, outd2, outd3, ck, update       : IN std_logic := 'X';
        inq0, inq1, inq2, inq3, outq      : OUT std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT iddr
PORT(
        d, ck             : in std_logic := 'X';
        qp, qn            : out std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT ioddr
PORT(
        ind0, ind1, ind2, ind3, out1d0, out1d1             : in std_logic := 'X';
        out2d0, out2d1, out3d0, out3d1, out4d0, out4d1, ck : in std_logic := 'X';
        in1q0, in1q1, in2q0, in2q1, in3q0, in3q1           : out std_logic := 'X';
        in4q0, in4q1, outq0, outq1, outq2, outq3           : out std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT ioddrn
PORT(
        ind0, ind1, ind2, ind3, out1d0, out1d1             : in std_logic := 'X';
        out2d0, out2d1, out3d0, out3d1, out4d0, out4d1, ck : in std_logic := 'X';
        in1q0, in1q1, in2q0, in2q1, in3q0, in3q1           : out std_logic := 'X';
        in4q0, in4q1, outq0, outq1, outq2, outq3           : out std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT osr2x2
PORT(
        d10, d11, d20, d21, ck, update       : IN std_logic := 'X';
        q1, q2      : OUT std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT hosr2x2
PORT(
        d10, d11, d20, d21, ck, update       : IN std_logic := 'X';
        q1, q2      : OUT std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT hiosr2
PORT(
        ind, outd0, outd1, ck, update       : IN std_logic   := 'X';
        inq0, inq1, outq      : OUT std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT hiosr4
PORT(
        ind, outd0, outd1, outd2, outd3, ck, update       : IN std_logic := 'X';
        inq0, inq1, inq2, inq3, outq      : OUT std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT hioddr
PORT(
        ind0, ind1, ind2, ind3, out1d0, out1d1             : in std_logic := 'X';
        out2d0, out2d1, out3d0, out3d1, out4d0, out4d1, ck : in std_logic := 'X';
        in1q0, in1q1, in2q0, in2q1, in3q0, in3q1           : out std_logic := 'X';
        in4q0, in4q1, outq0, outq1, outq2, outq3           : out std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT hioddrn
PORT(
        ind0, ind1, ind2, ind3, out1d0, out1d1             : in std_logic := 'X';
        out2d0, out2d1, out3d0, out3d1, out4d0, out4d1, ck : in std_logic := 'X';
        in1q0, in1q1, in2q0, in2q1, in3q0, in3q1           : out std_logic := 'X';
        in4q0, in4q1, outq0, outq1, outq2, outq3           : out std_logic := 'X'
 );
END COMPONENT;
--
COMPONENT ddr
PORT(
        ind0, ind1, ind2, ind3, outd0, outd1, outd2, outd3, ck : in std_logic := 'X';
        inq0, inq1, inq2, inq3, outq0, outq1, outq2, outq3     : out std_logic
 );
END COMPONENT;
--
COMPONENT bmw6
PORT(
        b:  INOUT std_logic := 'X';
        i:  IN std_logic := 'X';
        t:  IN std_logic := 'X';
        o:  OUT std_logic);
END COMPONENT;
--
COMPONENT obw6
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
COMPONENT sbr512x18
   GENERIC (
        BRAMMODE                  : String  := "NOREG";
        ARBITERMODE               : String  := "FALSE");
PORT(
        aw0, aw1, aw2, aw3, aw4, aw5, aw6, aw7, aw8         : in std_logic := 'X';
        ar0, ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8         : in std_logic := 'X';
        d0, d1, d2, d3, d4, d5, d6, d7, d8, d9              : in std_logic := 'X';
        d10, d11, d12, d13, d14, d15, d16, d17              : in std_logic := 'X';
        bw0, bw1, ckw, ckr, csw, csr                        : in std_logic := 'X';
        sq0, sq1, sq2, sq3, sq4, sq5, sq6, sq7, sq8, sq9    : in std_logic := 'X';
        sq10, sq11, sq12, sq13, sq14, sq15, sq16, sq17      : in std_logic := 'X';
        sbusy                                               : in std_logic := 'X';
        q0, q1, q2, q3, q4, q5, q6, q7, q8, q9              : out std_logic ;
        q10, q11, q12, q13, q14, q15, q16, q17, busy        : out std_logic ;
        saw0, saw1, saw2, saw3, saw4, saw5, saw6, saw7, saw8   : out std_logic ;
        sar0, sar1, sar2, sar3, sar4, sar5, sar6, sar7, sar8   : out std_logic ;
        sd0, sd1, sd2, sd3, sd4, sd5, sd6, sd7, sd8, sd9    : out std_logic ;
        sd10, sd11, sd12, sd13, sd14, sd15, sd16, sd17      : out std_logic ;
        sbw0, sbw1, sckw, sckr, scsw, scsr                  : out std_logic ;
        mc0, mc1, arbiter                                   : out std_logic 
 );
END COMPONENT;
--
COMPONENT sbr1024x18
   GENERIC (
        BRAMMODE                  : String  := "NOREG";
        ARBITERMODE               : String  := "FALSE");
PORT(
        aw0, aw1, aw2, aw3, aw4, aw5, aw6, aw7, aw8, aw9             : in std_logic := 'X';
        ar0, ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8, ar9             : in std_logic := 'X';
        d0, d1, d2, d3, d4, d5, d6, d7, d8, d9                       : in std_logic := 'X';
        d10, d11, d12, d13, d14, d15, d16, d17                       : in std_logic := 'X';
        bw0, bw1, ckw, ckr, csw, csr                                 : in std_logic := 'X';
        sq0, sq1, sq2, sq3, sq4, sq5, sq6, sq7, sq8, sq9             : in std_logic := 'X';
        sq10, sq11, sq12, sq13, sq14, sq15, sq16, sq17, sbusy        : in std_logic := 'X';

        q0, q1, q2, q3, q4, q5, q6, q7, q8, q9                       : out std_logic ;
        q10, q11, q12, q13, q14, q15, q16, q17, busy                 : out std_logic ;
        saw0, saw1, saw2, saw3, saw4, saw5, saw6, saw7, saw8, saw9   : out std_logic ;
        sar0, sar1, sar2, sar3, sar4, sar5, sar6, sar7, sar8, sar9   : out std_logic ;
        sd0, sd1, sd2, sd3, sd4, sd5, sd6, sd7, sd8, sd9             : out std_logic ;
        sd10, sd11, sd12, sd13, sd14, sd15, sd16, sd17               : out std_logic ;
        sbw0, sbw1, sckw, sckr, scsw, scsr                           : out std_logic ;
        mc0, mc1, arbiter                                            : out std_logic 
 );
END COMPONENT;
--
COMPONENT ulis
PORT(
        rdata0, rdata1, rdata2, rdata3, rdata4, rdata5, rdata6, rdata7        : in std_logic ;
        rdata8, rdata9, rdata10, rdata11, rdata12, rdata13, rdata14           : in std_logic ;
        rdata15, rdata16, rdata17, rdata18, rdata19, rdata20, rdata21         : in std_logic ;
        rdata22, rdata23, rdata24, rdata25, rdata26, rdata27, rdata28         : in std_logic ;
        rdata29, rdata30, rdata31, rdata32, rdata33, rdata34, rdata35         : in std_logic ;
        clk, reset, ack, retry, err, irq, swdata0, swdata1                    : in std_logic ;
        swdata2, swdata3, swdata4, swdata5, swdata6, swdata7                  : in std_logic ;
        swdata8, swdata9, swdata10, swdata11, swdata12, swdata13, swdata14    : in std_logic ;
        swdata15, swdata16, swdata17, swdata18, swdata19, swdata20, swdata21  : in std_logic ;
        swdata22, swdata23, swdata24, swdata25, swdata26, swdata27, swdata28  : in std_logic ;
        swdata29, swdata30, swdata31, swdata32, swdata33, swdata34, swdata35  : in std_logic ;
        saddr0, saddr1, saddr2, saddr3, saddr4, saddr5, saddr6, saddr7        : in std_logic ;
        saddr8, saddr9, saddr10, saddr11, saddr12, saddr13, saddr14           : in std_logic ;
        saddr15, saddr16, saddr17, sburst, srdy, swr, ssize0, ssize1          : in std_logic ;

        wdata0, wdata1, wdata2, wdata3, wdata4, wdata5, wdata6, wdata7        : out std_logic ;
        wdata8, wdata9, wdata10, wdata11, wdata12, wdata13, wdata14           : out std_logic ;
        wdata15, wdata16, wdata17, wdata18, wdata19, wdata20, wdata21         : out std_logic ;
        wdata22, wdata23, wdata24, wdata25, wdata26, wdata27, wdata28         : out std_logic ;
        wdata29, wdata30, wdata31, wdata32, wdata33, wdata34, wdata35         : out std_logic ;
        addr0, addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8, addr9  : out std_logic ;
        addr10, addr11, addr12, addr13, addr14, addr15, addr16, addr17        : out std_logic ;
        burst, rdy, wr, size0, size1, srdata0, srdata1, srdata2               : out std_logic ;
        srdata3, srdata4, srdata5, srdata6, srdata7, srdata8, srdata9         : out std_logic ;
        srdata10, srdata11, srdata12, srdata13, srdata14, srdata15, srdata16  : out std_logic ;
        srdata17, srdata18, srdata19, srdata20, srdata21, srdata22, srdata23  : out std_logic ;
        srdata24, srdata25, srdata26, srdata27, srdata28, srdata29, srdata30  : out std_logic ;
        srdata31, srdata32, srdata33, srdata34, srdata35                      : out std_logic ;
        sclk, sreset, sack, sretry, serr, sirq                                : out std_logic
 );
END COMPONENT;
--
COMPONENT ulim
PORT(
        addr0, addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8, addr9  : in std_logic ;
        addr10, addr11, addr12, addr13, addr14, addr15, addr16, addr17        : in std_logic ;
        wdata0, wdata1, wdata2, wdata3, wdata4, wdata5, wdata6, wdata7        : in std_logic ;
        wdata8, wdata9, wdata10, wdata11, wdata12, wdata13, wdata14           : in std_logic ;
        wdata15, wdata16, wdata17, wdata18, wdata19, wdata20, wdata21         : in std_logic ;
        wdata22, wdata23, wdata24, wdata25, wdata26, wdata27, wdata28         : in std_logic ;
        wdata29, wdata30, wdata31, wdata32, wdata33, wdata34, wdata35         : in std_logic ;
        clk, reset, write, read, burst, rdy, size0, size1, lock, irq          : in std_logic ;
        srdata0, srdata1, srdata2, srdata3, srdata4, srdata5, srdata6, srdata7: in std_logic ;
        srdata8, srdata9, srdata10, srdata11, srdata12, srdata13, srdata14    : in std_logic ;
        srdata15, srdata16, srdata17, srdata18, srdata19, srdata20, srdata21  : in std_logic ;
        srdata22, srdata23, srdata24, srdata25, srdata26, srdata27, srdata28  : in std_logic ;
        srdata29, srdata30, srdata31, srdata32, srdata33, srdata34, srdata35  : in std_logic ;
        sgranted, sack, sretry, serr                                          : in std_logic ;

        rdata0, rdata1, rdata2, rdata3, rdata4, rdata5, rdata6, rdata7        : out std_logic ;
        rdata8, rdata9, rdata10, rdata11, rdata12, rdata13, rdata14           : out std_logic ;
        rdata15, rdata16, rdata17, rdata18, rdata19, rdata20, rdata21         : out std_logic ;
        rdata22, rdata23, rdata24, rdata25, rdata26, rdata27, rdata28         : out std_logic ;
        rdata29, rdata30, rdata31, rdata32, rdata33, rdata34, rdata35         : out std_logic ;
        granted, ack, retry, err, saddr0, saddr1, saddr2, saddr3              : out std_logic ;
        saddr4, saddr5, saddr6, saddr7, saddr8, saddr9, saddr10, saddr11      : out std_logic ;
        saddr12, saddr13, saddr14, saddr15, saddr16, saddr17                  : out std_logic ;
        swdata0, swdata1, swdata2, swdata3, swdata4, swdata5, swdata6         : out std_logic ;
        swdata7, swdata8, swdata9, swdata10, swdata11, swdata12, swdata13     : out std_logic ;
        swdata14, swdata15, swdata16, swdata17, swdata18, swdata19, swdata20  : out std_logic ;
        swdata21, swdata22, swdata23, swdata24, swdata25, swdata26, swdata27  : out std_logic ;
        swdata28, swdata29, swdata30, swdata31, swdata32, swdata33, swdata34  : out std_logic ;
        swdata35, sclk, sreset, swrite, sread, sburst, srdy                   : out std_logic ;
        ssize0, ssize1, slock, sirq                                           : out std_logic
 );
END COMPONENT;
--

--
END orcacomp;

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
-- $Header: /home/dmsys/pvcs/RCSMigTest/rcs/vhdl/pkg/vhdsclibs/data/orca3/src/RCS/ORCACOMP.vhd,v 1.30 2005/05/19 20:04:53 pradeep Exp $ 
--
--
----- package conversion----
--
--(For Viewlogic speedwave compilation uncomment these three declaration and
--comment-out the other three declaration)
--LIBRARY ieee, ieee_numeric_std;
--USE ieee.std_logic_1164.all;
--USE ieee.numeric_std.all; 

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
COMPONENT clkcntlb
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT clkcntll
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT clkcntlr
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT clkcntlt
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT clkcnthb
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT clkcnthl
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT clkcnthr
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT clkcntht
PORT(
	clkin : IN std_logic := 'X';
	shutoff : IN std_logic := 'X';
	clkout : OUT std_logic := 'X'
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
COMPONENT mpi960
PORT(
        adsn    : IN std_logic := 'X';
        ale     : IN std_logic := 'X';
        clk     : IN std_logic := 'X'; 
        cs0n    : IN std_logic := 'X';
        cs1     : IN std_logic := 'X';
        wrrdn   : IN std_logic := 'X';
        adin7   : IN std_logic := 'X';
        adin6   : IN std_logic := 'X';
        adin5   : IN std_logic := 'X';
        adin4   : IN std_logic := 'X';
        adin3   : IN std_logic := 'X';
        adin2   : IN std_logic := 'X';
        adin1   : IN std_logic := 'X';
        adin0   : IN std_logic := 'X';
        be1n	: IN std_logic := 'X';
        be0n	: IN std_logic := 'X';
        rrcvnin	: IN std_logic := 'X';
        uend    : IN std_logic := 'X';
        uirqn	: IN std_logic := 'X';
        udout7	: IN std_logic := 'X';
        udout6	: IN std_logic := 'X';
        udout5	: IN std_logic := 'X';
        udout4	: IN std_logic := 'X';
        udout3	: IN std_logic := 'X';
        udout2	: IN std_logic := 'X';
        udout1	: IN std_logic := 'X';
        udout0	: IN std_logic := 'X';
        dout7   : OUT std_logic := 'X';
        dout6   : OUT std_logic := 'X';
        dout5   : OUT std_logic := 'X';
        dout4   : OUT std_logic := 'X';
        dout3   : OUT std_logic := 'X';
        dout2   : OUT std_logic := 'X';
        dout1   : OUT std_logic := 'X';
        dout0   : OUT std_logic := 'X';
        ddrvctl : OUT std_logic := 'X';
        irqn 	: OUT std_logic := 'X';
        rdyrcvn	: OUT std_logic := 'X';
        rdrcvts: OUT std_logic := 'X';
        mpgsr 	: OUT std_logic := 'X';
        urdwrn 	: OUT std_logic := 'X';
        ustart 	: OUT std_logic := 'X';
        ua3 	: OUT std_logic := 'X';
        ua2 	: OUT std_logic := 'X';
        ua1 	: OUT std_logic := 'X';
        ua0 	: OUT std_logic := 'X';
        udin7 	: OUT std_logic := 'X';
        udin6 	: OUT std_logic := 'X';
        udin5 	: OUT std_logic := 'X';
        udin4 	: OUT std_logic := 'X';
        udin3 	: OUT std_logic := 'X';
        udin2 	: OUT std_logic := 'X';
        udin1 	: OUT std_logic := 'X';
        udin0 	: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT mpippc 
PORT(
        clk	: IN std_logic := 'X';
        cs0n	: IN std_logic := 'X';
        cs1	: IN std_logic := 'X';
        rdwrn	: IN std_logic := 'X';
        tsn	: IN std_logic := 'X';
        a27	: IN std_logic := 'X';
        a28	: IN std_logic := 'X';
        a29	: IN std_logic := 'X';
        a30	: IN std_logic := 'X';
        a31	: IN std_logic := 'X';
        din7	: IN std_logic := 'X';
        din6	: IN std_logic := 'X';
        din5	: IN std_logic := 'X';
        din4	: IN std_logic := 'X';
        din3	: IN std_logic := 'X';
        din2	: IN std_logic := 'X';
        din1	: IN std_logic := 'X';
        din0	: IN std_logic := 'X';
        uend	: IN std_logic := 'X';
        uirqn	: IN std_logic := 'X';
        udout7	: IN std_logic := 'X';
        udout6	: IN std_logic := 'X';
        udout5	: IN std_logic := 'X';
        udout4	: IN std_logic := 'X';
        udout3	: IN std_logic := 'X';
        udout2	: IN std_logic := 'X';
        udout1	: IN std_logic := 'X';
        udout0	: IN std_logic := 'X';
        dout7	: OUT std_logic := 'X';
        dout6	: OUT std_logic := 'X';
        dout5	: OUT std_logic := 'X';
        dout4	: OUT std_logic := 'X';
        dout3	: OUT std_logic := 'X';
        dout2	: OUT std_logic := 'X';
        dout1	: OUT std_logic := 'X';
        dout0	: OUT std_logic := 'X';
        ddrvctl	: OUT std_logic := 'X';
        bin	: OUT std_logic := 'X';
        irqn	: OUT std_logic := 'X';
        tan	: OUT std_logic := 'X';
        tants	: OUT std_logic := 'X';
        mpgsr	: OUT std_logic := 'X';
        urdwrn	: OUT std_logic := 'X';
        ustart	: OUT std_logic := 'X';
        ua3	: OUT std_logic := 'X';
        ua2	: OUT std_logic := 'X';
        ua1	: OUT std_logic := 'X';
        ua0	: OUT std_logic := 'X';
        udin7	: OUT std_logic := 'X';
        udin6	: OUT std_logic := 'X';
        udin5	: OUT std_logic := 'X';
        udin4	: OUT std_logic := 'X';
        udin3	: OUT std_logic := 'X';
        udin2	: OUT std_logic := 'X';
        udin1	: OUT std_logic := 'X';
        udin0	: OUT std_logic := 'X'
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
COMPONENT plldfb
GENERIC(
        div0 : in Integer;
        div1 : in Integer;
        div2 : in Integer;
        disabled_gsr  : in std_logic;
        fbdelay   : Time    := 0 ns
  );
PORT(
        clkin : IN std_logic := 'X';
        eclk : OUT std_logic := 'X';
        sclk : OUT std_logic := 'X';
        lock : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT plldft
GENERIC(
        div0 : in Integer;
        div1 : in Integer;
        div2 : in Integer;
        disabled_gsr  : in std_logic;
        fbdelay   : Time    := 0 ns
  );
PORT(
        clkin : IN std_logic := 'X';
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
COMPONENT pcmb
GENERIC(
        pcm       : pcm_mode := PCMBUF;
        duty      : real := 50.0;
        pdelay    : Integer := 1;
        div0      : Integer;
        div1      : Integer;
        div2      : Integer;
        fbdelay   : Time    := 0 ns;
        disabled_done  : std_logic  := '1';
        disabled_gsr   : std_logic  := '0';
        pwron     : std_logic  := '1'
  );
PORT(
        clkin : IN std_logic := 'X';
        fb    : IN std_logic := '0';
        we    : IN std_logic := 'X';
        re    : IN std_logic := 'X';
        a2    : IN std_logic := 'X';
        a1    : IN std_logic := 'X';
        a0    : IN std_logic := 'X';
        di7   : IN std_logic := 'X';
        di6   : IN std_logic := 'X';
        di5   : IN std_logic := 'X';
        di4   : IN std_logic := 'X';
        di3   : IN std_logic := 'X';
        di2   : IN std_logic := 'X';
        di1   : IN std_logic := 'X';
        di0   : IN std_logic := 'X';
        do7   : out std_logic := 'X';
        do6   : out std_logic := 'X';
        do5   : out std_logic := 'X';
        do4   : out std_logic := 'X';
        do3   : out std_logic := 'X';
        do2   : out std_logic := 'X';
        do1   : out std_logic := 'X';
        do0   : out std_logic := 'X';
        eclk  : OUT std_logic := 'X';
        sclk  : OUT std_logic := 'X';
        lock  : OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pcmt
GENERIC(
        pcm       : pcm_mode := PCMBUF;
        duty      : real := 50.0;
        pdelay    : Integer := 1;
        div0      : Integer;
        div1      : Integer;
        div2      : Integer;
        fbdelay   : Time    := 0 ns;
        disabled_done  : std_logic  := '1';
        disabled_gsr   : std_logic  := '0';
        pwron     : std_logic  := '1'
  );
PORT(
        clkin : IN std_logic := 'X';
        fb    : IN std_logic := '0';
        we    : IN std_logic := 'X';
        re    : IN std_logic := 'X';
        a2    : IN std_logic := 'X';
        a1    : IN std_logic := 'X';
        a0    : IN std_logic := 'X';
        di7   : IN std_logic := 'X';
        di6   : IN std_logic := 'X';
        di5   : IN std_logic := 'X';
        di4   : IN std_logic := 'X';
        di3   : IN std_logic := 'X';
        di2   : IN std_logic := 'X';
        di1   : IN std_logic := 'X';
        di0   : IN std_logic := 'X';
        do7   : out std_logic := 'X';
        do6   : out std_logic := 'X';
        do5   : out std_logic := 'X';
        do4   : out std_logic := 'X';
        do3   : out std_logic := 'X';
        do2   : out std_logic := 'X';
        do1   : out std_logic := 'X';
        do0   : out std_logic := 'X';
        eclk  : OUT std_logic := 'X';
        sclk  : OUT std_logic := 'X';
        lock  : OUT std_logic := 'X'
  );
END COMPONENT;
--
END orcacomp;

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
-- $Header: /home/rel01/env5_1a.34/vhdl/pkg/vhdsclibs/data/orca5/src/RCS/ORCACOMP.vhd,v 1.35 2005/05/31 21:32:16 pradeep Exp $ 
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
PACKAGE components IS 
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
COMPONENT jtaga
    GENERIC (JTAG_FLASH_PRGRM : string := "ENABLED");
PORT(
      TCK                : IN    std_logic := 'X';
      TMS                : IN    std_logic := 'X';
      TDI                : IN    std_logic := 'X';
      PSROUT1            : IN    std_logic := 'X';
      PSROUT2            : IN    std_logic := 'X';
      PSROUT3            : IN    std_logic := 'X';
      JTDO1          : IN    std_logic := 'X';
      JTDO2          : IN    std_logic := 'X';
      JTDO3          : IN    std_logic := 'X';
      JTDO4          : IN    std_logic := 'X';
      JTDO5          : IN    std_logic := 'X';
      JTDO6          : IN    std_logic := 'X';
      JTDO7          : IN    std_logic := 'X';
      JTDO8          : IN    std_logic := 'X';
      TDO                :      OUT  std_logic;
      TRESET             :      OUT  std_logic;
      PSRSFTN            :      OUT  std_logic;
      PSRCAP             :      OUT  std_logic;
      PSRENABLE1         :      OUT  std_logic;
      PSRENABLE2         :      OUT  std_logic;
      PSRENABLE3         :      OUT  std_logic;
      SCANENABLE1        :      OUT  std_logic;
      SCANENABLE2        :      OUT  std_logic;
      SCANENABLE3        :      OUT  std_logic;
      SCANENABLE4        :      OUT  std_logic;
      SCANENABLE5        :      OUT  std_logic;
      SCANENABLE6        :      OUT  std_logic;
      SCANENABLE7        :      OUT  std_logic;
      SCANENABLE8        :      OUT  std_logic;
      SCANI              :      OUT  std_logic;
      JTCK               :      OUT  std_logic;
      JTDI               :      OUT  std_logic;
      JSHIFT             :      OUT  std_logic;
      JUPDATE            :      OUT  std_logic;
      JRSTN              :      OUT  std_logic;
      JCE1               :      OUT  std_logic;
      JCE2               :      OUT  std_logic;
      JCE3               :      OUT  std_logic;
      JCE4               :      OUT  std_logic;
      JCE5               :      OUT  std_logic;
      JCE6               :      OUT  std_logic;
      JCE7               :      OUT  std_logic;
      JCE8               :      OUT  std_logic;
      JRTI1              :      OUT  std_logic;
      JRTI2              :      OUT  std_logic;
      JRTI3              :      OUT  std_logic;
      JRTI4              :      OUT  std_logic;
      JRTI5              :      OUT  std_logic;
      JRTI6              :      OUT  std_logic;
      JRTI7              :      OUT  std_logic;
      JRTI8              :      OUT  std_logic);

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
COMPONENT ilf2p3bx
    GENERIC (gsr : String := "ENABLED");
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
    GENERIC (gsr : String := "ENABLED");
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
    GENERIC (gsr : String := "ENABLED");
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
    GENERIC (gsr : String := "ENABLED");
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
    GENERIC (gsr : String := "ENABLED");
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
    GENERIC (gsr : String := "ENABLED");
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
COMPONENT osca
   GENERIC (
      div               : Integer   := 1);
PORT(
	osc: OUT std_logic := 'X');
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
COMPONENT rom32x4
GENERIC(
        gsr : string := "ENABLED";
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
COMPONENT rdbk
    GENERIC (FF_RDCFG : string := "ENABLED";
             FF_RDCFG_CLK : string := "USER";
             RDCFG_DATA_SYNC : string := "RISE");
PORT(
      rdcfgn : IN std_logic := 'X';
      ffrdcfg : IN std_logic := 'X';
      ffrdcfgclk : IN std_logic := 'X';
      rddata : OUT std_logic := 'X'
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
       tsalln: IN std_logic := 'X'
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
COMPONENT pvtioctrl
PORT(
         update: IN std_logic := 'X'
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
   GENERIC(
      buf_delay       : time := 0 ns);
PORT(
        a: IN std_logic := 'X';
        z: OUT std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT dp16ka
GENERIC(
        DATA_WIDTH_A : in Integer := 18;
        DATA_WIDTH_B : in Integer := 18;
        REGMODE_A    : String  := "NOREG";
        REGMODE_B    : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE_A   : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_B   : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE_A  : String  := "NORMAL";
        WRITEMODE_B  : String  := "NORMAL";
        GSR : String  := "DISABLED";
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
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic := 'X';
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic := 'X';
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic := 'X';
        ada9, ada10, ada11, ada12, ada13                                : in std_logic := 'X';
        cea, clka, wea, csa0, csa1, csa2, rsta                         : in std_logic := 'X';
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic := 'X';
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic := 'X';
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic := 'X';
        adb9, adb10, adb11, adb12, adb13                                : in std_logic := 'X';
        ceb, clkb, web, csb0, csb1, csb2, rstb                         : in std_logic := 'X';

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic := 'X';
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic := 'X';
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic := 'X';
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT pdp16ka
GENERIC(
        DATA_WIDTH_W : in Integer := 18;
        DATA_WIDTH_R : in Integer := 18;
        REGMODE      : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE_W   : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_R   : std_logic_vector(2 downto 0)  := "000";
        GSR : String  := "DISABLED";
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
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        di18, di19, di20, di21, di22, di23, di24, di25, di26   : in std_logic := 'X';
        di27, di28, di29, di30, di31, di32, di33, di34, di35   : in std_logic := 'X';
        adw0, adw1, adw2, adw3, adw4, adw5, adw6, adw7, adw8   : in std_logic := 'X';
        adw9, adw10, adw11, adw12, adw13                       : in std_logic := 'X';
        cew, clkw, we, csw0, csw1, csw2                        : in std_logic := 'X';
        adr0, adr1, adr2, adr3, adr4, adr5, adr6, adr7, adr8   : in std_logic := 'X';
        adr9, adr10, adr11, adr12, adr13                       : in std_logic := 'X';
        cer, clkr, csr0, csr1, csr2, rst                       : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X';
        do18, do19, do20, do21, do22, do23, do24, do25, do26   : out std_logic := 'X';
        do27, do28, do29, do30, do31, do32, do33, do34, do35   : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT fifo16ka
GENERIC(
        DATA_WIDTH_W               : Integer  := 18;
        DATA_WIDTH_R               : Integer  := 18;
        REGMODE                    : String  := "NOREG";
        RESETMODE                  : String  := "ASYNC";
        CSDECODE_W                 : std_logic_vector(1 downto 0)  := "00";
        CSDECODE_R                 : std_logic_vector(1 downto 0)  := "00";
        AEPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AEPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER                : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER1               : std_logic_vector(14 downto 0)  := "000000000000000";
        gsr                        : String    := "DISABLED"
  );
PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        di18, di19, di20, di21, di22, di23, di24, di25, di26   : in std_logic := 'X';
        di27, di28, di29, di30, di31, di32, di33, di34, di35   : in std_logic := 'X';
        fulli, csw0, csw1, emptyi, csr0, csr1                     : in std_logic := 'X';
        we, re, clkw, clkr, rst, rprst                       : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X';
        do18, do19, do20, do21, do22, do23, do24, do25, do26   : out std_logic := 'X';
        do27, do28, do29, do30, do31, do32, do33, do34, do35   : out std_logic := 'X';
        ef, aef, aff, ff                                       : out std_logic := 'X'
  );
END COMPONENT;
--
COMPONENT sp16ka
GENERIC(
        DATA_WIDTH   : in Integer := 18;
        REGMODE      : String  := "NOREG";
        RESETMODE    : String  := "SYNC";
        CSDECODE     : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE    : String  := "NORMAL";
        GSR : String  := "DISABLED";
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
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8            : in std_logic := 'X';
        ad9, ad10, ad11, ad12, ad13                            : in std_logic := 'X';
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
COMPONENT clkdiv
   GENERIC (
      gsr : String := "ENABLED";
      div             : Integer := 1);
PORT(
      clki, lsr               :   IN   std_logic;
      clko, elsr           :   OUT  std_logic);
END COMPONENT;
--
COMPONENT clkdet
PORT(
      clk, rst               :   IN   std_logic;
      q                     :   OUT  std_logic);
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
COMPONENT iddra
GENERIC(
        AILRST          : in string := "ENABLED");
PORT(
        d               : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic;
        update              : OUT std_logic;
        lock            : OUT std_logic);
END COMPONENT;
--
COMPONENT iddrxa
GENERIC(
        AILRST          : in string := "ENABLED");
PORT(
        d               : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic;
        update              : OUT std_logic;
        lock            : OUT std_logic);
END COMPONENT;
--
COMPONENT iddrx1a
GENERIC(
        AILRST          : in string := "ENABLED");
PORT(
        d               : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        qa              : OUT std_logic;
        qb              : OUT std_logic;
        update              : OUT std_logic;
        lock            : OUT std_logic);
END COMPONENT;
--
COMPONENT iddrx2a
GENERIC(
        AILRST          : in string := "ENABLED";
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS");
PORT(
        d               : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        qa0             : OUT std_logic;
        qb0             : OUT std_logic;
        qa1             : OUT std_logic;
        qb1             : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);
END COMPONENT;
--
COMPONENT iddrx4a
GENERIC(
        AILRST          : in string := "ENABLED";
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS");
PORT(
        d               : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        qa0             : OUT std_logic;
        qb0             : OUT std_logic;
        qa1             : OUT std_logic;
        qb1             : OUT std_logic;
        qa2             : OUT std_logic;
        qb2             : OUT std_logic;
        qa3             : OUT std_logic;
        qb3             : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);
END COMPONENT;
--
COMPONENT isrx1a
GENERIC(
        AILRST          : in string := "ENABLED");
PORT(
        d               : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);
END COMPONENT;
--
COMPONENT isrx2a
GENERIC(
        AILRST          : in string := "ENABLED";
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS");
PORT(
        d               : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        q0              : OUT std_logic;
        q1              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);
END COMPONENT;
--
COMPONENT isrx4a
GENERIC(
        AILRST          : in string := "ENABLED";
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS");
PORT(
        d               : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        rstail          : IN std_logic;
        runail          : IN std_logic;
        q0              : OUT std_logic;
        q1              : OUT std_logic;
        q2              : OUT std_logic;
        q3              : OUT std_logic;
        update          : OUT std_logic;
        lock            : OUT std_logic);
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
COMPONENT osrx1a
GENERIC(
        REGSET : in String := "RESET");
PORT(
        d              : IN std_logic;
        clk            : IN std_logic;
        rst            : IN std_logic;
        q              : OUT std_logic);
END COMPONENT;
--
COMPONENT osrx2a
GENERIC(
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS";
        REGSET          : in String := "RESET");
PORT(
        d0              : IN std_logic;
        d1              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);
END COMPONENT;
--
COMPONENT osrx4a
GENERIC(
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS";
        REGSET          : in String := "RESET");
PORT(
        d0              : IN std_logic;
        d1              : IN std_logic;
        d2              : IN std_logic;
        d3              : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);
END COMPONENT;
--
COMPONENT oddra
GENERIC(
        REGSET          : in String := "RESET");
PORT(
        da              : IN std_logic;
        db              : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic);
END COMPONENT;
--
COMPONENT oddrxa
GENERIC(
        REGSET          : in String := "RESET");
PORT(
        da              : IN std_logic;
        db              : IN std_logic;
        clk             : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic);
END COMPONENT;
--
COMPONENT oddrx2a
GENERIC(
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS";
        REGSET          : in String := "RESET");
PORT(
        da0             : IN std_logic;
        db0             : IN std_logic;
        da1             : IN std_logic;
        db1             : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);
END COMPONENT;
--
COMPONENT oddrx4a
GENERIC(
        lsrmode         : in string := "LOCAL";
        updt            : in string := "POS";
        REGSET          : in String := "RESET");
PORT(
        da0             : IN std_logic;
        db0             : IN std_logic;
        da1             : IN std_logic;
        db1             : IN std_logic;
        da2             : IN std_logic;
        db2             : IN std_logic;
        da3             : IN std_logic;
        db3             : IN std_logic;
        eclk            : IN std_logic;
        sclk            : IN std_logic;
        rst             : IN std_logic;
        q               : OUT std_logic;
        update          : OUT std_logic);
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
GENERIC(
        DELAYTYPE : in String := "CFGBIT";
        COARSE : in String := "CDEL0";
        FINE : in String := "FDEL0");
PORT(
        a                 : IN std_logic;
        dcntl0            : IN std_logic;
        dcntl1            : IN std_logic;
        dcntl2            : IN std_logic;
        dcntl3            : IN std_logic;
        dcntl4            : IN std_logic;
        dcntl5            : IN std_logic;
        dcntl6            : IN std_logic;
        dcntl7            : IN std_logic;
        dcntl8            : IN std_logic;
        z                 : OUT std_logic);
END COMPONENT;
--
COMPONENT dpr16x2
GENERIC(
        gsr : String := "ENABLED";
        initval : string := "0x0000000000000000"
  );
PORT(
        di0               : IN std_logic;
        di1               : IN std_logic;
        wad0              : IN std_logic;
        wad1              : IN std_logic;
        wad2              : IN std_logic;
        wad3              : IN std_logic;
        wre               : IN std_logic;
        wpe               : IN std_logic;
        wck               : IN std_logic;
        rad0              : IN std_logic;
        rad1              : IN std_logic;
        rad2              : IN std_logic;
        rad3              : IN std_logic;
        wdo0              : OUT std_logic;
        wdo1              : OUT std_logic;
        rdo0              : OUT std_logic;
        rdo1              : OUT std_logic);
END COMPONENT;
--
COMPONENT spr16x2
GENERIC(
        gsr : String := "ENABLED";
        initval : string := "0x0000000000000000"
  );
PORT(
        di0               : IN std_logic;
        di1               : IN std_logic;
        ad0               : IN std_logic;
        ad1               : IN std_logic;
        ad2               : IN std_logic;
        ad3               : IN std_logic;
        wre               : IN std_logic;
        wpe               : IN std_logic;
        ck                : IN std_logic;
        do0               : OUT std_logic;
        do1               : OUT std_logic);
END COMPONENT;
--
COMPONENT trdlla
GENERIC(
      CLKOP_PHASE        : Integer   := 0;
      CLKOS_PHASE        : Integer   := 0;
      CLKOS_FPHASE       : Integer   := 0;
      CLKOS_DIV          : Integer   := 1;
      CLKOP_DUTY50       : String    := "DISABLED";
      CLKOS_DUTY50       : String    := "DISABLED";
      GSR                : String    := "DISABLED";
      CLKOS_FDEL_ADJVAL  : Integer   := 0;
      CLKOS_FPHASE_ADJVAL : Integer   := 0;
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      DCNTL_ADJVAL       : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0)  := "0000000000"
  );
PORT(
        clki               : IN std_logic;
        rstn               : IN std_logic;
        aluhold            : IN std_logic;
        uddcntl            : IN std_logic;
        smiaddr9           : IN std_logic;
        smiaddr8           : IN std_logic;
        smiaddr7           : IN std_logic;
        smiaddr6           : IN std_logic;
        smiaddr5           : IN std_logic;
        smiaddr4           : IN std_logic;
        smiaddr3           : IN std_logic;
        smiaddr2           : IN std_logic;
        smiaddr1           : IN std_logic;
        smiaddr0           : IN std_logic;
        smird              : IN std_logic;
        smiwr              : IN std_logic;
        smiclk             : IN std_logic;
        smiwdata           : IN std_logic;
        smirstn            : IN std_logic;
        clkop              : OUT std_logic;
        clkos              : OUT std_logic;
        lock               : OUT std_logic;
        dcntl8             : OUT std_logic;
        dcntl7             : OUT std_logic;
        dcntl6             : OUT std_logic;
        dcntl5             : OUT std_logic;
        dcntl4             : OUT std_logic;
        dcntl3             : OUT std_logic;
        dcntl2             : OUT std_logic;
        dcntl1             : OUT std_logic;
        dcntl0             : OUT std_logic;
        smirdata           : OUT std_logic);
END COMPONENT;
--
COMPONENT cimdlla
GENERIC(
      CLKOS_FPHASE       : Integer   := 0;
      CLKOS_DIV          : Integer   := 1;
      GSR                : String    := "DISABLED";
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      DCNTL_ADJVAL       : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0)  := "0000000000"
  );
PORT(
        clki               : IN std_logic;
        clkfb              : IN std_logic;
        rstn               : IN std_logic;
        aluhold            : IN std_logic;
        uddcntl            : IN std_logic;
        smiaddr9           : IN std_logic;
        smiaddr8           : IN std_logic;
        smiaddr7           : IN std_logic;
        smiaddr6           : IN std_logic;
        smiaddr5           : IN std_logic;
        smiaddr4           : IN std_logic;
        smiaddr3           : IN std_logic;
        smiaddr2           : IN std_logic;
        smiaddr1           : IN std_logic;
        smiaddr0           : IN std_logic;
        smird              : IN std_logic;
        smiwr              : IN std_logic;
        smiclk             : IN std_logic;
        smiwdata           : IN std_logic;
        smirstn            : IN std_logic;
        clkop              : OUT std_logic;
        clkos              : OUT std_logic;
        lock               : OUT std_logic;
        dcntl8             : OUT std_logic;
        dcntl7             : OUT std_logic;
        dcntl6             : OUT std_logic;
        dcntl5             : OUT std_logic;
        dcntl4             : OUT std_logic;
        dcntl3             : OUT std_logic;
        dcntl2             : OUT std_logic;
        dcntl1             : OUT std_logic;
        dcntl0             : OUT std_logic;
        smirdata           : OUT std_logic);
END COMPONENT;
--
COMPONENT ciddlla
GENERIC(
      CLKOP_PHASE        : Integer   := 0;
      CLKOS_PHASE        : Integer   := 0;
      CLKOS_FPHASE       : Integer   := 0;
      CLKI_DIV           : Integer   := 1;
      CLKOS_DIV          : Integer   := 1;
      CLKOP_DUTY50       : String    := "DISABLED";
      CLKOS_DUTY50       : String    := "DISABLED";
      GSR                : String    := "DISABLED";
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      ALU_INIT_CNTVAL    : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      smi_addr_dis       : std_logic_vector(9 downto 0)  := "0000000000"
  );
PORT(
        clki               : IN std_logic;
        clkfb              : IN std_logic;
        rstn               : IN std_logic;
        aluhold            : IN std_logic;
        smiaddr9           : IN std_logic;
        smiaddr8           : IN std_logic;
        smiaddr7           : IN std_logic;
        smiaddr6           : IN std_logic;
        smiaddr5           : IN std_logic;
        smiaddr4           : IN std_logic;
        smiaddr3           : IN std_logic;
        smiaddr2           : IN std_logic;
        smiaddr1           : IN std_logic;
        smiaddr0           : IN std_logic;
        smird              : IN std_logic;
        smiwr              : IN std_logic;
        smiclk             : IN std_logic;
        smiwdata           : IN std_logic;
        smirstn            : IN std_logic;
        clkop              : OUT std_logic;
        clkos              : OUT std_logic;
        lock               : OUT std_logic;
        smirdata           : OUT std_logic);
END COMPONENT;
--
COMPONENT sdcdlla
GENERIC(
      CLKOS_FPHASE       : Integer   := 0;
      CLKOS_DIV          : Integer   := 1;
      CLKI_DIV           : Integer   := 1;
      GSR                : String    := "DISABLED";
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      DCNTL_ADJVAL       : Integer   := 0;
      ALU_INIT_CNTVAL    : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0)  := "0000000000"
 );
    PORT (
        clki               : IN std_logic;
        clkfb              : IN std_logic;
        rstn               : IN std_logic;
        aluhold            : IN std_logic;
        uddcntl            : IN std_logic;
        smiaddr9           : IN std_logic;
        smiaddr8           : IN std_logic;
        smiaddr7           : IN std_logic;
        smiaddr6           : IN std_logic;
        smiaddr5           : IN std_logic;
        smiaddr4           : IN std_logic;
        smiaddr3           : IN std_logic;
        smiaddr2           : IN std_logic;
        smiaddr1           : IN std_logic;
        smiaddr0           : IN std_logic;
        smird              : IN std_logic;
        smiwr              : IN std_logic;
        smiclk             : IN std_logic;
        smiwdata           : IN std_logic;
        smirstn            : IN std_logic;
        clkop              : OUT std_logic;
        clkos              : OUT std_logic;
        lock               : OUT std_logic;
        dcntl8             : OUT std_logic;
        dcntl7             : OUT std_logic;
        dcntl6             : OUT std_logic;
        dcntl5             : OUT std_logic;
        dcntl4             : OUT std_logic;
        dcntl3             : OUT std_logic;
        dcntl2             : OUT std_logic;
        dcntl1             : OUT std_logic;
        dcntl0             : OUT std_logic;
        smirdata           : OUT std_logic);
END COMPONENT;
--
COMPONENT ehxplla
GENERIC(
      CLKI_DIV           : Integer   := 1;
      CLKFB_DIV          : Integer   := 1;
      CLKOP_DIV          : Integer   := 1;
      CLKOS_DIV          : Integer   := 1;
      CLKOP_MODE         : String    := "BYPASS";
      CLKOS_MODE         : String    := "BYPASS";
      PHASEADJ           : Integer   := 0;
      gsr                : String    := "ENABLED";
      CLKI_FDEL          : Integer   := 0;
      CLKFB_FDEL         : Integer   := 0;
      CLKOS_FDEL         : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      CLKOS_VCODEL       : Integer   := 0;
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0) := "0000000000"
  );
PORT(
      smiaddr9              : in std_logic;
      smiaddr8              : in std_logic;
      smiaddr7              : in std_logic;
      smiaddr6              : in std_logic;
      smiaddr5              : in std_logic;
      smiaddr4              : in std_logic;
      smiaddr3              : in std_logic;
      smiaddr2              : in std_logic;
      smiaddr1              : in std_logic;
      smiaddr0              : in std_logic;
      smird                 : in std_logic;
      smiwr                 : in std_logic;
      smiclk                : in std_logic;
      smiwdata              : in std_logic;
      smirstn               : in std_logic;
      clki                  : in std_logic;
      clkfb                 : in std_logic;
      rstn                  : in std_logic;
      clkos                 : out std_logic;
      clkop                 : out std_logic;
      lock                  : out std_logic;
      clkintfb              : out std_logic;
      smirdata              : out std_logic);
END COMPONENT;
--
COMPONENT clkcntl
   GENERIC (CLKMODE : String := "ECLK");
PORT(
        d               : IN std_logic;
        clk             : IN std_logic;
        ce              : IN std_logic;
        q               : OUT std_logic);
END COMPONENT;

--
COMPONENT SLOGICA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SLOGICA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        M1MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        M0MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        REG1_SD         : string := "VLO";
        REG0_SD         : string := "VLO";
        LUT1_INITVAL    : bit_vector := X"0000";
        LUT0_INITVAL    : bit_vector := X"0000";
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_FXA        : boolean := FALSE;
        check_FXB        : boolean := FALSE;
        check_A1        : boolean := FALSE;
        check_B1        : boolean := FALSE;
        check_C1        : boolean := FALSE;
        check_D1        : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_A0        : boolean := FALSE;
        check_B0        : boolean := FALSE;
        check_C0        : boolean := FALSE;
        check_D0        : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE);

   PORT(
        M1, FXA, FXB, A1, B1, C1, D1, DI1, DI0            : in std_ulogic := '0';
        A0, B0, C0, D0, M0, CE, CLK, LSR                  : in std_ulogic := '0';
        OFX1, F1, Q1, OFX0, F0, Q0                        : out std_ulogic := '0'
        );

END COMPONENT ;
----
COMPONENT SRIPPLEA IS
   GENERIC (
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SRIPPLEA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        M1MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        M0MUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        REG1_SD         : string := "VLO";
        REG0_SD         : string := "VLO";
        ALU2_MODE       : string := "ADD";  -- "ADD", "SUB", "CNTUP", "CNTDN", "A_GE_B", "A_NE_B"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        LSRONMUX        : string := "LSRMUX";  -- "LSRMUX", "OFF"
        FCIMUX          : string := "M0MUX";  -- "M0MUX", "FCI"
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_FCI        : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE);

   PORT(
        M1, A1, B1, DI1, DI0                           : in std_ulogic := '0';
        A0, B0, FCI, M0, CE, CLK, LSR                  : in std_ulogic := '0';
        FCO, OFX1, F1, Q1, OFX0, F0, Q0                : out std_ulogic := '0'
        );

END COMPONENT ;
----
COMPONENT SSPRAMA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SSPRAMA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        INITVAL         : string := "0x0000000000000000";
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        -- timing check enable for each port
        check_M1        : boolean := FALSE;
        check_M0        : boolean := FALSE;
        check_AD0       : boolean := FALSE;
        check_AD1       : boolean := FALSE;
        check_AD2       : boolean := FALSE;
        check_AD3       : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE);

   PORT(
        M0, M1, AD0, AD1, AD2, AD3, DI0, DI1, CE, CLK, LSR         : in std_ulogic := '0';
        F1, Q1, F0, Q0                                             : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SDPRAMA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SDPRAMA";

        GSR             : string := "ENABLED";
        SRMODE          : string := "ASYNC";      -- "LSR_OVER_CE", "ASYNC"
        REGMODE         : string := "FF";      -- "FF", "LATCH"
        LSRMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CEMUX           : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLKMUX          : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        CLK2MUX         : string := "VLO";      -- "VLO", "SIG", "INV", "VHI"
        WCLKMUX         : string := "CLKMUX";      -- "CLKMUX", "CLK2MUX"
        RCLKMUX         : string := "CLK2MUX";      -- "CLKMUX", "CLK2MUX"
        REG1_REGSET     : string := "RESET";  -- "RESET", "SET"
        REG0_REGSET     : string := "RESET";  -- "RESET", "SET"
        INITVAL         : string := "0x0000000000000000";
        CLK_BOOST0      : time   := 0 ns;
        CLK_BOOST1      : time   := 0 ns;

        check_M0        : boolean := FALSE;
        check_DPI       : boolean := FALSE;
        check_A0        : boolean := FALSE;
        check_B0        : boolean := FALSE;
        check_C0        : boolean := FALSE;
        check_D0        : boolean := FALSE;
        check_A1        : boolean := FALSE;
        check_B1        : boolean := FALSE;
        check_C1        : boolean := FALSE;
        check_D1        : boolean := FALSE;
        check_DI1        : boolean := FALSE;
        check_DI0        : boolean := FALSE;
        check_CE        : boolean := FALSE;
        check_LSR        : boolean := FALSE);

   PORT(
        M0, DPI, A0, B0, C0, D0, A1, B1, C1, D1, DI0, DI1, CE, CLK, CLK2, LSR         : in std_ulogic := '0';
        F1, Q1, F0, Q0, DPO                                             : out std_ulogic := '0'
        );

END COMPONENT ;
--
COMPONENT SBRAMA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SBRAMA";

        DATA_WIDTH_A               : Integer  := 18;
        DATA_WIDTH_B               : Integer  := 18;
        REGMODE_A                  : String  := "NOREG";
        REGMODE_B                  : String  := "NOREG";
        RESETMODE                  : String  := "SYNC";
        CSDECODE_A                 : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_B                 : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE_A                : String  := "NORMAL";
        WRITEMODE_B                : String  := "NORMAL";
        GSR                        : String  := "DISABLED";

        initval_00 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_01 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_02 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_03 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_04 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_05 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_06 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_07 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_08 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_09 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_0f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_10 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_11 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_12 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_13 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_14 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_15 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_16 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_17 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_18 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_19 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_1f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_20 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_21 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_22 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_23 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_24 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_25 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_26 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_27 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_28 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_29 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_2f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_30 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_31 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_32 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_33 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_34 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_35 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_36 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_37 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_38 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_39 : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3a : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3b : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3c : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3d : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3e : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        initval_3f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

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
        check_DIA10      : boolean := FALSE;
        check_DIA11      : boolean := FALSE;
        check_DIA12      : boolean := FALSE;
        check_DIA13      : boolean := FALSE;
        check_DIA14      : boolean := FALSE;
        check_DIA15      : boolean := FALSE;
        check_DIA16      : boolean := FALSE;
        check_DIA17      : boolean := FALSE;
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
        check_ADA10      : boolean := FALSE;
        check_ADA11      : boolean := FALSE;
        check_ADA12      : boolean := FALSE;
        check_ADA13      : boolean := FALSE;
        check_CEA        : boolean := FALSE;
        check_WEA        : boolean := FALSE;
        check_CSA0       : boolean := FALSE;
        check_CSA1       : boolean := FALSE;
        check_CSA2       : boolean := FALSE;
        check_RSTA       : boolean := FALSE;

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
        check_DIB10      : boolean := FALSE;
        check_DIB11      : boolean := FALSE;
        check_DIB12      : boolean := FALSE;
        check_DIB13      : boolean := FALSE;
        check_DIB14      : boolean := FALSE;
        check_DIB15      : boolean := FALSE;
        check_DIB16      : boolean := FALSE;
        check_DIB17      : boolean := FALSE;
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
        check_ADB10      : boolean := FALSE;
        check_ADB11      : boolean := FALSE;
        check_ADB12      : boolean := FALSE;
        check_ADB13      : boolean := FALSE;
        check_CEB        : boolean := FALSE;
        check_WEB        : boolean := FALSE;
        check_CSB0       : boolean := FALSE;
        check_CSB1       : boolean := FALSE;
        check_CSB2       : boolean := FALSE;
        check_RSTB       : boolean := FALSE);

   PORT(
        DIA0, DIA1, DIA2, DIA3, DIA4, DIA5, DIA6, DIA7, DIA8            : in std_logic := 'X';
        DIA9, DIA10, DIA11, DIA12, DIA13, DIA14, DIA15, DIA16, DIA17    : in std_logic := 'X';
        ADA0, ADA1, ADA2, ADA3, ADA4, ADA5, ADA6, ADA7, ADA8            : in std_logic := 'X';
        ADA9, ADA10, ADA11, ADA12, ADA13                                : in std_logic := 'X';
        CEA, CLKA, WEA, CSA0, CSA1, CSA2, RSTA                         : in std_logic := 'X';
        DIB0, DIB1, DIB2, DIB3, DIB4, DIB5, DIB6, DIB7, DIB8            : in std_logic := 'X';
        DIB9, DIB10, DIB11, DIB12, DIB13, DIB14, DIB15, DIB16, DIB17    : in std_logic := 'X';
        ADB0, ADB1, ADB2, ADB3, ADB4, ADB5, ADB6, ADB7, ADB8            : in std_logic := 'X';
        ADB9, ADB10, ADB11, ADB12, ADB13                                : in std_logic := 'X';
        CEB, CLKB, WEB, CSB0, CSB1, CSB2, RSTB                         : in std_logic := 'X';

        DOA0, DOA1, DOA2, DOA3, DOA4, DOA5, DOA6, DOA7, DOA8            : out std_logic := 'X';
        DOA9, DOA10, DOA11, DOA12, DOA13, DOA14, DOA15, DOA16, DOA17    : out std_logic := 'X';
        DOB0, DOB1, DOB2, DOB3, DOB4, DOB5, DOB6, DOB7, DOB8            : out std_logic := 'X';
        DOB9, DOB10, DOB11, DOB12, DOB13, DOB14, DOB15, DOB16, DOB17    : out std_logic := 'X'
        );

END COMPONENT ;
--
COMPONENT SFIFOA IS
   GENERIC (
        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "SFIFOA";

        DATA_WIDTH_W               : Integer  := 18;
        DATA_WIDTH_R               : Integer  := 18;
        REGMODE                    : String  := "NOREG";
        RESETMODE                  : String  := "ASYNC";
        CSDECODE_W                 : std_logic_vector(1 downto 0)  := "00";
        CSDECODE_R                 : std_logic_vector(1 downto 0)  := "00";
        AEPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AEPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER                  : std_logic_vector(14 downto 0)  := "000000000000000";
        AFPOINTER1                 : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER                : std_logic_vector(14 downto 0)  := "000000000000000";
        FULLPOINTER1               : std_logic_vector(14 downto 0)  := "000000000000000";
        GSR                        : String  := "DISABLED";

        CLKW_NEGEDGE    : boolean := FALSE;
        CLKR_NEGEDGE    : boolean := FALSE;

        check_DI0      : boolean := FALSE;
        check_DI1      : boolean := FALSE;
        check_DI2      : boolean := FALSE;
        check_DI3      : boolean := FALSE;
        check_DI4      : boolean := FALSE;
        check_DI5      : boolean := FALSE;
        check_DI6      : boolean := FALSE;
        check_DI7      : boolean := FALSE;
        check_DI8      : boolean := FALSE;
        check_DI9      : boolean := FALSE;
        check_DI10      : boolean := FALSE;
        check_DI11      : boolean := FALSE;
        check_DI12      : boolean := FALSE;
        check_DI13      : boolean := FALSE;
        check_DI14      : boolean := FALSE;
        check_DI15      : boolean := FALSE;
        check_DI16      : boolean := FALSE;
        check_DI17      : boolean := FALSE;
        check_DI18      : boolean := FALSE;
        check_DI19      : boolean := FALSE;
        check_DI20      : boolean := FALSE;
        check_DI21      : boolean := FALSE;
        check_DI22      : boolean := FALSE;
        check_DI23      : boolean := FALSE;
        check_DI24      : boolean := FALSE;
        check_DI25      : boolean := FALSE;
        check_DI26      : boolean := FALSE;
        check_DI27      : boolean := FALSE;
        check_DI28      : boolean := FALSE;
        check_DI29      : boolean := FALSE;
        check_DI30      : boolean := FALSE;
        check_DI31      : boolean := FALSE;
        check_DI32      : boolean := FALSE;
        check_DI33      : boolean := FALSE;
        check_DI34      : boolean := FALSE;
        check_DI35      : boolean := FALSE;
        check_FULLI        : boolean := FALSE;
        check_CSW0        : boolean := FALSE;
        check_CSW1       : boolean := FALSE;
        check_EMPTYI       : boolean := FALSE;
        check_CSR0       : boolean := FALSE;
        check_CSR1       : boolean := FALSE;
        check_WE       : boolean := FALSE;
        check_RE       : boolean := FALSE;
        check_RST       : boolean := FALSE;
        check_RPRST       : boolean := FALSE);

   PORT(
        DI0, DI1, DI2, DI3, DI4, DI5, DI6, DI7, DI8            : in std_logic := 'X';
        DI9, DI10, DI11, DI12, DI13, DI14, DI15, DI16, DI17    : in std_logic := 'X';
        DI18, DI19, DI20, DI21, DI22, DI23, DI24, DI25, DI26   : in std_logic := 'X';
        DI27, DI28, DI29, DI30, DI31, DI32, DI33, DI34, DI35   : in std_logic := 'X';
        FULLI, CSW0, CSW1, EMPTYI, CSR0, CSR1                     : in std_logic := 'X';
        WE, RE, CLKW, CLKR, RST, RPRST                       : in std_logic := 'X';

        DO0, DO1, DO2, DO3, DO4, DO5, DO6, DO7, DO8            : out std_logic := 'X';
        DO9, DO10, DO11, DO12, DO13, DO14, DO15, DO16, DO17    : out std_logic := 'X';
        DO18, DO19, DO20, DO21, DO22, DO23, DO24, DO25, DO26   : out std_logic := 'X';
        DO27, DO28, DO29, DO30, DO31, DO32, DO33, DO34, DO35   : out std_logic := 'X';
        EF, AEF, AFF, FF                                       : out std_logic := 'X'
  );

END COMPONENT;

END components;

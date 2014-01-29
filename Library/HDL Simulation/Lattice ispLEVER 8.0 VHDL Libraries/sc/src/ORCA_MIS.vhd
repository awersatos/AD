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
-- $Header: /home/rlp/Orfdry/env_rcs/vhdl/pkg/vhdsclibs/data/orca5/src/RCS/ORCA_MIS.vhd,v 1.49 2005/10/07 18:20:32 pradeep Exp $ 
--

--
----- package mem3 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

PACKAGE mem3 IS
   TYPE mem_type_5 IS array (Integer range <>) OF std_logic_vector(17 downto 0);
   TYPE mem_type_6 IS array (Integer range <>) OF std_logic_vector(15 downto 0);
   FUNCTION hex2bin (hex: character) RETURN std_logic_vector;
   FUNCTION str3_slv12 (hex: string) RETURN std_logic_vector;
   FUNCTION data2data (data_w: integer) RETURN integer;
   FUNCTION data2addr_w (data_w: integer) RETURN integer;
   FUNCTION data2data_w (data_w: integer) RETURN integer;
   FUNCTION init_ram (hex: string) RETURN std_logic_vector;
   FUNCTION init_ram1 (hex: string) RETURN mem_type_6;
   FUNCTION Valid_Address (IN_ADDR : in std_logic_vector) return boolean;
--   FUNCTION init_ram2 (hex: string) RETURN std_logic_vector;
   FUNCTION str2slv (str: in string) RETURN std_logic_vector;
   PROCEDURE mem_initialize (div0 : in Integer; div1 : in Integer; 
   div2 : in Integer; div3 : in Integer; p0_delay : in Integer;
   p1_delay : in Integer; p2_delay : in Integer; vcotap : in Integer;
   gsr : in string; mclkmode : in string; nclkmode : in string;
   signal MEM : out std_logic_vector(127 downto 0));
END mem3;

PACKAGE BODY mem3 IS

   FUNCTION hex2bin (hex: character) RETURN std_logic_vector IS
        VARIABLE result : std_logic_vector (3 downto 0);
   BEGIN
        CASE hex IS
          WHEN '0' =>
             result := "0000";
          WHEN '1' =>
             result := "0001";
          WHEN '2' =>
             result := "0010";
          WHEN '3' =>
             result := "0011";
          WHEN '4' =>
             result := "0100";
          WHEN '5' =>
             result := "0101";
          WHEN '6' =>
             result := "0110";
          WHEN '7' =>
             result := "0111";
          WHEN '8' =>
             result := "1000";
          WHEN '9' =>
             result := "1001";
          WHEN 'A'|'a' =>
             result := "1010";
          WHEN 'B'|'b' =>
             result := "1011";
          WHEN 'C'|'c' =>
             result := "1100";
          WHEN 'D'|'d' =>
             result := "1101";
          WHEN 'E'|'e' =>
             result := "1110";
          WHEN 'F'|'f' =>
             result := "1111";
          WHEN 'X'|'x' =>
             result := "XXXX";
          WHEN others =>
             NULL;
        END CASE;
        RETURN result;
   END;

   FUNCTION str5_slv18 (s : string(5 downto 1)) return std_logic_vector is
        VARIABLE result : std_logic_vector(17 downto 0);
   BEGIN
       FOR i in 0 to 3 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(s(i+1));
       END LOOP;
          result(17 downto 16) := hex2bin(s(5))(1 downto 0);
       RETURN result;
   END;

   FUNCTION str4_slv16 (s : string(4 downto 1)) return std_logic_vector is
        VARIABLE result : std_logic_vector(15 downto 0);
   BEGIN
       FOR i in 0 to 3 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(s(i+1));
       END LOOP;
       RETURN result;
   END;

   FUNCTION str3_slv12 (hex: string) return std_logic_vector is
        VARIABLE result : std_logic_vector(11 downto 0);
   BEGIN
       FOR i in 0 to 2 LOOP
          result(((i+1)*4)-1 downto (i*4)) := hex2bin(hex(i+1));
       END LOOP;
       RETURN result;
   END;

   FUNCTION data2addr_w (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 14;
          WHEN 2 =>
             result := 13;
          WHEN 4 =>
             result := 12;
          WHEN 9 =>
             result := 11;
          WHEN 18 =>
             result := 10;
          WHEN 36 =>
             result := 9;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION data2data_w (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 1;
          WHEN 2 =>
             result := 2;
          WHEN 4 =>
             result := 4;
          WHEN 9 =>
             result := 9;
          WHEN 18 =>
             result := 18;
          WHEN 36 =>
             result := 18;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION data2data (data_w : integer) return integer is
        VARIABLE result : integer;
   BEGIN
        CASE data_w IS
          WHEN 1 =>
             result := 8;
          WHEN 2 =>
             result := 4;
          WHEN 4 =>
             result := 2;
          WHEN 9 =>
             result := 36864;
          WHEN 18 =>
             result := 36864;
          WHEN 36 =>
             result := 36864;
          WHEN others =>
             NULL;
        END CASE;
       RETURN result;
   END;

   FUNCTION init_ram (hex: string) RETURN std_logic_vector IS
        CONSTANT length : integer := hex'length;
        VARIABLE result1 : mem_type_5 (0 to ((length/5)-1));
        VARIABLE result : std_logic_vector(((length*18)/5)-1 downto 0);
   BEGIN
       FOR i in 0 to ((length/5)-1) LOOP
         result1(i) := str5_slv18(hex((i+1)*5 downto (i*5)+1));
       END LOOP;
       FOR j in 0 to 1023 LOOP
         result(((j*18) + 17) downto (j*18)) := result1(j)(17 downto 0);
       END LOOP;
       RETURN result;
   END;

   FUNCTION init_ram1 (hex: string) RETURN mem_type_6 IS
        CONSTANT length : integer := hex'length;
        VARIABLE result : mem_type_6 (0 to ((length/4)-1));
   BEGIN
       FOR i in 0 to ((length/4)-1) LOOP
         result(i) := str4_slv16(hex((i+1)*4 downto (i*4)+1));
       END LOOP;
       RETURN result;
   END;

--   FUNCTION init_ram2 (hex: string) RETURN std_logic_vector IS
--        CONSTANT length : integer := hex'length;
--        VARIABLE result : std_logic_vector (((length * 4) - 1) downto 0);
--   BEGIN
--       FOR i in 0 to (length-1) LOOP
--         result(i) := str3_slv12(hex((i+1)*4 downto (i*4)+1));
--       END LOOP;
--       RETURN result;
--   END;

-- String to std_logic_vector

  FUNCTION str2slv (
      str : in string
  ) return std_logic_vector is

  variable j : integer := str'length;
  variable slv : std_logic_vector (str'length downto 1);

  begin
      for i in str'low to str'high loop
          case str(i) is
              when '0' => slv(j) := '0';
              when '1' => slv(j) := '1';
              when 'X' => slv(j) := 'X';
              when 'U' => slv(j) := 'U';
              when others => slv(j) := 'X';
          end case;
          j := j - 1;
      end loop;
      return slv;
  end str2slv;

   PROCEDURE mem_initialize (div0 : in Integer; div1 : in Integer; 
   div2 : in Integer; div3 : in Integer; p0_delay : in Integer;
   p1_delay : in Integer; p2_delay : in Integer; vcotap : in Integer;
   gsr : in string; mclkmode : in string; nclkmode : in string;
   signal MEM : out std_logic_vector(127 downto 0)) IS

   BEGIN
         MEM(7 downto 2) <= conv_std_logic_vector((div0 - 1), 6);
         MEM(15 downto 10) <= conv_std_logic_vector((div1 - 1), 6);
         MEM(23 downto 18) <= conv_std_logic_vector((div2 - 1), 6);
         MEM(31 downto 26) <= conv_std_logic_vector((div3 - 1), 6);
         MEM(34 downto 32) <= conv_std_logic_vector(p0_delay, 3);
         MEM(37 downto 35) <= conv_std_logic_vector(p1_delay, 3);
         MEM(42 downto 40) <= conv_std_logic_vector(p2_delay, 3);
         MEM(45 downto 43) <= conv_std_logic_vector(vcotap, 3);
         IF (gsr = "DISABLED") THEN
            MEM(94) <= '1';
         ELSIF (gsr = "ENABLED") THEN
            MEM(94) <= '0';
         END IF;

         IF (mclkmode = "DIV") THEN
            MEM(17 downto 16) <= "11";
         ELSIF (mclkmode = "VCO") THEN
            MEM(17 downto 16) <= "10";
         ELSIF (mclkmode = "FDEL") THEN
            MEM(17 downto 16) <= "01";
         ELSIF (mclkmode = "BYPASS") THEN
            MEM(17 downto 16) <= "00";
         END IF;

         IF (nclkmode = "DIV") THEN
            MEM(25 downto 24) <= "11";
         ELSIF (nclkmode = "VCO") THEN
            MEM(25 downto 24) <= "10";
         ELSIF (nclkmode = "FDEL") THEN
            MEM(25 downto 24) <= "01";
         ELSIF (nclkmode = "BYPASS") THEN
            MEM(25 downto 24) <= "00";
         END IF;

   END mem_initialize;

function Valid_Address (
    IN_ADDR : in std_logic_vector
 ) return boolean is

    variable v_Valid_Flag : boolean := TRUE;

begin

    for i in IN_ADDR'high downto IN_ADDR'low loop
        if (IN_ADDR(i) /= '0' and IN_ADDR(i) /= '1') then
            v_Valid_Flag := FALSE;
        end if;
    end loop;

    return v_Valid_Flag;
end Valid_Address;


END mem3 ;



--
----- cell ehxplla -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY ehxplla IS
   GENERIC (
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
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0) := "0000000000";
      CLKOS_VCODEL       : Integer   := 0;
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "ehxplla";
      tipd_clki             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr9         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr8         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr7         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr6         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr5         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr4         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr3         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr2         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr1         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiaddr0         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smird            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiwr            : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiclk           : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smiwdata         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_smirstn          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstn             : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb            : VitalDelayType01 := (0 ns, 0 ns));

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

    ATTRIBUTE Vital_Level0 OF ehxplla : ENTITY IS TRUE;

END ehxplla ;

-- ARCHITECTURE body --
ARCHITECTURE V OF ehxplla IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;
    SIGNAL smiaddr9_ipd          : std_logic := '0';
    SIGNAL smiaddr8_ipd          : std_logic := '0';
    SIGNAL smiaddr7_ipd          : std_logic := '0';
    SIGNAL smiaddr6_ipd          : std_logic := '0';
    SIGNAL smiaddr5_ipd          : std_logic := '0';
    SIGNAL smiaddr4_ipd          : std_logic := '0';
    SIGNAL smiaddr3_ipd          : std_logic := '0';
    SIGNAL smiaddr2_ipd          : std_logic := '0';
    SIGNAL smiaddr1_ipd          : std_logic := '0';
    SIGNAL smiaddr0_ipd          : std_logic := '0';
    SIGNAL smird_ipd             : std_logic := '0';
    SIGNAL smiwr_ipd             : std_logic := '0';
    SIGNAL smiclk_ipd            : std_logic := '0';
    SIGNAL smiwdata_ipd          : std_logic := '0';
    SIGNAL smirstn_ipd           : std_logic := '0';
    SIGNAL clki_ipd          : std_logic := '0';
    SIGNAL clkfb_ipd             : std_logic := '0';
    SIGNAL rstn_ipd          : std_logic := '0';
    SIGNAL set_resetn          : std_logic := '0';
    SIGNAL g_reset            : std_logic := '0';
    SIGNAL false_int          : std_logic := '0';
    SIGNAL false_mck          : std_logic := '0';
    SIGNAL false_nck          : std_logic := '0';
    SIGNAL false_t_int        : time := 0 ns;
    SIGNAL set_reset_time     : time := 0 ns;
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_vco              : time := 0 ns;
    SIGNAL ha_vco             : time := 0 ns;
    SIGNAL ha_vco_r           : real := 0.0;
    SIGNAL round_err          : real := 0.0;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL clock_invalid      : std_logic := '0';
    SIGNAL t_fb_clk           : time := 0 ns;
    SIGNAL t_intfb_clock      : time := 0 ns;
    SIGNAL ha_intfb_clk       : time := 0 ns;
    SIGNAL clkfb_per_valid    : std_logic := '0';
    SIGNAL ext_divider        : Real := 1.0 ;
    SIGNAL net_divide         : Real := 1.0 ;
    SIGNAL lockout           : std_logic := '0';
    SIGNAL lock_all           : std_logic := '0';
    SIGNAL lock_all1           : std_logic := '0';
    SIGNAL lock_all2           : std_logic := '0';
    SIGNAL vir_sclk           : std_logic := '0';
    SIGNAL vir_pclk           : std_logic := '0';
    SIGNAL vir_lock           : std_logic := '0';
    SIGNAL vir_intfb          : std_logic := '0';
    SIGNAL intfb_out          : std_logic := '0';
    SIGNAL final_sclk         : std_logic := '0';
    SIGNAL final_pclk         : std_logic := '0';
    SIGNAL div0_reg1          : Integer   := 0;
    SIGNAL div0_reg           : Integer   := 0;
    SIGNAL div1_reg1          : Integer   := 0;
    SIGNAL div1_reg           : Integer   := 0;
    SIGNAL div2_reg1          : Integer   := 0;
    SIGNAL div2_reg           : Integer   := 0;
    SIGNAL div3_reg1          : Integer   := 0;
    SIGNAL div3_reg           : Integer   := 0;
    SIGNAL vcotap_reg         : Integer   := 0;
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL real_delay2        : time := 0 ps;
    SIGNAL real_delay         : time := 0 ps;
    SIGNAL total_fb_delay     : time := 0 ps;
    SIGNAL lock_delay_reg     : time := 1 ns;
    SIGNAL intfb_du_out       : std_logic := '0';
    SIGNAL final_intfb        : std_logic := '0';
    SIGNAL final_lock         : std_logic := '0';

    SIGNAL MEM                : std_logic_vector(127 downto 0) := "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    SIGNAL smi_id_reg         : std_logic_vector(5 downto 0) := "000000";
    SIGNAL addr_dis_reg       : std_logic_vector(9 downto 0) := "0000000000";
    SIGNAL p0_delay_reg       : Integer   := 0;
    SIGNAL p1_delay_reg       : Integer   := 0;
    SIGNAL p2_delay_reg       : Integer   := 0;
    SIGNAL disabled_gsr_reg   : Integer   := 1;
    SIGNAL pll_addr           : std_logic_vector(9 downto 0) := "0000000000";
    SIGNAL ipll_addr          : std_logic_vector(9 downto 0) := "0000000000";
    SIGNAL valid_pll          : std_logic := '0';
    SIGNAL STATE              : std_logic_vector(1 downto 0) := "00";
    SIGNAL COUNT              : std_logic_vector(2 downto 0) := "000";
    SIGNAL mem_addr           : std_logic_vector(3 downto 0) := "0000";
    SIGNAL rdwr               : std_logic_vector(2 downto 0) := "000";
    SIGNAL BYTE_SEL           : std_logic_vector(3 downto 0) := "0000";
    SIGNAL D                  : std_logic_vector(7 downto 0) := "00000000";
    SIGNAL WEN                : std_logic := '0';
    SIGNAL rdata_sig          : std_logic := '0';
    SIGNAL clkin_dly          : std_logic := '0';
    SIGNAL fb_dly             : std_logic := '0';
    SIGNAL false_clk          : std_logic := '0';
    SIGNAL false_clkos        : std_logic := '0';
    SIGNAL out_clk_valid      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL first_time7        : std_logic := '1';
    SIGNAL false_clkos_int    : std_logic := '0';
    SIGNAL false_clkop        : std_logic := '0';
    SIGNAL false_t1_int       : time := 5 ns;
    SIGNAL lock_count         : Integer := 0;
    SIGNAL fb_count           : Integer := 0;
    CONSTANT smi_id_int1      : string(3 downto 1) := SMI_OFFSET(3 to 5);
    CONSTANT smi_id_int2      : std_logic_vector(11 downto 0) := str3_slv12 (smi_id_int1);
    SIGNAL smi_id_int3        : integer := (((conv_integer(smi_id_int2)) - 1024) / 16);
BEGIN

   ---------------------
   --  INPUT PATH DELAYs
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(smiaddr9_ipd, smiaddr9, tipd_smiaddr9);
   VitalWireDelay(smiaddr8_ipd, smiaddr8, tipd_smiaddr8);
   VitalWireDelay(smiaddr7_ipd, smiaddr7, tipd_smiaddr7);
   VitalWireDelay(smiaddr6_ipd, smiaddr6, tipd_smiaddr6);
   VitalWireDelay(smiaddr5_ipd, smiaddr5, tipd_smiaddr5);
   VitalWireDelay(smiaddr4_ipd, smiaddr4, tipd_smiaddr4);
   VitalWireDelay(smiaddr3_ipd, smiaddr3, tipd_smiaddr3);
   VitalWireDelay(smiaddr2_ipd, smiaddr2, tipd_smiaddr2);
   VitalWireDelay(smiaddr1_ipd, smiaddr1, tipd_smiaddr1);
   VitalWireDelay(smiaddr0_ipd, smiaddr0, tipd_smiaddr0);
   VitalWireDelay(smird_ipd, smird, tipd_smird);
   VitalWireDelay(smiwr_ipd, smiwr, tipd_smiwr);
   VitalWireDelay(smiclk_ipd, smiclk, tipd_smiclk);
   VitalWireDelay(smiwdata_ipd, smiwdata, tipd_smiwdata);
   VitalWireDelay(smirstn_ipd, smirstn, tipd_smirstn);
   VitalWireDelay(rstn_ipd, rstn, tipd_rstn);
   VitalWireDelay(clki_ipd, clki, tipd_clki);
   VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
   END BLOCK;

   --------------------
   --  BEHAVIOR SECTION
   --------------------
   div0_reg1 <= CLKI_DIV;
   smi_id_reg <= conv_std_logic_vector(smi_id_int3, 6);
   addr_dis_reg <= SMI_ADDR_DIS;

   S1 : PROCESS (div0_reg1, WEN, STATE, BYTE_SEL)
   BEGIN
      IF (NOW = 0 ns) THEN
         mem_initialize (div0 => CLKI_DIV, div1 => CLKFB_DIV, div2 => CLKOS_DIV, 
                         div3 => CLKOP_DIV,
                         p0_delay => (CLKI_FDEL / 100), p1_delay => (CLKFB_FDEL / 100), 
                         p2_delay => (CLKOS_FDEL / 100),
                         gsr => gsr, mclkmode => CLKOS_MODE,
                         nclkmode => CLKOP_MODE, vcotap => (PHASEADJ / 45), MEM => MEM);
      ELSE
       IF ((STATE = "11") and (WEN = '0')) THEN
          case BYTE_SEL is
               when "0000" => MEM(7 downto 0) <= D;
               when "0001" => MEM(15 downto 8) <= D;
               when "0010" => MEM(23 downto 16) <= D;
               when "0011" => MEM(31 downto 24) <= D;
               when "0100" => MEM(39 downto 32) <= D;
               when "0101" => MEM(47 downto 40) <= D;
               when "0110" => MEM(55 downto 48) <= D;
               when "0111" => MEM(63 downto 56) <= D;
               when "1000" => MEM(71 downto 64) <= D;
               when "1001" => MEM(79 downto 72) <= D;
               when "1010" => MEM(87 downto 80) <= D;
               when "1011" => MEM(95 downto 88) <= D;
               when "1100" => MEM(103 downto 96) <= D;
               when "1101" => MEM(111 downto 104) <= D;
               when "1110" => MEM(119 downto 112) <= D;
               when "1111" => MEM(127 downto 120) <= D;
               when others => ASSERT false
                              REPORT "Access to unsupported register!"
                              SEVERITY WARNING;
          end case;
       END IF;
      END IF;
   END PROCESS;

   S2 : PROCESS (MEM)
   BEGIN
      div0_reg <= conv_integer(MEM(7 downto 2)) + 1;
      div1_reg <= conv_integer(MEM(15 downto 10)) + 1;
      div2_reg <= conv_integer(MEM(23 downto 18)) + 1;
      div3_reg <= conv_integer(MEM(31 downto 26)) + 1;
      p0_delay_reg <= conv_integer(MEM(34 downto 32));
      p1_delay_reg <= conv_integer(MEM(37 downto 35));
      p2_delay_reg <= conv_integer(MEM(42 downto 40));
      vcotap_reg <= conv_integer(MEM(45 downto 43));
      IF (MEM(94) = '1') THEN
         disabled_gsr_reg <= 1;
      ELSIF (MEM(94) = '0') THEN
         disabled_gsr_reg <= 0;
      END IF;
   END PROCESS;

   pll_addr <= (smiaddr9_ipd, smiaddr8_ipd, smiaddr7_ipd, smiaddr6_ipd, smiaddr5_ipd, 
                smiaddr4_ipd, smiaddr3_ipd, smiaddr2_ipd, smiaddr1_ipd, smiaddr0_ipd);
   ipll_addr <= pll_addr and (not addr_dis_reg);

   S3 : PROCESS (ipll_addr)
   BEGIN
      IF (ipll_addr(9 downto 4) = smi_id_reg) THEN
         valid_pll <= '1';
      ELSE 
         valid_pll <= '0';
      END IF;
    END PROCESS;

   rdwr <= (smiwr_ipd, smird_ipd, valid_pll);

   S4 : PROCESS (smiclk_ipd, smirstn_ipd, smird_ipd, smiwr_ipd)
   VARIABLE rd_or_wr : std_logic;
   BEGIN
      IF (smirstn_ipd = '0') THEN
         STATE <= "00";
         COUNT <= "000";
      ELSIF (smiclk_ipd'event and smiclk_ipd = '1') THEN
         case STATE is
            when "01" => if (COUNT = "111") then
                            STATE <= "00";         -- read 
                         end if;
            when "10" => if (COUNT = "111") then  
                            STATE <= "11";         -- write
                         end if;
            when others => 
                         case rdwr is
                           when "011" => STATE <= "01"; -- read begin
                           when "101" => STATE <= "10"; -- write begin
                           when others => STATE <= "00";
                         end case;
         end case;

         rd_or_wr := smird_ipd xor smiwr_ipd;

         IF ((STATE = "01" or STATE = "10") or ((valid_pll = '1') and rd_or_wr = '1')) THEN
            COUNT <= COUNT + '1';
         ELSE
            COUNT <= "000";
         END IF;
      END IF;
    END PROCESS;

   mem_addr <= ipll_addr(3 downto 0);

   S5 : PROCESS (smiclk_ipd)
   BEGIN
      IF (smiclk_ipd'event and smiclk_ipd = '1') THEN
         IF ((STATE = "00" or STATE = "11") and (smird_ipd = '1') and (valid_pll = '1')) THEN
            case mem_addr is
                 when "0000" => D <= MEM(7 downto 0);
                 when "0001" => D <= MEM(15 downto 8);
                 when "0010" => D <= MEM(23 downto 16);
                 when "0011" => D <= MEM(31 downto 24);
                 when "0100" => D <= MEM(39 downto 32);
                 when "0101" => D <= MEM(47 downto 40);
                 when "0110" => D <= MEM(55 downto 48);
                 when "0111" => D <= MEM(63 downto 56);
                 when "1000" => D <= MEM(71 downto 64);
                 when "1001" => D <= MEM(79 downto 72);
                 when "1010" => D <= MEM(87 downto 80);
                 when "1011" => D <= MEM(95 downto 88);
                 when "1100" => D <= MEM(103 downto 96);
                 when "1101" => D <= MEM(111 downto 104);
                 when "1110" => D <= MEM(119 downto 112);
                 when "1111" => D <= MEM(127 downto 120);
                 when others => ASSERT false
                                REPORT "Access to unsupported register!"
                                SEVERITY WARNING;
            end case;
         ELSE
            D(7) <= smiwdata_ipd;  -- right shifting
            D(6 downto 0) <= D(7 downto 1);  -- right shifting
         END IF;

         IF ((STATE = "00" or STATE = "11") and (smiwr_ipd = '1') and (valid_pll = '1')) THEN
            BYTE_SEL <= mem_addr;
         END IF;
      END IF;
    END PROCESS;

    smirdata <= D(0) after 0.01 ns;

    S6 : PROCESS (smiclk_ipd, smirstn_ipd)
    BEGIN
       IF (smirstn_ipd = '0') THEN
          WEN <= '0';
       ELSIF (smiclk_ipd'event and smiclk_ipd = '1') THEN
          WEN <= (STATE(0) and STATE(1));
       END IF;
    END PROCESS;


   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (disabled_gsr_reg =  1) THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   set_resetn <= g_reset and rstn_ipd;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
---------------------------------------------------------------------
-- Measure input clock and feedback delay
---------------------------------------------------------------------
   CLKOS_DELAY : PROCESS (false_clk)
   BEGIN
      IF ((p2_delay_reg * 0.1 ns) > 0 ps) THEN
         false_clkos_int <= transport false_clk after (p2_delay_reg * 0.1 ns);
      ELSE
         false_clkos_int <= false_clk;
      END IF;
   END PROCESS;

-- Generate false clkos and false clkop

   FALSE_CLKOS_GEN : PROCESS (false_clkos_int)
   VARIABLE index_clkos : Integer := 0;
   VARIABLE first_time2 : boolean := true;
   BEGIN
      IF (false_clkos_int'event) THEN
         IF (first_time2) THEN
            IF (false_clkos_int = '1') THEN
               false_clkos <= '1';
               first_time2 := false;
               index_clkos := 0;
            END IF;
         ELSE
            index_clkos := index_clkos + 1;
            IF (index_clkos = div2_reg) THEN
               false_clkos <= NOT false_clkos;
               index_clkos := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   FALSE_CLKOP_GEN : PROCESS (false_clk)
   VARIABLE index_clkop : Integer := 0;
   VARIABLE first_time2 : boolean := true;
   BEGIN
      IF (false_clk'event) THEN
         IF (first_time2) THEN
            IF (false_clk = '1') THEN
               false_clkop <= '1';
               first_time2 := false;
               index_clkop := 0;
            END IF;
         ELSE
            index_clkop := index_clkop + 1;
            IF (index_clkop = div3_reg) THEN
               false_clkop <= NOT false_clkop;
               index_clkop := 0;
            END IF;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------

   CLKIN_DELAY : PROCESS (clki_ipd)
   BEGIN
      IF ((p0_delay_reg * 0.1 ns) > 0 ps) THEN
         clkin_dly <= transport clki_ipd after (p0_delay_reg * 0.1 ns);
      ELSE
         clkin_dly <= clki_ipd;
      END IF;
   END PROCESS;


   CLKIN_PERIOD : PROCESS (clkin_dly)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clkin_dly'event and clkin_dly = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
--             IF (((t_in_clk - t_in_clk3) < 0.0001 ns) and ((t_in_clk - t_in_clk3) > -0.0001 ns)) THEN
             IF ((t_in_clk = t_in_clk1) and (t_in_clk = t_in_clk2) and (t_in_clk = t_in_clk3)) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;
           IF (t_in_clk > 0 ps) THEN
--             IF (((t_in_clk - t_in_clk1) < 0.0001 ns) and ((t_in_clk - t_in_clk1) > -0.0001 ns)) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_invalid <= '0';
             ELSE
                  clock_invalid <= '1';
             END IF;
           END IF;
      END IF;
   END PROCESS;

------------------------------------------------
-- measure the feedback delay value
------------------------------------------------
   FBP_DELAY : PROCESS (clkfb_ipd)
   BEGIN
      IF ((p1_delay_reg * 0.1 ns) > 0 ps) THEN
         fb_dly <= transport clkfb_ipd after (p1_delay_reg * 0.1 ns);
      ELSE
         fb_dly <= clkfb_ipd;
      END IF;
   END PROCESS;

   P100 : PROCESS (fb_dly)
   BEGIN
      IF (fb_dly'event and fb_dly = '1') THEN
         fb_count <= fb_count + 1;
         IF (fb_count = 3) THEN
            clkop_first_time <= '0';
         END IF;
      END IF;
   END PROCESS;
 
   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, fb_dly)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (fb_dly'event and fb_dly'last_value = '0' and fb_dly = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   FB_PERIOD : PROCESS (fb_dly)
   VARIABLE last_clock_edge : time := 0 ps;
   VARIABLE next_clock_edge : time := 0 ps;
   VARIABLE first_time      : Boolean := true;
   BEGIN
      IF (fb_dly'event and fb_dly = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
             IF (first_time) THEN
                t_fb_clk <= next_clock_edge - last_clock_edge;
                first_time := false;
             END IF;
           END IF;
      END IF;
   END PROCESS;

   false_t_int <= 2 * false_t1_int;

   INT_FB : PROCESS (t_fb_clk)
   BEGIN
      IF (t_fb_clk > 0 ps) THEN
         ext_divider <= (real(time'pos(t_fb_clk)) / real(time'pos(false_t_int)) );
      END IF;
   END PROCESS;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1, clkin_dly)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      END IF;
   END PROCESS;

   net_divide <= (real(div1_reg) * ext_divider);

   P6 : PROCESS (t_in_clk, div0_reg, net_divide)
   BEGIN
      IF (net_divide > 0.0) THEN
         t_vco <= ((t_in_clk * div0_reg) / net_divide);  -- vco oscillating cycle
         ha_vco_r <= ((real(time'pos(t_in_clk)) * real(div0_reg)) / net_divide) / 2.0;
      END IF;
   END PROCESS;

   ha_vco <= (t_vco / 2.0);  -- vco oscillating half-cycle

   P106 : PROCESS (ha_vco)
   BEGIN
      IF (ha_vco > 0 ps) THEN
         round_err <= (real(time'pos(t_in_clk)) - ((real(time'pos(ha_vco)) * 2.0 * net_divide) / real(div0_reg))) / 2.0;
      END IF;
   END PROCESS;

   P7 : PROCESS (clkin_dly, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         out_clk_valid <= '0';
      ELSIF (clkin_dly'event and clkin_dly = '1') THEN
         IF (fb_count >= 3) THEN
            out_clk_valid <= clock_valid;
         END IF;
      END IF;
   END PROCESS;

   P50 : PROCESS (clkin_dly)
   BEGIN
      IF (t_in_clk > 0 ps) THEN
         lockout <= transport clkin_dly after (8 * t_in_clk);
      END IF;
   END PROCESS;

   P51 : PROCESS (lockout)
   BEGIN
      IF (lockout'event and lockout = '1') THEN
         IF (clkin_dly = '0') THEN
            lock_count <= lock_count + 1;
         ELSE
            lock_count <= 0;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate all CLOCKs in DELAY MODE
-------------------------------------------------------
   P8 : PROCESS (out_clk_valid, intfb_out)
      VARIABLE index : real := 0.0;
   BEGIN
      IF (out_clk_valid  = '0') THEN
         intfb_out <= '0';
         first_time7 <= '1';
         index := 0.0;
      ELSE
         IF (first_time7 = '1') THEN
            intfb_out <= '1';
            first_time7 <= '0';
            index := 0.0;
         ELSE
            index := index + 1.0;
            IF (index = net_divide) THEN
--               intfb_out <= not intfb_out after time'val(integer(ha_vco_r + round_err));
               intfb_out <= not intfb_out after (ha_vco + time'val(integer(round_err)));
               index := 0.0;
            ELSE
               intfb_out <= not intfb_out after ha_vco;
            END IF;
         END IF;
      END IF;
   END PROCESS;

   real_delay2 <= ((t_vco * vcotap_reg) / 8);

   real_delay <= (real_delay1 + real_delay2);

   vir_intfb <= transport intfb_out after real_delay1;

   P108 : PROCESS (intfb_out)
   BEGIN
      IF (out_clk_valid  = '0') THEN
         vir_lock <= '0';
      ELSE
         vir_lock <= '1';
      END IF;
   END PROCESS;
 
   P9 : PROCESS (vir_intfb, set_resetn)
   VARIABLE index1 : Integer := 0;
   VARIABLE index2 : Integer := 0;
   VARIABLE first_time : boolean := true;
   BEGIN
      IF (set_resetn = '0') THEN
         vir_sclk <= '0';
         vir_pclk <= '0';
         first_time := true;
      ELSE
         IF (vir_intfb'event) THEN
            IF (first_time) THEN
               IF (vir_intfb = '1') THEN
                  vir_sclk <= '1';
                  vir_pclk <= '1';
                  IF (out_clk_valid = '0') THEN
                     first_time := true;
                  ELSE
                     first_time := false;
                  END IF;
                  index1 := 0;
                  index2 := 0;
               END IF;
            ELSE
               index1 := index1 + 1;
               index2 := index2 + 1;
               IF (index1 = div2_reg) THEN
                  vir_sclk <= NOT vir_sclk;
                  index1 := 0;
               END IF;
               IF (index2 = div3_reg) THEN
                  vir_pclk <= NOT vir_pclk;
                  index2 := 0;
               END IF;
            END IF;
         END IF;
      END IF;
   END PROCESS;

-------------------------------------------------------
-- Generate LOCK signal
-------------------------------------------------------
   LOCK_IT : PROCESS (set_resetn, vir_lock, out_clk_valid, clock_invalid, lock_count)
   BEGIN
      IF ((set_resetn = '0') or (clock_invalid = '1') or (lock_count = 8)) THEN
         lock_all1 <= '0';
      ELSE
         lock_all1 <= vir_lock;
      END IF;
   END PROCESS;

   P53 : PROCESS (lock_all1)
   BEGIN
      IF (lock_all1 = '0') THEN
         lock_all2 <= '0';
      ELSE
         lock_all2 <= transport lock_all1 after (LOCK_DELAY * lock_delay_reg);
      END IF;
   END PROCESS;

   lock_all <= lock_all2;
-------------------------------------------------------
-- Select clocks with appropriate modes
-------------------------------------------------------
   P101 : PROCESS (clki_ipd, set_resetn, vir_pclk, vir_intfb, lock_all)
   BEGIN
      IF (CLKOP_MODE = "BYPASS") THEN
         final_pclk <= clki_ipd;
         IF (clki_ipd'event AND clki_ipd = '1') THEN
            final_lock <= '1';
         END IF;
      ELSIF (set_resetn = '0') THEN
         final_pclk <= '0';
         final_intfb <= '0';
         final_lock <= '0';
      ELSIF (CLKOP_MODE = "FDEL0") THEN 
         final_pclk <= vir_intfb;
         final_intfb <= vir_intfb;
         final_lock <= lock_all;
      ELSIF (CLKOP_MODE = "VCO") THEN
         final_pclk <= vir_intfb; 
         final_intfb <= vir_intfb;
         final_lock <= lock_all;
      ELSIF (CLKOP_MODE = "DIV") THEN
         final_pclk <= vir_pclk; 
         final_intfb <= vir_intfb;
         final_lock <= lock_all;
      END IF;
   END PROCESS;
 
   P102 : PROCESS (clki_ipd, set_resetn, vir_sclk, vir_intfb)
   BEGIN
      IF (CLKOS_MODE = "BYPASS") THEN
         final_sclk <= clki_ipd;
      ELSIF (set_resetn = '0') THEN
         final_sclk <= '0';
      ELSIF (CLKOS_MODE = "FDEL") THEN
         final_sclk <= transport vir_intfb after (real_delay2 + (p2_delay_reg * 0.1 ns));
      ELSIF (CLKOS_MODE = "VCO") THEN
         final_sclk <= transport vir_intfb after real_delay2;
      ELSIF (CLKOS_MODE = "DIV") THEN
         final_sclk <= transport vir_sclk after ((CLKOS_VCODEL * t_vco) + real_delay2 + (p2_delay_reg * 0.1 ns));
      END IF;
   END PROCESS;

   S11 : PROCESS (out_clk_valid, final_sclk, set_resetn, false_clk, false_clkos)
   BEGIN
      IF (clkop_first_time = '1') THEN
         IF ((CLKOS_MODE = "DIV") or (CLKOS_MODE = "FDEL")) THEN
            clkos <= false_clkos;
         ELSE
            clkos <= false_clk;
         END IF;
      ELSIF (set_resetn = '0') THEN
         clkos <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkos <= final_sclk;
      END IF;
   END PROCESS;

   S12 : PROCESS (out_clk_valid, false_clkop, final_pclk, set_resetn, false_clk, final_lock, final_intfb)
   BEGIN
      IF (clkop_first_time = '1') THEN
         clkop <= false_clkop;
         clkintfb <= false_clk;
         lock <= '0';
      ELSIF (set_resetn = '0') THEN
         clkop <= '0';
         clkintfb <= '0';
         lock <= '0';
      ELSIF (out_clk_valid = '1') THEN
         clkop <= final_pclk;
         clkintfb <= final_intfb;
         lock <= final_lock;
      END IF;
   END PROCESS;

END V;



--
----- cell mux81 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux81 IS

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux81 : ENTITY IS TRUE;

END mux81;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux81 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, d2, d3, d4, d5, d6, d7, sd1, sd2, sd3)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d7, d6, d5, d4, d3, d2, d1, d0),
                  dselect => (sd3, sd2, sd1));

   END PROCESS;

END v;

--
----- cell mux161 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux161 IS

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      d8              : IN    std_logic;
      d9              : IN    std_logic;
      d10             : IN    std_logic;
      d11             : IN    std_logic;
      d12             : IN    std_logic;
      d13             : IN    std_logic;
      d14             : IN    std_logic;
      d15             : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      sd4             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux161 : ENTITY IS TRUE;

END mux161;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux161 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, sd1, sd2, sd3, sd4)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1, d0),
                  dselect => (sd4, sd3, sd2, sd1));

   END PROCESS;

END v;


--
----- cell mux321 -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY mux321 IS

   PORT(
      d0              : IN    std_logic;
      d1              : IN    std_logic;
      d2              : IN    std_logic;
      d3              : IN    std_logic;
      d4              : IN    std_logic;
      d5              : IN    std_logic;
      d6              : IN    std_logic;
      d7              : IN    std_logic;
      d8              : IN    std_logic;
      d9              : IN    std_logic;
      d10             : IN    std_logic;
      d11             : IN    std_logic;
      d12             : IN    std_logic;
      d13             : IN    std_logic;
      d14             : IN    std_logic;
      d15             : IN    std_logic;
      d16             : IN    std_logic;
      d17             : IN    std_logic;
      d18             : IN    std_logic;
      d19             : IN    std_logic;
      d20             : IN    std_logic;
      d21             : IN    std_logic;
      d22             : IN    std_logic;
      d23             : IN    std_logic;
      d24             : IN    std_logic;
      d25             : IN    std_logic;
      d26             : IN    std_logic;
      d27             : IN    std_logic;
      d28             : IN    std_logic;
      d29             : IN    std_logic;
      d30             : IN    std_logic;
      d31             : IN    std_logic;
      sd1             : IN    std_logic;
      sd2             : IN    std_logic;
      sd3             : IN    std_logic;
      sd4             : IN    std_logic;
      sd5             : IN    std_logic;
      z               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF mux321 : ENTITY IS TRUE;

END mux321;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF mux321 IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31, sd1, sd2, sd3, sd4, sd5)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= vitalmux
                 (data => (d31, d30, d29, d28, d27, d26, d25, d24, d23, d22, d21, d20, d19, d18, d17, d16, d15, d14, d13, d12, d11, d10, d9, d8, d7, d6, d5, d4, d3, d2, d1, d0),
                  dselect => (sd5, sd4, sd3, sd2, sd1));

   END PROCESS;

END v;




--
----- cell ilvds -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY ilvds IS

   PORT(
      a               : IN std_logic;
      an              : IN std_logic;
      z               : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF ilvds : ENTITY IS TRUE;

END ilvds;

-- architecture body --
ARCHITECTURE v OF ilvds IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= VitalBUF(a);

   END PROCESS;

END v;


--
----- cell olvds -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;
USE ieee.vital_primitives.all;

-- entity declaration --
ENTITY olvds IS

   PORT(
      a               : IN std_logic;
      z               : OUT std_logic;
      zn              : OUT std_logic);

    ATTRIBUTE Vital_Level0 OF olvds : ENTITY IS TRUE;

END olvds;

-- architecture body --
ARCHITECTURE v OF olvds IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

BEGIN

   --------------------
   --  behavior section
   --------------------
   VitalBehavior : PROCESS (a)

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
      z <= VitalBUF(a);
      zn <= VitalINV(a);

   END PROCESS;

END v;



--
-----cell dp16ka----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY dp16ka IS
   GENERIC (
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

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "dp16ka";

        -- input SIGNAL delays
        tipd_ada13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada9 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada8 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada7 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada6 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada5 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ada0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia17 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia16 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia15 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia14 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dia0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clka  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_cea  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_wea : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csa2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rsta : VitalDelayType01 := (0.0 ns, 0.0 ns);

        tipd_adb13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb9 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb8 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb7 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb6 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb5 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb4 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb3 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_adb0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib17 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib16 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib15 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib14 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_dib0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clkb  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_ceb  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_web : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csb2 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rstb : VitalDelayType01 := (0.0 ns, 0.0 ns)
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

      ATTRIBUTE Vital_Level0 OF dp16ka : ENTITY IS TRUE;

END dp16ka ;

-- ARCHITECTURE body --
ARCHITECTURE V OF dp16ka IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

--SIGNAL DECLARATIONS----

    SIGNAL ada_ipd   : std_logic_vector(13 downto 0) := (others => '0');
    SIGNAL dia_ipd   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL clka_ipd  : std_logic := '0';
    SIGNAL cea_ipd   : std_logic := '0';
    SIGNAL wrea_ipd  : std_logic := '0';
    SIGNAL csa_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rsta_ipd  : std_logic := '0';
    SIGNAL adb_ipd   : std_logic_vector(13 downto 0) := "XXXXXXXXXXXXXX";
    SIGNAL dib_ipd   : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
    SIGNAL clkb_ipd  : std_logic := '0';
    SIGNAL ceb_ipd   : std_logic := '0';
    SIGNAL wreb_ipd  : std_logic := '0';
    SIGNAL csb_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rstb_ipd  : std_logic := '0';
    SIGNAL csa_en    : std_logic := '0';
    SIGNAL csb_en    : std_logic := '0';
    SIGNAL g_reset   : std_logic := '0';
    CONSTANT ADDR_WIDTH_A : integer := data2addr_w(DATA_WIDTH_A); 
    CONSTANT ADDR_WIDTH_B : integer := data2addr_w(DATA_WIDTH_B); 
    CONSTANT new_data_width_a : integer := data2data_w(DATA_WIDTH_A); 
    CONSTANT new_data_width_b : integer := data2data_w(DATA_WIDTH_B); 
    CONSTANT div_a    : integer := data2data(DATA_WIDTH_A); 
    CONSTANT div_b    : integer := data2data(DATA_WIDTH_B); 
    SIGNAL dia_node   : std_logic_vector((new_data_width_a - 1) downto 0) := (others => '0');
    SIGNAL dib_node   : std_logic_vector((new_data_width_b - 1) downto 0) := (others => '0');
    SIGNAL ada_node   : std_logic_vector((ADDR_WIDTH_A - 1) downto 0);
    SIGNAL adb_node   : std_logic_vector((ADDR_WIDTH_B - 1) downto 0);
    SIGNAL diab_node  : std_logic_vector(35 downto 0) := (others => '0');
    SIGNAL rsta_int   : std_logic := '0';
    SIGNAL rstb_int   : std_logic := '0';
    SIGNAL rsta_reg   : std_logic := '0';
    SIGNAL rstb_reg   : std_logic := '0';
    SIGNAL reseta     : std_logic := '0';
    SIGNAL resetb     : std_logic := '0';
    SIGNAL dia_reg    : std_logic_vector((new_data_width_a - 1) downto 0) := (others => '0');
    SIGNAL dib_reg    : std_logic_vector((new_data_width_b - 1) downto 0) := (others => '0');
    SIGNAL ada_reg    : std_logic_vector((ADDR_WIDTH_A - 1) downto 0);
    SIGNAL adb_reg    : std_logic_vector((ADDR_WIDTH_B - 1) downto 0);
    SIGNAL diab_reg   : std_logic_vector(35 downto 0) := (others => '0');
    SIGNAL bwa0_reg   : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL bwa1_reg   : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL bwb_reg    : std_logic_vector(1 downto 0) := (others => '0');
    SIGNAL wrena_reg  : std_logic := '0';
    SIGNAL clka_valid : std_logic := '0';
    SIGNAL clkb_valid : std_logic := '0';
    SIGNAL clka_valid1 : std_logic := '0';
    SIGNAL clkb_valid1 : std_logic := '0';
    SIGNAL last_clka_valid1 : std_logic := '0';
    SIGNAL last_clkb_valid1 : std_logic := '0';
    SIGNAL wrenb_reg  : std_logic := '0';
    SIGNAL rena_reg   : std_logic := '0';
    SIGNAL renb_reg   : std_logic := '0';
    SIGNAL rsta_sig   : std_logic := '0';
    SIGNAL rstb_sig   : std_logic := '0';
    SIGNAL doa_node   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_tr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_wt   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_node_rbr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_tr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_wt   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_node_rbr   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_reg    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_reg    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doab_reg   : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL doa_int    : std_logic_vector(17 downto 0) := (others => '0');
    SIGNAL dob_int    : std_logic_vector(17 downto 0) := (others => '0');

	 --write & read/write collision flags
	 signal wr_a_wr_b_coll : std_logic := '0';
	 signal wr_a_rd_b_coll : std_logic := '0';
	 signal rd_a_wr_b_coll : std_logic := '0';
	 --lower & upper collision addresses
    signal dn_coll_addr, up_coll_addr : integer;

    CONSTANT initval   : string(5120 downto 1) := (
      initval_3f(3 to 82)&initval_3e(3 to 82)&initval_3d(3 to 82)&initval_3c(3 to 82)&
      initval_3b(3 to 82)&initval_3a(3 to 82)&initval_39(3 to 82)&initval_38(3 to 82)&
      initval_37(3 to 82)&initval_36(3 to 82)&initval_35(3 to 82)&initval_34(3 to 82)&
      initval_33(3 to 82)&initval_32(3 to 82)&initval_31(3 to 82)&initval_30(3 to 82)&
      initval_2f(3 to 82)&initval_2e(3 to 82)&initval_2d(3 to 82)&initval_2c(3 to 82)&
      initval_2b(3 to 82)&initval_2a(3 to 82)&initval_29(3 to 82)&initval_28(3 to 82)&
      initval_27(3 to 82)&initval_26(3 to 82)&initval_25(3 to 82)&initval_24(3 to 82)&
      initval_23(3 to 82)&initval_22(3 to 82)&initval_21(3 to 82)&initval_20(3 to 82)&
      initval_1f(3 to 82)&initval_1e(3 to 82)&initval_1d(3 to 82)&initval_1c(3 to 82)&
      initval_1b(3 to 82)&initval_1a(3 to 82)&initval_19(3 to 82)&initval_18(3 to 82)&
      initval_17(3 to 82)&initval_16(3 to 82)&initval_15(3 to 82)&initval_14(3 to 82)&
      initval_13(3 to 82)&initval_12(3 to 82)&initval_11(3 to 82)&initval_10(3 to 82)&
      initval_0f(3 to 82)&initval_0e(3 to 82)&initval_0d(3 to 82)&initval_0c(3 to 82)&
      initval_0b(3 to 82)&initval_0a(3 to 82)&initval_09(3 to 82)&initval_08(3 to 82)&
      initval_07(3 to 82)&initval_06(3 to 82)&initval_05(3 to 82)&initval_04(3 to 82)&
      initval_03(3 to 82)&initval_02(3 to 82)&initval_01(3 to 82)&initval_00(3 to 82));
    SIGNAL MEM       : std_logic_vector(18431 downto 0) := init_ram (initval);
    SIGNAL j         : integer := 0;
BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(ada_ipd(0), ada0, tipd_ada0);
   VitalWireDelay(ada_ipd(1), ada1, tipd_ada1);
   VitalWireDelay(ada_ipd(2), ada2, tipd_ada2);
   VitalWireDelay(ada_ipd(3), ada3, tipd_ada3);
   VitalWireDelay(ada_ipd(4), ada4, tipd_ada4);
   VitalWireDelay(ada_ipd(5), ada5, tipd_ada5);
   VitalWireDelay(ada_ipd(6), ada6, tipd_ada6);
   VitalWireDelay(ada_ipd(7), ada7, tipd_ada7);
   VitalWireDelay(ada_ipd(8), ada8, tipd_ada8);
   VitalWireDelay(ada_ipd(9), ada9, tipd_ada9);
   VitalWireDelay(ada_ipd(10), ada10, tipd_ada10);
   VitalWireDelay(ada_ipd(11), ada11, tipd_ada11);
   VitalWireDelay(ada_ipd(12), ada12, tipd_ada12);
   VitalWireDelay(ada_ipd(13), ada13, tipd_ada13);
   VitalWireDelay(dia_ipd(0), dia0, tipd_dia0);
   VitalWireDelay(dia_ipd(1), dia1, tipd_dia1);
   VitalWireDelay(dia_ipd(2), dia2, tipd_dia2);
   VitalWireDelay(dia_ipd(3), dia3, tipd_dia3);
   VitalWireDelay(dia_ipd(4), dia4, tipd_dia4);
   VitalWireDelay(dia_ipd(5), dia5, tipd_dia5);
   VitalWireDelay(dia_ipd(6), dia6, tipd_dia6);
   VitalWireDelay(dia_ipd(7), dia7, tipd_dia7);
   VitalWireDelay(dia_ipd(8), dia8, tipd_dia8);
   VitalWireDelay(dia_ipd(9), dia9, tipd_dia9);
   VitalWireDelay(dia_ipd(10), dia10, tipd_dia10);
   VitalWireDelay(dia_ipd(11), dia11, tipd_dia11);
   VitalWireDelay(dia_ipd(12), dia12, tipd_dia12);
   VitalWireDelay(dia_ipd(13), dia13, tipd_dia13);
   VitalWireDelay(dia_ipd(14), dia14, tipd_dia14);
   VitalWireDelay(dia_ipd(15), dia15, tipd_dia15);
   VitalWireDelay(dia_ipd(16), dia16, tipd_dia16);
   VitalWireDelay(dia_ipd(17), dia17, tipd_dia17);
   VitalWireDelay(clka_ipd, clka, tipd_clka);
   VitalWireDelay(wrea_ipd, wea, tipd_wea);
   VitalWireDelay(cea_ipd, cea, tipd_cea);
   VitalWireDelay(csa_ipd(0), csa0, tipd_csa0);
   VitalWireDelay(csa_ipd(1), csa1, tipd_csa1);
   VitalWireDelay(csa_ipd(2), csa2, tipd_csa2);
   VitalWireDelay(rsta_ipd, rsta, tipd_rsta);
   VitalWireDelay(adb_ipd(0), adb0, tipd_adb0);
   VitalWireDelay(adb_ipd(1), adb1, tipd_adb1);
   VitalWireDelay(adb_ipd(2), adb2, tipd_adb2);
   VitalWireDelay(adb_ipd(3), adb3, tipd_adb3);
   VitalWireDelay(adb_ipd(4), adb4, tipd_adb4);
   VitalWireDelay(adb_ipd(5), adb5, tipd_adb5);
   VitalWireDelay(adb_ipd(6), adb6, tipd_adb6);
   VitalWireDelay(adb_ipd(7), adb7, tipd_adb7);
   VitalWireDelay(adb_ipd(8), adb8, tipd_adb8);
   VitalWireDelay(adb_ipd(9), adb9, tipd_adb9);
   VitalWireDelay(adb_ipd(10), adb10, tipd_adb10);
   VitalWireDelay(adb_ipd(11), adb11, tipd_adb11);
   VitalWireDelay(adb_ipd(12), adb12, tipd_adb12);
   VitalWireDelay(adb_ipd(13), adb13, tipd_adb13);
   VitalWireDelay(dib_ipd(0), dib0, tipd_dib0);
   VitalWireDelay(dib_ipd(1), dib1, tipd_dib1);
   VitalWireDelay(dib_ipd(2), dib2, tipd_dib2);
   VitalWireDelay(dib_ipd(3), dib3, tipd_dib3);
   VitalWireDelay(dib_ipd(4), dib4, tipd_dib4);
   VitalWireDelay(dib_ipd(5), dib5, tipd_dib5);
   VitalWireDelay(dib_ipd(6), dib6, tipd_dib6);
   VitalWireDelay(dib_ipd(7), dib7, tipd_dib7);
   VitalWireDelay(dib_ipd(8), dib8, tipd_dib8);
   VitalWireDelay(dib_ipd(9), dib9, tipd_dib9);
   VitalWireDelay(dib_ipd(10), dib10, tipd_dib10);
   VitalWireDelay(dib_ipd(11), dib11, tipd_dib11);
   VitalWireDelay(dib_ipd(12), dib12, tipd_dib12);
   VitalWireDelay(dib_ipd(13), dib13, tipd_dib13);
   VitalWireDelay(dib_ipd(14), dib14, tipd_dib14);
   VitalWireDelay(dib_ipd(15), dib15, tipd_dib15);
   VitalWireDelay(dib_ipd(16), dib16, tipd_dib16);
   VitalWireDelay(dib_ipd(17), dib17, tipd_dib17);
   VitalWireDelay(clkb_ipd, clkb, tipd_clkb);
   VitalWireDelay(wreb_ipd, web, tipd_web);
   VitalWireDelay(ceb_ipd, ceb, tipd_ceb);
   VitalWireDelay(csb_ipd(0), csb0, tipd_csb0);
   VitalWireDelay(csb_ipd(1), csb1, tipd_csb1);
   VitalWireDelay(csb_ipd(2), csb2, tipd_csb2);
   VitalWireDelay(rstb_ipd, rstb, tipd_rstb);
   END BLOCK;

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (GSR =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

  rsta_sig <= rsta_ipd or (not g_reset);
  rstb_sig <= rstb_ipd or (not g_reset);

--   set_reset <= g_reset and (not reset_ipd);
  ada_node <= ada_ipd(13 downto (14 - ADDR_WIDTH_A));
  adb_node <= adb_ipd(13 downto (14 - ADDR_WIDTH_B));

-- chip select A decode
  P1 : PROCESS(csa_ipd)
  BEGIN
     IF (csa_ipd = "000" and CSDECODE_A = "000") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "001" and CSDECODE_A = "001") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "010" and CSDECODE_A = "010") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "011" and CSDECODE_A = "011") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "100" and CSDECODE_A = "100") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "101" and CSDECODE_A = "101") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "110" and CSDECODE_A = "110") THEN
        csa_en <= '1';
     ELSIF (csa_ipd = "111" and CSDECODE_A = "111") THEN
        csa_en <= '1';
     ELSE
        csa_en <= '0';
     END IF;
  END PROCESS;

  P2 : PROCESS(csb_ipd)
  BEGIN
     IF (csb_ipd = "000" and CSDECODE_B = "000") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "001" and CSDECODE_B = "001") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "010" and CSDECODE_B = "010") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "011" and CSDECODE_B = "011") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "100" and CSDECODE_B = "100") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "101" and CSDECODE_B = "101") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "110" and CSDECODE_B = "110") THEN
        csb_en <= '1';
     ELSIF (csb_ipd = "111" and CSDECODE_B = "111") THEN
        csb_en <= '1';
     ELSE
        csb_en <= '0';
     END IF;
  END PROCESS;

  P3 : PROCESS(dia_ipd)
  BEGIN
     CASE DATA_WIDTH_A IS
       WHEN 1 =>
        dia_node <= dia_ipd(11 downto 11);
       WHEN 2 =>
        dia_node <= (dia_ipd(1), dia_ipd(11));
       WHEN 4 =>
        dia_node <= dia_ipd(3 downto 0); 
       WHEN 9 =>
        dia_node <= dia_ipd(8 downto 0);
       WHEN 18 =>
        dia_node <= dia_ipd;
       WHEN 36 =>
        dia_node <= dia_ipd;
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;

  P4 : PROCESS(dib_ipd)
  BEGIN
     CASE DATA_WIDTH_B IS
       WHEN 1 =>
        dib_node <= dib_ipd(11 downto 11);
       WHEN 2 =>
        dib_node <= (dib_ipd(1), dib_ipd(11));
       WHEN 4 =>
        dib_node <= dib_ipd(3 downto 0); 
       WHEN 9 =>
        dib_node <= dib_ipd(8 downto 0);
       WHEN 18 =>
        dib_node <= dib_ipd;
       WHEN 36 =>
        dib_node <= dib_ipd;
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;

  diab_node <= (dib_ipd & dia_ipd);

  P107 : PROCESS(clka_ipd)
  BEGIN
     IF (clka_ipd'event and clka_ipd = '1') THEN
        IF ((g_reset = '0') or (rsta_ipd = '1')) THEN
           clka_valid <= '0';
        ELSE
           IF (cea_ipd = '1') THEN
              IF (csa_en = '1') THEN
                 clka_valid <= '1', '0' after 0.2 ns;
              ELSE
                 clka_valid <= '0';
              END IF;
           ELSE
              clka_valid <= '0';
           END IF;
        END IF;
     END IF;
  END PROCESS;
 
  P108 : PROCESS(clkb_ipd)
  BEGIN
     IF (clkb_ipd'event and clkb_ipd = '1') THEN
        IF ((g_reset = '0') or (rstb_ipd = '1')) THEN
           clkb_valid <= '0';
        ELSE
           IF (ceb_ipd = '1') THEN
              IF (csb_en = '1') THEN 
                 clkb_valid <= '1', '0' after 0.2 ns;
              ELSE
                 clkb_valid <= '0';
              END IF;
           ELSE
              clkb_valid <= '0';
           END IF;
        END IF;
     END IF;
  END PROCESS;

  clka_valid1 <= clka_valid;
  clkb_valid1 <= clkb_valid;
  last_clka_valid1 <= clka_valid1;
  last_clkb_valid1 <= clkb_valid1;

  P7 : PROCESS(g_reset, rsta_ipd, rstb_ipd, clka_ipd, clkb_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        dia_reg <= (others => '0');
        diab_reg <= (others => '0');
        ada_reg <= (others => '0');
        bwa0_reg <= (others => '0');
        bwa1_reg <= (others => '0');
        wrena_reg <= '0';
        rena_reg <= '0';
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rsta_ipd = '1') THEN
           dia_reg <= (others => '0');
           diab_reg <= (others => '0');
           ada_reg <= (others => '0');
           bwa0_reg <= (others => '0');
           bwa1_reg <= (others => '0');
           wrena_reg <= '0';
           rena_reg <= '0';
        ELSIF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              dia_reg <= dia_node;
              diab_reg <= diab_node;
              ada_reg <= ada_node;
              bwa0_reg <= (ada_ipd(1), ada_ipd(0));
              bwa1_reg <= (ada_ipd(3), ada_ipd(2));
              wrena_reg <= (wrea_ipd and csa_en);
              rena_reg <= ((not wrea_ipd) and csa_en);
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN 
        IF (clka_ipd'event and clka_ipd = '1') THEN
           IF (rsta_ipd = '1') THEN
              dia_reg <= (others => '0');
              diab_reg <= (others => '0');
              ada_reg <= (others => '0');
              bwa0_reg <= (others => '0');
              bwa1_reg <= (others => '0');
              wrena_reg <= '0';
              rena_reg <= '0';
           ELSIF (cea_ipd = '1') THEN
              dia_reg <= dia_node; 
              diab_reg <= diab_node; 
              ada_reg <= ada_node;
              bwa0_reg <= (ada_ipd(1), ada_ipd(0));
              bwa1_reg <= (ada_ipd(3), ada_ipd(2));
              wrena_reg <= (wrea_ipd and csa_en);
              rena_reg <= ((not wrea_ipd) and csa_en);
           END IF;
        END IF;
     END IF;

     IF (g_reset = '0') THEN
        dib_reg <= (others => '0');
        adb_reg <= (others => '0');
        bwb_reg <= (others => '0');
        wrenb_reg <= '0';
        renb_reg <= '0';
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rstb_ipd = '1') THEN
           dib_reg <= (others => '0');
           adb_reg <= (others => '0');
           bwb_reg <= (others => '0');
           wrenb_reg <= '0';
           renb_reg <= '0';
        ELSIF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              dib_reg <= dib_node;
              adb_reg <= adb_node;
              bwb_reg <= (adb_ipd(1), adb_ipd(0));
              wrenb_reg <= (wreb_ipd and csb_en);
              renb_reg <= ((not wreb_ipd) and csb_en);
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (rstb_ipd = '1') THEN
              dib_reg <= (others => '0');
              adb_reg <= (others => '0');
              bwb_reg <= (others => '0');
              wrenb_reg <= '0';
              renb_reg <= '0';
           ELSIF (ceb_ipd = '1') THEN
              dib_reg <= dib_node;
              adb_reg <= adb_node;
              bwb_reg <= (adb_ipd(1), adb_ipd(0));
              wrenb_reg <= (wreb_ipd and csb_en);
              renb_reg <= ((not wreb_ipd) and csb_en);
           END IF;
        END IF;
     END IF;
  END PROCESS;

-- Warning for collision

  PW : PROCESS(ada_reg, adb_reg, wrena_reg, wrenb_reg, clka_valid, clkb_valid, rena_reg, 
       renb_reg) 
  VARIABLE WADDR_A_VALID : boolean := TRUE;
  VARIABLE WADDR_B_VALID : boolean := TRUE;
  VARIABLE ADDR_A : integer := 0;
  VARIABLE ADDR_B : integer := 0;
  VARIABLE DN_ADDR_A : integer := 0;
  VARIABLE UP_ADDR_A : integer := 0;
  VARIABLE DN_ADDR_B : integer := 0;
  VARIABLE UP_ADDR_B : integer := 0;
  BEGIN
     WADDR_A_VALID := Valid_Address (ada_reg);
     WADDR_B_VALID := Valid_Address (adb_reg);

     IF (WADDR_A_VALID = TRUE) THEN
        ADDR_A := conv_integer(ada_reg);
     END IF;
     IF (WADDR_B_VALID = TRUE) THEN
        ADDR_B := conv_integer(adb_reg);
     END IF;
  
     --DN_ADDR_A := (ADDR_A * DATA_WIDTH_A);
     --UP_ADDR_A := (((ADDR_A + 1) * DATA_WIDTH_A) - 1);
     --DN_ADDR_B := (ADDR_B * DATA_WIDTH_B); 
     --UP_ADDR_B := (((ADDR_B + 1) * DATA_WIDTH_B) - 1);

	  DN_ADDR_A := (ADDR_A * DATA_WIDTH_A) + (ADDR_A / div_a);
	  UP_ADDR_A := DN_ADDR_A + (DATA_WIDTH_A - 1);
	  DN_ADDR_B := (ADDR_B * DATA_WIDTH_B) + (ADDR_B / div_b);
	  UP_ADDR_B := DN_ADDR_B + (DATA_WIDTH_B - 1);

          IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
             IF (wr_a_wr_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   wr_a_wr_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             wr_a_wr_b_coll <= '0';
          END IF;

          IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
             IF (wr_a_rd_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   wr_a_rd_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             wr_a_rd_b_coll <= '0';
          END IF;

          IF (not((UP_ADDR_A < DN_ADDR_B) or (DN_ADDR_A > UP_ADDR_B))) THEN
             IF (rd_a_wr_b_coll = '1') THEN
                IF (clka_valid = '0' and clkb_valid = '0') THEN
                   rd_a_wr_b_coll <= '0';
                END IF;
             END IF;
          ELSE
             rd_a_wr_b_coll <= '0';
          END IF;

	  if (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) then
		  if ((DN_ADDR_A > DN_ADDR_B) and (UP_ADDR_A < UP_ADDR_B)) then
			  dn_coll_addr <= DN_ADDR_A;
			  up_coll_addr <= UP_ADDR_A;
		  elsif ((DN_ADDR_B > DN_ADDR_A) and (UP_ADDR_B < UP_ADDR_A)) then
			  dn_coll_addr <= DN_ADDR_B;
			  up_coll_addr <= UP_ADDR_B;
		  elsif ((UP_ADDR_A - DN_ADDR_B) <= (UP_ADDR_B - DN_ADDR_A)) then
			  dn_coll_addr <= DN_ADDR_B;
			  up_coll_addr <= UP_ADDR_A;
		  else
			  dn_coll_addr <= DN_ADDR_A;
			  up_coll_addr <= UP_ADDR_B;
		  end if;
	  end if;

     IF ((wrena_reg = '1' and clka_valid = '1') and (wrenb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
--           assert false
--           report " Write collision! Writing in the same memory location using Port A and Port B will cause the memory content invalid."
--           severity warning;
		     wr_a_wr_b_coll <= '1';
        END IF;
     END IF;

     IF ((wrena_reg = '1' and clka_valid = '1') and (renb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_B < DN_ADDR_A) or (DN_ADDR_B > UP_ADDR_A))) THEN
--           assert false
--           report " Write/Read collision! Writing through Port A and reading through Port B from the same memory location may give wrong output."
--           severity warning;
			  wr_a_rd_b_coll <= '1';
        END IF;
     END IF;

     IF ((rena_reg = '1' and clka_valid = '1') and (wrenb_reg = '1' and clkb_valid = '1')) THEN 
        IF (not((UP_ADDR_A < DN_ADDR_B) or (DN_ADDR_A > UP_ADDR_B))) THEN
--           assert false
--           report " Write/Read collision! Writing through Port B and reading through Port A from the same memory location may give wrong output."
--           severity warning;
			  rd_a_wr_b_coll <= '1';
        END IF;
     END IF;
  END PROCESS;

-- Writing to the memory

  P8 : PROCESS(ada_reg, dia_reg, diab_reg, bwa0_reg, bwa1_reg, wrena_reg, dib_reg, adb_reg,
               bwb_reg, wrenb_reg, clka_valid, clkb_valid,
					wr_a_wr_b_coll)
  VARIABLE WADDR_A_VALID : boolean := TRUE;
  VARIABLE WADDR_B_VALID : boolean := TRUE;
  VARIABLE WADDR_A : integer := 0;
  VARIABLE WADDR_B : integer := 0;
  VARIABLE dout_node_rbr : std_logic_vector(35 downto 0);
  BEGIN
     WADDR_A_VALID := Valid_Address (ada_reg);
     WADDR_B_VALID := Valid_Address (adb_reg);

     IF (WADDR_A_VALID = TRUE) THEN
        WADDR_A := conv_integer(ada_reg);
     END IF;
     IF (WADDR_B_VALID = TRUE) THEN
        WADDR_B := conv_integer(adb_reg);
     END IF;
    
     IF (DATA_WIDTH_A = 36) THEN
        IF (wrena_reg = '1' and clka_valid = '1') THEN
           FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              dout_node_rbr(i) := MEM((WADDR_A * DATA_WIDTH_A) + i);
           END LOOP;
           doa_node_rbr <= dout_node_rbr(17 downto 0);
           dob_node_rbr <= dout_node_rbr(35 downto 18);

           IF (bwa0_reg(0) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i) <= diab_reg(i);
              END LOOP;
           END IF;
           IF (bwa0_reg(1) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= diab_reg(i + 9);
              END LOOP;
           END IF;
           IF (bwa1_reg(0) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 18) <= diab_reg(i + 18);
              END LOOP;
           END IF;
           IF (bwa1_reg(1) = '1') THEN
              FOR i IN 0 TO 8 LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i + 27) <= diab_reg(i + 27);
              END LOOP;
           END IF;
        END IF;
     ELSE
        IF (DATA_WIDTH_A = 18) THEN
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

              IF (bwa0_reg(0) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_A * DATA_WIDTH_A) + i) <= dia_reg(i);
						  if ( (wr_a_wr_b_coll = '1') and
								 (((WADDR_A * DATA_WIDTH_A) + i) >= dn_coll_addr) and
								 (((WADDR_A * DATA_WIDTH_A) + i) <= up_coll_addr) and
								 ( (DATA_WIDTH_B < 18) or ((DATA_WIDTH_B = 18) and (bwb_reg(0) = '1')) ) ) then
							  MEM((WADDR_A * DATA_WIDTH_A) + i) <= 'X';
						  end if;
                 END LOOP;
              END IF;
              IF (bwa0_reg(1) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= dia_reg(i + 9);
						  if ( (wr_a_wr_b_coll = '1') and
								 (((WADDR_A * DATA_WIDTH_A) + i + 9) >= dn_coll_addr) and
								 (((WADDR_A * DATA_WIDTH_A) + i + 9) <= up_coll_addr) and
								 ( (DATA_WIDTH_B < 18) or ((DATA_WIDTH_B = 18) and (bwb_reg(1) = '1')) ) ) then
							  MEM((WADDR_A * DATA_WIDTH_A) + i + 9) <= 'X';
						  end if;
                 END LOOP;
              END IF;
           END IF;
        ELSIF (DATA_WIDTH_A = 9) THEN
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
                 MEM((WADDR_A * DATA_WIDTH_A) + i) <= dia_reg(i);
					  if ( (wr_a_wr_b_coll = '1') and
							 (((WADDR_A * DATA_WIDTH_A) + i) >= dn_coll_addr) and
							 (((WADDR_A * DATA_WIDTH_A) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_B < 18) or
								( (DATA_WIDTH_B = 18) and
								  ( ((bwb_reg(0) = '1') and (((WADDR_A * DATA_WIDTH_A) rem 18) = 0)) or
								    ((bwb_reg(1) = '1') and (((WADDR_A * DATA_WIDTH_A) rem 18) = 9)) ) ) ) ) then
						  MEM((WADDR_A * DATA_WIDTH_A) + i) <= 'X';
					  end if;
              END LOOP;
           END IF;
        ELSE
           IF (wrena_reg = '1' and clka_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
              doa_node_rbr(i) <= MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_A - 1) LOOP
                  MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= dia_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) >= dn_coll_addr) and
							  (((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= up_coll_addr) and
							  ( (DATA_WIDTH_B < 18) or
								 ( (DATA_WIDTH_B = 18) and
								   ( ((bwb_reg(0) = '1') and ((((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a)) rem 18) < 9)) or
								     ((bwb_reg(1) = '1') and ((((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a)) rem 18) >= 9))
									) ) ) ) then
						   MEM((WADDR_A * DATA_WIDTH_A) + (WADDR_A / div_a) + i) <= 'X';
					  end if;
              END LOOP;
           END IF;
        END IF;

        IF (DATA_WIDTH_B = 18) THEN
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);
              END LOOP;

              IF (bwb_reg(0) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_B * DATA_WIDTH_B) + i) <= dib_reg(i);
						  if ( (wr_a_wr_b_coll = '1') and
							    (((WADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							    (((WADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) and
								 ( (DATA_WIDTH_A < 18) or ((DATA_WIDTH_A = 18) and (bwa0_reg(0) = '1')) ) ) then
							  MEM((WADDR_B * DATA_WIDTH_B) + i) <= 'X';
						  end if;
                 END LOOP;
              END IF;
              IF (bwb_reg(1) = '1') THEN
                 FOR i IN 0 TO 8 LOOP
                    MEM((WADDR_B * DATA_WIDTH_B) + i + 9) <= dib_reg(i + 9);
						  if ( (wr_a_wr_b_coll = '1') and
							    (((WADDR_B * DATA_WIDTH_B) + i + 9) >= dn_coll_addr) and
							    (((WADDR_B * DATA_WIDTH_B) + i + 9) <= up_coll_addr) and
								 ( (DATA_WIDTH_A < 18) or ((DATA_WIDTH_A = 18) and (bwa0_reg(1) = '1')) ) ) then
							  MEM((WADDR_B * DATA_WIDTH_B) + i + 9) <= 'X';
						  end if;
                 END LOOP;
              END IF;
           END IF;
        ELSIF (DATA_WIDTH_B = 9) THEN
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                  MEM((WADDR_B * DATA_WIDTH_B) + i) <= dib_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							  (((WADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) and
							  ( (DATA_WIDTH_A < 18) or
								 ( (DATA_WIDTH_A = 18) and
									( ((bwa0_reg(0) = '1') and (((WADDR_B * DATA_WIDTH_B) rem 18) = 0)) or
									  ((bwa0_reg(1) = '1') and (((WADDR_B * DATA_WIDTH_B) rem 18) = 9)) ) ) ) ) then
							MEM((WADDR_B * DATA_WIDTH_B) + i) <= 'X';
						end if;
              END LOOP;
           END IF;
        ELSE
           IF (wrenb_reg = '1' and clkb_valid = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
              dob_node_rbr(i) <= MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i);
              END LOOP;

              FOR i IN 0 TO (DATA_WIDTH_B - 1)  LOOP
                  MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= dib_reg(i);
						if ( (wr_a_wr_b_coll = '1') and
							  (((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) >= dn_coll_addr) and
							  (((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= up_coll_addr) and
							  ( (DATA_WIDTH_A < 18) or
								 ( (DATA_WIDTH_A = 18) and
									( ((bwa0_reg(0) = '1') and ((((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b)) rem 18) < 9)) or
									  ((bwa0_reg(1) = '1') and ((((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b)) rem 18) >= 9))
									) ) ) ) then
							MEM((WADDR_B * DATA_WIDTH_B) + (WADDR_B / div_b) + i) <= 'X';
						end if;
              END LOOP;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P9 : PROCESS(ada_reg, rena_reg, adb_reg, renb_reg, MEM, clka_valid1, clkb_valid1, rsta_sig, rstb_sig,
               doa_node_rbr, dob_node_rbr,
					wr_a_rd_b_coll, rd_a_wr_b_coll) 
  VARIABLE RADDR_A_VALID : boolean := TRUE;
  VARIABLE RADDR_B_VALID : boolean := TRUE;
  VARIABLE RADDR_A : integer := 0;
  VARIABLE RADDR_B : integer := 0;
  VARIABLE dout_node_tr : std_logic_vector(35 downto 0);
  VARIABLE dout_node_wt : std_logic_vector(35 downto 0);
  BEGIN
     RADDR_A_VALID := Valid_Address (ada_reg);
     RADDR_B_VALID := Valid_Address (adb_reg);

     IF (RADDR_A_VALID = TRUE) THEN
        RADDR_A := conv_integer(ada_reg);
     END IF;
     IF (RADDR_B_VALID = TRUE) THEN
        RADDR_B := conv_integer(adb_reg);
     END IF;

     IF (DATA_WIDTH_B = 36) THEN
        IF (rstb_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clkb_ipd = '1') THEN
                 doa_node <= (others => '0');
                 dob_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              doa_node <= (others => '0');
              dob_node <= (others => '0');
           END IF;
        ELSIF (clkb_valid1'event and clkb_valid1 = '1') THEN
           IF (renb_reg = '1') THEN
              FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                 dout_node_tr(i) := MEM((RADDR_B * DATA_WIDTH_B) + i);
					  if ( (wr_a_rd_b_coll = '1') and
							 (((RADDR_B * DATA_WIDTH_B) + i) >= dn_coll_addr) and
							 (((RADDR_B * DATA_WIDTH_B) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_A < 18) or
								( (DATA_WIDTH_A = 18) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 18) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 18) >= 9)) ) ) or
								( (DATA_WIDTH_A = 36) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) >= 9)
										                   and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) < 18)) or
								    ((bwa1_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) >= 18)
										                   and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) < 27)) or
								    ((bwa1_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + i) rem 36) >= 27)) ) )
								 ) ) then
						  dout_node_tr(i) := 'X';
					  end if;
              END LOOP;
              doa_node <= dout_node_tr(17 downto 0);
              dob_node <= dout_node_tr(35 downto 18);
           ELSIF (renb_reg = '0') THEN
              IF (WRITEMODE_B = "WRITETHROUGH") THEN
                 FOR i IN 0 TO (DATA_WIDTH_B - 1) LOOP
                    dout_node_wt(i) := MEM((RADDR_B * DATA_WIDTH_B) + i);
                 END LOOP;
                 doa_node <= dout_node_wt(17 downto 0);
                 dob_node <= dout_node_wt(35 downto 18);
              ELSIF (WRITEMODE_B = "READBEFOREWRITE") THEN
                 ASSERT false
                 report "WRITEMODE of READBEFOREWRITE is not supported !!"
                 severity ERROR;
                 doa_node <= doa_node_rbr;
                 dob_node <= dob_node_rbr;
              END IF;
           END IF;
        END IF;
     ELSE
        IF (rsta_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clka_ipd = '1') THEN
                 doa_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              doa_node <= (others => '0');
           END IF;
        ELSIF (clka_valid1 = '1') THEN
           IF (rena_reg = '1') THEN
              IF ( last_clka_valid1 = '0') THEN
                 FOR i IN 0 TO (new_data_width_a - 1)  LOOP
                    doa_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
					  if ( (rd_a_wr_b_coll = '1') and
							 (((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) >= dn_coll_addr) and
							 (((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_B < 18) or
								( (DATA_WIDTH_B = 18) and
								  ( ((bwb_reg(0) = '1') and ((((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) rem 18) < 9)) or
									 ((bwb_reg(1) = '1') and ((((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i) rem 18) >= 9))
								  ) ) ) ) then
						  doa_node(i) <= 'X';
					  end if;
                 END LOOP;
              END IF;
           ELSIF (rena_reg = '0') THEN
              IF (WRITEMODE_A = "WRITETHROUGH") THEN
                  if (DATA_WIDTH_A <= 9) then
                     for i in 0 to (DATA_WIDTH_A - 1) loop
                        DOA_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
                     end loop;
                  elsif (DATA_WIDTH_A = 18) then
                     if (BWA0_reg(0) = '1') then
                        for i in 0 to 8 loop
                           DOA_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
                        end loop;
                     end if;
                     if (BWA0_reg(1) = '1') then
                        for i in 9 to 17 loop
                           DOA_node(i) <= MEM((RADDR_A * DATA_WIDTH_A) + (RADDR_A / div_a) + i);
                        end loop;
                     end if;
                  end if;
              ELSIF (WRITEMODE_A = "READBEFOREWRITE") THEN
                 ASSERT false
                 report "WRITEMODE of READBEFOREWRITE is not supported !!"
                 severity ERROR;
                 IF ( last_clka_valid1 = '0') THEN
                    doa_node <= doa_node_rbr;
                 END IF;
              END IF;
           END IF;
        END IF;

        IF (rstb_sig = '1') THEN
           IF (RESETMODE = "SYNC") THEN
              IF (clkb_ipd = '1') THEN
                 dob_node <= (others => '0');
              END IF;
           ELSIF (RESETMODE = "ASYNC") THEN
              dob_node <= (others => '0');
           END IF;
        ELSIF (clkb_valid1 = '1') THEN
           IF (renb_reg = '1') THEN
              IF ( last_clkb_valid1 = '0') THEN
                 FOR i IN 0 TO (DATA_WIDTH_B - 1)  LOOP
                    dob_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
					  if ( (wr_a_rd_b_coll = '1') and
							 (((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) >= dn_coll_addr) and
							 (((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) <= up_coll_addr) and
							 ( (DATA_WIDTH_A < 18) or
								( (DATA_WIDTH_A = 18) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 18) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 18) >= 9))
								  ) ) or
								( (DATA_WIDTH_A = 36) and
								  ( ((bwa0_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) < 9)) or
								    ((bwa0_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) >= 9)
										                   and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) < 18)) or
								    ((bwa1_reg(0) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) >= 18)
										                   and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) < 27)) or
								    ((bwa1_reg(1) = '1') and ((((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i) rem 36) >= 27))
								  ) ) ) ) then
						  dob_node(i) <= 'X';
					  end if;
                 END LOOP;
              END IF;
           ELSIF (renb_reg = '0') THEN
              IF (WRITEMODE_B = "WRITETHROUGH") THEN
                  if (DATA_WIDTH_B <= 9) then
                     for i in 0 to (DATA_WIDTH_B - 1) loop
                        DOB_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
                     end loop;
                  elsif (DATA_WIDTH_B = 18) then
                     if (BWB_reg(0) = '1') then
                        for i in 0 to 8 loop
                           DOB_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
                        end loop;
                     end if;
                     if (BWB_reg(1) = '1') then
                        for i in 9 to 17 loop
                           DOB_node(i) <= MEM((RADDR_B * DATA_WIDTH_B) + (RADDR_B / div_b) + i);
                        end loop;
                     end if;
                  end if;
              ELSIF (WRITEMODE_B = "READBEFOREWRITE") THEN
                 ASSERT false
                 report "WRITEMODE of READBEFOREWRITE is not supported !!"
                 severity ERROR;
                 IF ( last_clkb_valid1 = '0') THEN
                    dob_node <= dob_node_rbr;
                 END IF;
              END IF;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P10 : PROCESS(g_reset, rsta_ipd, rstb_ipd, clka_ipd, clkb_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        doa_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rsta_ipd = '1') THEN
           doa_reg <= (others => '0');
        ELSIF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              doa_reg <= doa_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clka_ipd'event and clka_ipd = '1') THEN
           IF (cea_ipd = '1') THEN
              IF (rsta_ipd = '1') THEN
                 doa_reg <= (others => '0');
              ELSIF (rsta_ipd = '0') THEN
                 doa_reg <= doa_node;
              END IF;
           END IF;
        END IF;
     END IF;

     IF (g_reset = '0') THEN
        dob_reg <= (others => '0');
        doab_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rstb_ipd = '1') THEN
           dob_reg <= (others => '0');
           doab_reg <= (others => '0');
        ELSIF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              dob_reg <= dob_node;
              doab_reg <= doa_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (clkb_ipd'event and clkb_ipd = '1') THEN
           IF (ceb_ipd = '1') THEN
              IF (rstb_ipd = '1') THEN
                 dob_reg <= (others => '0');
                 doab_reg <= (others => '0');
              ELSIF (rstb_ipd = '0') THEN
                 dob_reg <= dob_node;
                 doab_reg <= doa_node;
              END IF;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P11 : PROCESS(doa_node, dob_node, doa_reg, dob_reg, doab_reg)
  BEGIN
     IF (REGMODE_A = "OUTREG") THEN 
        IF (DATA_WIDTH_B = 36) THEN
           doa_int <= doab_reg;
        ELSE
           doa_int <= doa_reg;
        END IF;
     ELSE
        doa_int <= doa_node;
     END IF;

     IF (REGMODE_B = "OUTREG") THEN 
        dob_int <= dob_reg;
     ELSE
        dob_int <= dob_node;
     END IF;
  END PROCESS;

  (doa17, doa16, doa15, doa14, doa13, doa12, doa11, doa10, doa9, doa8, doa7, doa6,
   doa5, doa4, doa3, doa2, doa1, doa0) <= doa_int;

  (dob17, dob16, dob15, dob14, dob13, dob12, dob11, dob10, dob9, dob8, dob7, dob6,
   dob5, dob4, dob3, dob2, dob1, dob0) <= dob_int;

END V;



--
-----cell fifo16ka----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY fifo16ka IS
   GENERIC (
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

        -- miscellaneous vital GENERICs
        TimingChecksOn  : boolean := TRUE;
        XOn             : boolean := FALSE;
        MsgOn           : boolean := TRUE;
        InstancePath    : string  := "fifo16ka";

        -- input SIGNAL delays
        tipd_di35 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di34 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di33 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di32 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di31 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di30 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di29 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di28 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di27 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di26 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di25 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di24 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di23 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di22 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di21 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di20 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di19 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di18 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di17 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di16 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di15 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di14 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di13 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di12 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di11 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di10 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di9  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di8  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di7  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di6  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di5  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di4  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di3  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di2  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di1  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_di0  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clkw : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_clkr : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_we  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_re  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_fulli : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csw0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csw1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_emptyi : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csr0 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_csr1 : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rst  : VitalDelayType01 := (0.0 ns, 0.0 ns);
        tipd_rprst  : VitalDelayType01 := (0.0 ns, 0.0 ns)
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

      ATTRIBUTE Vital_Level0 OF fifo16ka : ENTITY IS TRUE;

END fifo16ka ;

-- ARCHITECTURE body --
ARCHITECTURE V OF fifo16ka IS
    ATTRIBUTE Vital_Level0 OF V : ARCHITECTURE IS TRUE;

--SIGNAL DECLARATIONS----

    SIGNAL di_ipd    : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    SIGNAL wclk_ipd  : std_logic := '0';
    SIGNAL we_ipd   : std_logic := '0';
    SIGNAL csw_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rst_ipd   : std_logic := '0';
    SIGNAL rclk_ipd  : std_logic := '0';
    SIGNAL re_ipd   : std_logic := '0';
    SIGNAL csr_ipd   : std_logic_vector(2 downto 0) := "000";
    SIGNAL rprst_ipd : std_logic := '0';
    SIGNAL csw_en    : std_logic := '0';
    SIGNAL csr_en    : std_logic := '0';
    SIGNAL g_reset   : std_logic := '0';
    CONSTANT ADDR_WIDTH_W : integer := data2addr_w(DATA_WIDTH_W); 
    CONSTANT ADDR_WIDTH_R : integer := data2addr_w(DATA_WIDTH_R); 
    CONSTANT div_a    : integer := data2data(DATA_WIDTH_W);
    CONSTANT div_b    : integer := data2data(DATA_WIDTH_R);
    SIGNAL di_node    : std_logic_vector((DATA_WIDTH_W - 1) downto 0) := (others => '0');
    SIGNAL adw_node   : std_logic_vector(ADDR_WIDTH_W downto 0) := (others => '1');
    SIGNAL adw_node_syncb   : std_logic_vector(ADDR_WIDTH_W downto 0) := (others => '1');
    SIGNAL adwf_node  : std_logic_vector(14 downto 0) := (others => '0');
    SIGNAL adwf_node_syncb  : std_logic_vector(14 downto 0) := (others => '0');
    SIGNAL adr_node   : std_logic_vector(ADDR_WIDTH_R downto 0) := (others => '1');
    SIGNAL adr_node_syncb   : std_logic_vector(ADDR_WIDTH_R downto 0) := (others => '1');
    SIGNAL adrf_node  : std_logic_vector(14 downto 0) := (others => '0');
    SIGNAL adrf_node_syncb  : std_logic_vector(14 downto 0) := (others => '0');
    SIGNAL fifo_words_used_syncw       : std_logic_vector(14 downto 0) := (others => '0');
    SIGNAL fifo_words_used_syncr       : std_logic_vector(14 downto 0) := (others => '0');
--    SIGNAL fifo_words_used_syncr       : signed(14 downto 0) := (others => '0');
    SIGNAL fifo_words_used       : std_logic_vector(14 downto 0) := (others => '0');
    SIGNAL diab_node  : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    SIGNAL rsta_int   : std_logic := '0';
    SIGNAL rstb_int   : std_logic := '0';
    SIGNAL rsta_reg   : std_logic := '0';
    SIGNAL rstb_reg   : std_logic := '0';
    SIGNAL reseta     : std_logic := '0';
    SIGNAL resetb     : std_logic := '0';
    SIGNAL di_reg     : std_logic_vector((DATA_WIDTH_W - 1) downto 0) := (others => '0');
    SIGNAL dib_reg    : std_logic_vector(17 downto 0) := "XXXXXXXXXXXXXXXXXX";
    SIGNAL adw_reg    : std_logic_vector((ADDR_WIDTH_W - 1) downto 0) := (others => '1');
    SIGNAL adr_reg    : std_logic_vector((ADDR_WIDTH_R - 1) downto 0) := (others => '1');
    SIGNAL diab_reg   : std_logic_vector(35 downto 0) := "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    SIGNAL bwa0_reg   : std_logic_vector(1 downto 0) := "XX";
    SIGNAL bwa1_reg   : std_logic_vector(1 downto 0) := "XX";
    SIGNAL bwb_reg    : std_logic_vector(1 downto 0) := "XX";
    SIGNAL adw_var_syncb_rst : std_logic_vector(ADDR_WIDTH_W downto 0) := (others => '0');
    SIGNAL empty_pointer_rst : std_logic_vector(ADDR_WIDTH_R downto 0) := (others => '0');
    SIGNAL empty_pointer : std_logic_vector(14 downto 0) := (others => '0');
    SIGNAL wrena_reg  : std_logic := '0';
    SIGNAL wrenb_reg  : std_logic := '0';
    SIGNAL rena_reg   : std_logic := '0';
    SIGNAL renb_reg   : std_logic := '0';
    SIGNAL do_node    : std_logic_vector((DATA_WIDTH_R - 1) downto 0) := (others => '0');
    SIGNAL do_reg     : std_logic_vector((DATA_WIDTH_R - 1) downto 0) := (others => '0');
    SIGNAL do_int     : std_logic_vector((DATA_WIDTH_R - 1) downto 0) := (others => '0');
    SIGNAL empty_pointer_reg  : integer := 0;
    SIGNAL pe_pointer_reg  : integer := 0;
    SIGNAL pf_pointer_reg  : integer := 0;
    SIGNAL full_pointer_reg  : integer := 0;
    SIGNAL RADDR_PTR  : integer := 0;
    SIGNAL WADDR_PTR  : integer := 0;
    SIGNAL ef_int     : std_logic := '1';
    SIGNAL pef_int    : std_logic := '1';
    SIGNAL pff_int    : std_logic := '0';
    SIGNAL ff_int     : std_logic := '0';
    SIGNAL ef_reg     : std_logic := '1';
    SIGNAL pef_reg    : std_logic := '1';
    SIGNAL pff_reg    : std_logic := '0';
    SIGNAL ff_reg     : std_logic := '0';
    SIGNAL addr_valid : std_logic := '0';

    SIGNAL MEM       : std_logic_vector(36863 downto 0) := (others => '0');
BEGIN

   -----------------------
   -- input path delays
   -----------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay(di_ipd(0), di0, tipd_di0);
   VitalWireDelay(di_ipd(1), di1, tipd_di1);
   VitalWireDelay(di_ipd(2), di2, tipd_di2);
   VitalWireDelay(di_ipd(3), di3, tipd_di3);
   VitalWireDelay(di_ipd(4), di4, tipd_di4);
   VitalWireDelay(di_ipd(5), di5, tipd_di5);
   VitalWireDelay(di_ipd(6), di6, tipd_di6);
   VitalWireDelay(di_ipd(7), di7, tipd_di7);
   VitalWireDelay(di_ipd(8), di8, tipd_di8);
   VitalWireDelay(di_ipd(9), di9, tipd_di9);
   VitalWireDelay(di_ipd(10), di10, tipd_di10);
   VitalWireDelay(di_ipd(11), di11, tipd_di11);
   VitalWireDelay(di_ipd(12), di12, tipd_di12);
   VitalWireDelay(di_ipd(13), di13, tipd_di13);
   VitalWireDelay(di_ipd(14), di14, tipd_di14);
   VitalWireDelay(di_ipd(15), di15, tipd_di15);
   VitalWireDelay(di_ipd(16), di16, tipd_di16);
   VitalWireDelay(di_ipd(17), di17, tipd_di17);
   VitalWireDelay(di_ipd(18), di18, tipd_di18);
   VitalWireDelay(di_ipd(19), di19, tipd_di19);
   VitalWireDelay(di_ipd(20), di20, tipd_di20);
   VitalWireDelay(di_ipd(21), di21, tipd_di21);
   VitalWireDelay(di_ipd(22), di22, tipd_di22);
   VitalWireDelay(di_ipd(23), di23, tipd_di23);
   VitalWireDelay(di_ipd(24), di24, tipd_di24);
   VitalWireDelay(di_ipd(25), di25, tipd_di25);
   VitalWireDelay(di_ipd(26), di26, tipd_di26);
   VitalWireDelay(di_ipd(27), di27, tipd_di27);
   VitalWireDelay(di_ipd(28), di28, tipd_di28);
   VitalWireDelay(di_ipd(29), di29, tipd_di29);
   VitalWireDelay(di_ipd(30), di30, tipd_di30);
   VitalWireDelay(di_ipd(31), di31, tipd_di31);
   VitalWireDelay(di_ipd(32), di32, tipd_di32);
   VitalWireDelay(di_ipd(33), di33, tipd_di33);
   VitalWireDelay(di_ipd(34), di34, tipd_di34);
   VitalWireDelay(di_ipd(35), di35, tipd_di35);
   VitalWireDelay(wclk_ipd, clkw, tipd_clkw);
   VitalWireDelay(we_ipd, we, tipd_we);
   VitalWireDelay(csw_ipd(0), csw0, tipd_csw0);
   VitalWireDelay(csw_ipd(1), csw1, tipd_csw1);
   VitalWireDelay(csw_ipd(2), fulli, tipd_fulli);
   VitalWireDelay(rst_ipd, rst, tipd_rst);
   VitalWireDelay(rclk_ipd, clkr, tipd_clkr);
   VitalWireDelay(re_ipd, re, tipd_re);
   VitalWireDelay(csr_ipd(0), csr0, tipd_csr0);
   VitalWireDelay(csr_ipd(1), csr1, tipd_csr1);
   VitalWireDelay(csr_ipd(2), emptyi, tipd_emptyi);
   VitalWireDelay(rprst_ipd, rprst, tipd_rprst);
   END BLOCK;

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (GSR =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

-- chip select A decode
  P1 : PROCESS(csw_ipd)
  BEGIN
     IF (csw_ipd = "000" and CSDECODE_W = "00") THEN
        csw_en <= '1';
     ELSIF (csw_ipd = "001" and CSDECODE_W = "01") THEN
        csw_en <= '1';
     ELSIF (csw_ipd = "010" and CSDECODE_W = "10") THEN
        csw_en <= '1';
     ELSIF (csw_ipd = "011" and CSDECODE_W = "11") THEN
        csw_en <= '1';
     ELSE
        csw_en <= '0';
     END IF;
  END PROCESS;

  P2 : PROCESS(csr_ipd)
  BEGIN
     IF (csr_ipd = "000" and CSDECODE_R = "00") THEN
        csr_en <= '1';
     ELSIF (csr_ipd = "001" and CSDECODE_R = "01") THEN
        csr_en <= '1';
     ELSIF (csr_ipd = "010" and CSDECODE_R = "10") THEN
        csr_en <= '1';
     ELSIF (csr_ipd = "011" and CSDECODE_R = "11") THEN
        csr_en <= '1';
     ELSE
        csr_en <= '0';
     END IF;
  END PROCESS;

  P3 : PROCESS(di_ipd)
  BEGIN
     CASE DATA_WIDTH_W IS
       WHEN 1 =>
        di_node <= di_ipd(11 downto 11);
       WHEN 2 =>
        di_node <= (di_ipd(1), di_ipd(11));
       WHEN 4 =>
        di_node <= di_ipd(3 downto 0); 
       WHEN 9 =>
        di_node <= di_ipd(8 downto 0);
       WHEN 18 =>
        di_node <= di_ipd(17 downto 0);
       WHEN 36 =>
        di_node <= di_ipd(35 downto 0);
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;

  S1 : PROCESS(adw_node)
  VARIABLE  adw_var : std_logic_vector(ADDR_WIDTH_W downto 0);
  BEGIN
     adw_var := adw_node + '1';
     adwf_node <= (adw_var(ADDR_WIDTH_W downto 0) & ((13 - ADDR_WIDTH_W) downto 0 => '0'));
  END PROCESS;

  S11 : PROCESS(adw_node_syncb, rprst_ipd, addr_valid)
  VARIABLE  adw_var_syncb : std_logic_vector(ADDR_WIDTH_W downto 0);
  BEGIN
     adw_var_syncb := adw_node_syncb + '1';

     IF (rprst_ipd = '1') THEN
        adwf_node_syncb <= (adw_var_syncb_rst(ADDR_WIDTH_W downto 0) & ((13 - ADDR_WIDTH_W) downto 0 => '0'));
     ELSIF (addr_valid'event) THEN 
        adwf_node_syncb <= (adw_var_syncb(ADDR_WIDTH_W downto 0) & ((13 - ADDR_WIDTH_W) downto 0 => '0'));
     END IF;
  END PROCESS;

  S2 : PROCESS(adr_node)
  VARIABLE  adr_var : std_logic_vector(ADDR_WIDTH_R downto 0);
  BEGIN
     adr_var := adr_node + '1';
     adrf_node <= (adr_var(ADDR_WIDTH_R downto 0) & ((13 - ADDR_WIDTH_R) downto 0 => '0'));
  END PROCESS;

  S21 : PROCESS(adr_node_syncb)
  VARIABLE  adr_var_syncb : std_logic_vector(ADDR_WIDTH_R downto 0);
  BEGIN
     adr_var_syncb := adr_node_syncb + '1';
     adrf_node_syncb <= (adr_var_syncb(ADDR_WIDTH_R downto 0) & ((13 - ADDR_WIDTH_R) downto 0 => '0'));
  END PROCESS;

  empty_pointer <= (empty_pointer_rst(ADDR_WIDTH_R downto 0) & ((13 - ADDR_WIDTH_R) downto 0 => '1'));

  empty_pointer_reg <= conv_integer(empty_pointer);
  pe_pointer_reg <= conv_integer(AEPOINTER);
  pf_pointer_reg <= conv_integer(AFPOINTER);
  full_pointer_reg <= conv_integer(FULLPOINTER);

fifo_words_used_syncr <= ((adwf_node_syncb(14) xor adrf_node(14)) & adwf_node_syncb(13 downto 0) - ('0' & adrf_node(13 downto 0)));

fifo_words_used_syncw <= ((adrf_node_syncb(14) xor adwf_node(14)) & adwf_node(13 downto 0) - ('0' & adrf_node_syncb(13 downto 0)));

ef_int <= '1' when (fifo_words_used_syncr <= empty_pointer_reg) else '0';
pef_int <= '1' when (fifo_words_used_syncr <= pe_pointer_reg) else '0';
pff_int <= '1' when (fifo_words_used_syncw >= pf_pointer_reg) else '0';
ff_int <= '1' when (fifo_words_used_syncw >= full_pointer_reg) else '0';

ef <= ef_int;
aef <= pef_int;
aff <= pff_int;
ff <= ff_int;

-- Reset Write and Read Counter

  P4 : PROCESS(g_reset, rst_ipd, wclk_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        di_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF (rst_ipd = '1') THEN
           di_reg <= (others => '0');
        ELSIF (wclk_ipd'event and wclk_ipd = '1') THEN
           IF (csw_en = '1' and we_ipd = '1') THEN
              di_reg <= di_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (wclk_ipd'event and wclk_ipd = '1') THEN
           IF (rst_ipd = '1') THEN
              di_reg <= (others => '0');
           ELSIF (csw_en = '1' and we_ipd = '1') THEN
              di_reg <= di_node;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P54 : PROCESS(g_reset, rst_ipd, wclk_ipd)
  BEGIN
     IF (g_reset = '0' or rst_ipd = '1') THEN
        adw_node <= (others => '1');
     ELSIF (wclk_ipd'event and wclk_ipd = '1') THEN
        IF (csw_en = '1' and we_ipd = '1') THEN
           adw_node <= adw_node + '1';
        END IF;
     END IF;
  END PROCESS;

  P55 : PROCESS(g_reset, rst_ipd, rclk_ipd)
  BEGIN
     IF (g_reset = '0' or rst_ipd = '1') THEN
        adw_node_syncb <= (others => '1');
        addr_valid <= not addr_valid;
     ELSIF (rclk_ipd'event and rclk_ipd = '1') THEN
        adw_node_syncb <= adw_node;
        addr_valid <= not addr_valid;
     END IF;
  END PROCESS;

  P5 : PROCESS(adw_node, di_reg)
  VARIABLE WADDR : integer;
  BEGIN
     WADDR := conv_integer(adw_node((ADDR_WIDTH_W-1) downto 0));
     WADDR_PTR <= (conv_integer(adw_node + '1') + 1);

     IF ((DATA_WIDTH_W = 36) or (DATA_WIDTH_W = 18) or (DATA_WIDTH_W = 9)) THEN
        FOR i IN 0 TO (DATA_WIDTH_W - 1) LOOP
            MEM((WADDR * DATA_WIDTH_W) + i) <= di_reg(i);
        END LOOP;
     ELSE
        FOR i IN 0 TO (DATA_WIDTH_W - 1) LOOP
            MEM((WADDR * DATA_WIDTH_W) + (WADDR / div_a) + i) <= di_reg(i);
        END LOOP;
     END IF;
  END PROCESS;

  P6 : PROCESS(g_reset, rst_ipd, rprst_ipd, rclk_ipd)
  BEGIN
     IF (g_reset = '0' or rst_ipd = '1' or rprst_ipd = '1') THEN
        adr_node <= (others => '1');
     ELSIF (rclk_ipd'event and rclk_ipd = '1') THEN
        IF (csr_en = '1' and re_ipd = '1') THEN
           adr_node <= adr_node + '1';
        END IF;
     END IF;
  END PROCESS;

  P60 : PROCESS(g_reset, rst_ipd, rprst_ipd, wclk_ipd)
  BEGIN
--     IF (g_reset = '0' or rst_ipd = '1' or rprst_ipd = '1') THEN
--        adr_node_syncb <= (others => '1');
--     ELSIF (wclk_ipd'event and wclk_ipd = '1') THEN
--        adr_node_syncb <= adr_node;
--     END IF;
     IF (g_reset = '0' or rst_ipd = '1') THEN
        adr_node_syncb <= (others => '1');
     ELSIF (wclk_ipd'event and wclk_ipd = '1') THEN
        IF (rprst_ipd = '1') THEN
           adr_node_syncb <= (others => '1');
        ELSE
           adr_node_syncb <= adr_node;
        END IF;
     END IF;
  END PROCESS;

  P7 : PROCESS(adr_node, g_reset, rst_ipd, rprst_ipd)
  VARIABLE RADDR : integer;
  BEGIN
     RADDR := conv_integer(adr_node((ADDR_WIDTH_R-1) downto 0));
     RADDR_PTR <= (conv_integer(adr_node + '1') + 1);

     IF ((g_reset = '0') or (rst_ipd = '1') or (rprst_ipd = '1')) THEN
        do_node <= (others => '0');
     ELSIF (adr_node'event) THEN
--        IF ((g_reset = '1') and (rst_ipd = '0') and (rprst_ipd = '0')) THEN     
        FOR i IN 0 TO (DATA_WIDTH_R - 1)  LOOP
           do_node(i) <= MEM((RADDR * DATA_WIDTH_R) + (RADDR / div_b) + i);
        END LOOP;
     END IF;
  END PROCESS;

  P8 : PROCESS(g_reset, rst_ipd, rprst_ipd, rclk_ipd)
  BEGIN
     IF (g_reset = '0') THEN
        do_reg <= (others => '0');
     ELSIF (RESETMODE = "ASYNC") THEN
        IF ((rst_ipd = '1') or (rprst_ipd = '1'))THEN
           do_reg <= (others => '0');
        ELSIF (rclk_ipd'event and rclk_ipd = '1') THEN
           IF (re_ipd = '1') THEN
              do_reg <= do_node;
           END IF;
        END IF;
     ELSIF (RESETMODE = "SYNC") THEN
        IF (rclk_ipd'event and rclk_ipd = '1') THEN
           IF (re_ipd = '1') THEN
              IF ((rst_ipd = '1') or (rprst_ipd = '1')) THEN
                 do_reg <= (others => '0');
              ELSE  
                 do_reg <= do_node;
              END IF;
           END IF;
        END IF;
     END IF;
  END PROCESS;

  P9 : PROCESS(do_node, do_reg)
  BEGIN
     IF (REGMODE = "OUTREG") THEN
        do_int <= do_reg;
     ELSE
        do_int <= do_node;
     END IF;
  END PROCESS;

  P10 : PROCESS(do_int)
  BEGIN
     CASE DATA_WIDTH_R IS
       WHEN 1 =>
        do0 <= do_int(0);
       WHEN 2 =>
        (do1, do0) <= do_int(1 downto 0);
       WHEN 4 =>
        (do3, do2, do1, do0) <= do_int(3 downto 0);
       WHEN 9 =>
        (do8, do7, do6, do5, do4, do3, do2, do1, do0) <= do_int(8 downto 0);
       WHEN 18 =>
        (do17, do16, do15, do14, do13, do12, do11, do10, do9, do8, do7, do6,
         do5, do4, do3, do2, do1, do0) <= do_int(17 downto 0);
       WHEN 36 =>
        (do35, do34, do33, do32, do31, do30, do29, do28, do27, do26, do25, do24,
         do23, do22, do21, do20, do19, do18) <= do_int(17 downto 0);
        (do17, do16, do15, do14, do13, do12,
         do11, do10, do9, do8, do7, do6, do5, do4, do3, do2, do1, do0) <= do_int(35 downto 18);
       WHEN others =>
          NULL;
     END CASE;
  END PROCESS;


END V;



--
----- cell dcs -----
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.vital_timing.all;


-- entity declaration --
ENTITY dcs IS
   GENERIC(
      DCSMODE         : String  := "NEG";
      TimingChecksOn  : boolean := TRUE;
      XOn             : boolean := FALSE;
      MsgOn           : boolean := TRUE;
      InstancePath    : string := "dcs";
      tipd_clk0         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_clk1         : VitalDelayType01 := (0.0 ns, 0.0 ns);
      tipd_sel         : VitalDelayType01 := (0.0 ns, 0.0 ns));

   PORT(
      clk0              : IN    std_logic;
      clk1              : IN    std_logic;
      sel              : IN    std_logic;
      dcsout               : OUT  std_logic);

   ATTRIBUTE Vital_Level0 OF dcs : ENTITY IS TRUE;

END dcs;

-- architecture body --

LIBRARY ieee;
USE ieee.vital_primitives.all;
ARCHITECTURE v OF dcs IS
   ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

   SIGNAL clk0_ipd         : std_logic := 'X';
   SIGNAL clk1_ipd         : std_logic := 'X';
   SIGNAL sel_ipd         : std_logic := 'X';
   SIGNAL sel_int1        : std_logic := '0';
   SIGNAL sel_int2        : std_logic := '0';
   SIGNAL sel_int3        : std_logic_vector(1 downto 0) := "00";
   SIGNAL dcsout_int1         : std_logic := '0';
   SIGNAL sel_int4        : std_logic := '0';
   SIGNAL sel_int5        : std_logic := '0';
   SIGNAL sel_int6        : std_logic_vector(1 downto 0) := "00";
   SIGNAL dcsout_int2         : std_logic := '0';
   SIGNAL sel_int7        : std_logic := '0';
   SIGNAL sel_int8        : std_logic := '0';
   SIGNAL sel_int9        : std_logic := '0';
   SIGNAL sel_int10       : std_logic := '0';
   SIGNAL dcsout_int3         : std_logic := '0';

BEGIN

   ---------------------
   --  input path delays
   ---------------------
   WireDelay : BLOCK
   BEGIN
   VitalWireDelay (clk0_ipd, clk0, tipd_clk0);
   VitalWireDelay (clk1_ipd, clk1, tipd_clk1);
   VitalWireDelay (sel_ipd, sel, tipd_sel);
   END BLOCK;
   --------------------
   --  behavior section
   --------------------
   P1 : PROCESS (clk0_ipd, clk1_ipd)
   BEGIN
        IF (clk0_ipd'event and clk0_ipd = '0') THEN
           IF (sel_ipd = '1') THEN
              sel_int1 <= sel_ipd;
           END IF;
--           ELSIF (sel_ipd = '0') THEN
           IF (sel_int1 = '0') THEN
              sel_int2 <= sel_int1;
           END IF;
        END IF;
        IF (clk1_ipd'event and clk1_ipd = '0') THEN
           IF (sel_ipd = '0') THEN
              sel_int1 <= sel_ipd;
           END IF;
--           ELSIF (sel_ipd = '1') THEN
           IF (sel_int1 = '1') THEN
              sel_int2 <= sel_int1;
           END IF;
        END IF;
   END PROCESS;       

   sel_int3 <= (sel_int2, sel_int1);

   P2 : PROCESS (clk0_ipd, clk1_ipd, sel_int3)
   BEGIN
        case sel_int3 is
           when "00" => dcsout_int1 <= clk0_ipd;
           when "01" => dcsout_int1 <= '0';
           when "10" => dcsout_int1 <= '0';
           when "11" => dcsout_int1 <= clk1_ipd;
           when others => NULL;
        end case;
   END PROCESS;

   P3 : PROCESS (clk0_ipd, clk1_ipd)
   BEGIN
        IF (clk0_ipd'event and clk0_ipd = '1') THEN
           IF (sel_ipd = '1') THEN
              sel_int4 <= sel_ipd;
           END IF;
           IF (sel_int4 = '0') THEN
              sel_int5 <= sel_int4;
           END IF;
        END IF;
        IF (clk1_ipd'event and clk1_ipd = '1') THEN
           IF (sel_ipd = '0') THEN
              sel_int4 <= sel_ipd;
           END IF;
           IF (sel_int4 = '1') THEN
              sel_int5 <= sel_int4;
           END IF;
        END IF;
   END PROCESS;

   sel_int6 <= (sel_int5, sel_int4);

   P4 : PROCESS (clk0_ipd, clk1_ipd, sel_int6)
   BEGIN
        case sel_int6 is
           when "00" => dcsout_int2 <= clk0_ipd;
           when "01" => dcsout_int2 <= '1';
           when "10" => dcsout_int2 <= '1';
           when "11" => dcsout_int2 <= clk1_ipd;
           when others => NULL;
        end case;
   END PROCESS;

   P7 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd'event and clk1_ipd = '0') THEN
            sel_int7 <= sel_ipd;
      END IF;
   END PROCESS;

   P8 : PROCESS (clk0_ipd)
   BEGIN
      IF (clk0_ipd'event and clk0_ipd = '0') THEN
            sel_int8 <= sel_ipd;
      END IF;
   END PROCESS;

   P9 : PROCESS (clk1_ipd)
   BEGIN
      IF (clk1_ipd'event and clk1_ipd = '1') THEN
            sel_int9 <= sel_ipd;
      END IF;
   END PROCESS;

   P10 : PROCESS (clk0_ipd)
   BEGIN
      IF (clk0_ipd'event and clk0_ipd = '1') THEN
            sel_int10 <= sel_ipd;
      END IF;
   END PROCESS;

   P11 : PROCESS (clk0_ipd, clk1_ipd, sel_ipd, sel_int7, sel_int8, sel_int9, sel_int10)
   BEGIN
      IF (DCSMODE = "HIGH_LOW") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, '0'),
                           dselect => (0 => sel_int7));
      ELSIF (DCSMODE = "HIGH_HIGH") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, '1'),
                           dselect => (0 => sel_int9));
      ELSIF (DCSMODE = "LOW_LOW") THEN
        dcsout_int3 <= vitalmux 
                          (data => ('0', clk0_ipd),
                           dselect => (0 => sel_int8));
      ELSIF (DCSMODE = "LOW_HIGH") THEN
        dcsout_int3 <= vitalmux 
                          (data => ('1', clk0_ipd),
                           dselect => (0 => sel_int10));
      ELSIF (DCSMODE = "CLK0") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk0_ipd, clk0_ipd),
                           dselect => (0 => sel_ipd));
      ELSIF (DCSMODE = "CLK1") THEN
        dcsout_int3 <= vitalmux 
                          (data => (clk1_ipd, clk1_ipd),
                           dselect => (0 => sel_ipd));
      END IF;
   END PROCESS;

   VitalBehavior : PROCESS (dcsout_int1, dcsout_int2, dcsout_int3)

   -- functionality results
   VARIABLE results : std_logic_vector(1 to 1) := (others => 'X');
   ALIAS dcsout_zd       : std_ulogic IS results(1);

   BEGIN

      -------------------------
      --  functionality section
      -------------------------
   IF (DCSMODE = "NEG") THEN
      dcsout_zd := dcsout_int1;
   ELSIF (DCSMODE = "POS") THEN
      dcsout_zd := dcsout_int2;
   ELSE
      dcsout_zd := dcsout_int3;
   END IF;       

   dcsout <= dcsout_zd;

END PROCESS;

END v;


--
-----cell sp16ka----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY sp16ka IS
   GENERIC (
        DATA_WIDTH               : Integer  := 18;
        REGMODE                  : String  := "NOREG";
        RESETMODE                : String  := "SYNC";
        CSDECODE                 : std_logic_vector(2 downto 0)  := "000";
        WRITEMODE                : String  := "NORMAL";
        GSR                      : String  := "DISABLED";
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
        initval_3f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

   PORT(
        di0, di1, di2, di3, di4, di5, di6, di7, di8            : in std_logic := 'X';
        di9, di10, di11, di12, di13, di14, di15, di16, di17    : in std_logic := 'X';
        ad0, ad1, ad2, ad3, ad4, ad5, ad6, ad7, ad8            : in std_logic := 'X';
        ad9, ad10, ad11, ad12, ad13                                : in std_logic := 'X';
        ce, clk, we, cs0, cs1, cs2, rst                         : in std_logic := 'X';

        do0, do1, do2, do3, do4, do5, do6, do7, do8            : out std_logic := 'X';
        do9, do10, do11, do12, do13, do14, do15, do16, do17    : out std_logic := 'X'
  );

      ATTRIBUTE Vital_Level0 OF sp16ka : ENTITY IS TRUE;

END sp16ka ;

architecture V of sp16ka is

signal lo: std_logic := '0';
signal hi: std_logic := '1';

component dp16ka
GENERIC(
        DATA_WIDTH_A : in Integer;
        DATA_WIDTH_B : in Integer;
        REGMODE_A    : in String;
        REGMODE_B    : in String;
        RESETMODE    : in String;
        CSDECODE_A   : in std_logic_vector(2 downto 0);
        CSDECODE_B   : in std_logic_vector(2 downto 0);
        WRITEMODE_A  : in String;
        WRITEMODE_B  : in String;
        GSR : in String;
        initval_00 : in string;
        initval_01 : in string;
        initval_02 : in string;
        initval_03 : in string;
        initval_04 : in string;
        initval_05 : in string;
        initval_06 : in string;
        initval_07 : in string;
        initval_08 : in string;
        initval_09 : in string;
        initval_0a : in string;
        initval_0b : in string;
        initval_0c : in string;
        initval_0d : in string;
        initval_0e : in string;
        initval_0f : in string;
        initval_10 : in string;
        initval_11 : in string;
        initval_12 : in string;
        initval_13 : in string;
        initval_14 : in string;
        initval_15 : in string;
        initval_16 : in string;
        initval_17 : in string;
        initval_18 : in string;
        initval_19 : in string;
        initval_1a : in string;
        initval_1b : in string;
        initval_1c : in string;
        initval_1d : in string;
        initval_1e : in string;
        initval_1f : in string;
        initval_20 : in string;
        initval_21 : in string;
        initval_22 : in string;
        initval_23 : in string;
        initval_24 : in string;
        initval_25 : in string;
        initval_26 : in string;
        initval_27 : in string;
        initval_28 : in string;
        initval_29 : in string;
        initval_2a : in string;
        initval_2b : in string;
        initval_2c : in string;
        initval_2d : in string;
        initval_2e : in string;
        initval_2f : in string;
        initval_30 : in string;
        initval_31 : in string;
        initval_32 : in string;
        initval_33 : in string;
        initval_34 : in string;
        initval_35 : in string;
        initval_36 : in string;
        initval_37 : in string;
        initval_38 : in string;
        initval_39 : in string;
        initval_3a : in string;
        initval_3b : in string;
        initval_3c : in string;
        initval_3d : in string;
        initval_3e : in string;
        initval_3f : in string);

PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic;
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic;
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic;
        ada9, ada10, ada11, ada12, ada13                                : in std_logic;
        cea, clka, wea, csa0, csa1, csa2, rsta                         : in std_logic;
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic;
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic;
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic;
        adb9, adb10, adb11, adb12, adb13                                : in std_logic;
        ceb, clkb, web, csb0, csb1, csb2, rstb                         : in std_logic;

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic;
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic;
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic;
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic
  );
END COMPONENT;

begin
    -- component instantiation statements
  dp16ka_inst : dp16ka
  generic map (DATA_WIDTH_A => DATA_WIDTH,
               DATA_WIDTH_B => DATA_WIDTH,
               REGMODE_A    => REGMODE,
               REGMODE_B    => REGMODE,
               RESETMODE    => RESETMODE,
               CSDECODE_A   => CSDECODE,
               CSDECODE_B   => CSDECODE,
               WRITEMODE_A  => WRITEMODE,
               WRITEMODE_B  => WRITEMODE,
               GSR => GSR,
        initval_00 => initval_00,
        initval_01 => initval_01,
        initval_02 => initval_02,
        initval_03 => initval_03,
        initval_04 => initval_04,
        initval_05 => initval_05,
        initval_06 => initval_06,
        initval_07 => initval_07,
        initval_08 => initval_08,
        initval_09 => initval_09,
        initval_0a => initval_0a,
        initval_0b => initval_0b,
        initval_0c => initval_0c,
        initval_0d => initval_0d,
        initval_0e => initval_0e,
        initval_0f => initval_0f,
        initval_10 => initval_10,
        initval_11 => initval_11,
        initval_12 => initval_12,
        initval_13 => initval_13,
        initval_14 => initval_14,
        initval_15 => initval_15,
        initval_16 => initval_16,
        initval_17 => initval_17,
        initval_18 => initval_18,
        initval_19 => initval_19,
        initval_1a => initval_1a,
        initval_1b => initval_1b,
        initval_1c => initval_1c,
        initval_1d => initval_1d,
        initval_1e => initval_1e,
        initval_1f => initval_1f,
        initval_20 => initval_20,
        initval_21 => initval_21,
        initval_22 => initval_22,
        initval_23 => initval_23,
        initval_24 => initval_24,
        initval_25 => initval_25,
        initval_26 => initval_26,
        initval_27 => initval_27,
        initval_28 => initval_28,
        initval_29 => initval_29,
        initval_2a => initval_2a,
        initval_2b => initval_2b,
        initval_2c => initval_2c,
        initval_2d => initval_2d,
        initval_2e => initval_2e,
        initval_2f => initval_2f,
        initval_30 => initval_30,
        initval_31 => initval_31,
        initval_32 => initval_32,
        initval_33 => initval_33,
        initval_34 => initval_34,
        initval_35 => initval_35,
        initval_36 => initval_36,
        initval_37 => initval_37,
        initval_38 => initval_38,
        initval_39 => initval_39,
        initval_3a => initval_3a,
        initval_3b => initval_3b,
        initval_3c => initval_3c,
        initval_3d => initval_3d,
        initval_3e => initval_3e,
        initval_3f => initval_3f)
  port map (dia0 => di0, dia1 => di1, dia2 => di2, dia3 => di3,
  dia4 => di4, dia5 => di5, dia6 => di6, dia7 => di7, dia8 => di8,
  dia9 => di9, dia10 => di10, dia11 => di11, dia12 => di12, dia13 => di13,
  dia14 => di14, dia15 => di15, dia16 => di16, dia17 => di17, dib0 => lo,
  dib1 => lo, dib2 => lo, dib3 => lo, dib4 => lo, dib5 => lo,
  dib6 => lo, dib7 => lo, dib8 => lo, dib9 => lo, dib10 => lo,
  dib11 => lo, dib12 => lo, dib13 => lo, dib14 => lo, dib15 => lo,
  dib16 => lo, dib17 => lo,
  cea => ce, clka => clk, wea => we, csa0 => cs0, csa1 => cs1, csa2 => cs2,
  rsta => rst, ada0 => ad0, ada1 => ad1, ada2 => ad2, ada3 => ad3,
  ada4 => ad4, ada5 => ad5, ada6 => ad6, ada7 => ad7, ada8 => ad8,
  ada9 => ad9, ada10 => ad10, ada11 => ad11, ada12 => ad12, ada13 => ad13,
  ceb => lo, clkb => lo, web => lo, csb0 => lo, csb1 => lo, csb2 => lo,
  rstb => hi, adb0 => lo, adb1 => lo, adb2 => lo, adb3 => lo,
  adb4 => lo, adb5 => lo, adb6 => lo, adb7 => lo, adb8 => lo,
  adb9 => lo, adb10 => lo, adb11 => lo, adb12 => lo, adb13 => lo,
  dob0 => open, dob1 => open, dob2 => open, dob3 => open,
  dob4 => open, dob5 => open, dob6 => open, dob7 => open, dob8 => open,
  dob9 => open, dob10 => open, dob11 => open, dob12 => open, dob13 => open,
  dob14 => open, dob15 => open, dob16 => open, dob17 => open, doa0 => do0,
  doa1 => do1, doa2 => do2, doa3 => do3, doa4 => do4, doa5 => do5,
  doa6 => do6, doa7 => do7, doa8 => do8, doa9 => do9, doa10 => do10,
  doa11 => do11, doa12 => do12, doa13 => do13, doa14 => do14, doa15 => do15,
  doa16 => do16, doa17 => do17);

end V;

--
-----cell pdp16ka----
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use ieee.std_logic_unsigned.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY pdp16ka IS
   GENERIC (
        DATA_WIDTH_W              : Integer  := 18;
        DATA_WIDTH_R              : Integer  := 18;
        REGMODE                   : String  := "NOREG";
        RESETMODE                  : String  := "SYNC";
        CSDECODE_W                 : std_logic_vector(2 downto 0)  := "000";
        CSDECODE_R                 : std_logic_vector(2 downto 0)  := "000";
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
        initval_3f : String := "0xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");

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

      ATTRIBUTE Vital_Level0 OF pdp16ka : ENTITY IS TRUE;

END pdp16ka ;

architecture V of pdp16ka is

signal lo: std_logic := '0';

component dp16ka
GENERIC(
        DATA_WIDTH_A : in Integer;
        DATA_WIDTH_B : in Integer;
        REGMODE_A    : in String;
        REGMODE_B    : in String;
        RESETMODE    : in String;
        CSDECODE_A   : in std_logic_vector(2 downto 0);
        CSDECODE_B   : in std_logic_vector(2 downto 0);
        GSR : in String;
        initval_00 : in string;
        initval_01 : in string;
        initval_02 : in string;
        initval_03 : in string;
        initval_04 : in string;
        initval_05 : in string;
        initval_06 : in string;
        initval_07 : in string;
        initval_08 : in string;
        initval_09 : in string;
        initval_0a : in string;
        initval_0b : in string;
        initval_0c : in string;
        initval_0d : in string;
        initval_0e : in string;
        initval_0f : in string;
        initval_10 : in string;
        initval_11 : in string;
        initval_12 : in string;
        initval_13 : in string;
        initval_14 : in string;
        initval_15 : in string;
        initval_16 : in string;
        initval_17 : in string;
        initval_18 : in string;
        initval_19 : in string;
        initval_1a : in string;
        initval_1b : in string;
        initval_1c : in string;
        initval_1d : in string;
        initval_1e : in string;
        initval_1f : in string;
        initval_20 : in string;
        initval_21 : in string;
        initval_22 : in string;
        initval_23 : in string;
        initval_24 : in string;
        initval_25 : in string;
        initval_26 : in string;
        initval_27 : in string;
        initval_28 : in string;
        initval_29 : in string;
        initval_2a : in string;
        initval_2b : in string;
        initval_2c : in string;
        initval_2d : in string;
        initval_2e : in string;
        initval_2f : in string;
        initval_30 : in string;
        initval_31 : in string;
        initval_32 : in string;
        initval_33 : in string;
        initval_34 : in string;
        initval_35 : in string;
        initval_36 : in string;
        initval_37 : in string;
        initval_38 : in string;
        initval_39 : in string;
        initval_3a : in string;
        initval_3b : in string;
        initval_3c : in string;
        initval_3d : in string;
        initval_3e : in string;
        initval_3f : in string);

PORT(
        dia0, dia1, dia2, dia3, dia4, dia5, dia6, dia7, dia8            : in std_logic;
        dia9, dia10, dia11, dia12, dia13, dia14, dia15, dia16, dia17    : in std_logic;
        ada0, ada1, ada2, ada3, ada4, ada5, ada6, ada7, ada8            : in std_logic;
        ada9, ada10, ada11, ada12, ada13                                : in std_logic;
        cea, clka, wea, csa0, csa1, csa2, rsta                          : in std_logic;
        dib0, dib1, dib2, dib3, dib4, dib5, dib6, dib7, dib8            : in std_logic;
        dib9, dib10, dib11, dib12, dib13, dib14, dib15, dib16, dib17    : in std_logic;
        adb0, adb1, adb2, adb3, adb4, adb5, adb6, adb7, adb8            : in std_logic;
        adb9, adb10, adb11, adb12, adb13                                : in std_logic;
        ceb, clkb, web, csb0, csb1, csb2, rstb                          : in std_logic;

        doa0, doa1, doa2, doa3, doa4, doa5, doa6, doa7, doa8            : out std_logic;
        doa9, doa10, doa11, doa12, doa13, doa14, doa15, doa16, doa17    : out std_logic;
        dob0, dob1, dob2, dob3, dob4, dob5, dob6, dob7, dob8            : out std_logic;
        dob9, dob10, dob11, dob12, dob13, dob14, dob15, dob16, dob17    : out std_logic
  );
END COMPONENT;

begin
    -- component instantiation statements
  dp16ka_inst : dp16ka
  generic map (DATA_WIDTH_A => DATA_WIDTH_W,
               DATA_WIDTH_B => DATA_WIDTH_R,
               REGMODE_A    => REGMODE,
               REGMODE_B    => REGMODE,
               RESETMODE    => RESETMODE,
               CSDECODE_A   => CSDECODE_W,
               CSDECODE_B   => CSDECODE_R,
               GSR => GSR,
        initval_00 => initval_00,
        initval_01 => initval_01,
        initval_02 => initval_02,
        initval_03 => initval_03,
        initval_04 => initval_04,
        initval_05 => initval_05,
        initval_06 => initval_06,
        initval_07 => initval_07,
        initval_08 => initval_08,
        initval_09 => initval_09,
        initval_0a => initval_0a,
        initval_0b => initval_0b,
        initval_0c => initval_0c,
        initval_0d => initval_0d,
        initval_0e => initval_0e,
        initval_0f => initval_0f,
        initval_10 => initval_10,
        initval_11 => initval_11,
        initval_12 => initval_12,
        initval_13 => initval_13,
        initval_14 => initval_14,
        initval_15 => initval_15,
        initval_16 => initval_16,
        initval_17 => initval_17,
        initval_18 => initval_18,
        initval_19 => initval_19,
        initval_1a => initval_1a,
        initval_1b => initval_1b,
        initval_1c => initval_1c,
        initval_1d => initval_1d,
        initval_1e => initval_1e,
        initval_1f => initval_1f,
        initval_20 => initval_20,
        initval_21 => initval_21,
        initval_22 => initval_22,
        initval_23 => initval_23,
        initval_24 => initval_24,
        initval_25 => initval_25,
        initval_26 => initval_26,
        initval_27 => initval_27,
        initval_28 => initval_28,
        initval_29 => initval_29,
        initval_2a => initval_2a,
        initval_2b => initval_2b,
        initval_2c => initval_2c,
        initval_2d => initval_2d,
        initval_2e => initval_2e,
        initval_2f => initval_2f,
        initval_30 => initval_30,
        initval_31 => initval_31,
        initval_32 => initval_32,
        initval_33 => initval_33,
        initval_34 => initval_34,
        initval_35 => initval_35,
        initval_36 => initval_36,
        initval_37 => initval_37,
        initval_38 => initval_38,
        initval_39 => initval_39,
        initval_3a => initval_3a,
        initval_3b => initval_3b,
        initval_3c => initval_3c,
        initval_3d => initval_3d,
        initval_3e => initval_3e,
        initval_3f => initval_3f)
  port map (dia0 => di0, dia1 => di1, dia2 => di2, dia3 => di3,
  dia4 => di4, dia5 => di5, dia6 => di6, dia7 => di7, dia8 => di8,
  dia9 => di9, dia10 => di10, dia11 => di11, dia12 => di12, dia13 => di13,
  dia14 => di14, dia15 => di15, dia16 => di16, dia17 => di17, dib0 => di18,
  dib1 => di19, dib2 => di20, dib3 => di21, dib4 => di22, dib5 => di23,
  dib6 => di24, dib7 => di25, dib8 => di26, dib9 => di27, dib10 => di28,
  dib11 => di29, dib12 => di30, dib13 => di31, dib14 => di32, dib15 => di33,
  dib16 => di34, dib17 => di35,
  cea => cew, clka => clkw, wea => we, csa0 => csw0, csa1 => csw1, csa2 => csw2,
  rsta => rst, ada0 => adw0, ada1 => adw1, ada2 => adw2, ada3 => adw3,
  ada4 => adw4, ada5 => adw5, ada6 => adw6, ada7 => adw7, ada8 => adw8,
  ada9 => adw9, ada10 => adw10, ada11 => adw11, ada12 => adw12, ada13 => adw13,
  ceb => cer, clkb => clkr, web => lo, csb0 => csr0, csb1 => csr1, csb2 => csr2,
  rstb => rst, adb0 => adr0, adb1 => adr1, adb2 => adr2, adb3 => adr3,
  adb4 => adr4, adb5 => adr5, adb6 => adr6, adb7 => adr7, adb8 => adr8,
  adb9 => adr9, adb10 => adr10, adb11 => adr11, adb12 => adr12, adb13 => adr13,
  dob0 => do0, dob1 => do1, dob2 => do2, dob3 => do3,
  dob4 => do4, dob5 => do5, dob6 => do6, dob7 => do7, dob8 => do8,
  dob9 => do9, dob10 => do10, dob11 => do11, dob12 => do12, dob13 => do13,
  dob14 => do14, dob15 => do15, dob16 => do16, dob17 => do17, doa0 => do18,
  doa1 => do19, doa2 => do20, doa3 => do21, doa4 => do22, doa5 => do23,
  doa6 => do24, doa7 => do25, doa8 => do26, doa9 => do27, doa10 => do28,
  doa11 => do29, doa12 => do30, doa13 => do31, doa14 => do32, doa15 => do33,
  doa16 => do34, doa17 => do35);

end V;



--
----- cell ciddlla -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY ciddlla IS
   GENERIC (
      CLKOP_PHASE        : Integer   := 0;
      CLKOS_PHASE        : Integer   := 0;
      CLKOS_FPHASE       : Integer   := 0;
      CLKOP_DUTY50       : String    := "DISABLED";
      CLKOS_DUTY50       : String    := "DISABLED";
      CLKI_DIV           : Integer   := 1;
      CLKOS_DIV          : Integer   := 1;
      GSR                : String    := "DISABLED";
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      ALU_INIT_CNTVAL    : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0)  := "0000000000";
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "ciddlla";
      tipd_clki          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstn          : VitalDelayType01 := (0 ns, 0 ns));

    PORT (
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

    ATTRIBUTE Vital_Level0 OF ciddlla : ENTITY IS TRUE;

END ciddlla ;

-- architecture body --
ARCHITECTURE v OF ciddlla IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL clki_ipd   : std_logic := '0';
    SIGNAL clkfb_ipd  : std_logic := '0';
    SIGNAL rstn_ipd   : std_logic := '0';
    SIGNAL aluhold_ipd   : std_logic := '0';
    SIGNAL smiaddr9_ipd   : std_logic := '0';
    SIGNAL smiaddr8_ipd   : std_logic := '0';
    SIGNAL smiaddr7_ipd   : std_logic := '0';
    SIGNAL smiaddr6_ipd   : std_logic := '0';
    SIGNAL smiaddr5_ipd   : std_logic := '0';
    SIGNAL smiaddr4_ipd   : std_logic := '0';
    SIGNAL smiaddr3_ipd   : std_logic := '0';
    SIGNAL smiaddr2_ipd   : std_logic := '0';
    SIGNAL smiaddr1_ipd   : std_logic := '0';
    SIGNAL smiaddr0_ipd   : std_logic := '0';
    SIGNAL smird_ipd   : std_logic := '0';
    SIGNAL smiwr_ipd   : std_logic := '0';
    SIGNAL smiclk_ipd   : std_logic := '0';
    SIGNAL smiwdata_ipd   : std_logic := '0';
    SIGNAL smirstn_ipd   : std_logic := '0';
    SIGNAL false_clk     : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL t_180              : time := 0 ns;
    SIGNAL t_270              : time := 0 ns;
    SIGNAL t_360              : time := 0 ns;
    SIGNAL t_90               : time := 0 ns;
    SIGNAL t_45               : time := 0 ns;
    SIGNAL t_22               : time := 0 ns;
    SIGNAL t_11               : time := 0 ns;
    SIGNAL total_fb_delay     : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL lock_valid         : std_logic := '0';
    SIGNAL real_lock          : std_logic := '0';
    SIGNAL g_reset            : std_logic := '0';
    SIGNAL resetn             : std_logic := '0';
    SIGNAL set_resetn         : std_logic := '0';
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL clock_p            : std_logic := '0';
    SIGNAL clock_s            : std_logic := '0';
    SIGNAL clock_s_del        : std_logic := '0';
    SIGNAL clock_s_del_d2     : std_logic := '0';
    SIGNAL clock_s_del_d4     : std_logic := '0';
    SIGNAL clock_s_final      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL clkos_first_time   : std_logic := '1';
    SIGNAL lock_delay_reg     : time := 1 ns;

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(clki_ipd, clki, tipd_clki);
       VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
       VitalWireDelay(rstn_ipd, rstn, tipd_rstn);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   smirdata <= '0';

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (gsr =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   resetn <= g_reset and  rstn_ipd;

   G1 : PROCESS (clki_ipd, resetn)
   BEGIN
      IF (resetn = '0') THEN
         set_resetn <= resetn;
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         set_resetn <= resetn;
      END IF;
   END PROCESS;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
   clkos_first_time <= '0' after 15 ns;
   clkop_first_time <= '0' after 15 ns;

---------------------------------------------------------------------

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
--             IF (((t_in_clk - t_in_clk1) < 0.0001 ns) and ((t_in_clk - t_in_clk1) > -0.0001 ns)) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;

           IF (t_in_clk > 0 ps) THEN
             t_180 <= (t_in_clk / 2);
             t_90 <= (t_in_clk / 4);
             t_270 <= ((t_in_clk * 3)/ 4);
             t_360 <= t_in_clk;
             t_45 <= (t_in_clk / 8);
             t_22 <= (t_in_clk / 16);
             t_11 <= (t_in_clk / 32);
           END IF;
      END IF;
   END PROCESS;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      end if;
   END PROCESS;

   P1 : PROCESS (clki_ipd, lock_valid)
   BEGIN
      IF (lock_valid = '1') THEN
         clock_p <= transport clki_ipd after real_delay1;
         clock_s <= transport clki_ipd after real_delay1;
      END IF;
   END PROCESS;

   P2 : PROCESS (clki_ipd, clock_s)
   BEGIN
      IF (CLKOS_FPHASE = 0) THEN
         clock_s_del <= clock_s;
      ELSIF (CLKOS_FPHASE = 11) THEN
         clock_s_del <= transport clock_s after t_11;
      ELSIF (CLKOS_FPHASE = 22) THEN
         clock_s_del <= transport clock_s after t_22;
      ELSIF (CLKOS_FPHASE = 45) THEN
         clock_s_del <= transport clock_s after t_45;
      END IF;
   END PROCESS;

   P3 : PROCESS (clock_s_del, clock_s_del_d2)
   BEGIN
      IF (clock_s_del'event and clock_s_del = '1') THEN
         clock_s_del_d2 <= not clock_s_del_d2;
      END IF;
      IF (clock_s_del_d2'event and clock_s_del_d2 = '1') THEN
         clock_s_del_d4 <= not clock_s_del_d4;
      END IF;
   END PROCESS;

   P4 : PROCESS (clock_s_del, clock_s_del_d2, clock_s_del_d4)
   BEGIN
      IF (CLKOS_DIV = 1) THEN
         clock_s_final <= clock_s_del;
      ELSIF (CLKOS_DIV = 2) THEN
         clock_s_final <= clock_s_del_d2;
      ELSIF (CLKOS_DIV = 4) THEN
         clock_s_final <= clock_s_del_d4;
      END IF;
   END PROCESS;

   P5 : PROCESS (clock_p, lock_valid, false_clk, set_resetn)
   BEGIN
      IF (clkop_first_time = '1') THEN
         clkop <= false_clk;
      ELSIF (set_resetn = '0') THEN
         clkop <= '0';
      ELSIF (lock_valid = '1') THEN
         clkop <= clock_p;
      END IF;
   END PROCESS;

   P6 : PROCESS (clock_s_final, lock_valid, false_clk, set_resetn)
   BEGIN
      IF (clkos_first_time = '1') THEN
         clkos <= false_clk;
      ELSIF (set_resetn = '0') THEN
         clkos <= '0';
      ELSIF (lock_valid = '1') THEN
         clkos <= clock_s_final;
      END IF;
   END PROCESS;

   P7 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         lock_valid <= '0';
      ELSE 
         lock_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '1') THEN
         real_lock <= transport clock_valid after (LOCK_DELAY * lock_delay_reg);
      END IF;
   END PROCESS;

   lock <= real_lock;

END v;


--
----- cell sdcdlla -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY sdcdlla IS
   GENERIC (
      CLKOS_FPHASE       : Integer   := 0;
      CLKI_DIV           : Integer   := 1;
      CLKOS_DIV          : Integer   := 1;
      GSR                : String    := "DISABLED";
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      DCNTL_ADJVAL       : Integer   := 0;
      ALU_INIT_CNTVAL    : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0)  := "0000000000";
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "sdcdlla";
      tipd_clki          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb         : VitalDelayType01 := (0 ns, 0 ns);
      tipd_uddcntl       : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstn          : VitalDelayType01 := (0 ns, 0 ns));

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

    ATTRIBUTE Vital_Level0 OF sdcdlla : ENTITY IS TRUE;

END sdcdlla ;

-- architecture body --
ARCHITECTURE v OF sdcdlla IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL clki_ipd   : std_logic := '0';
    SIGNAL clkfb_ipd  : std_logic := '0';
    SIGNAL rstn_ipd   : std_logic := '0';
    SIGNAL aluhold_ipd   : std_logic := '0';
    SIGNAL uddcntl_ipd   : std_logic := '0';
    SIGNAL smiaddr9_ipd   : std_logic := '0';
    SIGNAL smiaddr8_ipd   : std_logic := '0';
    SIGNAL smiaddr7_ipd   : std_logic := '0';
    SIGNAL smiaddr6_ipd   : std_logic := '0';
    SIGNAL smiaddr5_ipd   : std_logic := '0';
    SIGNAL smiaddr4_ipd   : std_logic := '0';
    SIGNAL smiaddr3_ipd   : std_logic := '0';
    SIGNAL smiaddr2_ipd   : std_logic := '0';
    SIGNAL smiaddr1_ipd   : std_logic := '0';
    SIGNAL smiaddr0_ipd   : std_logic := '0';
    SIGNAL smird_ipd   : std_logic := '0';
    SIGNAL smiwr_ipd   : std_logic := '0';
    SIGNAL smiclk_ipd   : std_logic := '0';
    SIGNAL smiwdata_ipd   : std_logic := '0';
    SIGNAL smirstn_ipd   : std_logic := '0';
    SIGNAL false_clk     : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL t_180              : time := 0 ns;
    SIGNAL t_270              : time := 0 ns;
    SIGNAL t_360              : time := 0 ns;
    SIGNAL t_90               : time := 0 ns;
    SIGNAL t_45               : time := 0 ns;
    SIGNAL t_22               : time := 0 ns;
    SIGNAL t_11               : time := 0 ns;
    SIGNAL delta              : time := 0.02 ns;
    SIGNAL total_fb_delay     : time := 0 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL lock_valid         : std_logic := '0';
    SIGNAL real_lock          : std_logic := '0';
    SIGNAL g_reset            : std_logic := '0';
    SIGNAL resetn             : std_logic := '0';
    SIGNAL set_resetn         : std_logic := '0';
    SIGNAL ratio1             : Integer   := 0;
    SIGNAL virtual_delay1     : time := 0 ps;
    SIGNAL real_delay1        : time := 0 ps;
    SIGNAL clock_p            : std_logic := '0';
    SIGNAL clock_s            : std_logic := '0';
    SIGNAL clock_s_del        : std_logic := '0';
    SIGNAL clock_s_del_d2     : std_logic := '0';
    SIGNAL clock_s_del_d4     : std_logic := '0';
    SIGNAL clock_s_final      : std_logic := '0';
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL clkos_first_time   : std_logic := '1';
    SIGNAL cntl_valid         : std_logic := '0';
    SIGNAL cntl_ratio         : integer := 0;
    SIGNAL cntl_reg           : std_logic_vector(8 downto 0) := "000000000";
    SIGNAL cntl_reg_update    : std_logic_vector(8 downto 0) := "000000000";
    SIGNAL lock_delay_reg     : time := 1 ns;

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(clki_ipd, clki, tipd_clki);
       VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
       VitalWireDelay(rstn_ipd, rstn, tipd_rstn);
       VitalWireDelay(uddcntl_ipd, uddcntl, tipd_uddcntl);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   smirdata <= '0';

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (gsr =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   resetn <= g_reset and  rstn_ipd;

   G1 : PROCESS (clki_ipd, resetn)
   BEGIN
      IF (resetn = '0') THEN
         set_resetn <= resetn;
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         set_resetn <= resetn;
      END IF;
   END PROCESS;

--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
   clkos_first_time <= '0' after 15 ns;
   clkop_first_time <= '0' after 15 ns;

---------------------------------------------------------------------

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;
         total_fb_delay <= first_fb_edge - first_int_edge ;
   END PROCESS;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
--             IF (((t_in_clk - t_in_clk1) < 0.0001 ns) and ((t_in_clk - t_in_clk1) > -0.0001 ns)) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;

           IF (t_in_clk > 0 ps) THEN
             t_180 <= (t_in_clk / 2);
             t_90 <= (t_in_clk / 4);
             t_270 <= ((t_in_clk * 3)/ 4);
             t_360 <= t_in_clk;
             t_45 <= (t_in_clk / 8);
             t_22 <= (t_in_clk / 16);
             t_11 <= (t_in_clk / 32);
           END IF;
      END IF;
   END PROCESS;

   S1 : PROCESS (clki_ipd, t_90)
   BEGIN
      IF (t_90 > 0 ps) THEN
         cntl_ratio <= (t_90 / delta);
      END IF;
   END PROCESS;

   cntl_reg <= CONV_STD_LOGIC_VECTOR(cntl_ratio, 9);

   S2 : PROCESS (cntl_reg, uddcntl_ipd, clock_valid)
   BEGIN
      IF (clock_valid = '1' and cntl_valid = '1') THEN
         IF (uddcntl_ipd = '1') THEN
            cntl_reg_update <= cntl_reg;
            cntl_valid <= '0';
         END IF;
      END IF;
   END PROCESS;

   (dcntl8, dcntl7, dcntl6, dcntl5, dcntl4, dcntl3, dcntl2, dcntl1, dcntl0) <= cntl_reg_update;

   DELAY1 : PROCESS (total_fb_delay, t_in_clk, ratio1, virtual_delay1)
   BEGIN
      IF ((total_fb_delay > 0 ps) and (t_in_clk > 0 ps)) THEN
          ratio1 <= total_fb_delay / t_in_clk;
          virtual_delay1 <= total_fb_delay - (t_in_clk * ratio1);
          real_delay1 <= t_in_clk - virtual_delay1 ;
      end if;
   END PROCESS;

   P1 : PROCESS (clki_ipd, lock_valid)
   BEGIN
      IF (lock_valid = '1') THEN
         clock_p <= transport clki_ipd after real_delay1;
         clock_s <= transport clki_ipd after real_delay1;
      END IF;
   END PROCESS;

   P2 : PROCESS (clki_ipd, clock_s)
   BEGIN
      IF (CLKOS_FPHASE = 0) THEN
         clock_s_del <= clock_s;
      ELSIF (CLKOS_FPHASE = 11) THEN
         clock_s_del <= transport clock_s after t_11;
      ELSIF (CLKOS_FPHASE = 22) THEN
         clock_s_del <= transport clock_s after t_22;
      ELSIF (CLKOS_FPHASE = 45) THEN
         clock_s_del <= transport clock_s after t_45;
      END IF;
   END PROCESS;

   P3 : PROCESS (clock_s_del, clock_s_del_d2)
   BEGIN
      IF (clock_s_del'event and clock_s_del = '1') THEN
         clock_s_del_d2 <= not clock_s_del_d2;
      END IF;
      IF (clock_s_del_d2'event and clock_s_del_d2 = '1') THEN
         clock_s_del_d4 <= not clock_s_del_d4;
      END IF;
   END PROCESS;

   P4 : PROCESS (clock_s_del, clock_s_del_d2, clock_s_del_d4)
   BEGIN
      IF (CLKOS_DIV = 1) THEN
         clock_s_final <= clock_s_del;
      ELSIF (CLKOS_DIV = 2) THEN
         clock_s_final <= clock_s_del_d2;
      ELSIF (CLKOS_DIV = 4) THEN
         clock_s_final <= clock_s_del_d4;
      END IF;
   END PROCESS;

   P5 : PROCESS (clock_p, lock_valid, false_clk, set_resetn)
   BEGIN
      IF (clkop_first_time = '1') THEN
         clkop <= false_clk;
      ELSIF (set_resetn = '0') THEN
         clkop <= '0';
      ELSIF (lock_valid = '1') THEN
         clkop <= clock_p;
      END IF;
   END PROCESS;

   P6 : PROCESS (clock_s_final, lock_valid, false_clk, set_resetn)
   BEGIN
      IF (clkos_first_time = '1') THEN
         clkos <= false_clk;
      ELSIF (set_resetn = '0') THEN
         clkos <= '0';
      ELSIF (lock_valid = '1') THEN
         clkos <= clock_s_final;
      END IF;
   END PROCESS;

   P7 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         lock_valid <= '0';
      ELSE 
         lock_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '1') THEN
         real_lock <= transport clock_valid after (LOCK_DELAY * lock_delay_reg);
      END IF;
   END PROCESS;

   lock <= real_lock;

END v;



--
----- cell trdlla -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY trdlla IS
   GENERIC (
      CLKOP_PHASE        : Integer   := 0;
      CLKOS_PHASE        : Integer   := 0;
      CLKOS_FPHASE       : Integer   := 0;
      CLKOS_DIV          : Integer   := 1;
      CLKOP_DUTY50       : String    := "DISABLED";
      CLKOS_DUTY50       : String    := "DISABLED";
      GSR                : String    := "DISABLED";
      CLKOS_FPHASE_ADJVAL : Integer  := 0;
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      DCNTL_ADJVAL       : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0)  := "0000000000";
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "trdlla";
      tipd_clki          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_aluhold       : VitalDelayType01 := (0 ns, 0 ns);
      tipd_uddcntl       : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstn          : VitalDelayType01 := (0 ns, 0 ns));

    PORT (
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

    ATTRIBUTE Vital_Level0 OF trdlla : ENTITY IS TRUE;

END trdlla ;

-- architecture body --
ARCHITECTURE v OF trdlla IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL clki_ipd   : std_logic := '0';
    SIGNAL rstn_ipd   : std_logic := '0';
    SIGNAL aluhold_ipd   : std_logic := '0';
    SIGNAL uddcntl_ipd   : std_logic := '0';
    SIGNAL smiaddr9_ipd   : std_logic := '0';
    SIGNAL smiaddr8_ipd   : std_logic := '0';
    SIGNAL smiaddr7_ipd   : std_logic := '0';
    SIGNAL smiaddr6_ipd   : std_logic := '0';
    SIGNAL smiaddr5_ipd   : std_logic := '0';
    SIGNAL smiaddr4_ipd   : std_logic := '0';
    SIGNAL smiaddr3_ipd   : std_logic := '0';
    SIGNAL smiaddr2_ipd   : std_logic := '0';
    SIGNAL smiaddr1_ipd   : std_logic := '0';
    SIGNAL smiaddr0_ipd   : std_logic := '0';
    SIGNAL smird_ipd   : std_logic := '0';
    SIGNAL smiwr_ipd   : std_logic := '0';
    SIGNAL smiclk_ipd   : std_logic := '0';
    SIGNAL smiwdata_ipd   : std_logic := '0';
    SIGNAL smirstn_ipd   : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL t_180              : time := 0 ns;
    SIGNAL t_270              : time := 0 ns;
    SIGNAL t_360              : time := 0 ns;
    SIGNAL t_90               : time := 0 ns;
    SIGNAL t_45               : time := 0 ns;
    SIGNAL t_22               : time := 0 ns;
    SIGNAL t_11               : time := 0 ns;
    SIGNAL delta              : time := 0.02 ns;
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL real_lock          : std_logic := '0';
    SIGNAL lock_valid         : std_logic := '0';
    SIGNAL g_reset            : std_logic := '0';
    SIGNAL resetn             : std_logic := '0';
    SIGNAL set_resetn         : std_logic := '0';
    SIGNAL clock_p            : std_logic := '0';
    SIGNAL clock_s            : std_logic := '0';
    SIGNAL clock_s_del        : std_logic := '0';
    SIGNAL clock_s_del_d2     : std_logic := '0';
    SIGNAL clock_s_del_d4     : std_logic := '0';
    SIGNAL clock_s_final      : std_logic := '0';
    SIGNAL cntl_ratio         : integer := 0;
    SIGNAL cntl_reg           : std_logic_vector(8 downto 0) := "000000000";
    SIGNAL cntl_reg_update    : std_logic_vector(8 downto 0) := "000000000";
    SIGNAL cntl_reg_final     : std_logic_vector(8 downto 0) := "000000000";
    SIGNAL lock_delay_reg     : time := 1 ns;

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(clki_ipd, clki, tipd_clki);
       VitalWireDelay(rstn_ipd, rstn, tipd_rstn);
       VitalWireDelay(aluhold_ipd, aluhold, tipd_aluhold);
       VitalWireDelay(uddcntl_ipd, uddcntl, tipd_uddcntl);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   smirdata <= '0';

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (gsr =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   resetn <= g_reset and  rstn_ipd;

   G1 : PROCESS (clki_ipd, resetn)
   BEGIN
      IF (resetn = '0') THEN
         set_resetn <= resetn;
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         set_resetn <= resetn;
      END IF;
   END PROCESS;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
--             IF (((t_in_clk - t_in_clk1) < 0.0001 ns) and ((t_in_clk - t_in_clk1) > -0.0001 ns)) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;

           IF (t_in_clk > 0 ps) THEN
             t_180 <= (t_in_clk / 2);
             t_90 <= (t_in_clk / 4);
             t_270 <= ((t_in_clk * 3)/ 4);
             t_360 <= t_in_clk;
             t_45 <= (t_in_clk / 8);
             t_22 <= (t_in_clk / 16);
             t_11 <= (t_in_clk / 32);
           END IF;
      END IF;
      
   END PROCESS;

   S1 : PROCESS (clki_ipd, t_90)
   BEGIN
      IF (t_90 > 0 ps) THEN
         cntl_ratio <= (t_90 / delta);
      END IF;
   END PROCESS;

   cntl_reg <= CONV_STD_LOGIC_VECTOR(cntl_ratio, 9);

   S2 : PROCESS (cntl_reg, uddcntl_ipd, clock_valid)
   BEGIN
      IF (clock_valid = '1') THEN
         IF (uddcntl_ipd = '1') THEN
            cntl_reg_update <= cntl_reg;
         END IF;
      END IF;
   END PROCESS;

   S3 : PROCESS (set_resetn, cntl_reg_update)
   BEGIN
      IF (set_resetn = '0') THEN
         cntl_reg_final <= (others => '0'); 
      ELSE
         cntl_reg_final <= cntl_reg_update;
      END IF;
   END PROCESS;

   (dcntl8, dcntl7, dcntl6, dcntl5, dcntl4, dcntl3, dcntl2, dcntl1, dcntl0) <= cntl_reg_final;

   P7 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         lock_valid <= '0';
      ELSE
         lock_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '1') THEN
         real_lock <= transport clock_valid after (LOCK_DELAY * lock_delay_reg);
      END IF;
   END PROCESS;

   P1 : PROCESS (clki_ipd, lock_valid)
   BEGIN
      IF (CLKOP_PHASE = 0) THEN
         IF (lock_valid = '1') THEN
            clock_p <= clki_ipd;
         ELSIF (lock_valid = '0') THEN
            clock_p <= '0';
         END IF;
      ELSIF (CLKOP_PHASE = 90) THEN
         IF (lock_valid = '1') THEN
            clock_p <= transport clki_ipd after t_90;
         ELSIF (lock_valid = '0') THEN
            clock_p <= '0';
         END IF;
      ELSIF (CLKOP_PHASE = 180) THEN
         IF (lock_valid = '1') THEN
            clock_p <= transport clki_ipd after t_180;
         ELSIF (lock_valid = '0') THEN
            clock_p <= '0';
         END IF;
      ELSIF (CLKOP_PHASE = 270) THEN
         IF (lock_valid = '1') THEN
            clock_p <= transport clki_ipd after t_270;
         ELSIF (lock_valid = '0') THEN
            clock_p <= '0';
         END IF;
      ELSIF (CLKOP_PHASE = 360) THEN
         IF (lock_valid = '1') THEN
            clock_p <= transport clki_ipd after t_360;
         ELSIF (lock_valid = '0') THEN
            clock_p <= '0';
         END IF;
      END IF;
   END PROCESS;

   P11 : PROCESS (clki_ipd, lock_valid)
   BEGIN
      IF (CLKOS_PHASE = 0) THEN
         IF (lock_valid = '1') THEN
            clock_s <= clki_ipd;
         ELSIF (lock_valid = '0') THEN
            clock_s <= '0';
         END IF;
      ELSIF (CLKOS_PHASE = 90) THEN
         IF (lock_valid = '1') THEN
            clock_s <= transport clki_ipd after t_90;
         ELSIF (lock_valid = '0') THEN
            clock_s <= '0';
         END IF;
      ELSIF (CLKOS_PHASE = 180) THEN
         IF (lock_valid = '1') THEN
            clock_s <= transport clki_ipd after t_180;
         ELSIF (lock_valid = '0') THEN
            clock_s <= '0';
         END IF;
      ELSIF (CLKOS_PHASE = 270) THEN
         IF (lock_valid = '1') THEN
            clock_s <= transport clki_ipd after t_270;
         ELSIF (lock_valid = '0') THEN
            clock_s <= '0';
         END IF;
      ELSIF (CLKOS_PHASE = 360) THEN
         IF (lock_valid = '1') THEN
            clock_s <= transport clki_ipd after t_360;
         ELSIF (lock_valid = '0') THEN
            clock_s <= '0';
         END IF;
      END IF;
   END PROCESS;

   P2 : PROCESS (clki_ipd, clock_s)
   BEGIN
      IF (CLKOS_FPHASE = 0) THEN
         clock_s_del <= clock_s;
      ELSIF (CLKOS_FPHASE = 11) THEN
         clock_s_del <= transport clock_s after t_11;
      ELSIF (CLKOS_FPHASE = 22) THEN
         clock_s_del <= transport clock_s after t_22;
      ELSIF (CLKOS_FPHASE = 45) THEN
         clock_s_del <= transport clock_s after t_45;
      END IF;
   END PROCESS;

   P3 : PROCESS (clock_s_del, clock_s_del_d2)
   BEGIN
      IF (clock_s_del'event and clock_s_del = '1') THEN
         clock_s_del_d2 <= not clock_s_del_d2;
      END IF;
      IF (clock_s_del_d2'event and clock_s_del_d2 = '1') THEN
         clock_s_del_d4 <= not clock_s_del_d4;
      END IF;
   END PROCESS;

   P4 : PROCESS (clock_s_del, clock_s_del_d2, clock_s_del_d4)
   BEGIN
      IF (CLKOS_DIV = 1) THEN
         clock_s_final <= clock_s_del;
      ELSIF (CLKOS_DIV = 2) THEN
         clock_s_final <= clock_s_del_d2;
      ELSIF (CLKOS_DIV = 4) THEN
         clock_s_final <= clock_s_del_d4;
      END IF;
   END PROCESS;

   S12 : PROCESS (clock_s_final, lock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         clkos <= '0';
      ELSIF (lock_valid = '1') THEN
         clkos <= clock_s_final;
      END IF;
   END PROCESS;

   S13 : PROCESS (clock_p, lock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         clkop <= '0';
      ELSIF (lock_valid = '1') THEN
         clkop <= clock_p;
      END IF;
   END PROCESS;

   lock <= real_lock;

END v;



--
----- cell cimdlla -----
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.vital_timing.all;
use ieee.vital_primitives.all;
use work.global.gsrnet;
use work.global.purnet;
use work.mem3.all;

-- entity declaration --
ENTITY cimdlla IS
   GENERIC (
      CLKOS_FPHASE       : Integer   := 0;
      CLKOS_DIV          : Integer   := 1;
      GSR                : String    := "DISABLED";
      ALU_LOCK_CNT       : Integer   := 3;
      ALU_UNLOCK_CNT     : Integer   := 3;
      GLITCH_TOLERANCE   : Integer   := 0;
      DCNTL_ADJVAL       : Integer   := 0;
      LOCK_DELAY         : Integer   := 100;
      SMI_OFFSET         : String    := "0x410";
      SMI_ADDR_DIS       : std_logic_vector(9 downto 0)  := "0000000000";
      TimingChecksOn     : Boolean   := TRUE;
      XOn                : Boolean   := FALSE;
      MsgOn              : Boolean   := TRUE;
      InstancePath       : String    := "cimdlla";
      tipd_clki          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_clkfb          : VitalDelayType01 := (0 ns, 0 ns);
      tipd_aluhold       : VitalDelayType01 := (0 ns, 0 ns);
      tipd_uddcntl       : VitalDelayType01 := (0 ns, 0 ns);
      tipd_rstn          : VitalDelayType01 := (0 ns, 0 ns));

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

    ATTRIBUTE Vital_Level0 OF cimdlla : ENTITY IS TRUE;

END cimdlla ;

-- architecture body --
ARCHITECTURE v OF cimdlla IS
    ATTRIBUTE Vital_Level0 OF v : ARCHITECTURE IS TRUE;

    SIGNAL clki_ipd   : std_logic := '0';
    SIGNAL clkfb_ipd   : std_logic := '0';
    SIGNAL rstn_ipd   : std_logic := '0';
    SIGNAL aluhold_ipd   : std_logic := '0';
    SIGNAL uddcntl_ipd   : std_logic := '0';
    SIGNAL smiaddr9_ipd   : std_logic := '0';
    SIGNAL smiaddr8_ipd   : std_logic := '0';
    SIGNAL smiaddr7_ipd   : std_logic := '0';
    SIGNAL smiaddr6_ipd   : std_logic := '0';
    SIGNAL smiaddr5_ipd   : std_logic := '0';
    SIGNAL smiaddr4_ipd   : std_logic := '0';
    SIGNAL smiaddr3_ipd   : std_logic := '0';
    SIGNAL smiaddr2_ipd   : std_logic := '0';
    SIGNAL smiaddr1_ipd   : std_logic := '0';
    SIGNAL smiaddr0_ipd   : std_logic := '0';
    SIGNAL smird_ipd   : std_logic := '0';
    SIGNAL smiwr_ipd   : std_logic := '0';
    SIGNAL smiclk_ipd   : std_logic := '0';
    SIGNAL smiwdata_ipd   : std_logic := '0';
    SIGNAL smirstn_ipd   : std_logic := '0';
    SIGNAL t_in_clk           : time := 0 ns;
    SIGNAL t_in_clk1          : time := 0 ns;
    SIGNAL t_in_clk2          : time := 0 ns;
    SIGNAL t_in_clk3          : time := 0 ns;
    SIGNAL total_fb_delay     : time := 0 ns;
    SIGNAL t_180              : time := 0 ns;
    SIGNAL t_270              : time := 0 ns;
    SIGNAL t_360              : time := 0 ns;
    SIGNAL t_90               : time := 0 ns;
    SIGNAL t_45               : time := 0 ns;
    SIGNAL t_22               : time := 0 ns;
    SIGNAL t_11               : time := 0 ns;
    SIGNAL delta              : time := 0.02 ns;
    SIGNAL false_clk          : std_logic := '0';
    SIGNAL lock_valid         : std_logic := '0';
    SIGNAL clock_valid        : std_logic := '0';
    SIGNAL real_lock          : std_logic := '0';
    SIGNAL g_reset            : std_logic := '0';
    SIGNAL resetn             : std_logic := '0';
    SIGNAL set_resetn         : std_logic := '0';
    SIGNAL clock_p            : std_logic := '0';
    SIGNAL clock_s            : std_logic := '0';
    SIGNAL clock_s_del        : std_logic := '0';
    SIGNAL clock_s_del_d2     : std_logic := '0';
    SIGNAL clock_s_del_d4     : std_logic := '0';
    SIGNAL clock_s_final      : std_logic := '0';
    SIGNAL cntl_ratio         : integer := 0;
    SIGNAL cntl_reg           : std_logic_vector(8 downto 0) := "000000000";
    SIGNAL cntl_reg_update    : std_logic_vector(8 downto 0) := "000000000";
    SIGNAL clkop_first_time   : std_logic := '1';
    SIGNAL clkos_first_time   : std_logic := '1';
    SIGNAL lock_delay_reg     : time := 1 ns;

BEGIN

   ---------------------
   --  input path delays
   ---------------------
    WireDelay : BLOCK
    BEGIN
       VitalWireDelay(clki_ipd, clki, tipd_clki);
       VitalWireDelay(clkfb_ipd, clkfb, tipd_clkfb);
       VitalWireDelay(rstn_ipd, rstn, tipd_rstn);
       VitalWireDelay(aluhold_ipd, aluhold, tipd_aluhold);
       VitalWireDelay(uddcntl_ipd, uddcntl, tipd_uddcntl);
    END BLOCK;

   --------------------
   --  behavior section
   --------------------
   smirdata <= '0';

   GLOBALRESET : PROCESS (purnet, gsrnet)
    BEGIN
      IF (gsr =  "DISABLED") THEN
         g_reset <= purnet;
      ELSE
         g_reset <= purnet AND gsrnet;
      END IF;
    END PROCESS;

   resetn <= g_reset and  rstn_ipd;

   G1 : PROCESS (clki_ipd, resetn)
   BEGIN
      IF (resetn = '0') THEN
         set_resetn <= resetn;
      ELSIF (clki_ipd'event and clki_ipd = '1') THEN
         set_resetn <= resetn;
      END IF;
   END PROCESS;
--------------------------------------------------------------------
-- Generate False Clocks
--------------------------------------------------------------------

   false_clk <= not false_clk after 5 ns;
   clkos_first_time <= '0' after 15 ns;
   clkop_first_time <= '0' after 15 ns;

---------------------------------------------------------------------

   GENERATE_FIRST_FB_EDGE : PROCESS (false_clk, clkfb_ipd, clki_ipd)
   VARIABLE false_clk_first_time : boolean := true;
   VARIABLE fb_first_time : boolean := true;
   VARIABLE first_int_edge : time := 0 ps;
   VARIABLE first_fb_edge : time := 0 ps;
   VARIABLE next_clki_edge : time := 0 ps;
   VARIABLE next_fb_edge : time := 0 ps;
   BEGIN
      if (false_clk'event and false_clk'last_value = '0' and false_clk = '1') then
         if (false_clk_first_time) then
            first_int_edge := NOW;
            false_clk_first_time := false;
         end if;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         if (fb_first_time) then
            first_fb_edge := NOW;
            fb_first_time := false;
         end if;
      end if;

      if (clki_ipd'event and clki_ipd'last_value = '0' and clki_ipd = '1') then
         next_clki_edge := NOW;
      end if;
      if (clkfb_ipd'event and clkfb_ipd'last_value = '0' and clkfb_ipd = '1') then
         next_fb_edge := NOW;
      end if;

      if (fb_first_time) then
         total_fb_delay <= first_fb_edge - first_int_edge ;
      else
         total_fb_delay <= next_fb_edge - next_clki_edge;
      end if;
   END PROCESS;

   CLKIN_PERIOD : PROCESS (clki_ipd)
   VARIABLE last_clock_edge, next_clock_edge : time := 0 ps;
   BEGIN
      IF (clki_ipd'event and clki_ipd = '1') THEN
           last_clock_edge := next_clock_edge;
           next_clock_edge := NOW;
           IF (last_clock_edge > 0 ps) THEN
                t_in_clk <= next_clock_edge - last_clock_edge;
                t_in_clk1 <= t_in_clk;
                t_in_clk2 <= t_in_clk1;
                t_in_clk3 <= t_in_clk2;
           END IF;
           IF (t_in_clk > 0 ps) THEN
--             IF (((t_in_clk - t_in_clk1) < 0.0001 ns) and ((t_in_clk - t_in_clk1) > -0.0001 ns)) THEN
             IF (t_in_clk = t_in_clk1) THEN
                  clock_valid <= '1';
             ELSE
                  clock_valid <= '0';
             END IF;
           END IF;

           IF (t_in_clk > 0 ps) THEN
             t_180 <= (t_in_clk / 2);
             t_90 <= (t_in_clk / 4);
             t_270 <= ((t_in_clk * 3)/ 4);
             t_360 <= t_in_clk;
             t_45 <= (t_in_clk / 8);
             t_22 <= (t_in_clk / 16);
             t_11 <= (t_in_clk / 32);
           END IF;
      END IF;
      
   END PROCESS;

   S1 : PROCESS (clki_ipd, total_fb_delay)
   BEGIN
      IF (total_fb_delay > 0 ps) THEN
         cntl_ratio <= (total_fb_delay / delta);
      END IF;
   END PROCESS;

   cntl_reg <= CONV_STD_LOGIC_VECTOR(cntl_ratio, 9);

   S2 : PROCESS (cntl_reg, uddcntl_ipd)
   BEGIN
      IF (uddcntl_ipd = '1') THEN
         cntl_reg_update <= cntl_reg;
      END IF;
   END PROCESS;

   (dcntl8, dcntl7, dcntl6, dcntl5, dcntl4, dcntl3, dcntl2, dcntl1, dcntl0) <= cntl_reg_update;

   P7 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         lock_valid <= '0';
      ELSE
         lock_valid <= clock_valid;
      END IF;
   END PROCESS;

   P8 : PROCESS (clock_valid, set_resetn)
   BEGIN
      IF (set_resetn = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '0') THEN
         real_lock <= '0';
      ELSIF (clock_valid = '1') THEN
         real_lock <= transport clock_valid after (LOCK_DELAY * lock_delay_reg);
      END IF;
   END PROCESS;

   P1 : PROCESS (clki_ipd, lock_valid)
   BEGIN
      IF (lock_valid = '1') THEN
         clock_p <= clki_ipd;
         clock_s <= clki_ipd;
      END IF;
   END PROCESS;

   P2 : PROCESS (clki_ipd, clock_s)
   BEGIN
      IF (CLKOS_FPHASE = 0) THEN
         clock_s_del <= clock_s;
      ELSIF (CLKOS_FPHASE = 11) THEN
         clock_s_del <= transport clock_s after t_11;
      ELSIF (CLKOS_FPHASE = 22) THEN
         clock_s_del <= transport clock_s after t_22;
      ELSIF (CLKOS_FPHASE = 45) THEN
         clock_s_del <= transport clock_s after t_45;
      END IF;
   END PROCESS;

   P3 : PROCESS (clock_s_del, clock_s_del_d2)
   BEGIN
      IF (clock_s_del'event and clock_s_del = '1') THEN
         clock_s_del_d2 <= not clock_s_del_d2;
      END IF;
      IF (clock_s_del_d2'event and clock_s_del_d2 = '1') THEN
         clock_s_del_d4 <= not clock_s_del_d4;
      END IF;
   END PROCESS;

   P4 : PROCESS (clock_s_del, clock_s_del_d2, clock_s_del_d4)
   BEGIN
      IF (CLKOS_DIV = 1) THEN
         clock_s_final <= clock_s_del;
      ELSIF (CLKOS_DIV = 2) THEN
         clock_s_final <= clock_s_del_d2;
      ELSIF (CLKOS_DIV = 4) THEN
         clock_s_final <= clock_s_del_d4;
      END IF;
   END PROCESS;

   P5 : PROCESS (clock_p, lock_valid, false_clk, set_resetn)
   BEGIN
      IF (clkop_first_time = '1') THEN
         clkop <= false_clk;
      ELSIF (set_resetn = '0') THEN
         clkop <= '0';
      ELSIF (lock_valid = '1') THEN
         clkop <= clock_p;
      END IF;
   END PROCESS;

   P6 : PROCESS (clock_s_final, lock_valid, false_clk, set_resetn)
   BEGIN
      IF (clkos_first_time = '1') THEN
         clkos <= false_clk;
      ELSIF (set_resetn = '0') THEN
         clkos <= '0';
      ELSIF (lock_valid = '1') THEN
         clkos <= clock_s_final;
      END IF;
   END PROCESS;

   lock <= real_lock;

END v;



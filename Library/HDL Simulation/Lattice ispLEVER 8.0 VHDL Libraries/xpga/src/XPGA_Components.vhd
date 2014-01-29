-- -------------------------------------------------------------------- 
-- >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<< 
-- -------------------------------------------------------------------- 
-- Copyright (c) 2001 by Lattice Semiconductor Corporation 
-- -------------------------------------------------------------------- 
-- 
-- 
--                     Lattice Semiconductor Corporation 
--                     5555 NE Moore Court 
--                     Hillsboro, OR 97214 
--                     U.S.A 
-- 
--                     TEL: 1-800-Lattice (USA and Canada) 
--                          408-826-6000 (other locations) 
-- 
--                     web: http://www.latticesemi.com/ 
--                     email: techsupport@latticesemi.com 
-- 
-- -------------------------------------------------------------------- 
-- 
-- Simulation package file for ispXPGA components

-- Revision History:
-- 
-- $Header: R:/src/mod_kits/ispXPGA/VHDL/rcs/XPGA_Components.vhd 1.36 2004/04/05 04:05:22Z jli Exp jli $
----------------------------------------------------------------
-- 
-- Created by the Synopsys Library Compiler 1999.10
-- FILENAME     :    lava1_components.vhd
-- FILE CONTENTS:    Component Package
-- DATE CREATED :    Mon Apr  9 19:31:34 2001
-- 
-- LIBRARY      :    lava1
-- REVISION     :    Not Specified
-- TECHNOLOGY   :    fpga
-- TIME SCALE   :    1 ns
-- LOGIC SYSTEM :    IEEE-1164
-- NOTES        :    
-- HISTORY      :
-- 
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package COMPONENTS is

constant Default_Timing_mesg : Boolean := True;
constant Default_Timing_xgen : Boolean := False;

function Str2int( L : string) return integer;
function Str2real( L : string) return REAL;
function str2std(L: string) return std_logic_vector;
function Valid_Address (IN_ADDR : in std_logic_vector) return boolean;
function init_flag(init_file : string) return integer;

---------------------------------------------------------------------------

type std_logic_2d is array (NATURAL RANGE <>, NATURAL RANGE <>) of std_logic;

---------------------------------------------------------------------------

----- Component B_KEEPER -----
component B_KEEPER
  generic( InstancePath: STRING := "*");
  port(X : inout STD_ULOGIC);
end component;

----- Component l_ram_dp -----
component l_ram_dp
  generic(
	   lpm_type              : string := "LPM_RAM_DP";
	   lpm_width             : integer := 1;
	   lpm_numwords          : integer := 1;
	   lpm_widthad           : integer := 1;
           lpm_parity_width      : integer := 1;
  	   lpm_indata            : string := "REGISTERED";
	   lpm_outdata           : string := "UNREGISTERED";
    	   lpm_wraddress_control : string := "REGISTERED";
	   lpm_rdaddress_control : string := "REGISTERED";
	   lpm_hint              : string := "UNUSED";
           lpm_file              : string := "");


  port(
           Data        : in  std_logic_vector (lpm_width-1 downto 0);
           WrAddress   : in  std_logic_vector (lpm_widthad-1 downto 0);
           RdAddress   : in  std_logic_vector (lpm_widthad-1 downto 0);
           WrClock     : in std_logic;
           WrClkEn     : in std_logic;
           RdClock     : in std_logic;
           RdClkEn     : in std_logic;
           RdEn        : in std_logic;
           WrEn        : in std_logic;
           EDI         : in std_logic_vector(lpm_parity_width - 1 downto 0);
           EDO         : out std_logic_vector(lpm_parity_width - 1 downto 0);
           Q           : out std_logic_vector (lpm_width-1 downto 0));

end component;

----- Component l_ram_dpx -----
component l_ram_dpx 
generic (
              LPM_TYPE      : string := "LPM_RAM_DPX";
              LPM_WIDTHA    : positive;
              LPM_WIDTHADA  : positive;
              LPM_NUMWORDSA : positive;
              LPM_WIDTHB    : positive;
              LPM_WIDTHADB  : positive;
              LPM_NUMWORDSB : positive;
              LPM_INDATA    : string :="REGISTERED";
              LPM_OUTDATA   : string :="UNREGISTERED";
              LPM_ADDRESSA_CONTROL   : string :="REGISTERED";
              LPM_ADDRESSB_CONTROL   : string :="REGISTERED";
              lpm_init_file        : string := "";
              LPM_HINT      : string :="UNUSED");
      port (  
              DataInA       : in std_logic_vector(LPM_WIDTHA-1 downto 0);
              AddressA      : in std_logic_vector(LPM_WIDTHADA-1 downto 0);
              DataInB       : in std_logic_vector(LPM_WIDTHB-1 downto 0);
              AddressB      : in std_logic_vector(LPM_WIDTHADB-1 downto 0);
              ClockA        : in std_logic := '0';
              ClockEnA      : in std_logic := '0';
              ClockB        : in std_logic := '0';
              ClockEnB      : in std_logic := '0';
              WrA           : in std_logic;
              WrB           : in std_logic;
              ResetA        : in std_logic;
              ResetB        : in std_logic;
              QA            : out std_logic_vector(LPM_WIDTHA-1 downto 0);
              QB            : out std_logic_vector(LPM_WIDTHB-1 downto 0));
end component;

----- Component l_ram_dq -----
component l_ram_dq
  generic(
	   lpm_type            : string  := "LPM_RAM_DQ";
	   lpm_width           : integer := 1;
	   lpm_numwords        : integer := 1;
	   lpm_widthad         : integer := 1;
           lpm_parity_width    : integer := 1;
  	   lpm_indata          : string  := "REGISTERED";
	   lpm_outdata         : string  := "UNREGISTERED";
	   lpm_address_control : string  := "REGISTERED";
           lpm_file            : string := "";
	   lpm_hint            : string  := "UNUSED");

  port(

           Data                : in  std_logic_vector (lpm_width-1 downto 0);
           Address             : in  std_logic_vector (lpm_widthad-1 downto 0);
           InClock             : in  std_logic;
           OutClock             : in  std_logic;
           WE                  : in  std_logic;
           EDI                 : in std_logic_vector(lpm_parity_width - 1 downto 0);
           EDO                 : out std_logic_vector(lpm_parity_width - 1 downto 0);
           Q                   : out std_logic_vector (lpm_width-1 downto 0));
end component;

----- Component l_rom -----
component l_rom
  generic (
	    lpm_type               : string  := "LPM_ROM";
	    lpm_width              : integer := 1;
	    lpm_numwords           : integer := 1;
	    lpm_widthad            : integer := 1;
            lpm_parity_width       : integer := 1;
	    lpm_outdata            : string  := "REGISTERED";
	    lpm_address_control    : string  := "UNREGISTERED";
            lpm_file               : string := "init_file";
	    lpm_hint               : string  := "UNUSED");
  port (
            Address       : in  std_logic_vector (lpm_widthad-1 downto 0);
            OutClock      : in  std_logic;
            MemEnab       : in  std_logic;
            EDO           : out std_logic_vector (lpm_parity_width-1 downto 0);
            Q             : out std_logic_vector (lpm_width-1 downto 0));
end component;

----- Component L_MUX -----
component L_MUX

    GENERIC (LPM_WIDTH: positive;
             LPM_SIZE: positive;
             LPM_WIDTHS: positive;
             LPM_PIPELINE: integer;
             LPM_TYPE: string;
             LPM_HINT: string);
    PORT (DATA: IN std_logic_2d(LPM_SIZE-1 downto 0, LPM_WIDTH-1 downto 0);
          ACLR : IN std_logic;
          CLOCK: IN std_logic;
          SEL  : IN std_logic_vector(LPM_WIDTHS-1 downto 0);
          RESULT: OUT std_logic_vector(LPM_WIDTH-1 downto 0));
END component;

----- Component LPM_ADD_SUB -----

component LPM_ADD_SUB

    GENERIC (LPM_WIDTH: positive;
             LPM_DIRECTION : string;
             LPM_REPRESENTATION: string;
             LPM_PIPELINE : integer;
             LPM_TYPE : string;
             LPM_HINT : string);
       port (DATAA : in std_logic_vector(LPM_WIDTH-1 downto 0);
             DATAB : in std_logic_vector(LPM_WIDTH-1 downto 0);
             ACLR : in std_logic;
             CLOCK : in std_logic;
             CIN : in std_logic;
             ADD_SUB : in std_logic;
             RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
             COUT : out std_logic;
             OVERFLOW : out std_logic);
END component;

component LPM_ADD_SUB_UNSIGNED
        generic (LPM_WIDTH : positive;
                 LPM_DIRECTION : string;
                 LPM_PIPELINE : integer;
                 LPM_TYPE : string;
                 LPM_HINT : string);
        port (DATAA : in std_logic_vector(LPM_WIDTH-1 downto 0);
              DATAB : in std_logic_vector(LPM_WIDTH-1 downto 0);
              ACLR : in std_logic;
              CLOCK : in std_logic;
              CIN : in std_logic;
              ADD_SUB : in std_logic;
              RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
              COUT : out std_logic;
              OVERFLOW : out std_logic);
END component;

component LPM_ADD_SUB_SIGNED
        generic (LPM_WIDTH : positive;
                 LPM_DIRECTION : string;
                 LPM_PIPELINE : integer := 0;
                 LPM_TYPE : string;
                 LPM_HINT : string);
        port (DATAA : in std_logic_vector(LPM_WIDTH downto 1);
              DATAB : in std_logic_vector(LPM_WIDTH downto 1);
              ACLR : in std_logic;
              CLOCK : in std_logic;
              CIN : in std_logic;
              ADD_SUB : in std_logic;
              RESULT : out std_logic_vector(LPM_WIDTH-1 downto 0);
              COUT : out std_logic;
              OVERFLOW : out std_logic);
END component;

----- Component LPM_ABS -----

component LPM_ABS

    GENERIC (LPM_WIDTH: positive;
             LPM_TYPE: string;
             LPM_HINT: string);
    PORT (DATA: IN std_logic_vector(LPM_WIDTH-1 downto 0);
          OVERFLOW: OUT std_logic;
          RESULT: OUT std_logic_vector(LPM_WIDTH-1 downto 0));
END component;

----- Component LPM_COMPARE -----

component LPM_COMPARE_SIGNED

        generic (LPM_WIDTH : positive;
                LPM_PIPELINE : integer;
                LPM_TYPE: string;
                LPM_HINT : string);
        port (DATAA : in std_logic_vector(LPM_WIDTH-1 downto 0);
                DATAB : in std_logic_vector(LPM_WIDTH-1 downto 0);
                ACLR : in std_logic;
                CLOCK : in std_logic;
                AGB : out std_logic;
                AGEB : out std_logic;
                AEB : out std_logic;
                ANEB : out std_logic;
                ALB : out std_logic;
                ALEB : out std_logic);
end component;

component LPM_COMPARE_UNSIGNED
        generic (LPM_WIDTH : positive;
                 LPM_PIPELINE : integer;
                 LPM_TYPE: string;
                 LPM_HINT : string);
        port (DATAA : in std_logic_vector(LPM_WIDTH-1 downto 0);
              DATAB : in std_logic_vector(LPM_WIDTH-1 downto 0);
              ACLR : in std_logic;
              CLOCK : in std_logic;
              AGB : out std_logic;
              AGEB : out std_logic;
              AEB : out std_logic;
              ANEB : out std_logic;
              ALB : out std_logic;
              ALEB : out std_logic);
  end component;

component LPM_COMPARE
    GENERIC (LPM_WIDTH: positive;
             LPM_REPRESENTATION : string;
             LPM_PIPELINE : integer;
             LPM_TYPE: string;
             LPM_HINT : string);
    PORT (DATAA: IN std_logic_vector(LPM_WIDTH-1 downto 0);
          DATAB : in std_logic_vector(LPM_WIDTH-1 downto 0);
          ACLR : in std_logic;
          CLOCK : in std_logic;
          AGB : out std_logic;
          AGEB : out std_logic;
          AEB : out std_logic;
          ANEB : out std_logic;
          ALB : out std_logic;
          ALEB : out std_logic);
END component;


----- Component LPM_COUNTER -----

component LPM_COUNTER

    GENERIC (LPM_WIDTH: positive;
             LPM_MODULUS: natural;
                 LPM_DIRECTION : string;
                 LPM_AVALUE : string;
                 LPM_SVALUE : string;
                 LPM_PVALUE : string;
                 LPM_TYPE: string;
                 LPM_HINT : string);
        port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
                 CLOCK : in std_logic;
                 CLK_EN : in std_logic;
                 CNT_EN : in std_logic;
                 UPDOWN : in std_logic;
                 SLOAD : in std_logic;
                 SSET : in std_logic;
                 SCLR : in std_logic;
                 ALOAD : in std_logic;
                 ASET : in std_logic;
                 ACLR : in std_logic;
                 CIN : in std_logic;
                 COUT : out std_logic;
                 Q : out std_logic_vector(LPM_WIDTH-1 downto 0));
END component;

----- Component LPM_MULT -----

component LPM_MULT_SIGNED 
        generic (LPM_WIDTHA : positive;
                LPM_WIDTHB : positive;
                --LPM_WIDTHS : positive;
                LPM_WIDTHS : natural;
                LPM_WIDTHP : positive;
                LPM_PIPELINE : integer;
                LPM_TYPE: string;
                LPM_HINT : string);
        port (DATAA : in std_logic_vector(LPM_WIDTHA-1 downto 0);
                DATAB : in std_logic_vector(LPM_WIDTHB-1 downto 0);
                ACLR : in std_logic;
                CLOCK : in std_logic;
                --CLKEN : in std_logic;
                SUM : in std_logic_vector(LPM_WIDTHS-1 downto 0);
                RESULT : out std_logic_vector(LPM_WIDTHP-1 downto 0));
END component;

component LPM_MULT_UNSIGNED
        generic (LPM_WIDTHA : positive;
                 LPM_WIDTHB : positive;
                 --LPM_WIDTHS : positive;
                 LPM_WIDTHS : natural;
                 LPM_WIDTHP : positive;
                 LPM_PIPELINE : integer;
                 LPM_TYPE: string;
                 LPM_HINT : string);
        port (DATAA : in std_logic_vector(LPM_WIDTHA-1 downto 0);
                 DATAB : in std_logic_vector(LPM_WIDTHB-1 downto 0);
                 ACLR : in std_logic;
                 CLOCK : in std_logic;
                 --CLKEN : in std_logic;
                 SUM : in std_logic_vector(LPM_WIDTHS-1 downto 0);
                 RESULT : out std_logic_vector(LPM_WIDTHP-1 downto 0));
END component;

component LPM_MULT
        generic (LPM_WIDTHA : positive;
                 LPM_WIDTHB : positive;
                 --LPM_WIDTHS : positive;
                 LPM_WIDTHS : natural;
                 LPM_WIDTHP : positive;
                 LPM_REPRESENTATION : string;
                 LPM_PIPELINE : integer;
                 LPM_TYPE: string;
                 LPM_HINT : string);
        port (DATAA : in std_logic_vector(LPM_WIDTHA-1 downto 0);
                 DATAB : in std_logic_vector(LPM_WIDTHB-1 downto 0);
                 ACLR : in std_logic;
                 CLOCK : in std_logic;
                 --CLKEN : in std_logic;
                 SUM : in std_logic_vector(LPM_WIDTHS-1 downto 0);
                 RESULT : out std_logic_vector(LPM_WIDTHP-1 downto 0));
END component;

----- Component LPM_CLSHIFT -----

component LPM_CLSHIFT
        generic (LPM_WIDTH : positive;
                 LPM_WIDTHDIST : positive;
                 LPM_SHIFTTYPE : string;
                 LPM_TYPE : string;
                 LPM_HINT : string);
        port (DATA : in STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0);
                  DISTANCE : in STD_LOGIC_VECTOR(LPM_WIDTHDIST-1 downto 0);
                  DIRECTION : in STD_LOGIC;
                  RESULT : out STD_LOGIC_VECTOR(LPM_WIDTH-1 downto 0);
                  UNDERFLOW : out STD_LOGIC;
                  OVERFLOW : out STD_LOGIC);
END component;

----- Component LPM_DECODE -----

component LPM_DECODE

    GENERIC (LPM_WIDTH: positive;
             LPM_DECODES: positive;
             LPM_PIPELINE: integer;
             LPM_TYPE: string);
    PORT (DATA: IN std_logic_vector(LPM_WIDTH-1 downto 0);
          ACLR : IN std_logic;
          CLOCK: IN std_logic;
          ENABLE: IN std_logic;
          EQ   : OUT std_logic_vector(LPM_DECODES-1 downto 0));
END component;

----- Component LPM_SHIFTREG -----

component LPM_SHIFTREG
        generic (LPM_WIDTH : positive;
           LPM_SHIFT_VALUE : integer;
           LPM_AVALUE : string;
           LPM_SVALUE : string;
           LPM_PVALUE : string;
           LPM_DIRECTION: string;
           LPM_TYPE: string;
           LPM_HINT : string);
        port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
              CLOCK : in std_logic;
              ENABLE : in std_logic;
              SHIFTIN : in std_logic;
              LOAD : in std_logic;
              SCLR : in std_logic;
              SSET : in std_logic;
              ACLR : in std_logic;
              ASET : in std_logic;
              Q : out std_logic_vector(LPM_WIDTH-1 downto 0);
              SHIFTOUT : out std_logic);
end Component;

----- Component LPM_FIFO -----

Component LPM_FIFO
        generic (LPM_WIDTH : positive;
                 LPM_WIDTHU : natural;
                 LPM_PARITY_WIDTH : positive;
                 LPM_NUMWORDS : positive;
                 LPM_SHOWAHEAD : string;
                 LPM_TYPE : string;
                 LPM_HINT : string);
        port (DATA : in std_logic_vector(LPM_WIDTH-1 downto 0);
                  CLOCK : in std_logic;
                  WRREQ : in std_logic;
                  RDREQ : in std_logic;
                  ACLR : in std_logic;
                  SCLR : in std_logic;
                  Q : out std_logic_vector(LPM_WIDTH-1 downto 0);
                  USEDW : out std_logic_vector(LPM_WIDTHU-1 downto 0);
                  FULL : out std_logic;
                  EMPTY : out std_logic);
end Component;



----- Component SPLL -----
component SPLL
   generic (in_freq : string := "100.0";
	    clk_out_to_pin : string := "off";
	    wake_on_lock : string := "off");
   port(
      CLK_IN                         :	in    STD_ULOGIC;
      CLK_OUT                        :	out   STD_ULOGIC);
end component;

----- Component STDPLL -----
component STDPLL
   generic (in_freq  : string  := "100.0";
            mult     : string  := "1";
            div      : string  := "1";
            post     : string  := "1";
            secdiv   : string  := "1";
            clk_out_to_pin   : string  := "off";
            wake_on_lock   : string  := "off";
            lock_cyc : integer := 1;
            pll_dly  : string  := "0.0");
   port(
      CLK_IN                         :	in    STD_ULOGIC;
      CLK_OUT                        :	out   STD_ULOGIC;
      PLL_LOCK                       :	out   STD_ULOGIC);
end component;

----- Component STDPLLX -----
component STDPLLX
   generic (in_freq  : string  := "100.0";
            mult     : string  := "1";
            div      : string  := "1";
            post     : string  := "1";
            secdiv   : string  := "1";
            lock_cyc : integer := 1;
            clk_out_to_pin   : string  := "off";
            wake_on_lock   : string  := "off";
            pll_fbk_attribute : string := "clktree";
            pll_dly  : string  := "1");
   port(
      CLK_IN                         :	in    STD_ULOGIC;
      PLL_FBK                        :	in    STD_ULOGIC;
      PLL_RST                        :	in    STD_ULOGIC;
      CLK_OUT                        :	out   STD_ULOGIC;
      SEC_OUT                        :	out   STD_ULOGIC;
      PLL_LOCK                       :	out   STD_ULOGIC);
end component;

----- Component AS_LSB -----
component AS_LSB
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      AS                             :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_AS_LSB -----
component CCU_AS_LSB
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      AS                             :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component BI_DIR -----
component BI_DIR
   port(
      I0                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      IO                             :	inout STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component BUFEI -----
component BUFEI
   port(
      I0                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component GCLKBUF -----
component GCLKBUF
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component GCLKBUFI -----
component GCLKBUFI
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component BUFF -----
component BUFF
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component CCU_BUF -----
component CCU_BUF
   port(
      CI                             :	in    STD_LOGIC;
      COUT                              :	out   STD_LOGIC);
end component;

----- Component CCU_OUT -----
component CCU_OUT
   port(
      CI                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component BUFTH -----
component BUFTH
   port(
      I0                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component BUFTI -----
component BUFTI
   port(
      I0                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component BUFTL -----
component BUFTL
   port(
      I0                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component CCU_ABS -----
component CCU_ABS
   port(
      D                              :	in    STD_LOGIC;
      PN                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_ADD -----
component CCU_ADD
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_GEN -----
component CCU_GEN
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_GEN1 -----
component CCU_GEN1
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_GEN2 -----
component CCU_GEN2
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_SUB -----
component CCU_SUB
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_ADD_2S -----
component CCU_ADD_2S
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      SEL                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_MULT -----
component CCU_MULT
   port(
      A0                             :	in    STD_LOGIC;
      A1                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      B1                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      P                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_AGB -----
component CCU_AGB
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_AGBS -----
component CCU_AGBS
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      COUT                           :	out   STD_LOGIC;
      S0                             :	out   STD_LOGIC);
end component;


----- Component CCU_AS -----
component CCU_AS
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      AS                             :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_BTH -----
component CCU_BTH
   port(
      A0                             :	in    STD_LOGIC;
      A1                             :	in    STD_LOGIC;
      D0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      AS                             :	in    STD_LOGIC;
      SH                             :	in    STD_LOGIC;
      NOP                            :	in    STD_LOGIC;
      P                              :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_BTH_LSTC -----
component CCU_BTH_LSTC
   port(
      A0                             :	in    STD_LOGIC;
      A1                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      ADD                            :	in    STD_LOGIC;
      P                              :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_BTH_TC_LSB -----
component CCU_BTH_TC_LSB
   port(
      A0                             :	in    STD_LOGIC;
      A1                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      AS                             :	in    STD_LOGIC;
      SH                             :	in    STD_LOGIC;
      NOP                            :	in    STD_LOGIC;
      P                              :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_BTH_TC_MSB -----
component CCU_BTH_TC_MSB
   port(
      A0                             :	in    STD_LOGIC;
      D0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      AS                             :	in    STD_LOGIC;
      NOP                            :	in    STD_LOGIC;
      P                              :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_BTH_UNS_LSB -----
component CCU_BTH_UNS_LSB
   port(
      A0                             :	in    STD_LOGIC;
      A1                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      B1                             :	in    STD_LOGIC;
      P                              :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_BTH_UNS_MSB -----
component CCU_BTH_UNS_MSB
   port(
      D0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      AS                             :	in    STD_LOGIC;
      NOP                            :	in    STD_LOGIC;
      P                              :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_DC -----
component CCU_DC
   port(
      D                              :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_UC -----
component CCU_UC
   port(
      D                              :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_DCP -----
component CCU_DCP
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      LOAD                           :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CCU_RCD_AS -----
component CCU_RCD_AS
   port(
      B2                             :	in    STD_LOGIC;
      AS                             :	out   STD_LOGIC;
      COUT                            :	out   STD_LOGIC);
end component;

----- Component CCU_RCD -----
component CCU_RCD
   port(
      B0                             :	in    STD_LOGIC;
      B1                             :	in    STD_LOGIC;
      B2                             :	in    STD_LOGIC;
      AS                             :	out   STD_LOGIC;
      SH                             :	out   STD_LOGIC;
      NOP                            :	out   STD_LOGIC);
end component;


----- Component CCU_RCD_LSB -----
component CCU_RCD_LSB
   port(
      B1                             :	in    STD_LOGIC;
      B2                             :	in    STD_LOGIC;
      AS                             :	out   STD_LOGIC;
      SH                             :	out   STD_LOGIC;
      NOP                            :	out   STD_LOGIC);
end component;


----- Component CCU_UCP -----
component CCU_UCP
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      LOAD                           :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_UDC -----
component CCU_UDC
   port(
      D                              :	in    STD_LOGIC;
      UD                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component CCU_UDCP -----
component CCU_UDCP
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      LOAD                           :	in    STD_LOGIC;
      UD                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component CYAND2 -----
component CYAND2
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component CYXOR2 -----
component CYXOR2
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component DC_LSB -----
component DC_LSB
   port(
      D                              :	in    STD_LOGIC;
      CYIBAR                         :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component DFF -----
component DFF
   generic (R_DELAY : TIME := 2 ns);
   port(
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCB -----
component DFFCB
   generic (R_DELAY : TIME := 2 ns);
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBLSH -----
component DFFCBLSH
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      LD                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBLSH_1 -----
component DFFCBLSH_1
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      LD                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBRH -----
component DFFCBRH
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      R                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBRH_1 -----
component DFFCBRH_1
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      R                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBSH -----
component DFFCBSH
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      S                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBSH_1 -----
component DFFCBSH_1
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      S                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBSRH -----
component DFFCBSRH
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      SR                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBSRH_1 -----
component DFFCBSRH_1
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      SR                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBSSH -----
component DFFCBSSH
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      SS                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCBSSH_1 -----
component DFFCBSSH_1
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      SS                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFCB_1 -----
component DFFCB_1
   generic (R_DELAY : TIME := 2 ns);
   port(
      CE                             :	in    STD_LOGIC;
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFLSH -----
component DFFLSH
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      LD                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFLSH_1 -----
component DFFLSH_1
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      LD                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFRH -----
component DFFRH
   port(
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      R                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFRH_1 -----
component DFFRH_1
   port(
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      R                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;

----- Component DFFSH -----
component DFFSH
   port(
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      S                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFSH_1 -----
component DFFSH_1
   port(
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      S                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFSRH -----
component DFFSRH
   port(
      D                              :	in    STD_LOGIC;
      SR                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFSRH_1 -----
component DFFSRH_1
   port(
      D                              :	in    STD_LOGIC;
      SR                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFSSH -----
component DFFSSH
   port(
      D                              :	in    STD_LOGIC;
      SS                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFFSSH_1 -----
component DFFSSH_1
   port(
      D                              :	in    STD_LOGIC;
      SS                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DFF_1 -----
component DFF_1
   generic (R_DELAY : TIME := 2 ns);
   port(
      D                              :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLAT -----
component DLAT
   port(
      D                              :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLATRH -----
component DLATRH
   port(
      D                              :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      R                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLATRH_1 -----
component DLATRH_1
   port(
      D                              :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      R                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLATSH -----
component DLATSH
   port(
      D                              :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      S                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLATSH_1 -----
component DLATSH_1
   port(
      D                              :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      S                              :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;



----- Component DLATSRH -----
component DLATSRH
   port(
      D                              :	in    STD_LOGIC;
      SR                             :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLATSRH_1 -----
component DLATSRH_1
   port(
      D                              :	in    STD_LOGIC;
      SR                             :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLATSSH -----
component DLATSSH
   port(
      D                              :	in    STD_LOGIC;
      SS                             :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLATSSH_1 -----
component DLATSSH_1
   port(
      D                              :	in    STD_LOGIC;
      SS                             :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component DLAT_1 -----
component DLAT_1
   port(
      D                              :	in    STD_LOGIC;
      LAT                            :	in    STD_LOGIC;
      Q                              :	out   STD_LOGIC);
end component;


----- Component GND -----
component GND
   port(
      X                              :	out   STD_LOGIC := '0');
end component;


----- Component GSRBUF -----
component GSRBUF
   port(
      SRI                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component GSRBUFINV -----
component GSRBUFINV
   port(
      SRI                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component GSRBUFI -----
component GSRBUFI
   port(
      I0                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component GSRBUFIINV -----
component GSRBUFIINV
   port(
      I0                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component SRBUF -----
component SRBUF
   port(
      CI                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component SRBUFINV -----
component SRBUFINV
   port(
      CI                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component SRBUFI -----
component SRBUFI
   port(
      I0                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component SRBUFIINV -----
component SRBUFIINV
   port(
      I0                            :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component GSROR2 -----
component GSROR2
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component IBUF -----
component IBUF
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component IBUFINV -----
component IBUFINV
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component LVDSIN -----
component LVDSIN
   port(
      P_IN                             :	in    STD_ULOGIC;
      N_IN                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;

----- Component LVPECLIN -----
component LVPECLIN
   port(
      P_IN                             :	in    STD_ULOGIC;
      N_IN                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;

----- Component BLVDSIN -----
component BLVDSIN
   port(
      P_IN                             :	in    STD_ULOGIC;
      N_IN                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;

----- Component FT_BUF -----
component FT_BUF
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component INV -----
component INV
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component INVTH -----
component INVTH
   port(
      I0                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component INVTL -----
component INVTL
   port(
      I0                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component LSB_CY -----
component LSB_CY
   port(
      CI                             :	in    STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component LSB_CYI -----
component LSB_CYI
   port(
      CI                             :	in    STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;

----- Component LUT1 -----
component LUT1
   generic(INIT                      :	bit_vector);
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component LUT2 -----
component LUT2
   generic(INIT                      :	bit_vector);
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component LUT3 -----
component LUT3
   generic(INIT                      :	bit_vector);
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      I2                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component LUT4 -----
component LUT4
   generic(INIT                      :	bit_vector);
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      I2                             :	in    STD_LOGIC;
      I3                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component LUT5 -----
component LUT5
   generic(INIT                      :	bit_vector);
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      I2                             :	in    STD_LOGIC;
      I3                             :	in    STD_LOGIC;
      I4                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component LUT6 -----
component LUT6
   generic(INIT                      :	bit_vector);
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      I2                             :	in    STD_LOGIC;
      I3                             :	in    STD_LOGIC;
      I4                             :	in    STD_LOGIC;
      I5                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component MULTAND2 -----
component MULTAND2
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component MUX2 -----
component MUX2
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component MUXL6C -----
component MUXL6C
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component MUX2A -----
component MUX2A
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component MUX2B -----
component MUX2B
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component MUX4 -----
component MUX4
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      I2                             :	in    STD_LOGIC;
      I3                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      S1                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component MUX8 -----
component MUX8
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      I2                             :	in    STD_LOGIC;
      I3                             :	in    STD_LOGIC;
      I4                             :	in    STD_LOGIC;
      I5                             :	in    STD_LOGIC;
      I6                             :	in    STD_LOGIC;
      I7                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      S1                             :	in    STD_LOGIC;
      S2                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component MUX8C -----
component MUX8C
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      I2                             :	in    STD_LOGIC;
      I3                             :	in    STD_LOGIC;
      I4                             :	in    STD_LOGIC;
      I5                             :	in    STD_LOGIC;
      I6                             :	in    STD_LOGIC;
      I7                             :	in    STD_LOGIC;
      MI                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      S1                             :	in    STD_LOGIC;
      S2                             :	in    STD_LOGIC;
      S3                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component MUXL5 -----
component MUXL5
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component MUXL6 -----
component MUXL6
   port(
      I0                             :	in    STD_LOGIC;
      I1                             :	in    STD_LOGIC;
      S0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;


----- Component OBUF -----
component OBUF
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component OBUFINV -----
component OBUFINV
   port(
      I0                             :	in    STD_LOGIC;
      O                              :	out   STD_LOGIC);
end component;

----- Component LVDSOUT -----
component LVDSOUT
   port(
      I                             :	in    STD_ULOGIC;
      P_OUT                           :	out   STD_ULOGIC;
      N_OUT                           :	out   STD_ULOGIC);
end component;

----- Component LVPECLOUT -----
component LVPECLOUT
   port(
      I                             :	in    STD_ULOGIC;
      P_OUT                           :	out   STD_ULOGIC;
      N_OUT                           :	out   STD_ULOGIC);
end component;

----- Component BLVDSOUT -----
component BLVDSOUT
   port(
      I                             :	in    STD_ULOGIC;
      P_OUT                           :	out   STD_ULOGIC;
      N_OUT                           :	out   STD_ULOGIC);
end component;

----- Component LVDSTRI -----
component LVDSTRI
   port(
      I                             :	in    STD_ULOGIC;
      OE                            :	in    STD_ULOGIC;
      P_OUT                          :	out   STD_ULOGIC;
      N_OUT                          :	out   STD_ULOGIC);
end component;

----- Component LVPECLTRI -----
component LVPECLTRI
   port(
      I                             :	in    STD_ULOGIC;
      OE                            :	in    STD_ULOGIC;
      P_OUT                          :	out   STD_ULOGIC;
      N_OUT                          :	out   STD_ULOGIC);
end component;

----- Component BLVDSTRI -----
component BLVDSTRI
   port(
      I                             :	in    STD_ULOGIC;
      OE                            :	in    STD_ULOGIC;
      P_OUT                          :	out   STD_ULOGIC;
      N_OUT                          :	out   STD_ULOGIC);
end component;

----- Component LVDSIO -----
component LVDSIO
   port(
      I                             :	in    STD_ULOGIC;
      OE                            :	in    STD_ULOGIC;
      P_IO                           :	inout   STD_ULOGIC;
      N_IO                           :	inout   STD_ULOGIC;
      O                           :	out   STD_ULOGIC);
end component;

----- Component BLVDSIO -----
component BLVDSIO
   port(
      I                             :	in    STD_ULOGIC;
      OE                            :	in    STD_ULOGIC;
      P_IO                           :	inout   STD_ULOGIC;
      N_IO                           :	inout   STD_ULOGIC;
      O                           :	out   STD_ULOGIC);
end component;


----- Component RAM16X1D -----
component RAM16X1D
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      DPAD0                          :	in    STD_LOGIC;
      DPAD1                          :	in    STD_LOGIC;
      DPAD2                          :	in    STD_LOGIC;
      DPAD3                          :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC;
      DPRDATA                        :	out   STD_LOGIC);
end component;


----- Component RAM16X1D_1 -----
component RAM16X1D_1
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      DPAD0                          :	in    STD_LOGIC;
      DPAD1                          :	in    STD_LOGIC;
      DPAD2                          :	in    STD_LOGIC;
      DPAD3                          :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC;
      DPRDATA                        :	out   STD_LOGIC);
end component;


----- Component RAM16X1S -----
component RAM16X1S
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC);
end component;


----- Component RAM16X1S_1 -----
component RAM16X1S_1
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC);
end component;


----- Component RAM32X1D -----
component RAM32X1D
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      AD4                            :	in    STD_LOGIC;
      DPAD0                          :	in    STD_LOGIC;
      DPAD1                          :	in    STD_LOGIC;
      DPAD2                          :	in    STD_LOGIC;
      DPAD3                          :	in    STD_LOGIC;
      DPAD4                          :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC;
      DPRDATA                        :	out   STD_LOGIC);
end component;


----- Component RAM32X1D_1 -----
component RAM32X1D_1
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      AD4                            :	in    STD_LOGIC;
      DPAD0                          :	in    STD_LOGIC;
      DPAD1                          :	in    STD_LOGIC;
      DPAD2                          :	in    STD_LOGIC;
      DPAD3                          :	in    STD_LOGIC;
      DPAD4                          :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC;
      DPRDATA                        :	out   STD_LOGIC);
end component;


----- Component RAM32X1S -----
component RAM32X1S
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      AD4                            :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC);
end component;


----- Component RAM32X1S_1 -----
component RAM32X1S_1
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      AD4                            :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC);
end component;


----- Component RAM64X1S -----
component RAM64X1S
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      AD4                            :	in    STD_LOGIC;
      AD5                            :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC);
end component;


----- Component RAM64X1S_1 -----
component RAM64X1S_1
GENERIC (INIT: BIT_VECTOR);
   port(
      WE                             :	in    STD_LOGIC;
      WDATA                          :	in    STD_LOGIC;
      WCLK                           :	in    STD_LOGIC;
      AD0                            :	in    STD_LOGIC;
      AD1                            :	in    STD_LOGIC;
      AD2                            :	in    STD_LOGIC;
      AD3                            :	in    STD_LOGIC;
      AD4                            :	in    STD_LOGIC;
      AD5                            :	in    STD_LOGIC;
      RDATA                          :	out   STD_LOGIC);
end component;


----- Component RAMB256X18DAF -----
component RAMB256X18DAF
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;

----- Component RAMB256X18DAF_1 -----
component RAMB256X18DAF_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;


----- Component RAMB256X18DAR -----
component RAMB256X18DAR
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;

----- Component RAMB256X18DAR_1 -----
component RAMB256X18DAR_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;

----- Component RAMB256X18DSF -----
component RAMB256X18DSF
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;

----- Component RAMB256X18DSF_1 -----
component RAMB256X18DSF_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;

----- Component RAMB256X18DSR -----
component RAMB256X18DSR
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;

----- Component RAMB256X18DSR_1 -----
component RAMB256X18DSR_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      DA8                            :	inout STD_LOGIC;
      DA9                            :	inout STD_LOGIC;
      DA10                           :	inout STD_LOGIC;
      DA11                           :	inout STD_LOGIC;
      DA12                           :	inout STD_LOGIC;
      DA13                           :	inout STD_LOGIC;
      DA14                           :	inout STD_LOGIC;
      DA15                           :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      EDA1                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      DB8                            :	inout STD_LOGIC;
      DB9                            :	inout STD_LOGIC;
      DB10                           :	inout STD_LOGIC;
      DB11                           :	inout STD_LOGIC;
      DB12                           :	inout STD_LOGIC;
      DB13                           :	inout STD_LOGIC;
      DB14                           :	inout STD_LOGIC;
      DB15                           :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC;
      EDB1                           :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SAF -----
component RAMB256X18SAF
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SAF_1 -----
component RAMB256X18SAF_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SAR -----
component RAMB256X18SAR
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SAR_1 -----
component RAMB256X18SAR_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SSR -----
component RAMB256X18SSR
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SSR_1 -----
component RAMB256X18SSR_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SSF -----
component RAMB256X18SSF
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB256X18SSF_1 -----
component RAMB256X18SSF_1
    GENERIC (   INIT12: BIT_VECTOR;
		INIT11: BIT_VECTOR;
		INIT10: BIT_VECTOR;
		INIT0F: BIT_VECTOR;
		INIT0E: BIT_VECTOR;
		INIT0D: BIT_VECTOR;
		INIT0C: BIT_VECTOR;
		INIT0B: BIT_VECTOR;
		INIT0A: BIT_VECTOR;
		INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC;
      D9                             :	inout STD_LOGIC;
      D10                            :	inout STD_LOGIC;
      D11                            :	inout STD_LOGIC;
      D12                            :	inout STD_LOGIC;
      D13                            :	inout STD_LOGIC;
      D14                            :	inout STD_LOGIC;
      D15                            :	inout STD_LOGIC;
      D16                            :	inout STD_LOGIC;
      D17                            :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DAF -----
component RAMB512X9DAF
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DAF_1 -----
component RAMB512X9DAF_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DAR -----
component RAMB512X9DAR
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DAR_1 -----
component RAMB512X9DAR_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DSF -----
component RAMB512X9DSF
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DSF_1 -----
component RAMB512X9DSF_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DSR -----
component RAMB512X9DSR
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9DSR_1 -----
component RAMB512X9DSR_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN0                           :	in    STD_LOGIC;
      WEN1                           :	in    STD_LOGIC;
      RWCLK0                         :	in    STD_LOGIC;
      RWCLK1                         :	in    STD_LOGIC;
      CE0                            :	in    STD_LOGIC;
      CE1                            :	in    STD_LOGIC;
      OE0                            :	in    STD_LOGIC;
      OE1                            :	in    STD_LOGIC;
      ADDA0                          :	in    STD_LOGIC;
      ADDA1                          :	in    STD_LOGIC;
      ADDA2                          :	in    STD_LOGIC;
      ADDA3                          :	in    STD_LOGIC;
      ADDA4                          :	in    STD_LOGIC;
      ADDA5                          :	in    STD_LOGIC;
      ADDA6                          :	in    STD_LOGIC;
      ADDA7                          :	in    STD_LOGIC;
      ADDA8                          :	in    STD_LOGIC;
      ADDB0                          :	in    STD_LOGIC;
      ADDB1                          :	in    STD_LOGIC;
      ADDB2                          :	in    STD_LOGIC;
      ADDB3                          :	in    STD_LOGIC;
      ADDB4                          :	in    STD_LOGIC;
      ADDB5                          :	in    STD_LOGIC;
      ADDB6                          :	in    STD_LOGIC;
      ADDB7                          :	in    STD_LOGIC;
      ADDB8                          :	in    STD_LOGIC;
      DA0                            :	inout STD_LOGIC;
      DA1                            :	inout STD_LOGIC;
      DA2                            :	inout STD_LOGIC;
      DA3                            :	inout STD_LOGIC;
      DA4                            :	inout STD_LOGIC;
      DA5                            :	inout STD_LOGIC;
      DA6                            :	inout STD_LOGIC;
      DA7                            :	inout STD_LOGIC;
      EDA0                           :	inout STD_LOGIC;
      DB0                            :	inout STD_LOGIC;
      DB1                            :	inout STD_LOGIC;
      DB2                            :	inout STD_LOGIC;
      DB3                            :	inout STD_LOGIC;
      DB4                            :	inout STD_LOGIC;
      DB5                            :	inout STD_LOGIC;
      DB6                            :	inout STD_LOGIC;
      DB7                            :	inout STD_LOGIC;
      EDB0                           :	inout STD_LOGIC);
end component;

----- Component RAMB512X9SAF -----
component RAMB512X9SAF
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;

----- Component RAMB512X9SAF_1 -----
component RAMB512X9SAF_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;

----- Component RAMB512X9SAR -----
component RAMB512X9SAR
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;

----- Component RAMB512X9SAR_1 -----
component RAMB512X9SAR_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;


----- Component RAMB512X9SSF -----
component RAMB512X9SSF
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;

----- Component RAMB512X9SSF_1 -----
component RAMB512X9SSF_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;

----- Component RAMB512X9SSR -----
component RAMB512X9SSR
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;

----- Component RAMB512X9SSR_1 -----
component RAMB512X9SSR_1
    GENERIC (   INIT09: BIT_VECTOR;
		INIT08: BIT_VECTOR;
		INIT07: BIT_VECTOR;
		INIT06: BIT_VECTOR;
		INIT05: BIT_VECTOR;
		INIT04: BIT_VECTOR;
		INIT03: BIT_VECTOR;
		INIT02: BIT_VECTOR;
		INIT01: BIT_VECTOR
	);
   port(
      WEN                            :	in    STD_LOGIC;
      RWCLK                          :	in    STD_LOGIC;
      CE                             :	in    STD_LOGIC;
      OE                             :	in    STD_LOGIC;
      ADD0                           :	in    STD_LOGIC;
      ADD1                           :	in    STD_LOGIC;
      ADD2                           :	in    STD_LOGIC;
      ADD3                           :	in    STD_LOGIC;
      ADD4                           :	in    STD_LOGIC;
      ADD5                           :	in    STD_LOGIC;
      ADD6                           :	in    STD_LOGIC;
      ADD7                           :	in    STD_LOGIC;
      ADD8                           :	in    STD_LOGIC;
      D0                             :	inout STD_LOGIC;
      D1                             :	inout STD_LOGIC;
      D2                             :	inout STD_LOGIC;
      D3                             :	inout STD_LOGIC;
      D4                             :	inout STD_LOGIC;
      D5                             :	inout STD_LOGIC;
      D6                             :	inout STD_LOGIC;
      D7                             :	inout STD_LOGIC;
      D8                             :	inout STD_LOGIC);
end component;

----- Component SHIFT8 -----
component SHIFT8
   generic(INIT : bit_vector := X"00");
   port(
      SI                             :	in    STD_LOGIC;
      A0                             :	in    STD_LOGIC;
      A1                             :	in    STD_LOGIC;
      A2                             :	in    STD_LOGIC;
      EN                             :	in    STD_LOGIC;
      CLK                            :	in    STD_LOGIC;
      SO                             :	out   STD_LOGIC);
end component;


----- Component UCP_LSB -----
component UCP_LSB
   port(
      D                              :	in    STD_LOGIC;
      SD                             :	in    STD_LOGIC;
      LOAD                           :	in    STD_LOGIC;
      CYIBAR                         :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component UC_LSB -----
component UC_LSB
   port(
      D                              :	in    STD_LOGIC;
      CYIBAR                         :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
end component;


----- Component UDC_LSB -----
component UDC_LSB
   port(
      D                              :	in    STD_LOGIC;
      UD                             :	in    STD_LOGIC;
      UDB                            :	in    STD_LOGIC;
      CYIBAR                         :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
      COUT                           :	out   STD_LOGIC;
      UDBAR                          :	out   STD_LOGIC);
end component;


----- Component VCC -----
component VCC
   port(
      X                              :	out   STD_LOGIC := '1');
end component;

----- Component CDRX_10B12B -----
 component CDRX_10B12B
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "12";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      SYMPAT: STRING := "111111000000";
      PLL_DLY  : string  := "0.0");
   port(
      SIN               : in    STD_ULOGIC;
      REFCLK            : in    STD_ULOGIC;
      CDRRST            : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RXD6              : out   STD_ULOGIC;
      RXD7              : out   STD_ULOGIC;
      RXD8              : out   STD_ULOGIC;
      RXD9              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC;
      SYDT              : out   STD_ULOGIC);
 end component;

----- Component CDRX_8B10B -----
 component CDRX_8B10B
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "10";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0";
      SYMPAT   : string  := "11000001010011111010");
   port(
      SIN               : in    STD_ULOGIC;
      REFCLK            : in    STD_ULOGIC;
      CDRRST            : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RXD6              : out   STD_ULOGIC;
      RXD7              : out   STD_ULOGIC;
      RXD8              : out   STD_ULOGIC;
      RXD9              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC;
      SYDT              : out   STD_ULOGIC);

 end component;


----- Component CDRX_SS_4 -----
 component CDRX_SS_4
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "4";
      DIV      : string  := "1";
--      POST     : string  := "1";
      LOCK_CYC : integer := 2;
--      SECDIV   : string   := "1";
      SYMPAT   : string  := "110011001100";
      PLL_DLY  : string  := "0.0");
   port(
      SIN               : in    STD_ULOGIC;
      CAL               : in    STD_ULOGIC;
      SS_CLKIN          : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC;
      SYDT              : out   STD_ULOGIC);

 end component;


----- Component CDRX_SS_6 -----
 component CDRX_SS_6
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "6";
      DIV      : string  := "1";
 --     POST     : string  := "1";
      LOCK_CYC : integer := 2;
 --     SECDIV   : string   := "1";
      SYMPAT   : string  := "111000111000";
      PLL_DLY  : string  := "0.0");
   port(
      SIN               : in    STD_ULOGIC;
      CAL               : in    STD_ULOGIC;
      SS_CLKIN          : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC;
      SYDT              : out   STD_ULOGIC);

 end component;


----- Component CDRX_SS_8 -----
 component CDRX_SS_8
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "8";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      SYMPAT   : string  := "000011110000";
      PLL_DLY  : string  := "0.0");
   port(
      SIN               : in    STD_ULOGIC;
      CAL               : in    STD_ULOGIC;
      SS_CLKIN          : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RXD6              : out   STD_ULOGIC;
      RXD7              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC;
      SYDT              : out   STD_ULOGIC);

 end component;

----- Component CDRX_SS_10 -----
 component CDRX_SS_10
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "10";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      SYMPAT   : string  := "001111100000";
      PLL_DLY  : string  := "0.0");
   port(
      SIN               : in    STD_ULOGIC;
      CAL               : in    STD_ULOGIC;
      SS_CLKIN          : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RXD6              : out   STD_ULOGIC;
      RXD7              : out   STD_ULOGIC;
      RXD8              : out   STD_ULOGIC;
      RXD9              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC;
      SYDT              : out   STD_ULOGIC);

 end component;


----- Component HSLB_10B12B -----
 component HSLB_10B12B
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "12";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      CDRRST            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      TXD4              : in    STD_ULOGIC;
      TXD5              : in    STD_ULOGIC;
      TXD6              : in    STD_ULOGIC;
      TXD7              : in    STD_ULOGIC;
      TXD8              : in    STD_ULOGIC;
      TXD9              : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RXD6              : out   STD_ULOGIC;
      RXD7              : out   STD_ULOGIC;
      RXD8              : out   STD_ULOGIC;
      RXD9              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;


----- Component HSLB_8B10B -----
 component HSLB_8B10B
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "10";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      CDRRST            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      TXD4              : in    STD_ULOGIC;
      TXD5              : in    STD_ULOGIC;
      TXD6              : in    STD_ULOGIC;
      TXD7              : in    STD_ULOGIC;
      TXD8              : in    STD_ULOGIC;
      TXD9              : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RXD6              : out   STD_ULOGIC;
      RXD7              : out   STD_ULOGIC;
      RXD8              : out   STD_ULOGIC;
      RXD9              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;


----- Component RX_SS_4 -----
 component RX_SS_4
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "4";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PHASE_ADJ  : string  := "1");
   port(
      SIN               : in    STD_ULOGIC;
      SS_CLKIN          : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);
 end component;


----- Component RX_SS_6 -----
 component RX_SS_6
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "6";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PHASE_ADJ  : string  := "1");
   port(
      SIN               : in    STD_ULOGIC;
      SS_CLKIN          : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;


----- Component RX_SS_8 -----
 component RX_SS_8 
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "8";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PHASE_ADJ  : string  := "1");
   port(
      SIN               : in    STD_ULOGIC;
      CAL               : in    STD_ULOGIC;
      SS_CLKIN          : in    STD_ULOGIC;
      RXD0              : out   STD_ULOGIC;
      RXD1              : out   STD_ULOGIC;
      RXD2              : out   STD_ULOGIC;
      RXD3              : out   STD_ULOGIC;
      RXD4              : out   STD_ULOGIC;
      RXD5              : out   STD_ULOGIC;
      RXD6              : out   STD_ULOGIC;
      RXD7              : out   STD_ULOGIC;
      RECCLK            : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC;
      SYDT              : out   STD_ULOGIC);

 end component;


----- Component TX_10B12B -----
 component TX_10B12B
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "12";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      TXD4              : in    STD_ULOGIC;
      TXD5              : in    STD_ULOGIC;
      TXD6              : in    STD_ULOGIC;
      TXD7              : in    STD_ULOGIC;
      TXD8              : in    STD_ULOGIC;
      TXD9              : in    STD_ULOGIC;
      SOUT              : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;


----- Component TX_8B10B -----
 component TX_8B10B
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "10";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      TXD4              : in    STD_ULOGIC;
      TXD5              : in    STD_ULOGIC;
      TXD6              : in    STD_ULOGIC;
      TXD7              : in    STD_ULOGIC;
      TXD8              : in    STD_ULOGIC;
      TXD9              : in    STD_ULOGIC;
      SOUT              : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;


----- Component TX_SS_4 -----
 component TX_SS_4
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "4";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      SOUT              : out   STD_ULOGIC;
      SS_CLKOUT         : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;


----- Component TX_SS_6 -----
 component TX_SS_6
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "6";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      TXD4              : in    STD_ULOGIC;
      TXD5              : in    STD_ULOGIC;
      TXD6              : in    STD_ULOGIC;
      TXD7              : in    STD_ULOGIC;
      SOUT              : out   STD_ULOGIC;
      SS_CLKOUT         : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;


----- Component TX_SS_8 -----
 component TX_SS_8
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "8";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      TXD4              : in    STD_ULOGIC;
      TXD5              : in    STD_ULOGIC;
      TXD6              : in    STD_ULOGIC;
      TXD7              : in    STD_ULOGIC;
      SOUT              : out   STD_ULOGIC;
      SS_CLKOUT         : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;

----- Component TX_SS_10 -----
 component TX_SS_10
   generic(
      IN_FREQ  : string  := "100.0";
      MULT     : string  := "10";
      DIV      : string  := "1";
      LOCK_CYC : integer := 2;
      PLL_DLY  : string  := "0.0");
   port(
      REFCLK            : in    STD_ULOGIC;
      TXD0              : in    STD_ULOGIC;
      TXD1              : in    STD_ULOGIC;
      TXD2              : in    STD_ULOGIC;
      TXD3              : in    STD_ULOGIC;
      TXD4              : in    STD_ULOGIC;
      TXD5              : in    STD_ULOGIC;
      TXD6              : in    STD_ULOGIC;
      TXD7              : in    STD_ULOGIC;
      TXD8              : in    STD_ULOGIC;
      TXD9              : in    STD_ULOGIC;
      SOUT              : out   STD_ULOGIC;
      SS_CLKOUT         : out   STD_ULOGIC;
      CSLOCK            : out   STD_ULOGIC);

 end component;

-------Component fifo-------
 component fifo
  generic (
         lpm_type         : string  := "Lattice_MEM";
	 module_type      : string  := "FIFO";
	 module_width     : integer := 1;
	 module_widthu    : integer := 1;
	 module_numwords  : integer := 2;
         module_amfull_flag : integer := 1;
         module_amempty_flag : integer := 1;
	 module_hint      : string  := "UNUSED");

  port (
	 Data          :  in  std_logic_vector (module_width-1 downto 0);
	 Clock         :  in  std_logic;
	 WrEn          :  in  std_logic;
	 RdEn          :  in  std_logic;
	 Reset         :  in  std_logic;
	 RPReset       :  in  std_logic;
	 Q             :  out std_logic_vector (module_width-1 downto 0);
	 Full          :  out std_logic;
	 Empty         :  out std_logic;
	 AlmostFull    :  out std_logic;
	 AlmostEmpty   :  out std_logic);

end component;

-------Component fifo_dc-------
 component fifo_dc
  generic (
         lpm_type         : string  := "Lattice_MEM";
	 module_type      : string  := "FIFO_DC";
	 module_width     : integer := 1;
	 module_widthu    : integer := 1;
	 module_numwords  : integer := 2;
         module_amfull_flag : integer := 1;
         module_amempty_flag : integer := 1;
	 module_hint      : string  := "UNUSED");

  port (
	 Data          :  in  std_logic_vector (module_width-1 downto 0);
	 WrClock       :  in  std_logic;
	 WrEn          :  in  std_logic;
	 RdClock       :  in  std_logic;
	 RdEn          :  in  std_logic;
	 Reset          :  in  std_logic;
	 RPReset       :  in  std_logic;
	 Q             :  out std_logic_vector (module_width-1 downto 0);
	 Full          :  out std_logic;
	 Empty         :  out std_logic;
	 AlmostFull    :  out std_logic;
	 AlmostEmpty   :  out std_logic);

end component;

-------Component fifo_dcx-------
 component fifo_dcx
  generic (
         lpm_type          : string  := "Lattice_MEM";
	 module_type       : string  := "FIFO_DCX";
	 module_widthw     : integer := 1;
	 module_widthr     : integer := 1;
	 module_widthuw    : integer := 1;
	 module_widthur    : integer := 1;
	 module_numwordsw  : integer := 2;
	 module_numwordsr  : integer := 2;
         module_amfull_flag : integer := 1;
         module_amempty_flag : integer := 1;
	 module_hint      : string  := "UNUSED");

  port (
	 Data          :  in  std_logic_vector (module_widthw-1 downto 0);
	 WrClock       :  in  std_logic;
	 WrEn          :  in  std_logic;
	 RdClock       :  in  std_logic;
	 RdEn          :  in  std_logic;
	 Reset          :  in  std_logic;
	 RPReset       :  in  std_logic;
	 Q             :  out std_logic_vector (module_widthr-1 downto 0);
	 Full          :  out std_logic;
	 Empty         :  out std_logic;
	 AlmostFull    :  out std_logic;
	 AlmostEmpty   :  out std_logic);

end component;

-------Component ram_dp-------
 component ram_dp
  generic( lpm_type                : string  := "Lattice_MEM";
	   module_type             : string  := "RAM_DP";
	   module_widthw           : integer := 1;
	   module_widthr           : integer := 1;
	   module_numwordsw        : integer := 1;
	   module_widthadw         : integer := 1;
	   module_widthadr         : integer := 1;
   	   module_numwordsr        : integer := 1;
  	   module_indata           : string := "REGISTERED";
	   module_outdata          : string := "UNREGISTERED";
    	   module_addressw_control : string := "REGISTERED";
	   module_addressr_control : string := "REGISTERED";
	   module_hint             : string := "UNUSED";
           module_init_file        : string := "");


  port(
           Data        : in  std_logic_vector (module_widthw-1 downto 0);
           WrAddress   : in  std_logic_vector (module_widthadw-1 downto 0);
           RdAddress   : in  std_logic_vector (module_widthadr-1 downto 0);
           WrClock     : in std_logic;
           WrClockEn   : in std_logic;
           RdClock     : in std_logic;
           RdClockEn   : in std_logic;
           WE          : in std_logic;
           Q           : out std_logic_vector (module_widthr-1 downto 0));

end component;

-------Component ram_dp_true-------
 component ram_dp_true 
generic (     lpm_type         : string := "Lattice_MEM";
              module_type      : string := "RAM_DP_TRUE";
              module_widtha    : positive;
              module_widthada  : positive;
              module_numwordsa : positive;
              module_widthb    : positive;
              module_widthadb  : positive;
              module_numwordsb : positive;
              module_indata    : string :="REGISTERED";
              module_outdata   : string :="UNREGISTERED";
              module_addressa_control   : string :="REGISTERED";
              module_addressb_control   : string :="REGISTERED";
              module_init_file        : string := "";
              module_hint      : string :="UNUSED");
      port (  
              DataInA       : in std_logic_vector(module_widtha-1 downto 0);
              AddressA      : in std_logic_vector(module_widthada-1 downto 0);
              DataInB       : in std_logic_vector(module_widthb-1 downto 0);
              AddressB      : in std_logic_vector(module_widthadb-1 downto 0);
              ClockA        : in std_logic := '0';
              ClockEnA      : in std_logic := '0';
              ClockB        : in std_logic := '0';
              ClockEnB      : in std_logic := '0';
              WrA           : in std_logic;
              WrB           : in std_logic;
              ResetA        : in std_logic;
              ResetB        : in std_logic;
              QA            : out std_logic_vector(module_widtha-1 downto 0);
              QB            : out std_logic_vector(module_widthb-1 downto 0));
end component;

-------Component ram_dq-------
 component ram_dq
  generic( lpm_type               : string  := "Lattice_MEM";
	   module_type            : string  := "RAM_DQ";
	   module_width           : integer := 1;
	   module_numwords        : integer := 1;
	   module_widthad         : integer := 1;
  	   module_indata          : string  := "REGISTERED";
	   module_outdata         : string  := "UNREGISTERED";
	   module_address_control : string  := "REGISTERED";
           module_init_file       : string := "";
	   module_hint            : string  := "UNUSED");

  port(

           Data                : in  std_logic_vector (module_width-1 downto 0);
           Address             : in  std_logic_vector (module_widthad-1 downto 0);
           Clock               : in  std_logic;
           ClockEn             : in  std_logic;
           WE                  : in  std_logic;
           Q                   : out std_logic_vector (module_width-1 downto 0));
  end component;

-------Component rom-------
 component rom
  generic ( lpm_type                  : string  := "Lattice_MEM";
	    module_type               : string  := "ROM";
	    module_width              : integer := 1;
	    module_numwords           : integer := 1;
	    module_widthad            : integer := 1;
	    module_outdata            : string  := "REGISTERED";
	    module_address_control    : string  := "REGISTERED";
            module_init_file          : string  := "init_file";
	    module_hint               : string  := "UNUSED");
  port (
            Address       : in  std_logic_vector (module_widthad-1 downto 0);
            OutClock      : in  std_logic;
            OutClockEn    : in  std_logic;
            Q             : out std_logic_vector (module_width-1 downto 0));
 end component;

end COMPONENTS;

package body Components is 
 
 
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
                while pos <= L'right and L(pos) /= '.' and L(pos) /= ' ' and L(pos) /= HT  loop
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

    function str2std(L: string) return std_logic_vector is 
	variable vpos : integer := 0;	-- Index of last valid bit in val.
	variable lpos : integer;	-- Index of next unused char in L.
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
		    exit;	-- Bit values must be '0' or '1'.
		end if;
		lpos := lpos + 1;
	    end loop;
        return val;
    end str2std;


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

function init_flag (init_file : string) return integer is
    variable flag  : integer := 0;
begin
    if (init_file = "") then
        flag := 0;
    else
        flag := 1;
    end if;

    return flag;
end init_flag;

end components;

---- end of components library ----

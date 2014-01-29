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
-- Simulation package file for ispMACh5000MX components
-- 
-- -------------------------------------------------------------------- 
-- 
-- Revision History : 

--$Header: R:/src/mod_kits/Mach/vital/rcs/LC5KMX_Components.vhd 1.28 2004/03/04 18:36:00Z jli Exp $
----------------------------------------------------------------
-- 
-- FILE CONTENTS:    ispMACH5000 VITAL Component Package
-- DATE CREATED :    Wen Sept  15 1998
-- 
-- LIBRARY      :    MACH
-- REVISION     :    1.0 
-- TIME SCALE   :    1 ns
-- LOGIC SYSTEM :    IEEE-1164
-- NOTES        :    
-- HISTORY      :
-- 
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;

package Components is

constant DefaultTimingChecksOn : Boolean := True;
constant DefaultXon : Boolean := True;
constant DefaultMsgOn : Boolean := True;

function Str2int( L : string) return integer;
function Str2real( L : string) return REAL;
function Valid_Address (IN_ADDR : in std_logic_vector) return boolean;
function init_flag(init_file : string) return integer;

---------------------------------------------------------------------------
----- Component SPLL -----
component SPLL
   generic (in_freq : string;
            clk_out_to_pin: STRING := "OFF";
            wake_on_lock: STRING := "OFF");
   port(
      CLK_IN                         :	in    STD_ULOGIC;
      CLK_OUT                        :	out   STD_ULOGIC);
end component;

----- Component STDPLL -----
component STDPLL
   generic (in_freq  : string  := "100.0";
            clk_out_to_pin: STRING := "OFF";
            wake_on_lock: STRING := "OFF";
            mult     : string  := "1";
            div      : string  := "1";
            post     : string  := "1";
            secdiv   : string  := "1";
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
            clk_out_to_pin: STRING := "OFF";
            wake_on_lock: STRING := "OFF";
            mult     : string  := "1";
            div      : string  := "1";
            post     : string  := "1";
            secdiv   : string  := "1";
            lock_cyc : integer := 1;
            pll_dly  : string  := "0.0");
   port(
      CLK_IN                         :	in    STD_ULOGIC;
      PLL_FBK                        :	in    STD_ULOGIC;
      PLL_RST                        :	in    STD_ULOGIC;
      CLK_OUT                        :	out   STD_ULOGIC;
      SEC_OUT                        :	out   STD_ULOGIC;
      PLL_LOCK                       :	out   STD_ULOGIC);
end component;

----- Component AND2 -----
component AND2
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component AND3 -----
component AND3
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component AND4 -----
component AND4
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component AND5 -----
component AND5
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component AND6 -----
component AND6
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component AND7 -----
component AND7
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component AND8 -----
component AND8
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      I7                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;

----- Component BI_DIR ----
component BI_DIR
   generic (PULL   : string  := "Off";
            OUTOPEN : string := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      OE                             :	in    STD_ULOGIC;
      IO                             :	inout STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component MUX2 -----
component MUX2
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


----- Component BUFF -----
component BUFF
   port(
      I0                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component BUFTH -----
component BUFTH
   generic (OUTOPEN   : string  := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      OE                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;



----- Component BUFTL -----
component BUFTL
   generic (OUTOPEN   : string  := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      OE                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component CLKI -----
component CLKI
   port(
      PAD                            :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component DFF -----
component DFF
   generic (R_DELAY : TIME := 2 ns);
   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFC -----
component DFFC
   generic (R_DELAY : TIME := 2 ns);
   port(
      CE                             :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFCR -----
component DFFCR
   port(
      CE                             :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFCRH -----
component DFFCRH
   port(
      CE                             :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFCRS -----
component DFFCRS
   port(
      CE                             :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFCRSH -----
component DFFCRSH
   port(
      CE                             :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFCS -----
component DFFCS
   port(
      CE                             :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFCSH -----
component DFFCSH
   port(
      CE                             :	in    STD_ULOGIC;
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFR -----
component DFFR
   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFRH -----
component DFFRH
   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFRS -----
component DFFRS
   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFRSH -----
component DFFRSH
   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFS -----
component DFFS
   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DFFSH -----
component DFFSH
   port(
      D                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DLAT -----
component DLAT
   port(
      D                              :	in    STD_ULOGIC;
      LAT                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DLATR -----
component DLATR
   port(
      D                              :	in    STD_ULOGIC;
      LAT                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DLATRH -----
component DLATRH
   port(
      D                              :	in    STD_ULOGIC;
      LAT                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DLATRS -----
component DLATRS
   port(
      D                              :	in    STD_ULOGIC;
      LAT                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DLATRSH -----
component DLATRSH
   port(
      D                              :	in    STD_ULOGIC;
      LAT                            :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DLATS -----
component DLATS
   port(
      D                              :	in    STD_ULOGIC;
      LAT                            :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component DLATSH -----
component DLATSH
   port(
      D                              :	in    STD_ULOGIC;
      LAT                            :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component GND -----
component GND
   port(
      X                              :	out   STD_ULOGIC := '0');
end component;


----- Component IBUF -----
component IBUF
   generic (PULL   : string  := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;

----- Component LVDSIN -----
component LVDSIN
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

----- Component INV -----
component INV
   port(
      I0                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component INVTH -----
component INVTH
   generic (OUTOPEN   : string  := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      OE                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component INVTL -----
component INVTL
   generic (OUTOPEN   : string  := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      OE                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NAN2 -----
component NAN2
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NAN3 -----
component NAN3
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NAN4 -----
component NAN4
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NAN5 -----
component NAN5
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NAN6 -----
component NAN6
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NAN7 -----
component NAN7
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NAN8 -----
component NAN8
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      I7                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NOR2 -----
component NOR2
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NOR3 -----
component NOR3
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NOR4 -----
component NOR4
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NOR5 -----
component NOR5
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NOR6 -----
component NOR6
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NOR7 -----
component NOR7
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component NOR8 -----
component NOR8
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      I7                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component OBUF -----
component OBUF
   generic (OUTOPEN   : string  := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;

----- Component LVDSOUT -----
component LVDSOUT
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

----- Component OR2 -----
component OR2
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component OR3 -----
component OR3
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component OR4 -----
component OR4
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component OR5 -----
component OR5
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component OR6 -----
component OR6
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component OR7 -----
component OR7
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component OR8 -----
component OR8
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      I2                             :	in    STD_ULOGIC;
      I3                             :	in    STD_ULOGIC;
      I4                             :	in    STD_ULOGIC;
      I5                             :	in    STD_ULOGIC;
      I6                             :	in    STD_ULOGIC;
      I7                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;



----- Component TFF -----
component TFF
   port(
      T                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component TFFR -----
component TFFR
   port(
      T                              :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component TFFRH -----
component TFFRH
   port(
      T                              :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component TFFRS -----
component TFFRS
   port(
      T                              :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component TFFRSH -----
component TFFRSH
   port(
      T                              :	in    STD_ULOGIC;
      R                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component TFFS -----
component TFFS
   port(
      T                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component TFFSH -----
component TFFSH
   port(
      T                              :	in    STD_ULOGIC;
      S                              :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      Q                              :	out   STD_ULOGIC);
end component;


----- Component VCC -----
component VCC
   port(
      X                              :	out   STD_ULOGIC := '1');
end component;


----- Component XOR2 -----
component XOR2
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;

----- Component XORSOFT -----
component XORSOFT
   port(
      I0                             :	in    STD_ULOGIC;
      I1                             :	in    STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
end component;


----- Component CCU_AGB -----
component CCU_AGB
   port(
      A0                             :	in    STD_LOGIC;
      B0                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      COUT                           :	out   STD_LOGIC);
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

----- Component CCU_ADD -----
component CCU_ADD
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

----- Component CCU_UDC -----
component CCU_UDC
   port(
      D                              :	in    STD_LOGIC;
      UD                             :	in    STD_LOGIC;
      CIN                            :	in    STD_LOGIC;
      S0                             :	out   STD_LOGIC;
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

----- Component DC_LSB -----
component DC_LSB
   port(
      D                              :	in    STD_LOGIC;
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


----- Component RAMB16K_WX1_RX1 -----
component RAMB16K_WX1_RX1
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RAD12                           :	in    STD_ULOGIC;
      RAD13                           :	in    STD_ULOGIC;
      RD0                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16KA_WX1_RX1 -----
component RAMB16KA_WX1_RX1
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RAD12                           :	in    STD_ULOGIC;
      RAD13                           :	in    STD_ULOGIC;
      RD0                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16K_WX1_RX2 -----
component RAMB16K_WX1_RX2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RAD12                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out   STD_ULOGIC);

end component;

----- Component RAMB16KA_WX1_RX2 -----
component RAMB16KA_WX1_RX2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RAD12                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out   STD_ULOGIC);

end component;


----- Component RAMB16K_WX1_RX4 -----
component RAMB16K_WX1_RX4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16KA_WX1_RX4 -----
component RAMB16KA_WX1_RX4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16K_WX1_RX8 -----
component RAMB16K_WX1_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);

end component;

----- Component RAMB16KA_WX1_RX8 -----
component RAMB16KA_WX1_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);

end component;

----- Component RAMB16K_WX1_RX16 -----
component RAMB16K_WX1_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16KA_WX1_RX16 -----
component RAMB16KA_WX1_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;


----- Component RAMB16K_WX1_RX32 -----
component RAMB16K_WX1_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16KA_WX1_RX32 -----
component RAMB16KA_WX1_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      WAD13                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;


----- Component RAMB16K_WX2_RX2 -----
component RAMB16K_WX2_RX2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RAD12                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out   STD_ULOGIC);

end component;

----- Component RAMB16KA_WX2_RX2 -----
component RAMB16KA_WX2_RX2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RAD12                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out   STD_ULOGIC);

end component;

----- Component RAMB16K_WX2_RX4 -----
component RAMB16K_WX2_RX4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16KA_WX2_RX4 -----
component RAMB16KA_WX2_RX4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16K_WX2_RX8 -----
component RAMB16K_WX2_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);
end component;

----- Component RAMB16K_WX2_RX8 -----
component RAMB16KA_WX2_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);
end component;


----- Component RAMB16K_WX2_RX16 -----
component RAMB16K_WX2_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16KA_WX2_RX16 -----
component RAMB16KA_WX2_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16K_WX2_RX32 -----
component RAMB16K_WX2_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16KA_WX2_RX32 -----
component RAMB16KA_WX2_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16K_WX4_RX4 -----
component RAMB16K_WX4_RX4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16KA_WX4_RX4 -----
component RAMB16KA_WX4_RX4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RAD11                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out   STD_ULOGIC);
end component;

----- Component RAMB16K_WX4_RX8 -----
component RAMB16K_WX4_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);
end component;

----- Component RAMB16KA_WX4_RX8 -----
component RAMB16KA_WX4_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);
end component;

----- Component RAMB16K_WX4_RX16 -----
component RAMB16K_WX4_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16KA_WX4_RX16 -----
component RAMB16KA_WX4_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16K_WX4_RX32 -----
component RAMB16K_WX4_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16KA_WX4_RX32 -----
component RAMB16KA_WX4_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16K_WX8_RX8 -----
component RAMB16K_WX8_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);


end component;

----- Component RAMB16KA_WX8_RX8 -----
component RAMB16KA_WX8_RX8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RAD10                           :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC);


end component;

----- Component RAMB16K_WX8_RX16 -----
component RAMB16K_WX8_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16KA_WX8_RX16 -----
component RAMB16KA_WX8_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16K_WX8_RX32 -----
component RAMB16K_WX8_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16KA_WX8_RX32 -----
component RAMB16KA_WX8_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16K_WX16_RX16 -----
component RAMB16K_WX16_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16KA_WX16_RX16 -----
component RAMB16KA_WX16_RX16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RAD9                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC);
end component;

----- Component RAMB16K_WX16_RX32 -----
component RAMB16K_WX16_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16KA_WX16_RX32 -----
component RAMB16KA_WX16_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      WAD9                            :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16K_WX32_RX32 -----
component RAMB16K_WX32_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

----- Component RAMB16KA_WX32_RX32 -----
component RAMB16KA_WX32_RX32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WAD7                            :	in    STD_ULOGIC;
      WAD8                            :	in    STD_ULOGIC;
      RAD0                            :	in    STD_ULOGIC;
      RAD1                            :	in    STD_ULOGIC;
      RAD2                            :	in    STD_ULOGIC;
      RAD3                            :	in    STD_ULOGIC;
      RAD4                            :	in    STD_ULOGIC;
      RAD5                            :	in    STD_ULOGIC;
      RAD6                            :	in    STD_ULOGIC;
      RAD7                            :	in    STD_ULOGIC;
      RAD8                            :	in    STD_ULOGIC;
      RD0                             :	out    STD_ULOGIC;
      RD1                             :	out    STD_ULOGIC;
      RD2                             :	out    STD_ULOGIC;
      RD3                             :	out    STD_ULOGIC;
      RD4                             :	out    STD_ULOGIC;
      RD5                             :	out    STD_ULOGIC;
      RD6                             :	out    STD_ULOGIC;
      RD7                             :	out    STD_ULOGIC;
      RD8                             :	out    STD_ULOGIC;
      RD9                             :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :	out    STD_ULOGIC;
      RD16                            :	out    STD_ULOGIC;
      RD17                            :	out    STD_ULOGIC;
      RD18                            :	out    STD_ULOGIC;
      RD19                            :	out    STD_ULOGIC;
      RD20                            :	out    STD_ULOGIC;
      RD21                            :	out    STD_ULOGIC;
      RD22                            :	out    STD_ULOGIC;
      RD23                            :	out    STD_ULOGIC;
      RD24                            :	out    STD_ULOGIC;
      RD25                            :	out    STD_ULOGIC;
      RD26                            :	out    STD_ULOGIC;
      RD27                            :	out    STD_ULOGIC;
      RD28                            :	out    STD_ULOGIC;
      RD29                            :	out    STD_ULOGIC;
      RD30                            :	out    STD_ULOGIC;
      RD31                            :	out    STD_ULOGIC);

end component;

-----Component RAMB16K_WX2_RX1-----
component RAMB16K_WX2_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX2_RX1-----
component RAMB16KA_WX2_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      WAD12                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX4_RX1-----
component RAMB16K_WX4_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX4_RX1-----
component RAMB16KA_WX4_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX4_RX2-----
component RAMB16K_WX4_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX4_RX2-----
component RAMB16KA_WX4_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      WAD11                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX8_RX1-----
component RAMB16K_WX8_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX8_RX1-----
component RAMB16KA_WX8_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX8_RX2-----
component RAMB16K_WX8_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX8_RX2-----
component RAMB16KA_WX8_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX8_RX4-----
component RAMB16K_WX8_RX4
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX8_RX4-----
component RAMB16KA_WX8_RX4
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      WAD10                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX16_RX1-----
component RAMB16K_WX16_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX16_RX1-----
component RAMB16KA_WX16_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX16_RX2-----
component RAMB16K_WX16_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX16_RX2-----
component RAMB16KA_WX16_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX16_RX4-----
component RAMB16K_WX16_RX4
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX16_RX4-----
component RAMB16KA_WX16_RX4
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX16_RX8-----
component RAMB16K_WX16_RX8
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :	out    STD_ULOGIC;
      RD4                            :	out    STD_ULOGIC;
      RD5                            :	out    STD_ULOGIC;
      RD6                            :	out    STD_ULOGIC;
      RD7                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX16_RX8-----
component RAMB16KA_WX16_RX8
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      WAD9                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :	out    STD_ULOGIC;
      RD4                            :	out    STD_ULOGIC;
      RD5                            :	out    STD_ULOGIC;
      RD6                            :	out    STD_ULOGIC;
      RD7                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX32_RX1-----
component RAMB16K_WX32_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX32_RX1-----
component RAMB16KA_WX32_RX1
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RAD13                           :  in    STD_ULOGIC;
      RD0                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX32_RX2-----
component RAMB16K_WX32_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX32_RX2-----
component RAMB16KA_WX32_RX2
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RAD12                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX32_RX4-----
component RAMB16K_WX32_RX4
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX32_RX4-----
component RAMB16KA_WX32_RX4
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RAD11                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX32_RX8-----
component RAMB16K_WX32_RX8
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :	out    STD_ULOGIC;
      RD4                            :	out    STD_ULOGIC;
      RD5                            :	out    STD_ULOGIC;
      RD6                            :	out    STD_ULOGIC;
      RD7                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX32_RX8-----
component RAMB16KA_WX32_RX8
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RAD10                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :	out    STD_ULOGIC;
      RD4                            :	out    STD_ULOGIC;
      RD5                            :	out    STD_ULOGIC;
      RD6                            :	out    STD_ULOGIC;
      RD7                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16K_WX32_RX16-----
component RAMB16K_WX32_RX16
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RCEN                            :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :	out    STD_ULOGIC;
      RD4                            :	out    STD_ULOGIC;
      RD5                            :	out    STD_ULOGIC;
      RD6                            :	out    STD_ULOGIC;
      RD7                            :	out    STD_ULOGIC;
      RD8                            :	out    STD_ULOGIC;
      RD9                            :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :    out    STD_ULOGIC);
end component;

-----Component RAMB16KA_WX32_RX16-----
component RAMB16KA_WX32_RX16
      generic (RAM_INIT_FILE   : string  := "");
   port(
      WCEN                            :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      WCS0                            :	in    STD_ULOGIC;
      WCS1                            :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      WD0                            :	in    STD_ULOGIC;
      WD1                            :	in    STD_ULOGIC;
      WD2                            :	in    STD_ULOGIC;
      WD3                            :	in    STD_ULOGIC;
      WD4                            :	in    STD_ULOGIC;
      WD5                            :	in    STD_ULOGIC;
      WD6                            :	in    STD_ULOGIC;
      WD7                            :	in    STD_ULOGIC;
      WD8                            :	in    STD_ULOGIC;
      WD9                            :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WAD0                           :	in    STD_ULOGIC;
      WAD1                           :	in    STD_ULOGIC;
      WAD2                           :	in    STD_ULOGIC;
      WAD3                           :	in    STD_ULOGIC;
      WAD4                           :	in    STD_ULOGIC;
      WAD5                           :	in    STD_ULOGIC;
      WAD6                           :	in    STD_ULOGIC;
      WAD7                           :	in    STD_ULOGIC;
      WAD8                           :	in    STD_ULOGIC;
      RAD0                           :  in    STD_ULOGIC;
      RAD1                           :  in    STD_ULOGIC;
      RAD2                           :  in    STD_ULOGIC;
      RAD3                           :  in    STD_ULOGIC;
      RAD4                           :  in    STD_ULOGIC;
      RAD5                           :  in    STD_ULOGIC;
      RAD6                           :  in    STD_ULOGIC;
      RAD7                           :  in    STD_ULOGIC;
      RAD8                           :  in    STD_ULOGIC;
      RAD9                           :  in    STD_ULOGIC;
      RD0                            :	out    STD_ULOGIC;
      RD1                            :	out    STD_ULOGIC;
      RD2                            :	out    STD_ULOGIC;
      RD3                            :	out    STD_ULOGIC;
      RD4                            :	out    STD_ULOGIC;
      RD5                            :	out    STD_ULOGIC;
      RD6                            :	out    STD_ULOGIC;
      RD7                            :	out    STD_ULOGIC;
      RD8                            :	out    STD_ULOGIC;
      RD9                            :	out    STD_ULOGIC;
      RD10                            :	out    STD_ULOGIC;
      RD11                            :	out    STD_ULOGIC;
      RD12                            :	out    STD_ULOGIC;
      RD13                            :	out    STD_ULOGIC;
      RD14                            :	out    STD_ULOGIC;
      RD15                            :    out    STD_ULOGIC);
end component;

----- Component RAMB16K_X1 -----
component RAMB16K_X1
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      AD11                           :	in    STD_ULOGIC;
      AD12                           :	in    STD_ULOGIC;
      AD13                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC);
end component;

----- Component RAMB16KA_X1 -----
component RAMB16KA_X1
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      AD11                           :	in    STD_ULOGIC;
      AD12                           :	in    STD_ULOGIC;
      AD13                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC);
end component;

----- Component RAMB16K_X2 -----
component RAMB16K_X2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      AD11                           :	in    STD_ULOGIC;
      AD12                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16KA_X2 -----
component RAMB16KA_X2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      AD11                           :	in    STD_ULOGIC;
      AD12                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16K_X4 -----
component RAMB16K_X4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      AD11                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16KA_X4 -----
component RAMB16KA_X4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      AD11                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16K_X8 -----
component RAMB16K_X8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      DI4                            :	in    STD_ULOGIC;
      DI5                            :	in    STD_ULOGIC;
      DI6                            :	in    STD_ULOGIC;
      DI7                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC;
      DO4                            :	out   STD_ULOGIC;
      DO5                            :	out   STD_ULOGIC;
      DO6                            :	out   STD_ULOGIC;
      DO7                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16KA_X8 -----
component RAMB16KA_X8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      DI4                            :	in    STD_ULOGIC;
      DI5                            :	in    STD_ULOGIC;
      DI6                            :	in    STD_ULOGIC;
      DI7                            :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      AD10                           :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC;
      DO4                            :	out   STD_ULOGIC;
      DO5                            :	out   STD_ULOGIC;
      DO6                            :	out   STD_ULOGIC;
      DO7                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16K_X16 -----
component RAMB16K_X16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      DI4                            :	in    STD_ULOGIC;
      DI5                            :	in    STD_ULOGIC;
      DI6                            :	in    STD_ULOGIC;
      DI7                            :	in    STD_ULOGIC;
      DI8                            :	in    STD_ULOGIC;
      DI9                            :	in    STD_ULOGIC;
      DI10                           :	in    STD_ULOGIC;
      DI11                           :	in    STD_ULOGIC;
      DI12                           :	in    STD_ULOGIC;
      DI13                           :	in    STD_ULOGIC;
      DI14                           :	in    STD_ULOGIC;
      DI15                           :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC;
      DO4                            :	out   STD_ULOGIC;
      DO5                            :	out   STD_ULOGIC;
      DO6                            :	out   STD_ULOGIC;
      DO7                            :	out   STD_ULOGIC;
      DO8                            :	out   STD_ULOGIC;
      DO9                            :	out   STD_ULOGIC;
      DO10                            :	out   STD_ULOGIC;
      DO11                            :	out   STD_ULOGIC;
      DO12                            :	out   STD_ULOGIC;
      DO13                            :	out   STD_ULOGIC;
      DO14                            :	out   STD_ULOGIC;
      DO15                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16KA_X16 -----
component RAMB16KA_X16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      DI4                            :	in    STD_ULOGIC;
      DI5                            :	in    STD_ULOGIC;
      DI6                            :	in    STD_ULOGIC;
      DI7                            :	in    STD_ULOGIC;
      DI8                            :	in    STD_ULOGIC;
      DI9                            :	in    STD_ULOGIC;
      DI10                           :	in    STD_ULOGIC;
      DI11                           :	in    STD_ULOGIC;
      DI12                           :	in    STD_ULOGIC;
      DI13                           :	in    STD_ULOGIC;
      DI14                           :	in    STD_ULOGIC;
      DI15                           :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      AD9                            :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC;
      DO4                            :	out   STD_ULOGIC;
      DO5                            :	out   STD_ULOGIC;
      DO6                            :	out   STD_ULOGIC;
      DO7                            :	out   STD_ULOGIC;
      DO8                            :	out   STD_ULOGIC;
      DO9                            :	out   STD_ULOGIC;
      DO10                            :	out   STD_ULOGIC;
      DO11                            :	out   STD_ULOGIC;
      DO12                            :	out   STD_ULOGIC;
      DO13                            :	out   STD_ULOGIC;
      DO14                            :	out   STD_ULOGIC;
      DO15                            :	out   STD_ULOGIC);

end component;

----- Component RAMB16K_X32 -----
component RAMB16K_X32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      DI4                            :	in    STD_ULOGIC;
      DI5                            :	in    STD_ULOGIC;
      DI6                            :	in    STD_ULOGIC;
      DI7                            :	in    STD_ULOGIC;
      DI8                            :	in    STD_ULOGIC;
      DI9                            :	in    STD_ULOGIC;
      DI10                           :	in    STD_ULOGIC;
      DI11                           :	in    STD_ULOGIC;
      DI12                           :	in    STD_ULOGIC;
      DI13                           :	in    STD_ULOGIC;
      DI14                           :	in    STD_ULOGIC;
      DI15                           :	in    STD_ULOGIC;
      DI16                            :	in    STD_ULOGIC;
      DI17                            :	in    STD_ULOGIC;
      DI18                            :	in    STD_ULOGIC;
      DI19                            :	in    STD_ULOGIC;
      DI20                            :	in    STD_ULOGIC;
      DI21                            :	in    STD_ULOGIC;
      DI22                            :	in    STD_ULOGIC;
      DI23                            :	in    STD_ULOGIC;
      DI24                            :	in    STD_ULOGIC;
      DI25                            :	in    STD_ULOGIC;
      DI26                           :	in    STD_ULOGIC;
      DI27                           :	in    STD_ULOGIC;
      DI28                           :	in    STD_ULOGIC;
      DI29                           :	in    STD_ULOGIC;
      DI30                           :	in    STD_ULOGIC;
      DI31                           :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC;
      DO4                            :	out   STD_ULOGIC;
      DO5                            :	out   STD_ULOGIC;
      DO6                            :	out   STD_ULOGIC;
      DO7                            :	out   STD_ULOGIC;
      DO8                            :	out   STD_ULOGIC;
      DO9                            :	out   STD_ULOGIC;
      DO10                            :	out   STD_ULOGIC;
      DO11                            :	out   STD_ULOGIC;
      DO12                            :	out   STD_ULOGIC;
      DO13                            :	out   STD_ULOGIC;
      DO14                            :	out   STD_ULOGIC;
      DO15                            :	out   STD_ULOGIC;
      DO16                            :	out   STD_ULOGIC;
      DO17                            :	out   STD_ULOGIC;
      DO18                            :	out   STD_ULOGIC;
      DO19                            :	out   STD_ULOGIC;
      DO20                            :	out   STD_ULOGIC;
      DO21                            :	out   STD_ULOGIC;
      DO22                            :	out   STD_ULOGIC;
      DO23                            :	out   STD_ULOGIC;
      DO24                            :	out   STD_ULOGIC;
      DO25                            :	out   STD_ULOGIC;
      DO26                            :	out   STD_ULOGIC;
      DO27                            :	out   STD_ULOGIC;
      DO28                            :	out   STD_ULOGIC;
      DO29                            :	out   STD_ULOGIC;
      DO30                            :	out   STD_ULOGIC;
      DO31                            :	out   STD_ULOGIC);


end component;

----- Component RAMB16KA_X32 -----
component RAMB16KA_X32
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CEN                            :	in    STD_ULOGIC;
      CLK                            :	in    STD_ULOGIC;
      WR                             :	in    STD_ULOGIC;
      CS0                            :	in    STD_ULOGIC;
      CS1                            :	in    STD_ULOGIC;
      RST                            :	in    STD_ULOGIC;
      DI0                            :	in    STD_ULOGIC;
      DI1                            :	in    STD_ULOGIC;
      DI2                            :	in    STD_ULOGIC;
      DI3                            :	in    STD_ULOGIC;
      DI4                            :	in    STD_ULOGIC;
      DI5                            :	in    STD_ULOGIC;
      DI6                            :	in    STD_ULOGIC;
      DI7                            :	in    STD_ULOGIC;
      DI8                            :	in    STD_ULOGIC;
      DI9                            :	in    STD_ULOGIC;
      DI10                           :	in    STD_ULOGIC;
      DI11                           :	in    STD_ULOGIC;
      DI12                           :	in    STD_ULOGIC;
      DI13                           :	in    STD_ULOGIC;
      DI14                           :	in    STD_ULOGIC;
      DI15                           :	in    STD_ULOGIC;
      DI16                            :	in    STD_ULOGIC;
      DI17                            :	in    STD_ULOGIC;
      DI18                            :	in    STD_ULOGIC;
      DI19                            :	in    STD_ULOGIC;
      DI20                            :	in    STD_ULOGIC;
      DI21                            :	in    STD_ULOGIC;
      DI22                            :	in    STD_ULOGIC;
      DI23                            :	in    STD_ULOGIC;
      DI24                            :	in    STD_ULOGIC;
      DI25                            :	in    STD_ULOGIC;
      DI26                           :	in    STD_ULOGIC;
      DI27                           :	in    STD_ULOGIC;
      DI28                           :	in    STD_ULOGIC;
      DI29                           :	in    STD_ULOGIC;
      DI30                           :	in    STD_ULOGIC;
      DI31                           :	in    STD_ULOGIC;
      AD0                            :	in    STD_ULOGIC;
      AD1                            :	in    STD_ULOGIC;
      AD2                            :	in    STD_ULOGIC;
      AD3                            :	in    STD_ULOGIC;
      AD4                            :	in    STD_ULOGIC;
      AD5                            :	in    STD_ULOGIC;
      AD6                            :	in    STD_ULOGIC;
      AD7                            :	in    STD_ULOGIC;
      AD8                            :	in    STD_ULOGIC;
      DO0                            :	out   STD_ULOGIC;
      DO1                            :	out   STD_ULOGIC;
      DO2                            :	out   STD_ULOGIC;
      DO3                            :	out   STD_ULOGIC;
      DO4                            :	out   STD_ULOGIC;
      DO5                            :	out   STD_ULOGIC;
      DO6                            :	out   STD_ULOGIC;
      DO7                            :	out   STD_ULOGIC;
      DO8                            :	out   STD_ULOGIC;
      DO9                            :	out   STD_ULOGIC;
      DO10                            :	out   STD_ULOGIC;
      DO11                            :	out   STD_ULOGIC;
      DO12                            :	out   STD_ULOGIC;
      DO13                            :	out   STD_ULOGIC;
      DO14                            :	out   STD_ULOGIC;
      DO15                            :	out   STD_ULOGIC;
      DO16                            :	out   STD_ULOGIC;
      DO17                            :	out   STD_ULOGIC;
      DO18                            :	out   STD_ULOGIC;
      DO19                            :	out   STD_ULOGIC;
      DO20                            :	out   STD_ULOGIC;
      DO21                            :	out   STD_ULOGIC;
      DO22                            :	out   STD_ULOGIC;
      DO23                            :	out   STD_ULOGIC;
      DO24                            :	out   STD_ULOGIC;
      DO25                            :	out   STD_ULOGIC;
      DO26                            :	out   STD_ULOGIC;
      DO27                            :	out   STD_ULOGIC;
      DO28                            :	out   STD_ULOGIC;
      DO29                            :	out   STD_ULOGIC;
      DO30                            :	out   STD_ULOGIC;
      DO31                            :	out   STD_ULOGIC);


end component;

----- RAMB8K_X1_X1 -----
component RAMB8K_X1_X1
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      ADA12                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      ADB10                           :	in    STD_ULOGIC;
      ADB11                           :	in    STD_ULOGIC;
      ADB12                           :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X1_X2 -----
component RAMB8K_X1_X2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      ADA12                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      ADB10                           :	in    STD_ULOGIC;
      ADB11                           :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X1_X4 -----
component RAMB8K_X1_X4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      ADA12                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      ADB10                           :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X1_X8 -----
component RAMB8K_X1_X8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      ADA12                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X1_X16 -----
component RAMB8K_X1_X16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      ADA12                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      DIB8                            :	in    STD_ULOGIC;
      DIB9                            :	in    STD_ULOGIC;
      DIB10                           :	in    STD_ULOGIC;
      DIB11                           :	in    STD_ULOGIC;
      DIB12                           :	in    STD_ULOGIC;
      DIB13                           :	in    STD_ULOGIC;
      DIB14                           :	in    STD_ULOGIC;
      DIB15                           :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC;
      DOB8                            :	out   STD_ULOGIC;
      DOB9                            :	out   STD_ULOGIC;
      DOB10                           :	out   STD_ULOGIC;
      DOB11                           :	out   STD_ULOGIC;
      DOB12                           :	out   STD_ULOGIC;
      DOB13                           :	out   STD_ULOGIC;
      DOB14                           :	out   STD_ULOGIC;
      DOB15                           :	out   STD_ULOGIC);

end component;

----- RAMB8K_X2_X2 -----
component RAMB8K_X2_X2
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      ADB10                           :	in    STD_ULOGIC;
      ADB11                           :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X2_X4 -----
component RAMB8K_X2_X4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      ADB10                           :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X2_X8 -----
component RAMB8K_X2_X8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X2_X16 -----
component RAMB8K_X2_X16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      ADA11                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      DIB8                            :	in    STD_ULOGIC;
      DIB9                            :	in    STD_ULOGIC;
      DIB10                           :	in    STD_ULOGIC;
      DIB11                           :	in    STD_ULOGIC;
      DIB12                           :	in    STD_ULOGIC;
      DIB13                           :	in    STD_ULOGIC;
      DIB14                           :	in    STD_ULOGIC;
      DIB15                           :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC;
      DOB8                            :	out   STD_ULOGIC;
      DOB9                            :	out   STD_ULOGIC;
      DOB10                           :	out   STD_ULOGIC;
      DOB11                           :	out   STD_ULOGIC;
      DOB12                           :	out   STD_ULOGIC;
      DOB13                           :	out   STD_ULOGIC;
      DOB14                           :	out   STD_ULOGIC;
      DOB15                           :	out   STD_ULOGIC);

end component;

----- RAMB8K_X4_X4 -----
component RAMB8K_X4_X4
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      DIA2                            :	in    STD_ULOGIC;
      DIA3                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      ADB10                           :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOA2                            :	out   STD_ULOGIC;
      DOA3                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X4_X8 -----
component RAMB8K_X4_X8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      DIA2                            :	in    STD_ULOGIC;
      DIA3                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOA2                            :	out   STD_ULOGIC;
      DOA3                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X4_X16 -----
component RAMB8K_X4_X16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      DIA2                            :	in    STD_ULOGIC;
      DIA3                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      ADA10                           :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      DIB8                            :	in    STD_ULOGIC;
      DIB9                            :	in    STD_ULOGIC;
      DIB10                           :	in    STD_ULOGIC;
      DIB11                           :	in    STD_ULOGIC;
      DIB12                           :	in    STD_ULOGIC;
      DIB13                           :	in    STD_ULOGIC;
      DIB14                           :	in    STD_ULOGIC;
      DIB15                           :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOA2                            :	out   STD_ULOGIC;
      DOA3                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC;
      DOB8                            :	out   STD_ULOGIC;
      DOB9                            :	out   STD_ULOGIC;
      DOB10                           :	out   STD_ULOGIC;
      DOB11                           :	out   STD_ULOGIC;
      DOB12                           :	out   STD_ULOGIC;
      DOB13                           :	out   STD_ULOGIC;
      DOB14                           :	out   STD_ULOGIC;
      DOB15                           :	out   STD_ULOGIC);

end component;

----- RAMB8K_X8_X8 -----
component RAMB8K_X8_X8
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      DIA2                            :	in    STD_ULOGIC;
      DIA3                            :	in    STD_ULOGIC;
      DIA4                            :	in    STD_ULOGIC;
      DIA5                            :	in    STD_ULOGIC;
      DIA6                            :	in    STD_ULOGIC;
      DIA7                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      ADB9                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOA2                            :	out   STD_ULOGIC;
      DOA3                            :	out   STD_ULOGIC;
      DOA4                            :	out   STD_ULOGIC;
      DOA5                            :	out   STD_ULOGIC;
      DOA6                            :	out   STD_ULOGIC;
      DOA7                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC);

end component;

----- RAMB8K_X8_X16 -----
component RAMB8K_X8_X16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      DIA2                            :	in    STD_ULOGIC;
      DIA3                            :	in    STD_ULOGIC;
      DIA4                            :	in    STD_ULOGIC;
      DIA5                            :	in    STD_ULOGIC;
      DIA6                            :	in    STD_ULOGIC;
      DIA7                            :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      ADA9                            :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      DIB8                            :	in    STD_ULOGIC;
      DIB9                            :	in    STD_ULOGIC;
      DIB10                           :	in    STD_ULOGIC;
      DIB11                           :	in    STD_ULOGIC;
      DIB12                           :	in    STD_ULOGIC;
      DIB13                           :	in    STD_ULOGIC;
      DIB14                           :	in    STD_ULOGIC;
      DIB15                           :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOA2                            :	out   STD_ULOGIC;
      DOA3                            :	out   STD_ULOGIC;
      DOA4                            :	out   STD_ULOGIC;
      DOA5                            :	out   STD_ULOGIC;
      DOA6                            :	out   STD_ULOGIC;
      DOA7                            :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC;
      DOB8                            :	out   STD_ULOGIC;
      DOB9                            :	out   STD_ULOGIC;
      DOB10                           :	out   STD_ULOGIC;
      DOB11                           :	out   STD_ULOGIC;
      DOB12                           :	out   STD_ULOGIC;
      DOB13                           :	out   STD_ULOGIC;
      DOB14                           :	out   STD_ULOGIC;
      DOB15                           :	out   STD_ULOGIC);

end component;

----- RAMB8K_X16_X16 -----
component RAMB8K_X16_X16
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CENA                            :	in    STD_ULOGIC;
      CLKA                            :	in    STD_ULOGIC;
      WRA                             :	in    STD_ULOGIC;
      CSA0                            :	in    STD_ULOGIC;
      CSA1                            :	in    STD_ULOGIC;
      RSTA                            :	in    STD_ULOGIC;
      CENB                            :	in    STD_ULOGIC;
      CLKB                            :	in    STD_ULOGIC;
      WRB                             :	in    STD_ULOGIC;
      CSB0                            :	in    STD_ULOGIC;
      CSB1                            :	in    STD_ULOGIC;
      RSTB                            :	in    STD_ULOGIC;
      DIA0                            :	in    STD_ULOGIC;
      DIA1                            :	in    STD_ULOGIC;
      DIA2                            :	in    STD_ULOGIC;
      DIA3                            :	in    STD_ULOGIC;
      DIA4                            :	in    STD_ULOGIC;
      DIA5                            :	in    STD_ULOGIC;
      DIA6                            :	in    STD_ULOGIC;
      DIA7                            :	in    STD_ULOGIC;
      DIA8                            :	in    STD_ULOGIC;
      DIA9                            :	in    STD_ULOGIC;
      DIA10                           :	in    STD_ULOGIC;
      DIA11                           :	in    STD_ULOGIC;
      DIA12                           :	in    STD_ULOGIC;
      DIA13                           :	in    STD_ULOGIC;
      DIA14                           :	in    STD_ULOGIC;
      DIA15                           :	in    STD_ULOGIC;
      ADA0                            :	in    STD_ULOGIC;
      ADA1                            :	in    STD_ULOGIC;
      ADA2                            :	in    STD_ULOGIC;
      ADA3                            :	in    STD_ULOGIC;
      ADA4                            :	in    STD_ULOGIC;
      ADA5                            :	in    STD_ULOGIC;
      ADA6                            :	in    STD_ULOGIC;
      ADA7                            :	in    STD_ULOGIC;
      ADA8                            :	in    STD_ULOGIC;
      DIB0                            :	in    STD_ULOGIC;
      DIB1                            :	in    STD_ULOGIC;
      DIB2                            :	in    STD_ULOGIC;
      DIB3                            :	in    STD_ULOGIC;
      DIB4                            :	in    STD_ULOGIC;
      DIB5                            :	in    STD_ULOGIC;
      DIB6                            :	in    STD_ULOGIC;
      DIB7                            :	in    STD_ULOGIC;
      DIB8                            :	in    STD_ULOGIC;
      DIB9                            :	in    STD_ULOGIC;
      DIB10                           :	in    STD_ULOGIC;
      DIB11                           :	in    STD_ULOGIC;
      DIB12                           :	in    STD_ULOGIC;
      DIB13                           :	in    STD_ULOGIC;
      DIB14                           :	in    STD_ULOGIC;
      DIB15                           :	in    STD_ULOGIC;
      ADB0                            :	in    STD_ULOGIC;
      ADB1                            :	in    STD_ULOGIC;
      ADB2                            :	in    STD_ULOGIC;
      ADB3                            :	in    STD_ULOGIC;
      ADB4                            :	in    STD_ULOGIC;
      ADB5                            :	in    STD_ULOGIC;
      ADB6                            :	in    STD_ULOGIC;
      ADB7                            :	in    STD_ULOGIC;
      ADB8                            :	in    STD_ULOGIC;
      DOA0                            :	out   STD_ULOGIC;
      DOA1                            :	out   STD_ULOGIC;
      DOA2                            :	out   STD_ULOGIC;
      DOA3                            :	out   STD_ULOGIC;
      DOA4                            :	out   STD_ULOGIC;
      DOA5                            :	out   STD_ULOGIC;
      DOA6                            :	out   STD_ULOGIC;
      DOA7                            :	out   STD_ULOGIC;
      DOA8                            :	out   STD_ULOGIC;
      DOA9                            :	out   STD_ULOGIC;
      DOA10                           :	out   STD_ULOGIC;
      DOA11                           :	out   STD_ULOGIC;
      DOA12                           :	out   STD_ULOGIC;
      DOA13                           :	out   STD_ULOGIC;
      DOA14                           :	out   STD_ULOGIC;
      DOA15                           :	out   STD_ULOGIC;
      DOB0                            :	out   STD_ULOGIC;
      DOB1                            :	out   STD_ULOGIC;
      DOB2                            :	out   STD_ULOGIC;
      DOB3                            :	out   STD_ULOGIC;
      DOB4                            :	out   STD_ULOGIC;
      DOB5                            :	out   STD_ULOGIC;
      DOB6                            :	out   STD_ULOGIC;
      DOB7                            :	out   STD_ULOGIC;
      DOB8                            :	out   STD_ULOGIC;
      DOB9                            :	out   STD_ULOGIC;
      DOB10                           :	out   STD_ULOGIC;
      DOB11                           :	out   STD_ULOGIC;
      DOB12                           :	out   STD_ULOGIC;
      DOB13                           :	out   STD_ULOGIC;
      DOB14                           :	out   STD_ULOGIC;
      DOB15                           :	out   STD_ULOGIC);

end component;


----- Component CAM128X48 -----
component CAM128X48
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CE                              :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      CLK                             :	in    STD_ULOGIC;
      EN_MASK                         :	in    STD_ULOGIC;
      WR_MASK                         :	in    STD_ULOGIC;
      WR_DC                           :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      CS0                             :	in    STD_ULOGIC;
      CS1                             :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WD0                             :	in    STD_ULOGIC;
      WD1                             :	in    STD_ULOGIC;
      WD2                             :	in    STD_ULOGIC;
      WD3                             :	in    STD_ULOGIC;
      WD4                             :	in    STD_ULOGIC;
      WD5                             :	in    STD_ULOGIC;
      WD6                             :	in    STD_ULOGIC;
      WD7                             :	in    STD_ULOGIC;
      WD8                             :	in    STD_ULOGIC;
      WD9                             :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WD32                            :	in    STD_ULOGIC;
      WD33                            :	in    STD_ULOGIC;
      WD34                            :	in    STD_ULOGIC;
      WD35                            :	in    STD_ULOGIC;
      WD36                            :	in    STD_ULOGIC;
      WD37                            :	in    STD_ULOGIC;
      WD38                            :	in    STD_ULOGIC;
      WD39                            :	in    STD_ULOGIC;
      WD40                            :	in    STD_ULOGIC;
      WD41                            :	in    STD_ULOGIC;
      WD42                            :	in    STD_ULOGIC;
      WD43                            :	in    STD_ULOGIC;
      WD44                            :	in    STD_ULOGIC;
      WD45                            :	in    STD_ULOGIC;
      WD46                            :	in    STD_ULOGIC;
      WD47                            :	in    STD_ULOGIC;
      CO0                             :	out   STD_ULOGIC;
      CO1                             :	out   STD_ULOGIC;
      CO2                             :	out   STD_ULOGIC;
      CO3                             :	out   STD_ULOGIC;
      CO4                             :	out   STD_ULOGIC;
      CO5                             :	out   STD_ULOGIC;
      CO6                             :	out   STD_ULOGIC;
      MATCH                           :	out   STD_ULOGIC;
      MUL_MATCH                       :	out   STD_ULOGIC);
end component;

----- Component CAM128X48CL -----
component CAM128X48CL
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CE                              :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      CLK                             :	in    STD_ULOGIC;
      EN_MASK                         :	in    STD_ULOGIC;
      WR_MASK                         :	in    STD_ULOGIC;
      WR_DC                           :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      CS0                             :	in    STD_ULOGIC;
      CS1                             :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WD0                             :	in    STD_ULOGIC;
      WD1                             :	in    STD_ULOGIC;
      WD2                             :	in    STD_ULOGIC;
      WD3                             :	in    STD_ULOGIC;
      WD4                             :	in    STD_ULOGIC;
      WD5                             :	in    STD_ULOGIC;
      WD6                             :	in    STD_ULOGIC;
      WD7                             :	in    STD_ULOGIC;
      WD8                             :	in    STD_ULOGIC;
      WD9                             :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WD32                            :	in    STD_ULOGIC;
      WD33                            :	in    STD_ULOGIC;
      WD34                            :	in    STD_ULOGIC;
      WD35                            :	in    STD_ULOGIC;
      WD36                            :	in    STD_ULOGIC;
      WD37                            :	in    STD_ULOGIC;
      WD38                            :	in    STD_ULOGIC;
      WD39                            :	in    STD_ULOGIC;
      WD40                            :	in    STD_ULOGIC;
      WD41                            :	in    STD_ULOGIC;
      WD42                            :	in    STD_ULOGIC;
      WD43                            :	in    STD_ULOGIC;
      WD44                            :	in    STD_ULOGIC;
      WD45                            :	in    STD_ULOGIC;
      WD46                            :	in    STD_ULOGIC;
      WD47                            :	in    STD_ULOGIC;
      CMO0                            :	out   STD_ULOGIC;
      CMO1                            :	out   STD_ULOGIC;
      CMO2                            :	out   STD_ULOGIC;
      CMO3                            :	out   STD_ULOGIC;
      CMO4                            :	out   STD_ULOGIC;
      CMO5                            :	out   STD_ULOGIC;
      CMO6                            :	out   STD_ULOGIC;
      CMO7                            :	out   STD_ULOGIC;
      CMO8                            :	out   STD_ULOGIC;
      CMO9                            :	out   STD_ULOGIC;
      CMO10                           :	out   STD_ULOGIC;
      CMO11                           :	out   STD_ULOGIC;
      CMO12                           :	out   STD_ULOGIC;
      CMO13                           :	out   STD_ULOGIC;
      CMO14                           :	out   STD_ULOGIC;
      CMO15                           :	out   STD_ULOGIC;
      CMO16                           :	out   STD_ULOGIC;
      CMO17                           :	out   STD_ULOGIC;
      CMO18                           :	out   STD_ULOGIC;
      CMO19                           :	out   STD_ULOGIC;
      CMO20                           :	out   STD_ULOGIC;
      CMO21                           :	out   STD_ULOGIC;
      CMO22                           :	out   STD_ULOGIC;
      CMO23                           :	out   STD_ULOGIC;
      CMO24                           :	out   STD_ULOGIC;
      CMO25                           :	out   STD_ULOGIC;
      CMO26                           :	out   STD_ULOGIC;
      CMO27                           :	out   STD_ULOGIC;
      CMO28                           :	out   STD_ULOGIC;
      CMO29                           :	out   STD_ULOGIC;
      CMO30                           :	out   STD_ULOGIC;
      CMO31                           :	out   STD_ULOGIC;
      CMO32                           :	out   STD_ULOGIC;
      CMO33                           :	out   STD_ULOGIC;
      CMO34                           :	out   STD_ULOGIC;
      CMO35                           :	out   STD_ULOGIC;
      CMO36                           :	out   STD_ULOGIC;
      CMO37                           :	out   STD_ULOGIC;
      CMO38                           :	out   STD_ULOGIC;
      CMO39                           :	out   STD_ULOGIC;
      CMO40                           :	out   STD_ULOGIC;
      CMO41                           :	out   STD_ULOGIC;
      CMO42                           :	out   STD_ULOGIC;
      CMO43                           :	out   STD_ULOGIC;
      CMO44                           :	out   STD_ULOGIC;
      CMO45                           :	out   STD_ULOGIC;
      CMO46                           :	out   STD_ULOGIC;
      CMO47                           :	out   STD_ULOGIC;
      CMO48                           :	out   STD_ULOGIC;
      CMO49                           :	out   STD_ULOGIC;
      CMO50                           :	out   STD_ULOGIC;
      CMO51                           :	out   STD_ULOGIC;
      CMO52                           :	out   STD_ULOGIC;
      CMO53                           :	out   STD_ULOGIC;
      CMO54                           :	out   STD_ULOGIC;
      CMO55                           :	out   STD_ULOGIC;
      CMO56                           :	out   STD_ULOGIC;
      CMO57                           :	out   STD_ULOGIC;
      CMO58                           :	out   STD_ULOGIC;
      CMO59                           :	out   STD_ULOGIC;
      CMO60                           :	out   STD_ULOGIC;
      CMO61                           :	out   STD_ULOGIC;
      CMO62                           :	out   STD_ULOGIC;
      CMO63                           :	out   STD_ULOGIC;
      CMO64                           :	out   STD_ULOGIC;
      CMO65                           :	out   STD_ULOGIC;
      CMO66                           :	out   STD_ULOGIC;
      CMO67                           :	out   STD_ULOGIC;
      CMO68                           :	out   STD_ULOGIC;
      CMO69                           :	out   STD_ULOGIC;
      CMO70                           :	out   STD_ULOGIC;
      CMO71                           :	out   STD_ULOGIC;
      CMO72                           :	out   STD_ULOGIC;
      CMO73                           :	out   STD_ULOGIC;
      CMO74                           :	out   STD_ULOGIC;
      CMO75                           :	out   STD_ULOGIC;
      CMO76                           :	out   STD_ULOGIC;
      CMO77                           :	out   STD_ULOGIC;
      CMO78                           :	out   STD_ULOGIC;
      CMO79                           :	out   STD_ULOGIC;
      CMO80                           :	out   STD_ULOGIC;
      CMO81                           :	out   STD_ULOGIC;
      CMO82                           :	out   STD_ULOGIC;
      CMO83                           :	out   STD_ULOGIC;
      CMO84                           :	out   STD_ULOGIC;
      CMO85                           :	out   STD_ULOGIC;
      CMO86                           :	out   STD_ULOGIC;
      CMO87                           :	out   STD_ULOGIC;
      CMO88                           :	out   STD_ULOGIC;
      CMO89                           :	out   STD_ULOGIC;
      CMO90                           :	out   STD_ULOGIC;
      CMO91                           :	out   STD_ULOGIC;
      CMO92                           :	out   STD_ULOGIC;
      CMO93                           :	out   STD_ULOGIC;
      CMO94                           :	out   STD_ULOGIC;
      CMO95                           :	out   STD_ULOGIC;
      CMO96                           :	out   STD_ULOGIC;
      CMO97                           :	out   STD_ULOGIC;
      CMO98                           :	out   STD_ULOGIC;
      CMO99                           :	out   STD_ULOGIC;
      CMO100                          :	out   STD_ULOGIC;
      CMO101                          :	out   STD_ULOGIC;
      CMO102                          :	out   STD_ULOGIC;
      CMO103                          :	out   STD_ULOGIC;
      CMO104                          :	out   STD_ULOGIC;
      CMO105                          :	out   STD_ULOGIC;
      CMO106                          :	out   STD_ULOGIC;
      CMO107                          :	out   STD_ULOGIC;
      CMO108                          :	out   STD_ULOGIC;
      CMO109                          :	out   STD_ULOGIC;
      CMO110                          :	out   STD_ULOGIC;
      CMO111                          :	out   STD_ULOGIC;
      CMO112                          :	out   STD_ULOGIC;
      CMO113                          :	out   STD_ULOGIC;
      CMO114                          :	out   STD_ULOGIC;
      CMO115                          :	out   STD_ULOGIC;
      CMO116                          :	out   STD_ULOGIC;
      CMO117                          :	out   STD_ULOGIC;
      CMO118                          :	out   STD_ULOGIC;
      CMO119                          :	out   STD_ULOGIC;
      CMO120                          :	out   STD_ULOGIC;
      CMO121                          :	out   STD_ULOGIC;
      CMO122                          :	out   STD_ULOGIC;
      CMO123                          :	out   STD_ULOGIC;
      CMO124                          :	out   STD_ULOGIC;
      CMO125                          :	out   STD_ULOGIC;
      CMO126                          :	out   STD_ULOGIC;
      CMO127                          :	out   STD_ULOGIC);
end component;

----- Component CAM128X48CM -----
component CAM128X48CM
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CE                              :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      CLK                             :	in    STD_ULOGIC;
      EN_MASK                         :	in    STD_ULOGIC;
      WR_MASK                         :	in    STD_ULOGIC;
      WR_DC                           :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      CS0                             :	in    STD_ULOGIC;
      CS1                             :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WD0                             :	in    STD_ULOGIC;
      WD1                             :	in    STD_ULOGIC;
      WD2                             :	in    STD_ULOGIC;
      WD3                             :	in    STD_ULOGIC;
      WD4                             :	in    STD_ULOGIC;
      WD5                             :	in    STD_ULOGIC;
      WD6                             :	in    STD_ULOGIC;
      WD7                             :	in    STD_ULOGIC;
      WD8                             :	in    STD_ULOGIC;
      WD9                             :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WD32                            :	in    STD_ULOGIC;
      WD33                            :	in    STD_ULOGIC;
      WD34                            :	in    STD_ULOGIC;
      WD35                            :	in    STD_ULOGIC;
      WD36                            :	in    STD_ULOGIC;
      WD37                            :	in    STD_ULOGIC;
      WD38                            :	in    STD_ULOGIC;
      WD39                            :	in    STD_ULOGIC;
      WD40                            :	in    STD_ULOGIC;
      WD41                            :	in    STD_ULOGIC;
      WD42                            :	in    STD_ULOGIC;
      WD43                            :	in    STD_ULOGIC;
      WD44                            :	in    STD_ULOGIC;
      WD45                            :	in    STD_ULOGIC;
      WD46                            :	in    STD_ULOGIC;
      WD47                            :	in    STD_ULOGIC;
      CMI0                            :	in   STD_ULOGIC;
      CMI1                            :	in   STD_ULOGIC;
      CMI2                            :	in   STD_ULOGIC;
      CMI3                            :	in   STD_ULOGIC;
      CMI4                            :	in   STD_ULOGIC;
      CMI5                            :	in   STD_ULOGIC;
      CMI6                            :	in   STD_ULOGIC;
      CMI7                            :	in   STD_ULOGIC;
      CMI8                            :	in   STD_ULOGIC;
      CMI9                            :	in   STD_ULOGIC;
      CMI10                           :	in   STD_ULOGIC;
      CMI11                           :	in   STD_ULOGIC;
      CMI12                           :	in   STD_ULOGIC;
      CMI13                           :	in   STD_ULOGIC;
      CMI14                           :	in   STD_ULOGIC;
      CMI15                           :	in   STD_ULOGIC;
      CMI16                           :	in   STD_ULOGIC;
      CMI17                           :	in   STD_ULOGIC;
      CMI18                           :	in   STD_ULOGIC;
      CMI19                           :	in   STD_ULOGIC;
      CMI20                           :	in   STD_ULOGIC;
      CMI21                           :	in   STD_ULOGIC;
      CMI22                           :	in   STD_ULOGIC;
      CMI23                           :	in   STD_ULOGIC;
      CMI24                           :	in   STD_ULOGIC;
      CMI25                           :	in   STD_ULOGIC;
      CMI26                           :	in   STD_ULOGIC;
      CMI27                           :	in   STD_ULOGIC;
      CMI28                           :	in   STD_ULOGIC;
      CMI29                           :	in   STD_ULOGIC;
      CMI30                           :	in   STD_ULOGIC;
      CMI31                           :	in   STD_ULOGIC;
      CMI32                           :	in   STD_ULOGIC;
      CMI33                           :	in   STD_ULOGIC;
      CMI34                           :	in   STD_ULOGIC;
      CMI35                           :	in   STD_ULOGIC;
      CMI36                           :	in   STD_ULOGIC;
      CMI37                           :	in   STD_ULOGIC;
      CMI38                           :	in   STD_ULOGIC;
      CMI39                           :	in   STD_ULOGIC;
      CMI40                           :	in   STD_ULOGIC;
      CMI41                           :	in   STD_ULOGIC;
      CMI42                           :	in   STD_ULOGIC;
      CMI43                           :	in   STD_ULOGIC;
      CMI44                           :	in   STD_ULOGIC;
      CMI45                           :	in   STD_ULOGIC;
      CMI46                           :	in   STD_ULOGIC;
      CMI47                           :	in   STD_ULOGIC;
      CMI48                           :	in   STD_ULOGIC;
      CMI49                           :	in   STD_ULOGIC;
      CMI50                           :	in   STD_ULOGIC;
      CMI51                           :	in   STD_ULOGIC;
      CMI52                           :	in   STD_ULOGIC;
      CMI53                           :	in   STD_ULOGIC;
      CMI54                           :	in   STD_ULOGIC;
      CMI55                           :	in   STD_ULOGIC;
      CMI56                           :	in   STD_ULOGIC;
      CMI57                           :	in   STD_ULOGIC;
      CMI58                           :	in   STD_ULOGIC;
      CMI59                           :	in   STD_ULOGIC;
      CMI60                           :	in   STD_ULOGIC;
      CMI61                           :	in   STD_ULOGIC;
      CMI62                           :	in   STD_ULOGIC;
      CMI63                           :	in   STD_ULOGIC;
      CMI64                           :	in   STD_ULOGIC;
      CMI65                           :	in   STD_ULOGIC;
      CMI66                           :	in   STD_ULOGIC;
      CMI67                           :	in   STD_ULOGIC;
      CMI68                           :	in   STD_ULOGIC;
      CMI69                           :	in   STD_ULOGIC;
      CMI70                           :	in   STD_ULOGIC;
      CMI71                           :	in   STD_ULOGIC;
      CMI72                           :	in   STD_ULOGIC;
      CMI73                           :	in   STD_ULOGIC;
      CMI74                           :	in   STD_ULOGIC;
      CMI75                           :	in   STD_ULOGIC;
      CMI76                           :	in   STD_ULOGIC;
      CMI77                           :	in   STD_ULOGIC;
      CMI78                           :	in   STD_ULOGIC;
      CMI79                           :	in   STD_ULOGIC;
      CMI80                           :	in   STD_ULOGIC;
      CMI81                           :	in   STD_ULOGIC;
      CMI82                           :	in   STD_ULOGIC;
      CMI83                           :	in   STD_ULOGIC;
      CMI84                           :	in   STD_ULOGIC;
      CMI85                           :	in   STD_ULOGIC;
      CMI86                           :	in   STD_ULOGIC;
      CMI87                           :	in   STD_ULOGIC;
      CMI88                           :	in   STD_ULOGIC;
      CMI89                           :	in   STD_ULOGIC;
      CMI90                           :	in   STD_ULOGIC;
      CMI91                           :	in   STD_ULOGIC;
      CMI92                           :	in   STD_ULOGIC;
      CMI93                           :	in   STD_ULOGIC;
      CMI94                           :	in   STD_ULOGIC;
      CMI95                           :	in   STD_ULOGIC;
      CMI96                           :	in   STD_ULOGIC;
      CMI97                           :	in   STD_ULOGIC;
      CMI98                           :	in   STD_ULOGIC;
      CMI99                           :	in   STD_ULOGIC;
      CMI100                          :	in   STD_ULOGIC;
      CMI101                          :	in   STD_ULOGIC;
      CMI102                          :	in   STD_ULOGIC;
      CMI103                          :	in   STD_ULOGIC;
      CMI104                          :	in   STD_ULOGIC;
      CMI105                          :	in   STD_ULOGIC;
      CMI106                          :	in   STD_ULOGIC;
      CMI107                          :	in   STD_ULOGIC;
      CMI108                          :	in   STD_ULOGIC;
      CMI109                          :	in   STD_ULOGIC;
      CMI110                          :	in   STD_ULOGIC;
      CMI111                          :	in   STD_ULOGIC;
      CMI112                          :	in   STD_ULOGIC;
      CMI113                          :	in   STD_ULOGIC;
      CMI114                          :	in   STD_ULOGIC;
      CMI115                          :	in   STD_ULOGIC;
      CMI116                          :	in   STD_ULOGIC;
      CMI117                          :	in   STD_ULOGIC;
      CMI118                          :	in   STD_ULOGIC;
      CMI119                          :	in   STD_ULOGIC;
      CMI120                          :	in   STD_ULOGIC;
      CMI121                          :	in   STD_ULOGIC;
      CMI122                          :	in   STD_ULOGIC;
      CMI123                          :	in   STD_ULOGIC;
      CMI124                          :	in   STD_ULOGIC;
      CMI125                          :	in   STD_ULOGIC;
      CMI126                          :	in   STD_ULOGIC;
      CMI127                          :	in   STD_ULOGIC;
      CMO0                            :	out   STD_ULOGIC;
      CMO1                            :	out   STD_ULOGIC;
      CMO2                            :	out   STD_ULOGIC;
      CMO3                            :	out   STD_ULOGIC;
      CMO4                            :	out   STD_ULOGIC;
      CMO5                            :	out   STD_ULOGIC;
      CMO6                            :	out   STD_ULOGIC;
      CMO7                            :	out   STD_ULOGIC;
      CMO8                            :	out   STD_ULOGIC;
      CMO9                            :	out   STD_ULOGIC;
      CMO10                           :	out   STD_ULOGIC;
      CMO11                           :	out   STD_ULOGIC;
      CMO12                           :	out   STD_ULOGIC;
      CMO13                           :	out   STD_ULOGIC;
      CMO14                           :	out   STD_ULOGIC;
      CMO15                           :	out   STD_ULOGIC;
      CMO16                           :	out   STD_ULOGIC;
      CMO17                           :	out   STD_ULOGIC;
      CMO18                           :	out   STD_ULOGIC;
      CMO19                           :	out   STD_ULOGIC;
      CMO20                           :	out   STD_ULOGIC;
      CMO21                           :	out   STD_ULOGIC;
      CMO22                           :	out   STD_ULOGIC;
      CMO23                           :	out   STD_ULOGIC;
      CMO24                           :	out   STD_ULOGIC;
      CMO25                           :	out   STD_ULOGIC;
      CMO26                           :	out   STD_ULOGIC;
      CMO27                           :	out   STD_ULOGIC;
      CMO28                           :	out   STD_ULOGIC;
      CMO29                           :	out   STD_ULOGIC;
      CMO30                           :	out   STD_ULOGIC;
      CMO31                           :	out   STD_ULOGIC;
      CMO32                           :	out   STD_ULOGIC;
      CMO33                           :	out   STD_ULOGIC;
      CMO34                           :	out   STD_ULOGIC;
      CMO35                           :	out   STD_ULOGIC;
      CMO36                           :	out   STD_ULOGIC;
      CMO37                           :	out   STD_ULOGIC;
      CMO38                           :	out   STD_ULOGIC;
      CMO39                           :	out   STD_ULOGIC;
      CMO40                           :	out   STD_ULOGIC;
      CMO41                           :	out   STD_ULOGIC;
      CMO42                           :	out   STD_ULOGIC;
      CMO43                           :	out   STD_ULOGIC;
      CMO44                           :	out   STD_ULOGIC;
      CMO45                           :	out   STD_ULOGIC;
      CMO46                           :	out   STD_ULOGIC;
      CMO47                           :	out   STD_ULOGIC;
      CMO48                           :	out   STD_ULOGIC;
      CMO49                           :	out   STD_ULOGIC;
      CMO50                           :	out   STD_ULOGIC;
      CMO51                           :	out   STD_ULOGIC;
      CMO52                           :	out   STD_ULOGIC;
      CMO53                           :	out   STD_ULOGIC;
      CMO54                           :	out   STD_ULOGIC;
      CMO55                           :	out   STD_ULOGIC;
      CMO56                           :	out   STD_ULOGIC;
      CMO57                           :	out   STD_ULOGIC;
      CMO58                           :	out   STD_ULOGIC;
      CMO59                           :	out   STD_ULOGIC;
      CMO60                           :	out   STD_ULOGIC;
      CMO61                           :	out   STD_ULOGIC;
      CMO62                           :	out   STD_ULOGIC;
      CMO63                           :	out   STD_ULOGIC;
      CMO64                           :	out   STD_ULOGIC;
      CMO65                           :	out   STD_ULOGIC;
      CMO66                           :	out   STD_ULOGIC;
      CMO67                           :	out   STD_ULOGIC;
      CMO68                           :	out   STD_ULOGIC;
      CMO69                           :	out   STD_ULOGIC;
      CMO70                           :	out   STD_ULOGIC;
      CMO71                           :	out   STD_ULOGIC;
      CMO72                           :	out   STD_ULOGIC;
      CMO73                           :	out   STD_ULOGIC;
      CMO74                           :	out   STD_ULOGIC;
      CMO75                           :	out   STD_ULOGIC;
      CMO76                           :	out   STD_ULOGIC;
      CMO77                           :	out   STD_ULOGIC;
      CMO78                           :	out   STD_ULOGIC;
      CMO79                           :	out   STD_ULOGIC;
      CMO80                           :	out   STD_ULOGIC;
      CMO81                           :	out   STD_ULOGIC;
      CMO82                           :	out   STD_ULOGIC;
      CMO83                           :	out   STD_ULOGIC;
      CMO84                           :	out   STD_ULOGIC;
      CMO85                           :	out   STD_ULOGIC;
      CMO86                           :	out   STD_ULOGIC;
      CMO87                           :	out   STD_ULOGIC;
      CMO88                           :	out   STD_ULOGIC;
      CMO89                           :	out   STD_ULOGIC;
      CMO90                           :	out   STD_ULOGIC;
      CMO91                           :	out   STD_ULOGIC;
      CMO92                           :	out   STD_ULOGIC;
      CMO93                           :	out   STD_ULOGIC;
      CMO94                           :	out   STD_ULOGIC;
      CMO95                           :	out   STD_ULOGIC;
      CMO96                           :	out   STD_ULOGIC;
      CMO97                           :	out   STD_ULOGIC;
      CMO98                           :	out   STD_ULOGIC;
      CMO99                           :	out   STD_ULOGIC;
      CMO100                          :	out   STD_ULOGIC;
      CMO101                          :	out   STD_ULOGIC;
      CMO102                          :	out   STD_ULOGIC;
      CMO103                          :	out   STD_ULOGIC;
      CMO104                          :	out   STD_ULOGIC;
      CMO105                          :	out   STD_ULOGIC;
      CMO106                          :	out   STD_ULOGIC;
      CMO107                          :	out   STD_ULOGIC;
      CMO108                          :	out   STD_ULOGIC;
      CMO109                          :	out   STD_ULOGIC;
      CMO110                          :	out   STD_ULOGIC;
      CMO111                          :	out   STD_ULOGIC;
      CMO112                          :	out   STD_ULOGIC;
      CMO113                          :	out   STD_ULOGIC;
      CMO114                          :	out   STD_ULOGIC;
      CMO115                          :	out   STD_ULOGIC;
      CMO116                          :	out   STD_ULOGIC;
      CMO117                          :	out   STD_ULOGIC;
      CMO118                          :	out   STD_ULOGIC;
      CMO119                          :	out   STD_ULOGIC;
      CMO120                          :	out   STD_ULOGIC;
      CMO121                          :	out   STD_ULOGIC;
      CMO122                          :	out   STD_ULOGIC;
      CMO123                          :	out   STD_ULOGIC;
      CMO124                          :	out   STD_ULOGIC;
      CMO125                          :	out   STD_ULOGIC;
      CMO126                          :	out   STD_ULOGIC;
      CMO127                          :	out   STD_ULOGIC);

end component;

----- Component CAM128X48CR -----
component CAM128X48CR
   generic (RAM_INIT_FILE   : string  := "");
   port(
      CE                              :	in    STD_ULOGIC;
      WE                              :	in    STD_ULOGIC;
      CLK                             :	in    STD_ULOGIC;
      EN_MASK                         :	in    STD_ULOGIC;
      WR_MASK                         :	in    STD_ULOGIC;
      WR_DC                           :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      CS0                             :	in    STD_ULOGIC;
      CS1                             :	in    STD_ULOGIC;
      WAD0                            :	in    STD_ULOGIC;
      WAD1                            :	in    STD_ULOGIC;
      WAD2                            :	in    STD_ULOGIC;
      WAD3                            :	in    STD_ULOGIC;
      WAD4                            :	in    STD_ULOGIC;
      WAD5                            :	in    STD_ULOGIC;
      WAD6                            :	in    STD_ULOGIC;
      WD0                             :	in    STD_ULOGIC;
      WD1                             :	in    STD_ULOGIC;
      WD2                             :	in    STD_ULOGIC;
      WD3                             :	in    STD_ULOGIC;
      WD4                             :	in    STD_ULOGIC;
      WD5                             :	in    STD_ULOGIC;
      WD6                             :	in    STD_ULOGIC;
      WD7                             :	in    STD_ULOGIC;
      WD8                             :	in    STD_ULOGIC;
      WD9                             :	in    STD_ULOGIC;
      WD10                            :	in    STD_ULOGIC;
      WD11                            :	in    STD_ULOGIC;
      WD12                            :	in    STD_ULOGIC;
      WD13                            :	in    STD_ULOGIC;
      WD14                            :	in    STD_ULOGIC;
      WD15                            :	in    STD_ULOGIC;
      WD16                            :	in    STD_ULOGIC;
      WD17                            :	in    STD_ULOGIC;
      WD18                            :	in    STD_ULOGIC;
      WD19                            :	in    STD_ULOGIC;
      WD20                            :	in    STD_ULOGIC;
      WD21                            :	in    STD_ULOGIC;
      WD22                            :	in    STD_ULOGIC;
      WD23                            :	in    STD_ULOGIC;
      WD24                            :	in    STD_ULOGIC;
      WD25                            :	in    STD_ULOGIC;
      WD26                            :	in    STD_ULOGIC;
      WD27                            :	in    STD_ULOGIC;
      WD28                            :	in    STD_ULOGIC;
      WD29                            :	in    STD_ULOGIC;
      WD30                            :	in    STD_ULOGIC;
      WD31                            :	in    STD_ULOGIC;
      WD32                            :	in    STD_ULOGIC;
      WD33                            :	in    STD_ULOGIC;
      WD34                            :	in    STD_ULOGIC;
      WD35                            :	in    STD_ULOGIC;
      WD36                            :	in    STD_ULOGIC;
      WD37                            :	in    STD_ULOGIC;
      WD38                            :	in    STD_ULOGIC;
      WD39                            :	in    STD_ULOGIC;
      WD40                            :	in    STD_ULOGIC;
      WD41                            :	in    STD_ULOGIC;
      WD42                            :	in    STD_ULOGIC;
      WD43                            :	in    STD_ULOGIC;
      WD44                            :	in    STD_ULOGIC;
      WD45                            :	in    STD_ULOGIC;
      WD46                            :	in    STD_ULOGIC;
      WD47                            :	in    STD_ULOGIC;
      CMI0                            :	in   STD_ULOGIC;
      CMI1                            :	in   STD_ULOGIC;
      CMI2                            :	in   STD_ULOGIC;
      CMI3                            :	in   STD_ULOGIC;
      CMI4                            :	in   STD_ULOGIC;
      CMI5                            :	in   STD_ULOGIC;
      CMI6                            :	in   STD_ULOGIC;
      CMI7                            :	in   STD_ULOGIC;
      CMI8                            :	in   STD_ULOGIC;
      CMI9                            :	in   STD_ULOGIC;
      CMI10                           :	in   STD_ULOGIC;
      CMI11                           :	in   STD_ULOGIC;
      CMI12                           :	in   STD_ULOGIC;
      CMI13                           :	in   STD_ULOGIC;
      CMI14                           :	in   STD_ULOGIC;
      CMI15                           :	in   STD_ULOGIC;
      CMI16                           :	in   STD_ULOGIC;
      CMI17                           :	in   STD_ULOGIC;
      CMI18                           :	in   STD_ULOGIC;
      CMI19                           :	in   STD_ULOGIC;
      CMI20                           :	in   STD_ULOGIC;
      CMI21                           :	in   STD_ULOGIC;
      CMI22                           :	in   STD_ULOGIC;
      CMI23                           :	in   STD_ULOGIC;
      CMI24                           :	in   STD_ULOGIC;
      CMI25                           :	in   STD_ULOGIC;
      CMI26                           :	in   STD_ULOGIC;
      CMI27                           :	in   STD_ULOGIC;
      CMI28                           :	in   STD_ULOGIC;
      CMI29                           :	in   STD_ULOGIC;
      CMI30                           :	in   STD_ULOGIC;
      CMI31                           :	in   STD_ULOGIC;
      CMI32                           :	in   STD_ULOGIC;
      CMI33                           :	in   STD_ULOGIC;
      CMI34                           :	in   STD_ULOGIC;
      CMI35                           :	in   STD_ULOGIC;
      CMI36                           :	in   STD_ULOGIC;
      CMI37                           :	in   STD_ULOGIC;
      CMI38                           :	in   STD_ULOGIC;
      CMI39                           :	in   STD_ULOGIC;
      CMI40                           :	in   STD_ULOGIC;
      CMI41                           :	in   STD_ULOGIC;
      CMI42                           :	in   STD_ULOGIC;
      CMI43                           :	in   STD_ULOGIC;
      CMI44                           :	in   STD_ULOGIC;
      CMI45                           :	in   STD_ULOGIC;
      CMI46                           :	in   STD_ULOGIC;
      CMI47                           :	in   STD_ULOGIC;
      CMI48                           :	in   STD_ULOGIC;
      CMI49                           :	in   STD_ULOGIC;
      CMI50                           :	in   STD_ULOGIC;
      CMI51                           :	in   STD_ULOGIC;
      CMI52                           :	in   STD_ULOGIC;
      CMI53                           :	in   STD_ULOGIC;
      CMI54                           :	in   STD_ULOGIC;
      CMI55                           :	in   STD_ULOGIC;
      CMI56                           :	in   STD_ULOGIC;
      CMI57                           :	in   STD_ULOGIC;
      CMI58                           :	in   STD_ULOGIC;
      CMI59                           :	in   STD_ULOGIC;
      CMI60                           :	in   STD_ULOGIC;
      CMI61                           :	in   STD_ULOGIC;
      CMI62                           :	in   STD_ULOGIC;
      CMI63                           :	in   STD_ULOGIC;
      CMI64                           :	in   STD_ULOGIC;
      CMI65                           :	in   STD_ULOGIC;
      CMI66                           :	in   STD_ULOGIC;
      CMI67                           :	in   STD_ULOGIC;
      CMI68                           :	in   STD_ULOGIC;
      CMI69                           :	in   STD_ULOGIC;
      CMI70                           :	in   STD_ULOGIC;
      CMI71                           :	in   STD_ULOGIC;
      CMI72                           :	in   STD_ULOGIC;
      CMI73                           :	in   STD_ULOGIC;
      CMI74                           :	in   STD_ULOGIC;
      CMI75                           :	in   STD_ULOGIC;
      CMI76                           :	in   STD_ULOGIC;
      CMI77                           :	in   STD_ULOGIC;
      CMI78                           :	in   STD_ULOGIC;
      CMI79                           :	in   STD_ULOGIC;
      CMI80                           :	in   STD_ULOGIC;
      CMI81                           :	in   STD_ULOGIC;
      CMI82                           :	in   STD_ULOGIC;
      CMI83                           :	in   STD_ULOGIC;
      CMI84                           :	in   STD_ULOGIC;
      CMI85                           :	in   STD_ULOGIC;
      CMI86                           :	in   STD_ULOGIC;
      CMI87                           :	in   STD_ULOGIC;
      CMI88                           :	in   STD_ULOGIC;
      CMI89                           :	in   STD_ULOGIC;
      CMI90                           :	in   STD_ULOGIC;
      CMI91                           :	in   STD_ULOGIC;
      CMI92                           :	in   STD_ULOGIC;
      CMI93                           :	in   STD_ULOGIC;
      CMI94                           :	in   STD_ULOGIC;
      CMI95                           :	in   STD_ULOGIC;
      CMI96                           :	in   STD_ULOGIC;
      CMI97                           :	in   STD_ULOGIC;
      CMI98                           :	in   STD_ULOGIC;
      CMI99                           :	in   STD_ULOGIC;
      CMI100                          :	in   STD_ULOGIC;
      CMI101                          :	in   STD_ULOGIC;
      CMI102                          :	in   STD_ULOGIC;
      CMI103                          :	in   STD_ULOGIC;
      CMI104                          :	in   STD_ULOGIC;
      CMI105                          :	in   STD_ULOGIC;
      CMI106                          :	in   STD_ULOGIC;
      CMI107                          :	in   STD_ULOGIC;
      CMI108                          :	in   STD_ULOGIC;
      CMI109                          :	in   STD_ULOGIC;
      CMI110                          :	in   STD_ULOGIC;
      CMI111                          :	in   STD_ULOGIC;
      CMI112                          :	in   STD_ULOGIC;
      CMI113                          :	in   STD_ULOGIC;
      CMI114                          :	in   STD_ULOGIC;
      CMI115                          :	in   STD_ULOGIC;
      CMI116                          :	in   STD_ULOGIC;
      CMI117                          :	in   STD_ULOGIC;
      CMI118                          :	in   STD_ULOGIC;
      CMI119                          :	in   STD_ULOGIC;
      CMI120                          :	in   STD_ULOGIC;
      CMI121                          :	in   STD_ULOGIC;
      CMI122                          :	in   STD_ULOGIC;
      CMI123                          :	in   STD_ULOGIC;
      CMI124                          :	in   STD_ULOGIC;
      CMI125                          :	in   STD_ULOGIC;
      CMI126                          :	in   STD_ULOGIC;
      CMI127                          :	in   STD_ULOGIC;
      CO0                            :	out   STD_ULOGIC;
      CO1                            :	out   STD_ULOGIC;
      CO2                            :	out   STD_ULOGIC;
      CO3                            :	out   STD_ULOGIC;
      CO4                            :	out   STD_ULOGIC;
      CO5                            :	out   STD_ULOGIC;
      CO6                            :	out   STD_ULOGIC;
      MATCH                          :	out   STD_ULOGIC;
      MUL_MATCH                      :	out   STD_ULOGIC);

end component;


-----Component RAMBFIFO16KX1A -----
component RAMBFIFO16KX1A
   generic (      
      FIFO_FULL_FLAG     : integer  := 16384;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);
   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      FULLIN                          :	in    STD_ULOGIC;
      EMPTYIN                         :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      DI0                             :	in    STD_ULOGIC;
      DO0                             :	out   STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO8KX2A -----
component RAMBFIFO8KX2A
   generic (
      FIFO_FULL_FLAG     : integer  := 8192;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);
   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      FULLIN                          :	in    STD_ULOGIC;
      EMPTYIN                         :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      DI0                             :	in    STD_ULOGIC;
      DI1                             :	in    STD_ULOGIC;
      DO0                             :	out   STD_ULOGIC;
      DO1                             :	out   STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO4KX4A -----
component RAMBFIFO4KX4A
   generic (
      FIFO_FULL_FLAG     : integer  := 4096;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);
   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      FULLIN                          :	in    STD_ULOGIC;
      EMPTYIN                         :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      DI0                             :	in    STD_ULOGIC;
      DI1                             :	in    STD_ULOGIC;
      DI2                             :	in    STD_ULOGIC;
      DI3                             :	in    STD_ULOGIC;
      DO0                             :	out   STD_ULOGIC;
      DO1                             :	out   STD_ULOGIC;
      DO2                             :	out   STD_ULOGIC;
      DO3                             :	out   STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO2KX8A -----
component RAMBFIFO2KX8A
   generic (
      FIFO_FULL_FLAG     : integer  := 2048;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);
   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      FULLIN                          :	in    STD_ULOGIC;
      EMPTYIN                         :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      DI0                             :	in    STD_ULOGIC;
      DI1                             :	in    STD_ULOGIC;
      DI2                             :	in    STD_ULOGIC;
      DI3                             :	in    STD_ULOGIC;
      DI4                             :	in    STD_ULOGIC;
      DI5                             :	in    STD_ULOGIC;
      DI6                             :	in    STD_ULOGIC;
      DI7                             :	in    STD_ULOGIC;
      DO0                             :	out   STD_ULOGIC;
      DO1                             :	out   STD_ULOGIC;
      DO2                             :	out   STD_ULOGIC;
      DO3                             :	out   STD_ULOGIC;
      DO4                             :	out   STD_ULOGIC;
      DO5                             :	out   STD_ULOGIC;
      DO6                             :	out   STD_ULOGIC;
      DO7                             :	out   STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO1KX16A -----
component RAMBFIFO1KX16A
   generic (
      FIFO_FULL_FLAG     : integer  := 1024;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);
   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      FULLIN                          :	in    STD_ULOGIC;
      EMPTYIN                         :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      DI0                             :	in    STD_ULOGIC;
      DI1                             :	in    STD_ULOGIC;
      DI2                             :	in    STD_ULOGIC;
      DI3                             :	in    STD_ULOGIC;
      DI4                             :	in    STD_ULOGIC;
      DI5                             :	in    STD_ULOGIC;
      DI6                             :	in    STD_ULOGIC;
      DI7                             :	in    STD_ULOGIC;
      DI8                             :	in    STD_ULOGIC;
      DI9                             :	in    STD_ULOGIC;
      DI10                            :	in    STD_ULOGIC;
      DI11                            :	in    STD_ULOGIC;
      DI12                            :	in    STD_ULOGIC;
      DI13                            :	in    STD_ULOGIC;
      DI14                            :	in    STD_ULOGIC;
      DI15                            :	in    STD_ULOGIC;
      DO0                             :	out   STD_ULOGIC;
      DO1                             :	out   STD_ULOGIC;
      DO2                             :	out   STD_ULOGIC;
      DO3                             :	out   STD_ULOGIC;
      DO4                             :	out   STD_ULOGIC;
      DO5                             :	out   STD_ULOGIC;
      DO6                             :	out   STD_ULOGIC;
      DO7                             :	out   STD_ULOGIC;
      DO8                             :	out   STD_ULOGIC;
      DO9                             :	out   STD_ULOGIC;
      DO10                            :	out   STD_ULOGIC;
      DO11                            :	out   STD_ULOGIC;
      DO12                            :	out   STD_ULOGIC;
      DO13                            :	out   STD_ULOGIC;
      DO14                            :	out   STD_ULOGIC;
      DO15                            :	out   STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO512X28A -----
component RAMBFIFO512X28A
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);
   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      FULLIN                          :	in    STD_ULOGIC;
      EMPTYIN                         :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      DI0                             :	in    STD_ULOGIC;
      DI1                             :	in    STD_ULOGIC;
      DI2                             :	in    STD_ULOGIC;
      DI3                             :	in    STD_ULOGIC;
      DI4                             :	in    STD_ULOGIC;
      DI5                             :	in    STD_ULOGIC;
      DI6                             :	in    STD_ULOGIC;
      DI7                             :	in    STD_ULOGIC;
      DI8                             :	in    STD_ULOGIC;
      DI9                             :	in    STD_ULOGIC;
      DI10                            :	in    STD_ULOGIC;
      DI11                            :	in    STD_ULOGIC;
      DI12                            :	in    STD_ULOGIC;
      DI13                            :	in    STD_ULOGIC;
      DI14                            :	in    STD_ULOGIC;
      DI15                            :	in    STD_ULOGIC;
      DI16                            :	in    STD_ULOGIC;
      DI17                            :	in    STD_ULOGIC;
      DI18                            :	in    STD_ULOGIC;
      DI19                            :	in    STD_ULOGIC;
      DI20                            :	in    STD_ULOGIC;
      DI21                            :	in    STD_ULOGIC;
      DI22                            :	in    STD_ULOGIC;
      DI23                            :	in    STD_ULOGIC;
      DI24                            :	in    STD_ULOGIC;
      DI25                            :	in    STD_ULOGIC;
      DI26                            :	in    STD_ULOGIC;
      DI27                            :	in    STD_ULOGIC;
      DO0                             :	out   STD_ULOGIC;
      DO1                             :	out   STD_ULOGIC;
      DO2                             :	out   STD_ULOGIC;
      DO3                             :	out   STD_ULOGIC;
      DO4                             :	out   STD_ULOGIC;
      DO5                             :	out   STD_ULOGIC;
      DO6                             :	out   STD_ULOGIC;
      DO7                             :	out   STD_ULOGIC;
      DO8                             :	out   STD_ULOGIC;
      DO9                             :	out   STD_ULOGIC;
      DO10                            :	out   STD_ULOGIC;
      DO11                            :	out   STD_ULOGIC;
      DO12                            :	out   STD_ULOGIC;
      DO13                            :	out   STD_ULOGIC;
      DO14                            :	out   STD_ULOGIC;
      DO15                            :	out   STD_ULOGIC;
      DO16                            :	out   STD_ULOGIC;
      DO17                            :	out   STD_ULOGIC;
      DO18                            :	out   STD_ULOGIC;
      DO19                            :	out   STD_ULOGIC;
      DO20                            :	out   STD_ULOGIC;
      DO21                            :	out   STD_ULOGIC;
      DO22                            :	out   STD_ULOGIC;
      DO23                            :	out   STD_ULOGIC;
      DO24                            :	out   STD_ULOGIC;
      DO25                            :	out   STD_ULOGIC;
      DO26                            :	out   STD_ULOGIC;
      DO27                            :	out   STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO512X32A -----
component RAMBFIFO512X32A
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);
   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      FULLIN                          :	in    STD_ULOGIC;
      EMPTYIN                         :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      DI0                             :	in    STD_ULOGIC;
      DI1                             :	in    STD_ULOGIC;
      DI2                             :	in    STD_ULOGIC;
      DI3                             :	in    STD_ULOGIC;
      DI4                             :	in    STD_ULOGIC;
      DI5                             :	in    STD_ULOGIC;
      DI6                             :	in    STD_ULOGIC;
      DI7                             :	in    STD_ULOGIC;
      DI8                             :	in    STD_ULOGIC;
      DI9                             :	in    STD_ULOGIC;
      DI10                            :	in    STD_ULOGIC;
      DI11                            :	in    STD_ULOGIC;
      DI12                            :	in    STD_ULOGIC;
      DI13                            :	in    STD_ULOGIC;
      DI14                            :	in    STD_ULOGIC;
      DI15                            :	in    STD_ULOGIC;
      DI16                            :	in    STD_ULOGIC;
      DI17                            :	in    STD_ULOGIC;
      DI18                            :	in    STD_ULOGIC;
      DI19                            :	in    STD_ULOGIC;
      DI20                            :	in    STD_ULOGIC;
      DI21                            :	in    STD_ULOGIC;
      DI22                            :	in    STD_ULOGIC;
      DI23                            :	in    STD_ULOGIC;
      DI24                            :	in    STD_ULOGIC;
      DI25                            :	in    STD_ULOGIC;
      DI26                            :	in    STD_ULOGIC;
      DI27                            :	in    STD_ULOGIC;
      DI28                            :	in    STD_ULOGIC;
      DI29                            :	in    STD_ULOGIC;
      DI30                            :	in    STD_ULOGIC;
      DI31                            :	in    STD_ULOGIC;
      DO0                             :	out   STD_ULOGIC;
      DO1                             :	out   STD_ULOGIC;
      DO2                             :	out   STD_ULOGIC;
      DO3                             :	out   STD_ULOGIC;
      DO4                             :	out   STD_ULOGIC;
      DO5                             :	out   STD_ULOGIC;
      DO6                             :	out   STD_ULOGIC;
      DO7                             :	out   STD_ULOGIC;
      DO8                             :	out   STD_ULOGIC;
      DO9                             :	out   STD_ULOGIC;
      DO10                            :	out   STD_ULOGIC;
      DO11                            :	out   STD_ULOGIC;
      DO12                            :	out   STD_ULOGIC;
      DO13                            :	out   STD_ULOGIC;
      DO14                            :	out   STD_ULOGIC;
      DO15                            :	out   STD_ULOGIC;
      DO16                            :	out   STD_ULOGIC;
      DO17                            :	out   STD_ULOGIC;
      DO18                            :	out   STD_ULOGIC;
      DO19                            :	out   STD_ULOGIC;
      DO20                            :	out   STD_ULOGIC;
      DO21                            :	out   STD_ULOGIC;
      DO22                            :	out   STD_ULOGIC;
      DO23                            :	out   STD_ULOGIC;
      DO24                            :	out   STD_ULOGIC;
      DO25                            :	out   STD_ULOGIC;
      DO26                            :	out   STD_ULOGIC;
      DO27                            :	out   STD_ULOGIC;
      DO28                            :	out   STD_ULOGIC;
      DO29                            :	out   STD_ULOGIC;
      DO30                            :	out   STD_ULOGIC;
      DO31                            :	out   STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO512X32A_FLAG -----
component RAMBFIFO512X32A_FLAG
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO16KA_WX16_RX32_FLAG -----
component RAMBFIFO16KA_WX16_RX32_FLAG
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO16KA_WX8_RX32_FLAG -----
component RAMBFIFO16KA_WX8_RX32_FLAG
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO16KA_WX4_RX32_FLAG -----
component RAMBFIFO16KA_WX4_RX32_FLAG
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO16KA_WX2_RX32_FLAG -----
component RAMBFIFO16KA_WX2_RX32_FLAG
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;

-----Component RAMBFIFO16KA_WX1_RX32_FLAG -----
component RAMBFIFO16KA_WX1_RX32_FLAG
   generic (
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer :=  1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                              :	in    STD_ULOGIC;
      WCLK                            :	in    STD_ULOGIC;
      RE                              :	in    STD_ULOGIC;
      RCLK                            :	in    STD_ULOGIC;
      RST                             :	in    STD_ULOGIC;
      RPRST                           :	in    STD_ULOGIC;
      FULL                            :	out   STD_ULOGIC;
      EMPTY                           :	out   STD_ULOGIC;
      AMFULL                          :	out   STD_ULOGIC;
      AMEMPTY                         :	out   STD_ULOGIC);

end component;
-----Component RAMBFIFO16KA_WX32_RX16-----
component RAMBFIFO16KA_WX32_RX16
   generic(
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DI16                          : in   STD_ULOGIC;
      DI17                          : in   STD_ULOGIC;
      DI18                          : in   STD_ULOGIC;
      DI19                          : in   STD_ULOGIC;
      DI20                          : in   STD_ULOGIC;
      DI21                          : in   STD_ULOGIC;
      DI22                          : in   STD_ULOGIC;
      DI23                          : in   STD_ULOGIC;
      DI24                          : in   STD_ULOGIC;
      DI25                          : in   STD_ULOGIC;
      DI26                          : in   STD_ULOGIC;
      DI27                          : in   STD_ULOGIC;
      DI28                          : in   STD_ULOGIC;
      DI29                          : in   STD_ULOGIC;
      DI30                          : in   STD_ULOGIC;
      DI31                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX32_RX8-----
component RAMBFIFO16KA_WX32_RX8
   generic(
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DI16                          : in   STD_ULOGIC;
      DI17                          : in   STD_ULOGIC;
      DI18                          : in   STD_ULOGIC;
      DI19                          : in   STD_ULOGIC;
      DI20                          : in   STD_ULOGIC;
      DI21                          : in   STD_ULOGIC;
      DI22                          : in   STD_ULOGIC;
      DI23                          : in   STD_ULOGIC;
      DI24                          : in   STD_ULOGIC;
      DI25                          : in   STD_ULOGIC;
      DI26                          : in   STD_ULOGIC;
      DI27                          : in   STD_ULOGIC;
      DI28                          : in   STD_ULOGIC;
      DI29                          : in   STD_ULOGIC;
      DI30                          : in   STD_ULOGIC;
      DI31                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX32_RX4-----
component RAMBFIFO16KA_WX32_RX4
   generic(
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DI16                          : in   STD_ULOGIC;
      DI17                          : in   STD_ULOGIC;
      DI18                          : in   STD_ULOGIC;
      DI19                          : in   STD_ULOGIC;
      DI20                          : in   STD_ULOGIC;
      DI21                          : in   STD_ULOGIC;
      DI22                          : in   STD_ULOGIC;
      DI23                          : in   STD_ULOGIC;
      DI24                          : in   STD_ULOGIC;
      DI25                          : in   STD_ULOGIC;
      DI26                          : in   STD_ULOGIC;
      DI27                          : in   STD_ULOGIC;
      DI28                          : in   STD_ULOGIC;
      DI29                          : in   STD_ULOGIC;
      DI30                          : in   STD_ULOGIC;
      DI31                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX32_RX2-----
component RAMBFIFO16KA_WX32_RX2
   generic(
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DI16                          : in   STD_ULOGIC;
      DI17                          : in   STD_ULOGIC;
      DI18                          : in   STD_ULOGIC;
      DI19                          : in   STD_ULOGIC;
      DI20                          : in   STD_ULOGIC;
      DI21                          : in   STD_ULOGIC;
      DI22                          : in   STD_ULOGIC;
      DI23                          : in   STD_ULOGIC;
      DI24                          : in   STD_ULOGIC;
      DI25                          : in   STD_ULOGIC;
      DI26                          : in   STD_ULOGIC;
      DI27                          : in   STD_ULOGIC;
      DI28                          : in   STD_ULOGIC;
      DI29                          : in   STD_ULOGIC;
      DI30                          : in   STD_ULOGIC;
      DI31                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX32_RX1-----
component RAMBFIFO16KA_WX32_RX1
   generic(
      FIFO_FULL_FLAG     : integer  := 512;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DI16                          : in   STD_ULOGIC;
      DI17                          : in   STD_ULOGIC;
      DI18                          : in   STD_ULOGIC;
      DI19                          : in   STD_ULOGIC;
      DI20                          : in   STD_ULOGIC;
      DI21                          : in   STD_ULOGIC;
      DI22                          : in   STD_ULOGIC;
      DI23                          : in   STD_ULOGIC;
      DI24                          : in   STD_ULOGIC;
      DI25                          : in   STD_ULOGIC;
      DI26                          : in   STD_ULOGIC;
      DI27                          : in   STD_ULOGIC;
      DI28                          : in   STD_ULOGIC;
      DI29                          : in   STD_ULOGIC;
      DI30                          : in   STD_ULOGIC;
      DI31                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX16_RX8-----
component RAMBFIFO16KA_WX16_RX8
   generic(
      FIFO_FULL_FLAG     : integer  := 1024;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX16_RX4-----
component RAMBFIFO16KA_WX16_RX4
   generic(
      FIFO_FULL_FLAG     : integer  := 1024;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX16_RX2-----
component RAMBFIFO16KA_WX16_RX2
   generic(
      FIFO_FULL_FLAG     : integer  := 1024;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX16_RX1-----
component RAMBFIFO16KA_WX16_RX1
   generic(
      FIFO_FULL_FLAG     : integer  := 1024;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX8_RX4-----
component RAMBFIFO16KA_WX8_RX4
   generic(
      FIFO_FULL_FLAG     : integer  := 2048;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX8_RX2-----
component RAMBFIFO16KA_WX8_RX2
   generic(
      FIFO_FULL_FLAG     : integer  := 2048;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX8_RX1-----
component RAMBFIFO16KA_WX8_RX1
   generic(
      FIFO_FULL_FLAG     : integer  := 2048;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX4_RX2-----
component RAMBFIFO16KA_WX4_RX2
   generic(
      FIFO_FULL_FLAG     : integer  := 4096;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX4_RX1-----
component RAMBFIFO16KA_WX4_RX1
   generic(
      FIFO_FULL_FLAG     : integer  := 4096;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX2_RX1-----
component RAMBFIFO16KA_WX2_RX1
   generic(
      FIFO_FULL_FLAG     : integer  := 8192;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX16_RX32-----
component RAMBFIFO16KA_WX16_RX32
   generic(
      FIFO_FULL_FLAG     : integer  := 1024;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DI8                          : in   STD_ULOGIC;
      DI9                          : in   STD_ULOGIC;
      DI10                          : in   STD_ULOGIC;
      DI11                          : in   STD_ULOGIC;
      DI12                          : in   STD_ULOGIC;
      DI13                          : in   STD_ULOGIC;
      DI14                          : in   STD_ULOGIC;
      DI15                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      DO16                          : out   STD_ULOGIC;
      DO17                          : out   STD_ULOGIC;
      DO18                          : out   STD_ULOGIC;
      DO19                          : out   STD_ULOGIC;
      DO20                          : out   STD_ULOGIC;
      DO21                          : out   STD_ULOGIC;
      DO22                          : out   STD_ULOGIC;
      DO23                          : out   STD_ULOGIC;
      DO24                          : out   STD_ULOGIC;
      DO25                          : out   STD_ULOGIC;
      DO26                          : out   STD_ULOGIC;
      DO27                          : out   STD_ULOGIC;
      DO28                          : out   STD_ULOGIC;
      DO29                          : out   STD_ULOGIC;
      DO30                          : out   STD_ULOGIC;
      DO31                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX8_RX32-----
component RAMBFIFO16KA_WX8_RX32
   generic(
      FIFO_FULL_FLAG     : integer  := 2048;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      DO16                          : out   STD_ULOGIC;
      DO17                          : out   STD_ULOGIC;
      DO18                          : out   STD_ULOGIC;
      DO19                          : out   STD_ULOGIC;
      DO20                          : out   STD_ULOGIC;
      DO21                          : out   STD_ULOGIC;
      DO22                          : out   STD_ULOGIC;
      DO23                          : out   STD_ULOGIC;
      DO24                          : out   STD_ULOGIC;
      DO25                          : out   STD_ULOGIC;
      DO26                          : out   STD_ULOGIC;
      DO27                          : out   STD_ULOGIC;
      DO28                          : out   STD_ULOGIC;
      DO29                          : out   STD_ULOGIC;
      DO30                          : out   STD_ULOGIC;
      DO31                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX4_RX32-----
component RAMBFIFO16KA_WX4_RX32
   generic(
      FIFO_FULL_FLAG     : integer  := 4096;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      DO16                          : out   STD_ULOGIC;
      DO17                          : out   STD_ULOGIC;
      DO18                          : out   STD_ULOGIC;
      DO19                          : out   STD_ULOGIC;
      DO20                          : out   STD_ULOGIC;
      DO21                          : out   STD_ULOGIC;
      DO22                          : out   STD_ULOGIC;
      DO23                          : out   STD_ULOGIC;
      DO24                          : out   STD_ULOGIC;
      DO25                          : out   STD_ULOGIC;
      DO26                          : out   STD_ULOGIC;
      DO27                          : out   STD_ULOGIC;
      DO28                          : out   STD_ULOGIC;
      DO29                          : out   STD_ULOGIC;
      DO30                          : out   STD_ULOGIC;
      DO31                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX2_RX32-----
component RAMBFIFO16KA_WX2_RX32
   generic(
      FIFO_FULL_FLAG     : integer  := 8192;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      DO16                          : out   STD_ULOGIC;
      DO17                          : out   STD_ULOGIC;
      DO18                          : out   STD_ULOGIC;
      DO19                          : out   STD_ULOGIC;
      DO20                          : out   STD_ULOGIC;
      DO21                          : out   STD_ULOGIC;
      DO22                          : out   STD_ULOGIC;
      DO23                          : out   STD_ULOGIC;
      DO24                          : out   STD_ULOGIC;
      DO25                          : out   STD_ULOGIC;
      DO26                          : out   STD_ULOGIC;
      DO27                          : out   STD_ULOGIC;
      DO28                          : out   STD_ULOGIC;
      DO29                          : out   STD_ULOGIC;
      DO30                          : out   STD_ULOGIC;
      DO31                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX1_RX32-----
component RAMBFIFO16KA_WX1_RX32
   generic(
      FIFO_FULL_FLAG     : integer  := 16384;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      DO16                          : out   STD_ULOGIC;
      DO17                          : out   STD_ULOGIC;
      DO18                          : out   STD_ULOGIC;
      DO19                          : out   STD_ULOGIC;
      DO20                          : out   STD_ULOGIC;
      DO21                          : out   STD_ULOGIC;
      DO22                          : out   STD_ULOGIC;
      DO23                          : out   STD_ULOGIC;
      DO24                          : out   STD_ULOGIC;
      DO25                          : out   STD_ULOGIC;
      DO26                          : out   STD_ULOGIC;
      DO27                          : out   STD_ULOGIC;
      DO28                          : out   STD_ULOGIC;
      DO29                          : out   STD_ULOGIC;
      DO30                          : out   STD_ULOGIC;
      DO31                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX8_RX16-----
component RAMBFIFO16KA_WX8_RX16
   generic(
      FIFO_FULL_FLAG     : integer  := 2048;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DI4                          : in   STD_ULOGIC;
      DI5                          : in   STD_ULOGIC;
      DI6                          : in   STD_ULOGIC;
      DI7                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX4_RX16-----
component RAMBFIFO16KA_WX4_RX16
   generic(
      FIFO_FULL_FLAG     : integer  := 4096;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX2_RX16-----
component RAMBFIFO16KA_WX2_RX16
   generic(
      FIFO_FULL_FLAG     : integer  := 8192;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX1_RX16-----
component RAMBFIFO16KA_WX1_RX16
   generic(
      FIFO_FULL_FLAG     : integer  := 16384;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      DO8                          : out   STD_ULOGIC;
      DO9                          : out   STD_ULOGIC;
      DO10                          : out   STD_ULOGIC;
      DO11                          : out   STD_ULOGIC;
      DO12                          : out   STD_ULOGIC;
      DO13                          : out   STD_ULOGIC;
      DO14                          : out   STD_ULOGIC;
      DO15                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX4_RX8-----
component RAMBFIFO16KA_WX4_RX8
   generic(
      FIFO_FULL_FLAG     : integer  := 4096;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DI2                          : in   STD_ULOGIC;
      DI3                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX2_RX8-----
component RAMBFIFO16KA_WX2_RX8
   generic(
      FIFO_FULL_FLAG     : integer  := 8192;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX1_RX8-----
component RAMBFIFO16KA_WX1_RX8
   generic(
      FIFO_FULL_FLAG     : integer  := 16384;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      DO4                          : out   STD_ULOGIC;
      DO5                          : out   STD_ULOGIC;
      DO6                          : out   STD_ULOGIC;
      DO7                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX2_RX4-----
component RAMBFIFO16KA_WX2_RX4
   generic(
      FIFO_FULL_FLAG     : integer  := 8192;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DI1                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX1_RX4-----
component RAMBFIFO16KA_WX1_RX4
   generic(
      FIFO_FULL_FLAG     : integer  := 16384;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      DO2                          : out   STD_ULOGIC;
      DO3                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;

-----Component RAMBFIFO16KA_WX1_RX2-----
component RAMBFIFO16KA_WX1_RX2
   generic(
      FIFO_FULL_FLAG     : integer  := 16384;
      FIFO_AMFULL_FLAG   : integer := 1;
      FIFO_AMEMPTY_FLAG  : integer := 1);

   port(
      WE                           : in    STD_ULOGIC;
      WCLK                         : in    STD_ULOGIC;
      RE                           : in    STD_ULOGIC;
      RCLK                         : in    STD_ULOGIC;
      FULLIN                       : in    STD_ULOGIC;
      EMPTYIN                      : in    STD_ULOGIC;
      RST                          : in    STD_ULOGIC;
      RPRST                        : in    STD_ULOGIC;
      DI0                          : in   STD_ULOGIC;
      DO0                          : out   STD_ULOGIC;
      DO1                          : out   STD_ULOGIC;
      FULL                         : out   STD_ULOGIC;
      EMPTY                        : out   STD_ULOGIC;
      AMFULL                       : out   STD_ULOGIC;
      AMEMPTY                      : out   STD_ULOGIC);
end component;


-------Component l_cam--------
 component l_cam
  generic (
	    lpm_type               : string  := "LPM_CAM";
	    lpm_width              : integer := 1;
	    lpm_numwords           : integer := 1;
	    lpm_widthad            : integer := 1;
            lpm_init_file          : string  := "";
	    lpm_hint               : string  := "UNUSED");
   port(
      ClockEn                      :	in    STD_ULOGIC;
      We                           :	in    STD_ULOGIC;
      Clock                        :	in    STD_ULOGIC;
      EnMask                       :	in    STD_ULOGIC;
      WrMask                       :	in    STD_ULOGIC;
      WrDc                         :	in    STD_ULOGIC;
      Reset                        :	in    STD_ULOGIC;
      Wad                          :	in    STD_ULOGIC_VECTOR(6 downto 0);
      Data                         :	in    STD_ULOGIC_VECTOR(lpm_width-1 downto 0);
      Address                      :	out   STD_ULOGIC_VECTOR( 6 downto 0);
      Match                        :	out   STD_ULOGIC;
      MulMatch                     :	out   STD_ULOGIC);

  end component;

-------Component l_fifo------
 component l_fifo

  generic (
	 lpm_type      : string  := "LPM_FIFO_DC";
	 lpm_width     : integer := 1;
	 lpm_widthu    : integer := 1;
	 lpm_numwords  : integer := 2;
         lpm_amfull_flag : integer := 1;
         lpm_amempty_flag : integer := 1;
	 lpm_hint      : string  := "UNUSED");

  port (
	 Data          :  in  std_logic_vector (lpm_width-1 downto 0);
	 WrClock       :  in  std_logic;
	 WrEn          :  in  std_logic;
	 RdClock       :  in  std_logic;
	 RdEn          :  in  std_logic;
	 Aclr          :  in  std_logic;
	 PRReset       :  in  std_logic;
	 Q             :  out std_logic_vector (lpm_width-1 downto 0);
	 Full          :  out std_logic;
	 Empty         :  out std_logic;
	 AlmostFull    :  out std_logic;
	 AlmostEmpty   :  out std_logic);

 end component;

-------Component l_fifodcx--------
component l_fifodcx
  generic (
	 lpm_type      : string  := "LPM_FIFO_DCX";
	 lpm_widthw     : integer := 1;
	 lpm_widthr     : integer := 1;
	 lpm_widthuw    : integer := 1;
	 lpm_widthur    : integer := 1;
	 lpm_numwordsw  : integer := 2;
	 lpm_numwordsr  : integer := 2;
         lpm_amfull_flag : integer := 1;
         lpm_amempty_flag : integer := 1;
	 lpm_hint      : string  := "UNUSED");

  port (
	 Data          :  in  std_logic_vector (lpm_widthw-1 downto 0);
	 WrClock       :  in  std_logic;
	 WrEn          :  in  std_logic;
	 RdClock       :  in  std_logic;
	 RdEn          :  in  std_logic;
	 Reset          :  in  std_logic;
	 RPReset       :  in  std_logic;
	 Q             :  out std_logic_vector (lpm_widthr-1 downto 0);
	 Full          :  out std_logic;
	 Empty         :  out std_logic;
	 AlmostFull    :  out std_logic;
	 AlmostEmpty   :  out std_logic);

end component;
-------Component l_ramdp--------
 component l_ramdp
generic (
              LPM_TYPE      : string := "LPM_RAM_DP";
              LPM_WIDTHA    : positive;
              LPM_WIDTHADA  : positive;
              LPM_NUMWORDSA : positive;
              LPM_WIDTHB    : positive;
              LPM_WIDTHADB  : positive;
              LPM_NUMWORDSB : positive;
              LPM_INDATA    : string :="REGISTERED";
              LPM_OUTDATA   : string :="REGISTERED";
              LPM_ADDRESSA_CONTROL   : string :="UNREGISTERED";
              LPM_ADDRESSB_CONTROL   : string :="UNREGISTERED";
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

-------Component l_ramdps------
 component l_ramdps

  generic(
	   lpm_type             : string := "LPM_RAM_DP_PSEUDO";
	   lpm_widthw           : integer := 1;
	   lpm_widthr           : integer := 1;
	   lpm_numwordsw        : integer := 1;
	   lpm_widthadw         : integer := 1;
	   lpm_widthadr         : integer := 1;
   	   lpm_numwordsr        : integer := 1;
  	   lpm_indata           : string := "REGISTERED";
	   lpm_outdata          : string := "REGISTERED";
    	   lpm_addressw_control : string := "UNREGISTERED";
	   lpm_addressr_control : string := "UNREGISTERED";
	   lpm_hint             : string := "UNUSED");


  port(
           Data        : in  std_logic_vector (lpm_widthw-1 downto 0);
           WrAddress   : in  std_logic_vector (lpm_widthadw-1 downto 0);
           RdAddress   : in  std_logic_vector (lpm_widthadr-1 downto 0);
           WrClock     : in std_logic;
           WrClockEn   : in std_logic;
           RdClock     : in std_logic;
           RdClockEn   : in std_logic;
           WE          : in std_logic;
           Reset       : in std_logic;
           Q           : out std_logic_vector (lpm_widthr-1 downto 0));


 end component;

-------Component l_ramdq-------
 component l_ramdq

  generic(
	   lpm_type            : string  := "LPM_RAM_DQ";
	   lpm_width           : integer := 1;
	   lpm_numwords        : integer := 1;
	   lpm_widthad         : integer := 1;
  	   lpm_indata          : string  := "REGISTERED";
	   lpm_outdata         : string  := "REGISTERED";
	   lpm_address_control : string  := "UNREGISTERED";
	   lpm_hint            : string  := "UNUSED");

  port(

           Data                : in  std_logic_vector (lpm_width-1 downto 0);
           Address             : in  std_logic_vector (lpm_widthad-1 downto 0);
           Clock               : in  std_logic;
           ClockEn             : in  std_logic;
           WE                  : in  std_logic;
           Reset               : in  std_logic;
           Q                   : out std_logic_vector (lpm_width-1 downto 0));
 end component;

-------Component l_rom-------
 component l_rom
  generic (
	    lpm_type               : string  := "LPM_ROM";
	    lpm_width              : integer := 1;
	    lpm_numwords           : integer := 1;
	    lpm_widthad            : integer := 1;
	    lpm_outdata            : string  := "REGISTERED";
	    lpm_address_control    : string  := "UNREGISTERED";
            lpm_init_file          : string := "init_file";
	    lpm_hint               : string  := "UNUSED");
  port (
            Address       : in  std_logic_vector (lpm_widthad-1 downto 0);
            OutClock      : in  std_logic;
            OutClockEn    : in  std_logic;
            Reset         : in  std_logic;
            Q             : out std_logic_vector (lpm_width-1 downto 0));

 end component;

-------Component cam-------
 component cam
  generic ( lpm_type                  : string  := "Lattice_MEM";
	    module_type               : string  := "CAM";
	    module_width              : integer := 1;
	    module_numwords           : integer := 1;
	    module_widthad            : integer := 1;
            module_init_file          : string := "";
	    module_hint               : string  := "UNUSED");
   port(
      ClockEn                      :	in    STD_ULOGIC;
      WE                           :	in    STD_ULOGIC;
      Clock                        :	in    STD_ULOGIC;
      EnMask                       :	in    STD_ULOGIC;
      WrMask                       :	in    STD_ULOGIC;
      WrDC                         :	in    STD_ULOGIC;
      Reset                        :	in    STD_ULOGIC;
      WrAddress                    :	in    STD_LOGIC_VECTOR(module_widthad-1 downto 0);
      Data                         :	in    STD_LOGIC_VECTOR(module_width-1 downto 0);
      Address                      :	out   STD_LOGIC_VECTOR(module_widthad-1 downto 0);
      Match                        :	out   STD_ULOGIC;
      MulMatch                     :	out   STD_ULOGIC);

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
  generic( lpm_type                : string := "Lattice_MEM";
	   module_type             : string := "RAM_DP";
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
           Reset       : in std_logic;
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
           Reset               : in  std_logic;
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
	    module_address_control    : string  := "UNREGISTERED";
            module_init_file          : string := "init_file";
	    module_hint               : string  := "UNUSED");
  port (
            Address       : in  std_logic_vector (module_widthad-1 downto 0);
            OutClock      : in  std_logic;
            OutClockEn    : in  std_logic;
            Reset         : in  std_logic;
            Q             : out std_logic_vector (module_width-1 downto 0));
 end component;


end components;
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
	variable value1:      real;
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

        if (L'right <= 2) then
           value1 := 0.25 * value;
        else
           value1 := value;
        end if;

        return (value1);
      end str2real;

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

---- end of VITAL components library ----

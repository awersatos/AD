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
-- Simulation package file for ispMACh5000VG components
-- 
-- Revision History:
-- -------------------------------------------------------------------- 
--$Header: R:/src/mod_kits/Mach/vital/rcs/lc5kvg_components.vhd 1.7 2004/03/04 18:35:43Z jli Exp $
----------------------------------------------------------------
-- 
-- FILE CONTENTS:    LC5KVG VITAL Component Package
-- DATE CREATED :    Wen Sept  15 1998
-- 
-- LIBRARY      :    LC5KVG
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

----- Components BI_DIR -----
component BI_DIR
   generic (PULL   : string  := "Off";
            OUTOPEN : string := "Off");
   port(
      I0                             :	in    STD_ULOGIC;
      OE                             :	in    STD_ULOGIC;
      IO                             :	inout STD_ULOGIC;
      O                              :	out   STD_ULOGIC);
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
      PIN                             :	in    STD_ULOGIC;
      NIN                             :	in    STD_ULOGIC;
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
      POUT                           :	out   STD_ULOGIC;
      NOUT                           :	out   STD_ULOGIC);
end component;

----- Component LVDSTRI -----
component LVDSTRI
   port(
      I                             :	in    STD_ULOGIC;
      OE                            :	in    STD_ULOGIC;
      POUT                          :	out   STD_ULOGIC;
      NOUT                          :	out   STD_ULOGIC);
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
 
end components;

---- end of VITAL components library ----

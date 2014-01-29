-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/unisims/unisim/VITAL/OBUFTDS.vhd,v 1.3 2009/08/22 00:26:02 harikr Exp $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  3-State Differential Signaling Output Buffer
-- /___/   /\     Filename : OBUFTDS.vhd
-- \   \  /  \    Timestamp : Thu Apr  8 10:56:42 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.

----- CELL OBUFTDS -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity OBUFTDS is
  generic(
      CAPACITANCE : string     := "DONT_CARE";
      IOSTANDARD  : string     := "DEFAULT"
    );

  port(
    O  : out std_ulogic;
    OB : out std_ulogic;

    I : in std_ulogic;
    T : in std_ulogic
    );
end OBUFTDS;

architecture OBUFTDS_V of OBUFTDS is
begin
  prcs_init : process
  variable FIRST_TIME        : boolean    := TRUE;
  begin

     If(FIRST_TIME = true) then
        if((CAPACITANCE = "LOW") or
           (CAPACITANCE = "NORMAL") or
           (CAPACITANCE = "DONT_CARE")) then
           FIRST_TIME := false;
        else
           assert false
           report "Attribute Syntax Error: The allowed values for CAPACITANCE are LOW, NORMAL or DONT_CARE"
           severity Failure;
        end if;
     end if;
     wait;
  end process prcs_init;

  VITALBehavior    : process (I, T)
  begin

    if ((T = '1') or (T = 'H')) then
      O <= 'Z';
    elsif ((T = '0') or (T = 'L')) then
      if ((I = '1') or (I = 'H')) then
        O <= '1';
      elsif ((I = '0') or (I = 'L')) then
        O <= '0';
      elsif (I = 'U') then
        O <= 'U';
      else
        O <= 'X';  
      end if;
    elsif (T = 'U') then
      O <= 'U';          
    else                                      
      O <= 'X';  
    end if;

    if ((T = '1') or (T = 'H')) then
      OB <= 'Z';
    elsif ((T = '0') or (T = 'L')) then
      if (((not I) = '1') or ((not I) = 'H')) then
        OB <= '1';
      elsif (((not I) = '0') or ((not I) = 'L')) then
        OB <= '0';
      elsif ((not I) = 'U') then
        OB <= 'U';
      else
        OB <= 'X';  
      end if;
    elsif (T = 'U') then
      OB <= 'U';          
    else                                      
      OB <= 'X';  
    end if;        
  end process;
end OBUFTDS_V;

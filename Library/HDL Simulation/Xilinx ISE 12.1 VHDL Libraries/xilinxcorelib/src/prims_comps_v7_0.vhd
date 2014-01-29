-- Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2003 Xilinx, Inc.
-- All rights reserved.

-- $Id: prims_comps_v7_0.vhd,v 1.13 2008/09/08 20:06:16 akennedy Exp $
--
-- Filename - prims_comps_v7_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains the component declarations for
--                               baseblocks primitives.

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v7_0.all;

package prims_comps_v7_0 is

-- Architecture Independant components...

----- Component C_BUFT_V7_0 -----
-- Short Description
--
-- Tristate buffer with Active HIGH tristate enable
--
   component C_BUFT_V7_0
      port ( I : in  std_ulogic := '0';
             T : in  std_ulogic := '0';
             O : out std_ulogic);
   end component;


----- Component C_PULLUP_V7_0 ---
-- Short Description
--
-- Pullup. Wired to "H" in the VHDL.
--
   component C_PULLUP_V7_0
      port ( O : out std_ulogic := 'H');
   end component;


----- Component C_PULLDOWN -----
-- Short Description
--
-- Pulldown. Wired to "L" in the VHDL.
--
--component C_PULLDOWN 
--    port ( O  : out std_ulogic := 'L');
--end component;


----- Component C_LUT_V7_0 -----
-- Short Description
--
-- 1-4 input LUT. I1...I3 are defaulted to '0's to allow their exclusion from
--      a port mapping.
--
   component C_LUT_V7_0
      generic (
         eqn            : string  := "";
         init           : integer := 0;
         c_enable_rlocs : boolean := false
         );
      port( I0         : in  std_ulogic;
            I1, I2, I3 : in  std_ulogic := '0';
            O          : out std_ulogic
            );

   end component;

   
end prims_comps_v7_0;

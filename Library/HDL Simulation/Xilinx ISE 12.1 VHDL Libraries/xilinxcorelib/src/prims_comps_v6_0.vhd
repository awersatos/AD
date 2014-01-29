-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.              
-- This text contains proprietary, confidential                        
-- information of Xilinx, Inc., is distributed                         
-- under license from Xilinx, Inc., and may be used,                   
-- copied and/or disclosed only pursuant to the terms                  
-- of a valid license agreement with Xilinx, Inc. This copyright       
-- notice must be retained as part of this text at all times.          


-- $Id: prims_comps_v6_0.vhd,v 1.17 2008/09/08 20:06:06 akennedy Exp $
--
-- Filename - prims_comps_v6_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains the component declarations for
--                               baseblocks primitives.

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v6_0.all;

package prims_comps_v6_0 is

-- Architecture Independant components...

----- Component C_BUFT_V6_0 -----
-- Short Description
--
-- Tristate buffer with Active HIGH tristate enable
--
   component C_BUFT_V6_0
      port ( I : in  std_ulogic := '0';
             T : in  std_ulogic := '0';
             O : out std_ulogic);
   end component;


----- Component C_PULLUP_V6_0 ---
-- Short Description
--
-- Pullup. Wired to "H" in the VHDL.
--
   component C_PULLUP_V6_0
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


----- Component C_LUT_V6_0 -----
-- Short Description
--
-- 1-4 input LUT. I1...I3 are defaulted to '0's to allow their exclusion from
--      a port mapping.
--
   component C_LUT_V6_0
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

   
end prims_comps_v6_0;

-- $Id: prims_comps_v5_0.vhd,v 1.18 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - prims_comps_v5_0.vhd
-- Author - Xilinx
-- Creation - 19 Aug 1999
--
-- Description - This file contains the component declarations for
--                               baseblocks primitives.

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v5_0.all;

package prims_comps_v5_0 is

-- Architecture Independant components...

----- Component C_LUT_V5_0 -----
-- Short Description
--
-- 1-4 input LUT. I1...I3 are defaulted to '0's to allow their exclusion from
--      a port mapping.
--
   component C_LUT_V5_0
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

   
end prims_comps_v5_0;

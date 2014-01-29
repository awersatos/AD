-------------------------------------------------------
--  Copyright (c) 1995/2007 Xilinx Inc.
--  All Right Reserved.
-------------------------------------------------------
--
--   ____  ____
--  /   /\/   / 
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version : 11.1
--  \   \          Description : 
--  /   /                      
-- /___/   /\      Filename    : suspend_sync.vhd
-- \   \  /  \      
--  \__ \/\__ \                   
--                                 
-------------------------------------------------------

----- CELL SUSPEND_SYNC -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.VITAL_Timing.all;

library unisim;
use unisim.vpkg.all;

  entity SUSPEND_SYNC is
    port (
      SREQ                 : out std_ulogic;
      CLK                  : in std_ulogic;
      SACK                 : in std_ulogic      
    );
  end SUSPEND_SYNC;

  architecture SUSPEND_SYNC_V of SUSPEND_SYNC is
    
    begin

  end SUSPEND_SYNC_V;

-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.              
-- This text contains proprietary, confidential                        
-- information of Xilinx, Inc., is distributed                         
-- under license from Xilinx, Inc., and may be used,                   
-- copied and/or disclosed only pursuant to the terms                  
-- of a valid license agreement with Xilinx, Inc. This copyright       
-- notice must be retained as part of this text at all times.          

-------------------------------------------------------------------------------
-- $Revision: 1.16 $ $Date: 2008/09/08 20:06:06 $
-------------------------------------------------------------------------------
-- Filename - c_shift_ram_v6_0_comp.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description - This file contains the component declaration for
--                               the C_SHIFT_RAM_V6_0 core
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

library XilinxCoreLib;
use XilinxCoreLib.prims_constants_v6_0.all;

package c_shift_ram_v6_0_comp is


----- Component C_SHIFT_RAM_V6_0 -----
-- Short Description
--
-- Shift register based on rams
--

   component C_SHIFT_RAM_V6_0
      generic (C_ADDR_WIDTH         : integer := 4;
               C_AINIT_VAL          : string  := "";
               C_DEFAULT_DATA       : string  := "0";
               C_DEFAULT_DATA_RADIX : integer := 1;
               C_DEPTH              : integer := 16;
               C_ENABLE_RLOCS       : integer := 1;
               C_GENERATE_MIF       : integer := 0;  -- unused by the behavioural model
               C_HAS_ACLR           : integer := 0;
               C_HAS_A              : integer := 0;
               C_HAS_AINIT          : integer := 0;
               C_HAS_ASET           : integer := 0;
               C_HAS_CE             : integer := 0;
               C_HAS_SCLR           : integer := 0;
               C_HAS_SINIT          : integer := 0;
               C_HAS_SSET           : integer := 0;
               C_MEM_INIT_FILE      : string  := "null.mif";
               C_MEM_INIT_RADIX     : integer := 1;  -- for backwards compatibility
               C_READ_MIF           : integer := 0;
               C_REG_LAST_BIT       : integer := 0;
               C_SHIFT_TYPE         : integer := c_fixed;
               C_SINIT_VAL          : string  := "";
               C_SYNC_PRIORITY      : integer := c_clear;
               C_SYNC_ENABLE        : integer := c_override;
               C_WIDTH              : integer := 16
               ); 

      port (A     : in  std_logic_vector(C_ADDR_WIDTH-1 downto 0) := (others => '0');
            D     : in  std_logic_vector(C_WIDTH-1 downto 0)      := (others => '0');
            CLK   : in  std_logic                                 := '0';
            CE    : in  std_logic                                 := '1';
            ACLR  : in  std_logic                                 := '0';
            ASET  : in  std_logic                                 := '0';
            AINIT : in  std_logic                                 := '0';
            SCLR  : in  std_logic                                 := '0';
            SSET  : in  std_logic                                 := '0';
            SINIT : in  std_logic                                 := '0';
            Q     : out std_logic_vector(C_WIDTH-1 downto 0)
            ); 
   end component;

end c_shift_ram_v6_0_comp;

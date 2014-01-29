-- $Id: c_shift_ram_v4_0_comp.vhd,v 1.10 2008/09/08 20:05:48 akennedy Exp $
--
-- Filename - c_shift_ram_v4_0_comp.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description - This file contains the component declaration for
--				 the C_SHIFT_RAM_V4_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v4_0.all;

package c_shift_ram_v4_0_comp is


----- Component C_SHIFT_RAM_V4_0 -----
-- Short Description
--
-- Shift register based on rams
--

component C_SHIFT_RAM_V4_0
	GENERIC (C_ADDR_WIDTH	 : integer := 4;
			 C_AINIT_VAL	 : string  := "";
             C_DEFAULT_DATA  : string  := "0";
             C_DEFAULT_DATA_RADIX : integer := 1;
			 C_DEPTH		 : integer := 16;
			 C_ENABLE_RLOCS	 : integer := 1;
             C_GENERATE_MIF  : integer := 0;    -- unused by the behavioural model
			 C_HAS_ACLR 	 : integer := 0;
			 C_HAS_A       	 : integer := 0;
			 C_HAS_AINIT	 : integer := 0;
			 C_HAS_ASET 	 : integer := 0;
			 C_HAS_CE 		 : integer := 0;
			 C_HAS_SCLR 	 : integer := 0;
			 C_HAS_SINIT	 : integer := 0;
			 C_HAS_SSET		 : integer := 0;
             C_MEM_INIT_FILE : string  := "null.mif";
             C_MEM_INIT_RADIX : integer := 1;   -- for backwards compatibility
             C_READ_MIF      : integer := 0;
			 C_REG_LAST_BIT	 : integer := 0;
			 C_SHIFT_TYPE 	 : integer := c_fixed;
			 C_SINIT_VAL 	 : string  := "";
			 C_SYNC_PRIORITY : integer := c_clear;
			 C_SYNC_ENABLE	 : integer := c_override;
             C_WIDTH		 : integer := 16
			 ); 

    PORT (A     : IN std_logic_vector(C_ADDR_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
          D     : IN std_logic_vector(C_WIDTH-1 DOWNTO 0) := (OTHERS => '0');
		  CLK   : IN std_logic := '0';
		  CE    : IN std_logic := '1';
		  ACLR  : IN std_logic := '0';
		  ASET  : IN std_logic := '0';
		  AINIT : IN std_logic := '0';
		  SCLR  : IN std_logic := '0';
		  SSET  : IN std_logic := '0';
		  SINIT : IN std_logic := '0';
		  Q     : OUT std_logic_vector(C_WIDTH-1 DOWNTO 0)
	); 
end component;

end c_shift_ram_v4_0_comp;

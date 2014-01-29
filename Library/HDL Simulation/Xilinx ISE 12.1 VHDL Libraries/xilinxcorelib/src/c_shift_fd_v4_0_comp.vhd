-- $Id: c_shift_fd_v4_0_comp.vhd,v 1.10 2008/09/08 20:05:48 akennedy Exp $
--
-- Filename - c_shift_fd_v4_0_comp.vhd
-- Author - Xilinx
-- Creation - 24 Mar 1999
--
-- Description - This file contains the component declaration for
--				 the C_SHIFT_FD_V4_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v4_0.all;

package c_shift_fd_v4_0_comp is


----- Component C_SHIFT_FD_V4_0 -----
-- Short Description
--
-- Shift register based on FD regs
--

component C_SHIFT_FD_V4_0
	generic (C_WIDTH		: integer := 16;
			 C_SHIFT_TYPE	: integer := c_lsb_to_msb;
			 C_FILL_DATA 	: integer := c_zeros;
			 C_AINIT_VAL	: string  := "";
			 C_SINIT_VAL	: string  := "";
			 C_SYNC_PRIORITY: integer := c_clear;
			 C_SYNC_ENABLE	: integer := c_override;
			 C_HAS_LSB_2_MSB: integer := 1;
			 C_HAS_SDIN		: integer := 1;
			 C_HAS_D		: integer := 0;
			 C_HAS_SDOUT 	: integer := 0;
			 C_HAS_Q		: integer := 1;
			 C_HAS_CE		: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT	: integer := 0;
			 C_ENABLE_RLOCS : integer := 1
			 ); 

    port (LSB_2_MSB : in std_logic := '0';
		  SDIN : in std_logic := '0';
		  D : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0');
		  P_LOAD : in std_logic := '0';
		  CLK : in std_logic := '0';
		  CE : in std_logic := '1';
		  ACLR : in std_logic := '0';
		  ASET : in std_logic := '0';
		  AINIT : in std_logic := '0';
		  SCLR : in std_logic := '0';
		  SSET : in std_logic := '0';
		  SINIT : in std_logic := '0';
		  SDOUT : out std_logic;
		  Q : out std_logic_vector(C_WIDTH-1 downto 0)		  
		  ); 
end component;

end c_shift_fd_v4_0_comp;

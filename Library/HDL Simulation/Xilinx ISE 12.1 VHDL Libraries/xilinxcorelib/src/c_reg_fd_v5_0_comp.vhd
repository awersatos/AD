-- $Id: c_reg_fd_v5_0_comp.vhd,v 1.17 2008/09/08 20:05:58 akennedy Exp $
--
-- Filename - c_reg_fd_v5_0_comp.vhd
-- Author - Xilinx
-- Creation - 25 Feb 1999
--
-- Description - This file contains the component declaration for
--				 the C_REG_FD_V5_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v5_0.all;

package c_reg_fd_v5_0_comp is

----- Component C_REG_FD_V5_0 -----
-- Short Description
--
-- Wide register
--

component C_REG_FD_V5_0
	generic (C_WIDTH 		: integer := 16;
			 C_AINIT_VAL 	: string  := "";
			 C_SINIT_VAL 	: string  := "";
			 C_SYNC_PRIORITY: integer := c_clear;
			 C_SYNC_ENABLE 	: integer := c_override; 
			 C_HAS_CE 		: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT 	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT 	: integer := 0;
			 C_ENABLE_RLOCS : integer := 1
			 ); 

    port (D : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input value
		  CLK : in std_logic := '0'; -- Clock
		  CE : in std_logic := '1'; -- Clock Enable
		  ACLR : in std_logic := '0'; -- Asynch clear.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch clear.
		  SSET : in std_logic := '0'; -- Synch set.
		  SINIT : in std_logic := '0'; -- Synch init.
		  Q : out std_logic_vector(C_WIDTH-1 downto 0) -- Output value
		  );
end component;

end c_reg_fd_v5_0_comp;

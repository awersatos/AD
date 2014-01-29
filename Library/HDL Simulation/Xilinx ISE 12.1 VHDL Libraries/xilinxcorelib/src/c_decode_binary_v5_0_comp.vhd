-- $Id: c_decode_binary_v5_0_comp.vhd,v 1.17 2008/09/08 20:05:57 akennedy Exp $
--
-- Filename - c_decode_binary_v5_0_comp.vhd
-- Author - Xilinx
-- Creation - 9 Dec 1998
--
-- Description - This file contains the component declaration for
--				 the C_DECODE_BINARY_V5_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v5_0.all;

package c_decode_binary_v5_0_comp is

	
----- Component C_DECODE_BINARY_V5_0 -----
-- Short Description
--
-- (A)Synchronous binary decoder
--

component C_DECODE_BINARY_V5_0
	generic (
			 C_SEL_WIDTH 		: integer := 3;
			 C_OUT_WIDTH 		: integer := 8;
			 C_OUT_HIGH		 	: integer := 1;
			 C_PIPE_STAGES 		: integer := 0;
			 C_AINIT_VAL 		: string := "";
			 C_SINIT_VAL 		: string := "";
			 C_SYNC_PRIORITY 	: integer := c_clear;
			 C_SYNC_ENABLE 		: integer := c_override;
			 C_HAS_O 			: integer := 0;
			 C_HAS_Q 			: integer := 1;
			 C_HAS_EN 			: integer := 0;
			 C_HAS_CE 			: integer := 0;
			 C_HAS_ACLR 		: integer := 0;
			 C_HAS_ASET 		: integer := 0;
			 C_HAS_AINIT 		: integer := 0;
			 C_HAS_SCLR 		: integer := 0;
			 C_HAS_SSET 		: integer := 0;
			 C_HAS_SINIT 		: integer := 0;
			 C_ENABLE_RLOCS 	: integer := 1
			 ); 
			 
    port (CLK : in std_logic := '0'; -- Optional clock
		  EN : in std_logic := '1';  -- Enable the inputs
		  CE : in std_logic := '1';  -- Optional Clock enable
		  S : in std_logic_vector(C_SEL_WIDTH-1 downto 0) := (others => '0');  -- Select value
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- optional asynch set to '1'
		  AINIT : in std_logic := '0'; -- optional asynch reset to init_val
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- optional synch set to '1'
		  SINIT : in std_logic := '0'; -- Optional synch reset to init_val
		  O : out std_logic_vector(C_OUT_WIDTH-1 downto 0); -- UnRegistered output value
		  Q : out std_logic_vector(C_OUT_WIDTH-1 downto 0) -- Registered output value
		  );
end component;

end c_decode_binary_v5_0_comp;

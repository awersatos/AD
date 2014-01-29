-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
--$Revision: 1.10 $ $Date: 2008/09/08 16:51:32 $

library ieee;
use ieee.std_logic_1164.all;

package pipe_bhv_v5_1_comp is
	
	component pipe_bhv_v5_1
		generic (
			C_HAS_ACLR      : integer := 0;
			C_HAS_CE        : integer := 0;
			C_HAS_SCLR      : integer := 1;
			C_PIPE_STAGES   : integer := 2; 
			C_WIDTH         : integer := 16);		 
		port (
			D     : in  std_logic_vector(C_WIDTH-1 downto 0); -- Input value
			CLK   : in  std_logic := '0'; -- Clock
			CE    : in  std_logic := '1'; -- Clock Enable
			ACLR  : in  std_logic := '0'; -- Asynch clear.
			SCLR  : in  std_logic := '0'; -- Synch clear.
			Q     : out std_logic_vector(C_WIDTH-1 downto 0));
	end component;
	
end pipe_bhv_v5_1_comp;

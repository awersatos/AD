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

package c_sin_cos_v5_1_comp is
	
component C_SIN_COS_V5_1
	generic(
			C_ENABLE_RLOCS 				: integer			:= 0;		 
			C_HAS_ACLR 								: integer 		:= 0;
			C_HAS_CE 								: integer			:= 0;		 
			C_HAS_CLK 								: integer 		:= 0;
			C_HAS_ND								: integer 		:= 1;
			C_HAS_RFD								: integer 		:= 1;
			C_HAS_RDY								: integer 		:= 1;
			C_HAS_SCLR								: integer 		:= 0;
			C_LATENCY								: integer			:= 0;
			C_MEM_TYPE								: integer 		:= 0; --DIST_ROM;
			C_NEGATIVE_COSINE		: integer 		:= 0;
			C_NEGATIVE_SINE				: integer 		:= 0;
			C_OUTPUTS_REQUIRED : integer 		:= 0; --SINE_ONLY;
			C_OUTPUT_WIDTH 				: integer			:= 16;
			C_PIPE_STAGES 					: integer 		:= 0;
			C_REG_INPUT 							: integer 		:= 0;
			C_REG_OUTPUT 						: integer 		:= 0;
			C_SYMMETRIC 							: integer 		:= 0;
			C_THETA_WIDTH 					: integer 		:= 4 
		);
	port(
		aclr 		: in std_logic := '0';
		ce 			: in std_logic := '1';
		clk 			: in std_logic := '0';
		nd			: in std_logic := '0';
		sclr 		: in std_logic := '0';
		theta 	: in std_logic_vector(C_THETA_WIDTH-1 downto 0) := (others=>'0');
		rdy 			: out std_logic;
		rfd 			: out std_logic;
		cosine : out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0);
		sine 		: out std_logic_vector(C_OUTPUT_WIDTH-1 downto 0)
		);
end component;
	
end c_sin_cos_v5_1_comp;

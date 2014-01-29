-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
-- $Revision: 1.12 $ $Date: 2008/09/08 20:09:48 $
library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

library XilinxCoreLib;
use XilinxCoreLib.iputils_std_logic_unsigned.all;
use XilinxCoreLib.iputils_std_logic_arith.all;
use XilinxCoreLib.c_shift_fd_v7_0_comp.all;
use XilinxCoreLib.c_reg_fd_v7_0_comp.all;
use XilinxCoreLib.c_sin_cos_v5_0_pack.all;
use XilinxCoreLib.pipe_bhv_v5_0_comp.all;

-- standard libraries declarations
library XILINXCORELIB;
use XILINXCORELIB.prims_constants_v7_0.all;

entity C_SIN_COS_V5_0 is
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
end C_SIN_COS_V5_0;

architecture behavioral of C_SIN_COS_V5_0 is
	
	---- Architecture declarations -----
	constant depth : integer:=2**C_THETA_WIDTH;
	constant cosine_table : table_array(0 TO depth-1):=trig_array(cos_table,depth,C_OUTPUT_WIDTH,C_NEGATIVE_COSINE, C_SYMMETRIC);
	constant sine_table : table_array(0 TO depth-1):=trig_array(sin_table,depth,C_OUTPUT_WIDTH,C_NEGATIVE_SINE, C_SYMMETRIC);
	
	
	----     Constants     -----
	constant GND_CONSTANT   : STD_LOGIC := '0';
	
	---- Signal declarations ----
	
	signal blockMem_int : integer := 0;
	signal ceInt : STD_LOGIC;
	signal delayedCe : STD_LOGIC;
	signal delayedCeInt : std_logic;
	signal ndInt : std_logic;
	signal outputRegCe : std_logic;
	signal rdyInt : STD_LOGIC;
	signal theta_int : integer := 0;
	signal zero : STD_LOGIC;
	signal ce_delay_zero_vector : STD_LOGIC_VECTOR (latencyOutRegCe(C_LATENCY)-2 downto 0) := (others=>'0');
	signal cosineInt : STD_LOGIC_VECTOR (C_OUTPUT_WIDTH-1 downto 0);
	signal cos_outreg : STD_LOGIC_VECTOR (C_OUTPUT_WIDTH-1 downto 0);
	signal cos_pipe : STD_LOGIC_VECTOR (C_OUTPUT_WIDTH-1 downto 0);
	signal sineInt : STD_LOGIC_VECTOR (C_OUTPUT_WIDTH-1 downto 0);
	signal sin_outreg : STD_LOGIC_VECTOR (C_OUTPUT_WIDTH-1 downto 0);
	signal sin_pipe : STD_LOGIC_VECTOR (C_OUTPUT_WIDTH-1 downto 0);
	signal zero_vector : std_logic_vector (latencyRdyPipeLine(C_LATENCY)-1 downto 0) := (others=>'0');
	
	---- Configuration specifications for declared components 
	
	for CE_DELAY : C_SHIFT_FD_V7_0 use entity xilinxcorelib.C_SHIFT_FD_V7_0;
	for COS_PIPE_DELAY : PIPE_BHV_V5_0 use entity xilinxcorelib.PIPE_BHV_V5_0;
	for COS_REG_OUT : C_REG_FD_V7_0 use entity xilinxcorelib.C_REG_FD_V7_0;
	for RDY_DELAY : C_SHIFT_FD_V7_0 use entity xilinxcorelib.C_SHIFT_FD_V7_0;
	for SIN_PIPE_DELAY : PIPE_BHV_V5_0 use entity xilinxcorelib.PIPE_BHV_V5_0;
	for SIN_REG_OUT : C_REG_FD_V7_0 use entity xilinxcorelib.C_REG_FD_V7_0;
	
begin
	
	---- User Signal Assignments ----
	zero_vector <= (others=>'0');
	regIn : process(clk, theta)
	begin
		if C_REG_INPUT = 0 then
			theta_int <= conv_integer(theta);
		elsif clk'event and clk='1' and  ceInt='1' then
			theta_int <= conv_integer(theta);	
		end if;
	end process;
	sin_pipe <= conv_std_logic_vector(integer(sine_table(theta_int)), C_OUTPUT_WIDTH);		
	cos_pipe <= conv_std_logic_vector(integer(cosine_table(theta_int)), C_OUTPUT_WIDTH);
	hasNd1 : if (C_HAS_ND=1) generate
		ndInt <= nd;
	end generate;	
	hasNd0 : if (not(C_HAS_ND=1)) generate
		ndInt <= '1';
	end generate;
	hasRfd1 : if C_HAS_RFD=1 generate
		RFD <= '1';
	end generate;	
	hasRfd0 : if not(C_HAS_RFD=1) generate
		RFD <= 'U';
	end generate;
	hasRdy1 : if (C_HAS_RDY=1 and (C_LATENCY>0)) generate
		RDY <= rdyInt;
	end generate;	
	hasRdy1NoLatency : if (C_HAS_RDY=1 and (C_LATENCY=0))generate
		rdy <= ndInt;
	end generate;	
	hasRdy0 : if not(C_HAS_RDY=1) generate
		rdy <= 'U';
	end generate;
	hasSin1 : if((C_OUTPUTS_REQUIRED = SINE_ONLY) or
		(C_OUTPUTS_REQUIRED = SINE_AND_COSINE)) generate
		
		hasSinRegOut1 : if (C_REG_OUTPUT=1) generate			
			Sine <= sineInt;
		end generate;
		
		hasSinRegOut0 : if not(C_REG_OUTPUT=1) generate			
			Sine <= sin_outreg;                      			
		end generate;
		
	end generate;
	
	hasSin0 : if not((C_OUTPUTS_REQUIRED = SINE_ONLY) or
		(C_OUTPUTS_REQUIRED = SINE_AND_COSINE)) generate
		Sine <= (others=>'U');
	end generate;
	hasOutRegCe1 : if C_LATENCY>1 generate
		delayedCe <= delayedCeInt;
	end generate;
	
	ceAnd: process(ceInt, delayedCe, ndInt)		
	begin
		if C_HAS_CE=1 and (C_LATENCY > 1) then
			outputRegCe <= ceInt and delayedCe;
		elsif (C_LATENCY > 1) then
			outputRegCe <= delayedCe;
		else outputRegCe <= ceInt and ndInt;
		--elsif C_HAS_CE=1 and C_HAS_ND=1 then
		--	outputRegCe <= CE and ND;
		--elsif C_HAS_CE=1 then
		--	outputRegCe <= CE;
		end if;
	end	process;
	
	hasCos1 : if (C_OUTPUTS_REQUIRED = COSINE_ONLY) or
		(C_OUTPUTS_REQUIRED = SINE_AND_COSINE) generate
		
		hasCosRegOut1 : if (C_REG_OUTPUT=1) generate	
			Cosine <= cosineInt;
		end generate;
		
		hasCosRegOut0 : if not(C_REG_OUTPUT=1) generate			
			Cosine <= cos_outreg;                      			
		end generate;
	end generate;	
	hasCos0 : if not((C_OUTPUTS_REQUIRED = COSINE_ONLY) or
		(C_OUTPUTS_REQUIRED = SINE_AND_COSINE)) generate
		Cosine <= (others=>'U');
	end generate;
	hasCe1 : if C_HAS_CE=1 generate
		ceInt <= CE;
	end generate;	
	hasCe0 : if not(C_HAS_CE=1) generate
		ceInt <= '1';
	end generate;
	
	----  Component instantiations  ----
	
	CE_DELAY : C_SHIFT_FD_V7_0
	generic map (
		C_FILL_DATA => c_sdin,
		C_HAS_ACLR => C_HAS_ACLR*C_REG_OUTPUT,
		C_HAS_AINIT => 0,
		C_HAS_ASET => 0,
		C_HAS_CE => C_HAS_CE,
		C_HAS_D => 0,
		C_HAS_LSB_2_MSB => 0,
		C_HAS_Q => 0,
		C_HAS_SCLR => C_HAS_SCLR*C_REG_OUTPUT,
		C_HAS_SDIN => 1,
		C_HAS_SDOUT => 1,
		C_HAS_SINIT => 0,
		C_HAS_SSET => 0,
		C_SHIFT_TYPE => c_lsb_to_msb,
		C_SYNC_ENABLE => c_override,
		C_SYNC_PRIORITY => c_clear,
		C_WIDTH => latencyOutRegCe(C_LATENCY)-1
		)
	port map(
		ACLR => ACLR,
		AINIT => zero,
		ASET => zero,
		CE => ceInt,
		CLK => CLK,
		D => ce_delay_zero_vector( latencyOutRegCe(C_LATENCY)-2 downto 0 ),
		LSB_2_MSB => zero,
		P_LOAD => zero,
		SCLR => SCLR,
		SDIN => ndInt,
		SDOUT => delayedCeInt,
		SINIT => zero,
		SSET => zero
		);
	
	COS_PIPE_DELAY : PIPE_BHV_V5_0
	generic map (
		C_HAS_ACLR => C_HAS_ACLR * C_REG_OUTPUT,
		C_HAS_CE => C_HAS_CE,
		C_HAS_SCLR => C_HAS_SCLR * C_REG_OUTPUT,
		C_PIPE_STAGES => C_LATENCY-C_REG_OUTPUT-C_REG_INPUT,
		C_WIDTH => C_OUTPUT_WIDTH
		)
	port map(
		ACLR => ACLR,
		CE => ceInt,
		CLK => CLK,
		D => cos_pipe( C_OUTPUT_WIDTH-1 downto 0 ),
		Q => cos_outreg( C_OUTPUT_WIDTH-1 downto 0 ),
		SCLR => SCLR
		);
	
	COS_REG_OUT : C_REG_FD_V7_0
	generic map (
	C_HAS_ACLR => C_HAS_ACLR*C_REG_OUTPUT,
	C_HAS_AINIT => 0,
	C_HAS_ASET => 0,
	C_HAS_CE => hasOutputRegCe(C_HAS_CE, C_HAS_ND, C_LATENCY),
	C_HAS_SCLR => C_HAS_SCLR*C_REG_OUTPUT,
	C_HAS_SINIT => 0,
	C_HAS_SSET => 0,
	C_SYNC_ENABLE => c_override,
	C_SYNC_PRIORITY => c_clear,
	C_WIDTH => C_OUTPUT_WIDTH
	)
	port map(
	ACLR => ACLR,
	AINIT => zero,
	ASET => zero,
	CE => outputRegCe,
	CLK => CLK,
	D => cos_outreg( C_OUTPUT_WIDTH-1 downto 0 ),
	Q => cosineInt( C_OUTPUT_WIDTH-1 downto 0 ),
	SCLR => SCLR,
	SINIT => zero,
	SSET => zero
	);
	
	RDY_DELAY : C_SHIFT_FD_V7_0
	generic map (
		C_FILL_DATA => c_sdin,
		C_HAS_ACLR => C_HAS_ACLR*C_REG_OUTPUT,
		C_HAS_AINIT => 0,
		C_HAS_ASET => 0,
		C_HAS_CE => C_HAS_CE,
		C_HAS_D => 0,
		C_HAS_LSB_2_MSB => 0,
		C_HAS_Q => 0,
		C_HAS_SCLR => C_HAS_SCLR*C_REG_OUTPUT,
		C_HAS_SDIN => 1,
		C_HAS_SDOUT => 1,
		C_HAS_SINIT => 0,
		C_HAS_SSET => 0,
		C_SHIFT_TYPE => c_lsb_to_msb,
		C_SYNC_ENABLE => c_override,
		C_SYNC_PRIORITY => c_clear,
		C_WIDTH => latencyRdyPipeLine(C_LATENCY)
		)
	port map(
		ACLR => ACLR,
		AINIT => zero,
		ASET => zero,
		CE => ceInt,
		CLK => CLK,
		D => zero_vector( latencyRdyPipeLine(C_LATENCY)-1 downto 0 ),
		LSB_2_MSB => zero,
		P_LOAD => zero,
		SCLR => SCLR,
		SDIN => ndInt,
		SDOUT => rdyInt,
		SINIT => zero,
		SSET => zero
		);
	
	SIN_PIPE_DELAY : PIPE_BHV_V5_0
	generic map (
		C_HAS_ACLR => C_HAS_ACLR * C_REG_OUTPUT,
		C_HAS_CE => C_HAS_CE,
		C_HAS_SCLR => C_HAS_SCLR * C_REG_OUTPUT,
		C_PIPE_STAGES => C_LATENCY-C_REG_OUTPUT-C_REG_INPUT,
		C_WIDTH => C_OUTPUT_WIDTH
		)
	port map(
		ACLR => ACLR,
		CE => ceInt,
		CLK => CLK,
		D => sin_pipe( C_OUTPUT_WIDTH-1 downto 0 ),
		Q => sin_outreg( C_OUTPUT_WIDTH-1 downto 0 ),
		SCLR => SCLR
		);
	
	SIN_REG_OUT : C_REG_FD_V7_0
	generic map (
	C_HAS_ACLR => C_HAS_ACLR*C_REG_OUTPUT,
	C_HAS_AINIT => 0,
	C_HAS_ASET => 0,
	C_HAS_CE => hasOutputRegCe(C_HAS_CE, C_HAS_ND, C_LATENCY),
	C_HAS_SCLR => C_HAS_SCLR*C_REG_OUTPUT,
	C_HAS_SINIT => 0,
	C_HAS_SSET => 0,
	C_SYNC_ENABLE => c_override,
	C_SYNC_PRIORITY => c_clear,
	C_WIDTH => C_OUTPUT_WIDTH
	)
	port map(
	ACLR => ACLR,
	AINIT => zero,
	ASET => zero,
	CE => outputRegCe,
	CLK => CLK,
	D => sin_outreg( C_OUTPUT_WIDTH-1 downto 0 ),
	Q => sineInt( C_OUTPUT_WIDTH-1 downto 0 ),
	SCLR => SCLR,
	SINIT => zero,
	SSET => zero
	);
	
	
	---- Power , ground assignment ----
	
	zero <= GND_CONSTANT;
	
end behavioral;

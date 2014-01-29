-- Copyright(C) 2004 by Xilinx, Inc. All rights reserved.
-- This text contains proprietary, confidential
-- information of Xilinx, Inc., is distributed
-- under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms
-- of a valid license agreement with Xilinx, Inc. This copyright
-- notice must be retained as part of this text at all times.
--
--$Revision: 1.10 $ $Date: 2008/09/08 16:51:32 $

Library IEEE;
Use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;

--Library XilinxCoreLib;
--Use XilinxCoreLib.prims_utils_v2_0.all;
--use XilinxCoreLib.prims_constants_v2_0.all;

entity PIPE_BHV_V5_1 is
	generic (C_HAS_ACLR      : integer := 0;
		C_HAS_CE        : integer := 0;
		C_HAS_SCLR      : integer := 1;
		C_PIPE_STAGES   : integer := 2; 
		C_WIDTH         : integer := 16); 
	port (D     : in  std_logic_vector(C_WIDTH-1 downto 0); -- Input value
		CLK   : in  std_logic := '0'; -- Clock
		CE    : in  std_logic := '1'; -- Clock Enable
		ACLR  : in  std_logic := '0'; -- Asynch clear.
		SCLR  : in  std_logic := '0'; -- Synch clear.
		Q     : out std_logic_vector(C_WIDTH-1 downto 0)); -- Output value
end PIPE_BHV_V5_1;

architecture behavioral of PIPE_BHV_V5_1 is
	
	constant timeunit : time := 1 ns;
	
	signal intQ : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');
	-- signals for optional pins...
	signal intCE    : std_logic;
	signal intACLR  : std_logic;
	signal intSCLR  : std_logic;
	type   pltype is array(0 to C_PIPE_STAGES-1) of std_logic_vector(C_WIDTH-1 downto 0);
	
	
begin
	
	nopipe: if C_PIPE_STAGES = 0 generate
		Q <= D;
	end generate;
	haspipe: if C_PIPE_STAGES > 0 generate
		-- Deal with optional pins...
		ce1: if C_HAS_CE = 1 generate
			intCE <= CE;
		end generate;
		ce0: if not (C_HAS_CE = 1) generate
			intCE <= '1';
		end generate;
		
		aclr1: if C_HAS_ACLR = 1 generate
			intACLR <= ACLR;
		end generate;
		aclr0: if not (C_HAS_ACLR = 1) generate
			intACLR <= '0';
		end generate;
		
		sclr1: if C_HAS_SCLR = 1 generate
			intSCLR <= SCLR;
		end generate;
		sclr0: if not (C_HAS_SCLR = 1) generate
			intSCLR <= '0';
		end generate;
		
		p1 : process(CLK, intCE, intACLR, intSCLR)
			variable FIRST      : boolean   := TRUE;
			variable ACTIVE_CLK : std_logic;
			variable pipeliner  : pltype;
		begin
			
			if FIRST then
				-- Define power-up value
				if C_HAS_ACLR = 1 then
					intQ <= (others => '0');
				elsif (C_HAS_SCLR = 1) then
					intQ <= (others => '0');
				end if;
				
				for i in 0 to C_PIPE_STAGES-1 loop
					pipeliner(i) := (others => '0');
				end loop;
				
				ACTIVE_CLK := '1';
				
				FIRST := FALSE;
				
			else -- Not FIRST
				-- deal with synchronous events first
				if (CLK'event and CLK'last_value = '0' and CLK = '1') then -- rising edge!
					-- First the pipeline
					if (intCE = 'X') then
						for i in 0 to C_PIPE_STAGES-1 loop
							pipeliner(i) := (others => 'X');
						end loop;
					elsif (intCE = '1') then
						for i in C_PIPE_STAGES-1 downto 1 loop
							pipeliner(i) := pipeliner(i-1);
						end loop;
					end if;
					
					-- Unqualified behaviour
					if (intCE = '1') then -- Enabled
						pipeliner(0) := D;
					end if;
					
					-- Synchronous controls 
					
					if (intSCLR = 'X')  then
						pipeliner(0) := (others => 'X');
						
					elsif (intSCLR = '1' ) then --Synchronous clear
						for i in 0 to C_PIPE_STAGES-1 loop
							pipeliner(i) := (others => '0');
						end loop;
					end if;
					
					
				elsif (CLK'event and ((CLK'last_value = '0' and CLK = 'X') or 
					(CLK'last_value = 'X' and CLK = '1'))) then
					if (intCE /= '0') then
						for i in 0 to C_PIPE_STAGES-1 loop
							pipeliner(i) := (others => 'X');
						end loop;
					end if;
				end if;
				
				-- Asynchronous Controls
				if intACLR = 'X' then
					pipeliner(C_PIPE_STAGES-1) := (others => 'X');
				elsif intACLR = '1' then -- asynch clear
					for i in 0 to C_PIPE_STAGES-1 loop
						pipeliner(i) := (others => '0');
					end loop;
				end if; 
				
				intQ <= pipeliner(C_PIPE_STAGES-1);
			end if; -- FIRST
		end process;
		
		Q <= intQ after timeunit;
		
	end generate;
	
end behavioral;

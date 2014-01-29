-- $Id: c_gate_bit_bus_v5_0.vhd,v 1.17 2008/09/08 20:05:57 akennedy Exp $
--
-- Filename - c_gate_bit_bus_v5_0.vhd
-- Author - Xilinx
-- Creation - 25 Jan 1999
--
-- Description - This file contains the behavior for all the 
--				 the C_GATE_BIT_BUS_V5_0 core 

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v5_0.all;
Use XilinxCoreLib.prims_utils_v5_0.all;
Use XilinxCoreLib.c_reg_fd_v5_0_comp.all;

-- (A)synchronous multi-input vs single input gate
--

entity C_GATE_BIT_BUS_V5_0 is
	generic(
			 C_GATE_TYPE 		: integer := c_and; 
			 C_WIDTH 			: integer := 16;
			 C_INPUT_INV_MASK 	: string  := ""; 
			 C_AINIT_VAL 		: string  := ""; 		
			 C_SINIT_VAL 		: string  := ""; 		
			 C_SYNC_PRIORITY 	: integer := c_clear; 	
			 C_SYNC_ENABLE 		: integer := c_override;
			 C_HAS_O 			: integer := 0;
			 C_HAS_Q 			: integer := 1;
			 C_HAS_CE 			: integer := 0;
			 C_HAS_ACLR 		: integer := 0;
			 C_HAS_ASET 		: integer := 0;
			 C_HAS_AINIT 		: integer := 0;
			 C_HAS_SCLR 		: integer := 0;
			 C_HAS_SSET 		: integer := 0;
			 C_HAS_SINIT 		: integer := 0;
			 C_ENABLE_RLOCS 	: integer := 1
			);

    port (I : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  CTRL : in std_logic := '0'; -- Control input
		  CLK : in std_logic := '0'; -- Clock
		  CE : in std_logic := '1'; -- Clock Enable
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- Synch set.		  
		  SINIT : in std_logic := '0'; -- Synch init.
		  O : out std_logic_vector(C_WIDTH-1 downto 0); -- Asynch output
		  Q : out std_logic_vector(C_WIDTH-1 downto 0)); -- Registered output value
		  	
end C_GATE_BIT_BUS_V5_0;


architecture behavioral of C_GATE_BIT_BUS_V5_0 is

	constant timeunit : time := 1 ns;

	-- signals for optional pins...
	signal intO : std_logic_vector(C_WIDTH-1 downto 0);
	signal intQ : std_logic_vector(C_WIDTH-1 downto 0);	

begin
	
	p1 : process (I, CTRL)
		variable tmpres : std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); 
	
	begin
	
		if CTRL = 'X' then
			l1 : for j in C_WIDTH - 1 downto 0 loop
				if str_to_slv_0(C_INPUT_INV_MASK, C_WIDTH)(C_WIDTH-j) = '1' then -- INV_MASK will be (0 to something)
					if C_GATE_TYPE = 0 then -- AND gate
						if I(j) = '1' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 1 then -- NAND gate
						if I(j) = '1' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 2 then -- OR gate
						if I(j) = '0' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 3 then -- NOR gate
						if I(j) = '0' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 4 then -- XOR gate
						tmpres(j) := 'X';
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						tmpres(j) := 'X';
					end if;						
				else -- no invert on input bit
					if C_GATE_TYPE = 0 then -- AND gate
						if I(j) = '0' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 1 then -- NAND gate
						if I(j) = '0' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 2 then -- OR gate
						if I(j) = '1' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 3 then -- NOR gate
						if I(j) = '1' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 4 then -- XOR gate
						tmpres(j) := 'X';
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						tmpres(j) := 'X';
					end if;						
				end if;
			end loop; -- l1
		else
			l2 : for j in C_WIDTH - 1 downto 0 loop
				if str_to_slv_0(C_INPUT_INV_MASK, C_WIDTH)(C_WIDTH-j) = '1' then -- INV_MASK will be (0 to something)
					if C_GATE_TYPE = 0 then -- AND gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL and not I(j);
						elsif CTRL = '0' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 1 then -- NAND gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL nand not I(j);
						elsif CTRL = '0' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 2 then -- OR gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL or not I(j);
						elsif CTRL = '1' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 3 then -- NOR gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL nor not I(j);
						elsif CTRL = '1' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 4 then -- XOR gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL xor not I(j);
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						if I(j) /= 'X' then							
							tmpres(j) := not(CTRL xor not I(j));
						else
							tmpres(j) := 'X';
						end if;
					end if;						
				else -- no invert on input bit
					if C_GATE_TYPE = 0 then -- AND gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL and I(j);
						elsif CTRL = '0' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 1 then -- NAND gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL nand I(j);
						elsif CTRL = '0' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 2 then -- OR gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL or I(j);
						elsif CTRL = '1' then
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 3 then -- NOR gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL nor I(j);
						elsif CTRL = '1' then
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 4 then -- XOR gate
						if I(j) /= 'X' then							
							tmpres(j) := CTRL xor I(j);
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						if I(j) /= 'X' then							
							tmpres(j) := not(CTRL xor I(j));
						else
							tmpres(j) := 'X';
						end if;
					end if;						
				end if;
			end loop; -- l2
		
		end if;
		
		intO <= tmpres after timeunit;

	end process; -- p1
	
	o1: if C_HAS_O = 1 generate
		O <= intO;
	end generate;
	o0: if not (C_HAS_O = 1) generate
		O <= (others => 'X');
	end generate;
	
	qreg1 : if C_HAS_Q = 1 generate
		reg1 : c_reg_fd_v5_0 generic map (C_WIDTH => C_WIDTH,
									 C_AINIT_VAL => C_AINIT_VAL,
									 C_SINIT_VAL => C_SINIT_VAL,
									 C_SYNC_PRIORITY => C_SYNC_PRIORITY,
							    	 C_SYNC_ENABLE => C_SYNC_ENABLE,
									 C_HAS_CE => C_HAS_CE,
									 C_HAS_ACLR => C_HAS_ACLR,
									 C_HAS_ASET => C_HAS_ASET,
									 C_HAS_AINIT => C_HAS_AINIT,
									 C_HAS_SCLR => C_HAS_SCLR,
									 C_HAS_SSET => C_HAS_SSET,
									 C_HAS_SINIT => C_HAS_SINIT,
									 C_ENABLE_RLOCS => C_ENABLE_RLOCS)
							port map(D => intO,
									 CLK => CLK,
									 CE => CE,
									 ACLR => ACLR,
									 SCLR => SCLR,
									 ASET => ASET,
									 SSET => SSET,
									 AINIT => AINIT,
									 SINIT => SINIT,
									 Q => intQ);
	end generate;

	q1 : if C_HAS_Q = 1 generate
		Q <= intQ;
	end generate;
	q0 : if not (C_HAS_Q = 1) generate
		Q <= (others => 'X');
	end generate;
	
end behavioral;

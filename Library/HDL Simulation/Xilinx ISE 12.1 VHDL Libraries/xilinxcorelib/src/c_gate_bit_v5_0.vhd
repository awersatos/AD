-- $Id: c_gate_bit_v5_0.vhd,v 1.17 2008/09/08 20:05:57 akennedy Exp $
--
-- Filename - c_gate_bit_v5_0.vhd
-- Author - Xilinx
-- Creation - 7 Jan 1999
--
-- Description - This file contains the behavior for the 
--				 the C_GATE_BIT_V5_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v5_0.all;
Use XilinxCoreLib.prims_utils_v5_0.all;
Use XilinxCoreLib.c_reg_fd_v5_0_comp.all;

-- (A)synchronous multi-input gate
--

entity C_GATE_BIT_V5_0 is
	generic(
			 C_GATE_TYPE		: integer := c_and;
			 C_INPUTS 			: integer := 2;
			 C_INPUT_INV_MASK 	: string := "";
			 C_PIPE_STAGES		: integer := 1;
			 C_AINIT_VAL 		: string := "0";
			 C_SINIT_VAL		: string := "0";
			 C_SYNC_PRIORITY: integer := c_clear;
			 C_SYNC_ENABLE 	: integer := c_override;
			 C_HAS_O 		: integer := 0;
			 C_HAS_Q 		: integer := 1;
			 C_HAS_CE 		: integer := 0;
			 C_HAS_ACLR 	: integer := 0;
			 C_HAS_ASET 	: integer := 0;
			 C_HAS_AINIT 	: integer := 0;
			 C_HAS_SCLR 	: integer := 0;
			 C_HAS_SSET 	: integer := 0;
			 C_HAS_SINIT 	: integer := 0;
			 C_ENABLE_RLOCS	: integer := 0
			);

    port (I : in std_logic_vector(C_INPUTS-1 downto 0) := (others => '0'); -- Input vector
		  CLK : in std_logic := '0'; -- Clock
		  CE : in std_logic := '1'; -- Clock Enable
		  ACLR : in std_logic := '0'; -- Asynch init.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch init.
		  SSET : in std_logic := '0'; -- Synch set.		  
		  SINIT : in std_logic := '0'; -- Synch init.
          O : out std_logic; -- Asynch output
		  Q : out std_logic; -- Registered output value
          T     : in std_logic := '0'; -- Tri-state input for buft
          EN    : in std_logic := '0'); -- Enable input for bufe
		  	
end C_GATE_BIT_V5_0;


architecture behavioral of C_GATE_BIT_V5_0 is

	constant timeunit : time := 1 ns;

	-- signals for optional pins...
	signal intO : std_logic;
	signal intQpipeend : std_logic;
	signal intQ : std_logic;	
	signal intQpipe : std_logic_vector(C_PIPE_STAGES+2 downto 0) := (others => '0');
	signal intCE : std_logic;
    
    signal intT : std_logic;
    signal intEN: std_logic;
    
begin
	
	ce1: if C_HAS_CE = 1 generate
		intCE <= CE;
	end generate;
	ce0: if not (C_HAS_CE = 1) generate
		intCE <= '1';
	end generate;
    
    t0: if C_GATE_TYPE = 8 generate
        intT <= T;
    end generate;
    
    en0: if C_GATE_TYPE = 9 generate
        intEN <= EN;
    end generate;
    
	p1 : process (I, T, EN)
		variable tmpres : std_logic := '1'; -- partial result
	
	begin
	
		if is_X(I) then -- There are X's in the input vector - needs special checking
			if C_GATE_TYPE = 0 or C_GATE_TYPE = 1 then
				tmpres := '1'; -- AND or NAND gate
			else
				tmpres := '0'; -- Other sort of gate
			end if;
			l1 : for j in C_INPUTS - 1 downto 0 loop
				if str_to_slv_0(C_INPUT_INV_MASK, C_INPUTS)(C_INPUTS-j) = '1' then -- INV_MASK will be (1 to something)
					if C_GATE_TYPE = 0 then -- AND gate
						if I(j) /= 'X' then
							tmpres := tmpres and not I(j);
						elsif tmpres = '1' then -- Only make tmpres = 'X' if not already = '0'
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 1 then -- NAND gate
						if I(j) /= 'X' then
							tmpres := tmpres and not I(j);
						elsif tmpres = '1' then
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 2 then -- OR gate
						if I(j) /= 'X' then
							tmpres := tmpres or not I(j);
						elsif tmpres = '0' then -- Only make tmpres = 'X' if not already = '1'
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 3 then -- NOR gate
						if I(j) /= 'X' then
							tmpres := tmpres or not I(j);
						elsif tmpres = '0' then -- Only make tmpres = 'X' if not already = '1'
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 4 then -- XOR gate
						tmpres := tmpres xor not I(j);
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						tmpres := tmpres xor not I(j);
                    else -- gate is either Invertor or Buffer.
                        tmpres := 'X';
					end if;						
				else -- no invert on input bit
					if C_GATE_TYPE = 0 then -- AND gate
						if I(j) /= 'X' then
							tmpres := tmpres and I(j);
						elsif tmpres = '1' then -- Only make tmpres = 'X' if not already = '0'
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 1 then -- NAND gate
						if I(j) /= 'X' then
							tmpres := tmpres and I(j);
						elsif tmpres = '1' then -- Only make tmpres = 'X' if not already = '0'
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 2 then -- OR gate
						if I(j) /= 'X' then
							tmpres := tmpres or I(j);
						elsif tmpres = '0' then -- Only make tmpres = 'X' if not already = '1'
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 3 then -- NOR gate
						if I(j) /= 'X' then
							tmpres := tmpres or I(j);
						elsif tmpres = '0' then -- Only make tmpres = 'X' if not already = '1'
							tmpres := 'X';
						end if;
					elsif C_GATE_TYPE = 4 then -- XOR gate
						tmpres := tmpres xor I(j);
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						tmpres := tmpres xor I(j);
                    else
                        tmpres := 'X';
					end if;						
				end if;
			end loop; -- l1
		else -- No 'X's on input vector
			if C_GATE_TYPE = 0 or C_GATE_TYPE = 1 then
				tmpres := '1'; -- AND or NAND gate
			else
				tmpres := '0'; -- Other sort of gate
			end if;
			l2 : for j in C_INPUTS - 1 downto 0 loop
				if str_to_slv_0(C_INPUT_INV_MASK, C_INPUTS)(C_INPUTS-j) = '1' then -- INV_MASK will be (1 to something)
					if C_GATE_TYPE = 0 then -- AND gate
						tmpres := tmpres and not I(j);
					elsif C_GATE_TYPE = 1 then -- NAND gate
						tmpres := tmpres and not I(j);
					elsif C_GATE_TYPE = 2 then -- OR gate
						tmpres := tmpres or not I(j);
					elsif C_GATE_TYPE = 3 then -- NOR gate
						tmpres := tmpres or not I(j);
					elsif C_GATE_TYPE = 4 then -- XOR gate
						tmpres := tmpres xor not I(j);
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						tmpres := tmpres xor not I(j);
                    elsif (C_GATE_TYPE = 7 ) then -- BUF gate
                        tmpres := not I(j);
                    elsif (C_GATE_TYPE = 8) then -- BUFT
                        if T = '0' then
                            tmpres := not I(j);
                        else 
                            tmpres := '1';
										end if;
                    elsif (C_GATE_TYPE = 9) then -- BUFE
                        if EN = '0' then
                            tmpres := not I(j);
                        else
                            tmpres := '1';
										end if;
                    else                       -- INV gate
                        tmpres := not I(j);
					end if;						
				else -- no invert on input bit
					if C_GATE_TYPE = 0 then -- AND gate
						tmpres := tmpres and I(j);
					elsif C_GATE_TYPE = 1 then -- NAND gate
						tmpres := tmpres and I(j);
					elsif C_GATE_TYPE = 2 then -- OR gate
						tmpres := tmpres or I(j);
					elsif C_GATE_TYPE = 3 then -- NOR gate
						tmpres := tmpres or I(j);
					elsif C_GATE_TYPE = 4 then -- XOR gate
						tmpres := tmpres xor I(j);
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						tmpres := tmpres xor I(j);
                    elsif (C_GATE_TYPE = 7 ) then -- BUF gate
                        tmpres := I(j);
                    elsif (C_GATE_TYPE = 8) then -- BUFT
                        if T = '0' then
                            tmpres := I(j);
                        else 
                            tmpres := '1';
										end if;
                    elsif (C_GATE_TYPE = 9) then -- BUFE
                        if EN = '0' then
                            tmpres := I(j);
                        else
                            tmpres := '1';
										end if;
                    else                       -- INV gate
                        tmpres := I(j);
                    end if;						
				end if;
			end loop; -- l2
		
		end if;
		
		if C_GATE_TYPE = 1 or C_GATE_TYPE = 3 or C_GATE_TYPE = 5 or C_GATE_TYPE = 6  then
			tmpres := not tmpres;
		end if;
		
		intO <= tmpres after timeunit;
		
	end process; -- p1
	
	o1: if C_HAS_O = 1 generate
		O <= intO;
	end generate;
	o0: if not (C_HAS_O = 1) generate
		O <= 'X';
	end generate;
	
	qreg1 : if (C_HAS_Q = 1) generate
		reg1 : c_reg_fd_v5_0 generic map (C_WIDTH => 1,
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
							port map(D(0) => intQpipeend,
									 CLK => CLK,
									 CE => CE,
									 ACLR => ACLR,
									 SCLR => SCLR,
									 ASET => ASET,
									 SSET => SSET,
									 AINIT => AINIT,
									 SINIT => SINIT,
									 Q(0) => intQ);
	end generate;

	pipeq : process (CLK)
	begin
		
		if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
			pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
				intQpipe(p) <= intQpipe(p+1);
			end loop; -- pipeloop
			intQpipe(C_PIPE_STAGES) <= intO;
		elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
			pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
				if intQpipe(p) /= intQpipe(p+1) then
					intQpipe(p) <= 'X';
				end if;
			end loop; -- pipeloopx
			if intQpipe(C_PIPE_STAGES) /= intO then
				intQpipe(C_PIPE_STAGES) <= 'X';	
			end if;		
		end if;
		
	end process; -- pipeq

	ps1 : if C_PIPE_STAGES < 2 generate
		intQpipeend <= intO;
	end generate;
	ps1b : if C_PIPE_STAGES > 1 generate
		intQpipeend <= intQpipe(2);
	end generate;
	
	q1 : if C_HAS_Q = 1 generate
		Q <= intQ;
	end generate;
	q0 : if not (C_HAS_Q = 1) generate
		Q <= 'X';
	end generate;
	
end behavioral;


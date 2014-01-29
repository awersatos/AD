-- Copyright(C) 2003 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 1995-2003 Xilinx, Inc.
-- All rights reserved.

-- $Id: c_gate_bus_v7_0.vhd,v 1.13 2008/09/08 20:06:15 akennedy Exp $
--
-- Filename - c_gate_bus_v7_0.vhd
-- Author - Xilinx
-- Creation - 26 Jan 1999
--
-- Description - This file contains the behavior for the 
--				 the C_GATE_BUS_V7_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v7_0.all;
Use XilinxCoreLib.prims_utils_v7_0.all;
Use XilinxCoreLib.c_reg_fd_v7_0_comp.all;

-- (A)synchronous multi-input (wide) gate
--

entity C_GATE_BUS_V7_0 is
	generic(
			 C_GATE_TYPE		: integer := c_and;
			 C_WIDTH 			: integer := 16;
			 C_INPUTS 			: integer := 2;
			 C_INPUT_A_INV_MASK	: string := "";
			 C_INPUT_B_INV_MASK	: string := "";
			 C_INPUT_C_INV_MASK	: string := "";
			 C_INPUT_D_INV_MASK	: string := "";
			 C_AINIT_VAL 		: string := "";
			 C_SINIT_VAL		: string := "";
			 C_SYNC_PRIORITY	: integer := c_clear;
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

    port (IA : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  IB : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  IC : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  ID : in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
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
		  	
end C_GATE_BUS_V7_0;


architecture behavioral of C_GATE_BUS_V7_0 is

	constant timeunit : time := 1 ns;

	-- signals for optional pins...
	signal intO : std_logic_vector(C_WIDTH-1 downto 0);
	signal intQ : std_logic_vector(C_WIDTH-1 downto 0);	
	
	signal intIA, intIB, intIC, intID : std_logic_vector(C_WIDTH-1 downto 0);

begin

	invif: if C_GATE_TYPE < 6 generate -- Ignore these for inv and buf types!
		ci4: if C_INPUTS = 4 generate
			intID <= ID xor str_to_slv_0(C_INPUT_D_INV_MASK, C_WIDTH);
			intIC <= IC xor str_to_slv_0(C_INPUT_C_INV_MASK, C_WIDTH);
			intIB <= IB xor str_to_slv_0(C_INPUT_B_INV_MASK, C_WIDTH);
			intIA <= IA xor str_to_slv_0(C_INPUT_A_INV_MASK, C_WIDTH);
		end generate;
		ci3: if C_INPUTS = 3 generate
			ci3_01: if(C_GATE_TYPE = 0 or C_GATE_TYPE = 1) generate
				intID <= (others => '1'); -- AND or NAND gate requires a '1' to work
			end generate;
			ci3_2345: if(C_GATE_TYPE > 1) generate -- neither an AND nor a NAND gate
				intID <= (others => '0');
			end generate;
			intIC <= IC xor str_to_slv_0(C_INPUT_C_INV_MASK, C_WIDTH);
			intIB <= IB xor str_to_slv_0(C_INPUT_B_INV_MASK, C_WIDTH);
			intIA <= IA xor str_to_slv_0(C_INPUT_A_INV_MASK, C_WIDTH);
		end generate;
		ci2: if C_INPUTS = 2 generate
			ci2_01: if(C_GATE_TYPE = 0 or C_GATE_TYPE = 1) generate
				intIC <= (others => '1'); -- AND or NAND gate requires a '1' to work
				intID <= (others => '1'); 
			end generate;
			ci2_2345: if(C_GATE_TYPE > 1) generate -- neither an AND nor a NAND gate
				intIC <= (others => '0');
				intID <= (others => '0');
			end generate;
			intIB <= IB xor str_to_slv_0(C_INPUT_B_INV_MASK, C_WIDTH);
			intIA <= IA xor str_to_slv_0(C_INPUT_A_INV_MASK, C_WIDTH);
		end generate;
	end generate; -- invif

	invif2: if C_GATE_TYPE > 5 generate -- for INV and BUF gates
		ci1: if C_INPUTS = 1 generate -- inv or buf gate
			intIC <= (others => '0');
			intID <= (others => '0');
			intIB <= (others => '0');
			intIA <= IA;
		end generate;
	end generate; -- invif2
			
	
	p1 : process (intIA, intIB, intIC, intID)
		variable tmpres : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X'); -- partial result
	
	begin
	
			l1 : for j in C_WIDTH - 1 downto 0 loop
				if intIA(j) = 'X' or intIB(j) = 'X' or intIC(j) = 'X' or intID(j) = 'X' then -- if ANY inputs are 'X'...
					if C_GATE_TYPE = 0 then -- AND gate
						if(intIA(j) = '0' or intIB(j) = '0' or intIC(j) = '0' or intID(j) = '0') then -- if ANY inputs are '0'
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 1 then -- NAND gate
						if(intIA(j) = '0' or intIB(j) = '0' or intIC(j) = '0' or intID(j) = '0') then -- if ANY inputs are '0'
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 2 then -- OR gate
						if(intIA(j) = '1' or intIB(j) = '1' or intIC(j) = '1' or intID(j) = '1') then -- if ANY inputs are '1'
							tmpres(j) := '1';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE = 3 then -- NOR gate
						if(intIA(j) = '1' or intIB(j) = '1' or intIC(j) = '1' or intID(j) = '1') then -- if ANY inputs are '1'
							tmpres(j) := '0';
						else
							tmpres(j) := 'X';
						end if;
					elsif C_GATE_TYPE > 3 then -- XOR gate
						tmpres(j) := 'X';
					end if;						
				else
					if C_GATE_TYPE = 0 then -- AND gate
						tmpres(j) := intIA(j) and intIB(j) and intIC(j) and intID(j);
					elsif C_GATE_TYPE = 1 then -- NAND gate
						tmpres(j) := not(intIA(j) and intIB(j) and intIC(j) and intID(j));
					elsif C_GATE_TYPE = 2 then -- OR gate
						tmpres(j) := intIA(j) or intIB(j) or intIC(j) or intID(j);
					elsif C_GATE_TYPE = 3 then -- NOR gate
						tmpres(j) := not(intIA(j) or intIB(j) or intIC(j) or intID(j));
					elsif C_GATE_TYPE = 4 then -- XOR gate
						tmpres(j) := intIA(j) xor intIB(j) xor intIC(j) xor intID(j);
					elsif C_GATE_TYPE = 5 then -- XNOR gate
						tmpres(j) := not(intIA(j) xor intIB(j) xor intIC(j) xor intID(j));
					elsif C_GATE_TYPE = 6 then -- INV gate
						tmpres(j) := not(intIA(j));
					elsif C_GATE_TYPE = 7 then -- BUF gate
						tmpres(j) := intIA(j);
					end if;						
				end if;
			end loop; -- l1
		
			intO <= tmpres after timeunit;
		
	end process; -- p1
	
	o1: if C_HAS_O = 1 generate
		O <= intO;
	end generate;
	o0: if not (C_HAS_O = 1) generate
		O <= (others => 'X');
	end generate;
	
	qreg1 : if (C_HAS_Q = 1) generate
		reg1 : c_reg_fd_v7_0 generic map (C_WIDTH => C_WIDTH,
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

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

-- $Id: c_decode_binary_v7_0.vhd,v 1.13 2008/09/08 20:06:14 akennedy Exp $
--
-- Filename - c_decode_binary_v7_0.vhd
-- Author - Xilinx
-- Creation - 9 Dec 1998
--
-- Description - This file contains the behavior for
--				 the C_DECODE_BINARY_V7_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v7_0.all;
Use XilinxCoreLib.c_reg_fd_v7_0_comp.all;

entity C_DECODE_BINARY_V7_0 is
	generic (
			 C_SEL_WIDTH 		: integer := 3;
			 C_OUT_WIDTH 		: integer := 8;
			 C_OUT_HIGH		 	: integer := 1;
			 C_PIPE_STAGES 		: integer := 0;
			 C_AINIT_VAL 		: string := "";
			 C_SINIT_VAL 		: string := "";
			 C_SYNC_PRIORITY 	: integer := c_clear;
			 C_SYNC_ENABLE 		: integer := c_override;
             C_HEIGHT           : integer := 0;
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
		  Q : out std_logic_vector(C_OUT_WIDTH-1 downto 0)); -- Registered output value
end C_DECODE_BINARY_V7_0;

architecture behavioral of C_DECODE_BINARY_V7_0 is

	constant timeunit : time := 1 ns;

	-- signals for optional pins...
	signal intQ : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => 'X');
	signal intO : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => 'X');
	signal intEN : std_logic;
	signal intCE : std_logic;
	
	signal intQpipeend : std_logic_vector(C_OUT_WIDTH-1 downto 0);
	type pipetype is array (C_PIPE_STAGES+2 downto 0) of std_logic_vector(C_OUT_WIDTH-1 downto 0);
	signal intQpipe : pipetype := (others => (others => '0'));
begin

	ce1: if C_HAS_CE = 1 generate
		intCE <= CE;
	end generate;
	ce0: if not (C_HAS_CE = 1) generate
		intCE <= '1';
	end generate;
		
	en1: if C_HAS_EN = 1 generate
		intEN <= EN;
	end generate;
	en0: if not (C_HAS_EN = 1) generate
		intEN <= '1';
	end generate;
		
	g1: if C_HAS_Q = 1 generate -- Need a register on the output
		opreg : c_reg_fd_v7_0 generic map(C_WIDTH => C_OUT_WIDTH,
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
							port map(D => intQpipeend,
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
	
	pipeq : process (CLK)
	begin
		
		if intCE = '1' and CLK = '1' and CLK'last_value /= 'X' and C_PIPE_STAGES > 1 then
			pipeloop : for p in 2 to C_PIPE_STAGES-1 loop
				intQpipe(p) <= intQpipe(p+1);
			end loop; -- pipeloop
			intQpipe(C_PIPE_STAGES) <= intO;
		elsif (intCE = 'X' or (CLK = 'X' and CLK'last_value = '0') or (CLK = '1' and CLK'last_value = 'X')) and C_PIPE_STAGES > 1 then
			pipeloopx : for p in 2 to C_PIPE_STAGES-1 loop
				pipeloopxinner : for p1 in 0 to C_OUT_WIDTH-1 loop
					if intQpipe(p)(p1) /= intQpipe(p+1)(p1) then
						intQpipe(p)(p1) <= 'X';
					end if;
				end loop; -- pipeloopxinner
			end loop; -- pipeloopx
			pipeloopxlast : for p1 in 0 to C_OUT_WIDTH-1 loop
				if intQpipe(C_PIPE_STAGES)(p1) /= intO(p1) then
					intQpipe(C_PIPE_STAGES)(p1) <= 'X';	
				end if;		
			end loop; -- pipeloopxlast
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
		Q <= (others => 'X');
	end generate;
	
	dec : process(S, intEN)
		variable i : integer := 0;
		variable j : integer := 0;
		variable k : integer := 1;
		variable unknown : integer := 0;
		variable tmpO : std_logic_vector(C_OUT_WIDTH-1 downto 0) := (others => '0');
	begin
		k := 1;
		i := 0;
		unknown := 0;
		l1 : for j in 0 to C_SEL_WIDTH-1 loop
			if S(j) = '1' then
				i := i + k;
			elsif S(j) /= '0' then
				unknown := 1;
			end if;
			k := k * 2;
		end loop;
		
		if unknown = 1 and intEN = '1' then
			tmpO := (others => 'X');
		elsif C_OUT_HIGH = 1 then
			tmpO := (others => '0');
			tmpO(i) := intEN;
		elsif C_OUT_HIGH = 0 then
			tmpO := (others => '1');
			tmpO(i) := not intEN;
		else -- C_OUT_HIGH is unknown
			tmpO := (others => 'X');
		end if;
		
		intO <= tmpO after timeunit;
		
	end process; -- dec
	
	o1 : if C_HAS_O = 1 generate
		O <= intO;
	end generate;
	o0 : if not (C_HAS_O = 1) generate
		O <= (others => 'X');
	end generate;
	
end behavioral;

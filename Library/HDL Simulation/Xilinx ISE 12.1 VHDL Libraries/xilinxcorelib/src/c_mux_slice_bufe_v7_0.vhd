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

-- $Id: c_mux_slice_bufe_v7_0.vhd,v 1.13 2008/09/08 20:06:15 akennedy Exp $
--
-- Filename - c_mux_slice_bufe_v7_0.vhd
-- Author - Xilinx
-- Creation - 4 Feb 1999
--
-- Description - This file contains the behavior for the baseblocks C_MUX_SLICE_BUFE_V7_0 module

Library IEEE;
Use IEEE.std_logic_1164.all;

-- 1*m to 1*m tristate (used as a bus mux)

entity C_MUX_SLICE_BUFE_V7_0 is
	generic(
			 C_WIDTH 		: integer := 16
			 ); 
			 
    port (I 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  OE 	: in std_logic := '0'; -- Output/Tristate ('1'/'0')
		  O 	: out std_logic_vector(C_WIDTH-1 downto 0)); -- Registered output value

end C_MUX_SLICE_BUFE_V7_0;

architecture behavioral of C_MUX_SLICE_BUFE_V7_0 is

	constant timeunit : time := 1 ns;

	signal intO : std_logic_vector(C_WIDTH-1 downto 0) := (others => 'X');

begin
	
	p1 : process(I, OE)
	begin
		if OE = '1' then
			intO <= I;
		elsif OE = '0' then
			intO <= (others => 'Z');
		else
			intO <= (others => 'X');
		end if;
	end process;
	
	O <= intO after timeunit;
	
end behavioral;

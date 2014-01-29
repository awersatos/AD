-- Copyright(C) 2002 by Xilinx, Inc. All rights reserved.              
-- This text contains proprietary, confidential                        
-- information of Xilinx, Inc., is distributed                         
-- under license from Xilinx, Inc., and may be used,                   
-- copied and/or disclosed only pursuant to the terms                  
-- of a valid license agreement with Xilinx, Inc. This copyright       
-- notice must be retained as part of this text at all times.          

-- $Id: c_mux_slice_bufe_v6_0.vhd,v 1.16 2008/09/08 20:06:06 akennedy Exp $
--
-- Filename - c_mux_slice_bufe_v6_0.vhd
-- Author - Xilinx
-- Creation - 4 Feb 1999
--
-- Description - This file contains the behavior for the baseblocks C_MUX_SLICE_BUFE_V6_0 module

Library IEEE;
Use IEEE.std_logic_1164.all;

-- 1*m to 1*m tristate (used as a bus mux)

entity C_MUX_SLICE_BUFE_V6_0 is
	generic(
			 C_WIDTH 		: integer := 16
			 ); 
			 
    port (I 	: in std_logic_vector(C_WIDTH-1 downto 0) := (others => '0'); -- Input vector
		  OE 	: in std_logic := '0'; -- Output/Tristate ('1'/'0')
		  O 	: out std_logic_vector(C_WIDTH-1 downto 0)); -- Registered output value

end C_MUX_SLICE_BUFE_V6_0;

architecture behavioral of C_MUX_SLICE_BUFE_V6_0 is

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

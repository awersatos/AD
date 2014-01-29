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

-- $Id: c_gate_bit_v7_0_comp.vhd,v 1.13 2008/09/08 20:06:15 akennedy Exp $
--
-- Filename - c_gate_bit_v7_0_comp.vhd
-- Author - Xilinx
-- Creation - 3 Mar 1999
--
-- Description - This file contains the component declaration for
--				 the C_GATE_BIT_V7_0 core

Library IEEE;
Use IEEE.std_logic_1164.all;

Library XilinxCoreLib;
Use XilinxCoreLib.prims_constants_v7_0.all;

package c_gate_bit_v7_0_comp is

	
----- Component C_GATE_BIT_V7_0 -----
-- Short Description
--
-- (A)Synchronous Wide Gate
--

component C_GATE_BIT_V7_0
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
		  ACLR : in std_logic := '0'; -- Asynch clr.
		  ASET : in std_logic := '0'; -- Asynch set.
		  AINIT : in std_logic := '0'; -- Asynch init.
		  SCLR : in std_logic := '0'; -- Synch clr.
		  SSET : in std_logic := '0'; -- Synch set.		  
		  SINIT : in std_logic := '0'; -- Synch init.
          T     : in std_logic := '0'; -- Tri-state input for BUFT
          EN    : in std_logic := '0'; -- Enable input for BUFE
		  O : out std_logic; -- Asynch output
		  Q : out std_logic); -- Registered output value
end component;


end c_gate_bit_v7_0_comp;
